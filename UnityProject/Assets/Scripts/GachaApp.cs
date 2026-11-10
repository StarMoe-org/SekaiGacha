using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using SekaiGacha.Simulation;
using TMPro;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Rendering.Universal;
using UnityEngine.Timeline;

namespace SekaiGacha
{
    public sealed class GachaApp : MonoBehaviour
    {
        public static GachaApp Instance { get; private set; }
        public string Phase { get; private set; } = "加载";
        public string Error { get; private set; }
        public int RevealedCount { get; private set; }
        public int DrawCount { get; private set; }
        public string[] CurrentResults { get; private set; }
        public PlayableDirector CurrentDirector { get; internal set; }
        public GachaAudio Audio { get; private set; }
        public GachaResources Assets { get; private set; }
        // Resources/GachaPool.json 存在时加载的卡池；否则为 null，沿用 CardCatalog 随机演示。
        public GachaLottery Lottery { get; private set; }
        public GachaPrize[] CurrentPrizes { get; private set; }
        public float MaximumFrameMs { get; private set; }
        public int SlowFrames { get; private set; }
        public event Action PlaybackCompleted;
        // 自动演示：TapWait 到循环段时代替点击（原版等待玩家点击 TAP 提示）。
        public bool AutoTap { get; set; } = true;
        // ScreenLayerGachaAnimation.Effects / LoadedMaterial 的对应物。
        internal readonly Dictionary<GachaEffectType, GameObject> Effects = new Dictionary<GachaEffectType, GameObject>();
        internal TMP_FontAsset GachaFont { get; private set; }
        internal Material UnitNameMaterial { get; private set; }
        internal Material SerifMaterial { get; private set; }
        // ScreenLayerGachaAnimation.effectFileNames
        static readonly KeyValuePair<GachaEffectType, string>[] effectFileNames =
        {
            new KeyValuePair<GachaEffectType, string>(GachaEffectType.CardR2, "fx_gacha_card_r2_01"),
            new KeyValuePair<GachaEffectType, string>(GachaEffectType.CardR3, "fx_gacha_card_r3_01"),
            new KeyValuePair<GachaEffectType, string>(GachaEffectType.CardR4, "fx_gacha_card_r4_01"),
            new KeyValuePair<GachaEffectType, string>(GachaEffectType.Birthday, "fx_gacha_card_birthday_01"),
            new KeyValuePair<GachaEffectType, string>(GachaEffectType.CardR3AfterTraning, "fx_gacha_card_r3_afterTraining_01"),
            new KeyValuePair<GachaEffectType, string>(GachaEffectType.CardR4AfterTraning, "fx_gacha_card_r4_afterTraining_01"),
        };
        TMP_FontAsset tmpFont;
        Camera fallbackCamera;
        GameObject main;
        readonly Dictionary<string, GachaCardInfo> cardInfos = new Dictionary<string, GachaCardInfo>();
        readonly Dictionary<string, Sprite> stills = new Dictionary<string, Sprite>();
        readonly HashSet<string> obtained = new HashSet<string>();
        Queue<IGachaState> states;
        IGachaState currentState;
        GachaCardRarity maxRarity;
        bool triggerSkip, finished, busy;

        [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
        static void Boot() { if (!FindObjectOfType<GachaApp>()) new GameObject("SekaiGacha").AddComponent<GachaApp>(); }
        void Awake()
        {
            Instance = this;
            Application.runInBackground = true;
            Application.targetFrameRate = 60;
            QualitySettings.vSyncCount = 0;
            tmpFont = TMP_FontAsset.CreateFontAsset(Resources.Load<Font>("GachaFont"));
            fallbackCamera = new GameObject("Loading Camera").AddComponent<Camera>();
            fallbackCamera.clearFlags = CameraClearFlags.SolidColor;
            fallbackCamera.backgroundColor = Color.black;
            fallbackCamera.cullingMask = 0;
            fallbackCamera.GetUniversalAdditionalCameraData().SetRenderer(1);
            fallbackCamera.gameObject.AddComponent<AudioListener>();
            Audio = gameObject.AddComponent<GachaAudio>();
            Assets = new GachaResources(Application.platform == RuntimePlatform.WebGLPlayer ? Application.persistentDataPath : Path.GetFullPath(Path.Combine(Application.dataPath, "../../Cache")));
            StartCoroutine(Guard(Initialize()));
        }
        IEnumerator Initialize()
        {
            var catalogCards = JObject.Parse(Resources.Load<TextAsset>("CardCatalog").text)["cards"];
            foreach (var c in catalogCards)
                cardInfos[(string)c["id"]] = new GachaCardInfo { AssetbundleName = (string)c["id"], CharacterId = (int)c["characterId"], Rarity = (GachaCardRarity)(int)c["rarity"], GachaPhrase = (string)c["phrase"] ?? "" };
            var catalog = catalogCards.Select(c => (string)c["id"]).ToArray();
            GachaPrize[] firstPrizes = null;
            var poolAsset = Resources.Load<TextAsset>("GachaPool");
            // 离线（WebGL）资源只含 CardCatalog 的卡，抽到其他卡会缺资源，因此只在在线模式使用卡池。
            if (poolAsset && Assets.IsOffline) Debug.Log("GACHA_POOL_SKIPPED_OFFLINE");
            else if (poolAsset)
            {
                // 卡池由 Tools/extract_gacha_pool.py 生成；首个十连用卡池模拟，只加载本次抽到的卡。
                var pool = JsonConvert.DeserializeObject<GachaPool>(poolAsset.text);
                var units = pool.gameCharacters.ToDictionary(c => c.id, c => c.unit);
                foreach (var card in pool.cards)
                    cardInfos[card.assetbundleName] = new GachaCardInfo
                    {
                        AssetbundleName = card.assetbundleName, CharacterId = card.characterId, Rarity = GachaCardInfo.ParseRarity(card.cardRarityType),
                        Prefix = card.prefix ?? "", GachaPhrase = card.gachaPhrase ?? "", IsOnlyAfterTraining = card.initialSpecialTrainingStatus == "done",
                        Unit = units.TryGetValue(card.characterId, out var unit) ? unit : null,
                    };
                Lottery = new GachaLottery(pool, GachaLottery.DefaultWishSelection(pool));
                firstPrizes = Draw(Lottery.DefaultTenPullBehavior());
                catalog = Names(firstPrizes).Distinct().ToArray();
            }
            yield return Assets.Initialize();
            yield return Assets.Load("live_pv/sp/gacha/main", "live_pv/sp/gacha/signal", "effect_asset/gacha_obtain_prize", "gacha/sound/se/se_gacha", "character/label", "live_pv/model/mesh_flare_para/textures/9200");
            Audio.Initialize();
            Audio.Load(Assets, "gacha/sound/se/se_gacha");
            yield return LoadCards(catalog.Select(CardInfo));
            // ScreenLayerGachaAnimation.Load：Font/FOT-RodinNTLGPro-EB SDF_Base 与 Gacha / Gacha2 材质（资源包内同名资源）。
            // 材质引用字体图集，只与资源包中的字体搭配；取不到字体（如 WebGL 离线目录）时整体退回本地字体。
            if (Assets.TryGet("effect_asset/gacha_obtain_prize", "FOT-RodinNTLGPro-EB SDF_Base", out TMP_FontAsset font))
            {
                GachaFont = font;
                UnitNameMaterial = Assets.TryGet("effect_asset/gacha_obtain_prize", "FOT-RodinNTLGPro-EB SDF_Base Gacha", out Material unitName) ? unitName : font.material;
                SerifMaterial = Assets.TryGet("effect_asset/gacha_obtain_prize", "FOT-RodinNTLGPro-EB SDF_Base Gacha2", out Material serif) ? serif : font.material;
            }
            else
            {
                GachaFont = tmpFont;
                UnitNameMaterial = SerifMaterial = tmpFont.material;
            }
            if (GachaFont != tmpFont)
            {
                if (GachaFont.fallbackFontAssetTable == null) GachaFont.fallbackFontAssetTable = new List<TMP_FontAsset>();
                if (!GachaFont.fallbackFontAssetTable.Contains(tmpFont)) GachaFont.fallbackFontAssetTable.Add(tmpFont);
            }
            main = InstantiateForSetup(Assets.Get<GameObject>("live_pv/sp/gacha/main", "MainTimeline"));
            main.name = "OriginalGachaTimeline";
            PrepareMain(main);
            Effects[GachaEffectType.Main] = main;
            SetCameras(main, false);
            foreach (var pair in effectFileNames)
            {
                var effect = InstantiateForSetup(Assets.Get<GameObject>("effect_asset/gacha_obtain_prize", pair.Value));
                effect.name = pair.Value;
                SetupCameras(effect);
                SetCameras(effect, false);
                effect.SetActive(false);
                Effects[pair.Key] = effect;
            }
            // 装载结束后跨过当前帧，避免初始化耗时进入演出的首帧时钟。
            yield return null;
            yield return new WaitForEndOfFrame();
            Phase = "就绪";
            Debug.Log("GACHA_READY");
            if (firstPrizes != null) PlayPrizes(firstPrizes);
            else PlayCards(Enumerable.Range(0, 10).Select(_ => catalog[UnityEngine.Random.Range(0, catalog.Length)]).ToArray());
        }
        // 用已加载的卡池执行一次抽卡行为并播放结果。
        public GachaPrize[] PlaySpin(int behaviorId)
        {
            if (Lottery == null) throw new InvalidOperationException("未加载卡池 Resources/GachaPool.json");
            var behavior = Lottery.FindBehavior(behaviorId);
            if (behavior.spinCount > 10) throw new ArgumentException("演出最多 10 张，抽卡行为 " + behaviorId + " 为 " + behavior.spinCount + " 抽", nameof(behaviorId));
            if (busy || (Phase != "就绪" && Phase != "完成")) throw new InvalidOperationException("演出正在进行");
            var prizes = Draw(behavior);
            PlayPrizes(prizes);
            return prizes;
        }
        void PlayPrizes(GachaPrize[] prizes)
        {
            PlayCards(Names(prizes));
            CurrentPrizes = prizes;
        }
        GachaPrize[] Draw(MasterGachaBehavior behavior)
        {
            var prizes = Lottery.Spin(behavior, new SystemRandomSource());
            Debug.Log("GACHA_DRAW gacha=" + Lottery.Gacha.id + " behavior=" + behavior.id + " " + string.Join(" ", prizes.Select(p =>
                p.Card.assetbundleName + "(" + p.Card.cardRarityType + (p.IsGuaranteedSlot ? ",保底" : "") + ")")));
            return prizes;
        }
        static string[] Names(GachaPrize[] prizes) => prizes.Select(p => p.Card.assetbundleName).ToArray();
        static GameObject InstantiateForSetup(GameObject prefab)
        {
            // 先完成管理器和轨道绑定，再由外壳启动原版 Timeline。
            foreach (var director in prefab.GetComponentsInChildren<PlayableDirector>(true)) director.playOnAwake = false;
            return Instantiate(prefab);
        }
        GachaCardInfo CardInfo(string card)
        {
            if (!cardInfos.TryGetValue(card, out var info)) throw new ArgumentException("没有卡牌数据 " + card + "（不在 GachaPool.json / CardCatalog.json 中）");
            return info;
        }
        internal Sprite MemberStill(string card, string fileName)
        {
            string key = card + "/" + fileName;
            if (stills.TryGetValue(key, out var sprite)) return sprite;
            var texture = Assets.Get<Texture2D>("character/member/" + card, fileName);
            sprite = Sprite.Create(texture, new Rect(0, 0, texture.width, texture.height), new Vector2(.5f, .5f));
            stills.Add(key, sprite);
            return sprite;
        }
        // GachaDisplayState 用到的资源包：★2 为 member_gacha + unit_background，★3 以上为 member + 获得语音。
        IEnumerator LoadCards(IEnumerable<GachaCardInfo> results)
        {
            foreach (var info in results.Distinct())
            {
                string id = info.AssetbundleName;
                var bundles = new List<string>();
                if (info.Rarity == GachaCardRarity.rarity_2) { bundles.Add("character/member_gacha/" + id); bundles.Add("unit_background"); }
                else bundles.Add("character/member/" + id);
                foreach (string bundle in bundles)
                    if (!Assets.Has(bundle))
                        throw new InvalidDataException("资源版本 " + Assets.AssetVersion + " 中没有 " + bundle + "（卡池数据比资源版本新），运行 python3 Tools/extract_gacha_pool.py --fetch 更新 ResourceVersion.json");
                string voice = "sound/gacha/get_voice/" + id;
                bool hasVoice = info.Rarity != GachaCardRarity.rarity_2 && Assets.Has(voice);
                if (hasVoice) bundles.Add(voice);
                else if (info.Rarity != GachaCardRarity.rarity_2) Debug.LogWarning("GACHA_NO_VOICE " + id);
                yield return Assets.Load(bundles.ToArray());
                if (hasVoice) Audio.Load(Assets, voice);
            }
        }
        // 接收上层给出的结果（卡牌资源名），按原版 ScreenLayerGachaAnimation 的状态队列播放。
        public void PlayCards(string[] results)
        {
            if (busy || (Phase != "就绪" && Phase != "完成")) throw new InvalidOperationException("演出正在进行");
            if (results == null || results.Length < 1 || results.Length > 10 || results.Any(id => !System.Text.RegularExpressions.Regex.IsMatch(id ?? "", @"^res\d+_no\d+$")))
                throw new ArgumentException("需要 1 至 10 个有效卡牌资源名", nameof(results));
            var infos = results.Select(CardInfo).ToArray();
            CurrentResults = (string[])results.Clone();
            CurrentPrizes = null;
            // newFlg 由服务端给出；模拟时按本次运行中是否首次获得。
            var prizes = infos.Select(info =>
            {
                var prize = new GachaCardInfo
                {
                    AssetbundleName = info.AssetbundleName, CharacterId = info.CharacterId, Rarity = info.Rarity, Prefix = info.Prefix,
                    GachaPhrase = info.GachaPhrase, IsOnlyAfterTraining = info.IsOnlyAfterTraining, Unit = info.Unit, IsNew = obtained.Add(info.AssetbundleName),
                };
                return prize;
            }).ToArray();
            busy = true;
            StartCoroutine(Guard(Play(prizes)));
        }
        IEnumerator Play(GachaCardInfo[] prizes)
        {
            Phase = "加载";
            yield return LoadCards(prizes);
            DrawCount = prizes.Length;
            RevealedCount = 0;
            MaximumFrameMs = 0;
            SlowFrames = 0;
            maxRarity = prizes.Max(p => p.Rarity);
            // ScreenLayerGachaAnimation.CreateState
            states = new Queue<IGachaState>();
            states.Enqueue(new GachaTapWaitState(prizes));
            states.Enqueue(new GachaSpawnAnimationState());
            foreach (var prize in prizes) states.Enqueue(new GachaDisplayState(prize));
            currentState = null;
            triggerSkip = false;
            finished = false;
            fallbackCamera.enabled = false;
            Phase = "3D演出";
            NextState();
            while (!finished)
            {
                // ScreenLayerGachaAnimation：全屏按钮 → currentState.Click；Escape → OnClickSkipButton。
                if (Input.GetKeyDown(KeyCode.Escape)) OnClickSkipButton();
                else if (Input.GetMouseButtonDown(0)) currentState?.Click(this);
                if (!finished) currentState?.Execute(this);
                yield return null;
            }
            Phase = "完成";
            busy = false;
            Debug.Log("GACHA_COMPLETE count=" + DrawCount + " revealed=" + RevealedCount + " voices=" + Audio.VoiceCount + " peak=" + Audio.VoicePeak + " maximumFrameMs=" + MaximumFrameMs + " framesOver100ms=" + SlowFrames);
            PlaybackCompleted?.Invoke();
        }
        void OnClickSkipButton()
        {
            Audio.PlaySe("SE_DECIDE1");
            triggerSkip = true;
            Audio.StopSe();
            NextState();
        }
        // ScreenLayerGachaAnimation.NextState / DequeueNext
        internal void NextState()
        {
            if (states != null && states.Count >= 1)
            {
                currentState?.Exit(this);
                if (!DequeueNext(out currentState)) OnFinished(null);
                else currentState.Init(this);
            }
            else OnFinished(currentState);
        }
        bool DequeueNext(out IGachaState nextState)
        {
            nextState = states.Dequeue();
            if (triggerSkip)
            {
                while (nextState.IsEnableSkip)
                {
                    nextState.Exit(this);
                    if (states.Count != 0)
                    {
                        nextState = states.Dequeue();
                        if (!triggerSkip) break;
                        continue;
                    }
                    return false;
                }
            }
            return true;
        }
        // 原版转到 GachaResult 结算界面（安装包内置 UI，未接入）；这里停在最后一张卡的末尾展示段。
        void OnFinished(IGachaState last)
        {
            if (finished) return;
            finished = true;
            (last as GachaDisplayState)?.Hold();
            currentState = null;
        }
        internal void OnReveal(GachaCardInfo card)
        {
            Phase = "揭卡";
            RevealedCount++;
            Debug.Log("GACHA_REVEAL " + RevealedCount + "/" + DrawCount + " " + card.AssetbundleName + " " + card.Rarity + (card.IsNew ? " new" : ""));
        }
        internal void ShowEffect(GameObject effect)
        {
            SetCameras(effect, true);
            effect.SetActive(true);
        }
        // 运行时实例化到已配置对象下的预制体，沿用所在演出的图层与音效回调。
        internal void PrepareSpawned(GameObject root, GameObject spawned)
        {
            foreach (var node in spawned.GetComponentsInChildren<Transform>(true)) node.gameObject.layer = root.layer;
            foreach (var animator in spawned.GetComponentsInChildren<Animator>(true)) animator.cullingMode = AnimatorCullingMode.AlwaysAnimate;
            foreach (var se in spawned.GetComponentsInChildren<Sekai.AnimationClipSoundEvent>(true)) se.OnPlaySeAction = Audio.PlaySe;
        }
        void Update()
        {
            if (Phase != "3D演出" && Phase != "揭卡") return;
            float ms = Time.unscaledDeltaTime * 1000;
            MaximumFrameMs = Mathf.Max(MaximumFrameMs, ms);
            if (ms > 100)
            {
                SlowFrames++;
                Debug.Log("GACHA_SLOW_FRAME ms=" + ms + " phase=" + Phase + " time=" + (CurrentDirector ? CurrentDirector.time : 0));
            }
        }
        IEnumerator Guard(IEnumerator routine)
        {
            var stack = new Stack<IEnumerator>();
            stack.Push(routine);
            while (stack.Count > 0)
            {
                object value;
                bool next;
                try { next = stack.Peek().MoveNext(); value = next ? stack.Peek().Current : null; }
                catch (Exception error)
                {
                    Error = error.ToString();
                    Phase = "失败";
                    Debug.LogException(error);
                    yield break;
                }
                if (!next) { stack.Pop(); continue; }
                if (value is IEnumerator child) stack.Push(child);
                else yield return value;
            }
        }
        void PrepareMain(GameObject root)
        {
            var director = root.transform.Find("Timeline").GetComponent<PlayableDirector>();
            director.Stop();
            director.playOnAwake = false;
            // 奖品槽、预兆特效、舞台贴图、光照与反射特效按本次结果在 GachaTapWaitState.Init 中设置。
            SetupCameras(root);
            foreach (var model in root.GetComponentsInChildren<Sekai.Core.CharacterModel>(true)) model.Setup(21, new Sekai.Live.CharacterSetupSignals(false), 1.58f, new Sekai.Scripts.Live.Common.CharacterLightData(root.GetComponentInChildren<Sekai.SekaiDirectionalLight>(true)), new Color[] { new Color32(254,246,236,255), new Color32(228,197,204,255), new Color32(204,152,163,255) });
            foreach (var flare in root.GetComponentsInChildren<Sekai.Core.MeshFlareParaController>(true))
                flare.Setup(root.GetComponentInChildren<Sekai.Core.Graphics.PostEffectV2>(true).GetComponent<Camera>(), Assets.Get<Sekai.Core.MeshFlareParaTexData>("live_pv/model/mesh_flare_para/textures/9200", "MeshFlareParaTexData").Texture2Ds);
            foreach (var signalTrack in root.GetComponentsInChildren<PlayableDirector>(true))
            {
                var effectManager = signalTrack.gameObject.GetComponent<Sekai.Live.LiveEffectTimelineManager>() ?? signalTrack.gameObject.AddComponent<Sekai.Live.LiveEffectTimelineManager>();
                effectManager.Setup(false, -1);
                var receiver = signalTrack.gameObject.GetComponent<SignalReceiver>() ?? signalTrack.gameObject.AddComponent<SignalReceiver>();
                var signal = Assets.Get<SignalAsset>("live_pv/sp/gacha/signal", "GachaSESignal");
                if (receiver.GetReaction(signal) == null)
                {
                    var reaction = new UnityEngine.Events.UnityEvent();
                    // ScreenLayerGachaAnimation.OnPlayTimelineSE
                    reaction.AddListener(() => Audio.PlaySe(((int)maxRarity & ~1) != 4 ? "SE_GACHA_BRANCH_1_3RD_ANV" : "SE_GACHA_BRANCH_2_3RD_ANV"));
                    receiver.AddReaction(signal, reaction);
                }
                if (signalTrack.playableAsset is TimelineAsset childTimeline)
                    foreach (var track in childTimeline.GetOutputTracks())
                        if (track is SignalTrack) signalTrack.SetGenericBinding(track, receiver);
            }
        }
        void SetupCameras(GameObject root)
        {
            foreach (var node in root.GetComponentsInChildren<Transform>(true)) node.gameObject.layer = root == main ? 8 : 9;
            foreach (var camera in root.GetComponentsInChildren<Camera>(true))
            {
                camera.targetTexture = null;
                camera.cullingMask = (1 << (root == main ? 8 : 9)) | (1 << Sekai.LayerID.LiveMV);
                var data = camera.GetComponent<UnityEngine.Rendering.Universal.UniversalAdditionalCameraData>();
                if (data) { data.SetRenderer(0); data.renderPostProcessing = false; data.volumeLayerMask = 1 << camera.gameObject.layer; }
                var listener = camera.GetComponent<AudioListener>();
                if (listener) Destroy(listener);
            }
            foreach(var post in root.GetComponentsInChildren<Sekai.Core.Graphics.PostEffectV2>(true)) post.Setup();
            foreach (var animator in root.GetComponentsInChildren<Animator>(true)) animator.cullingMode = AnimatorCullingMode.AlwaysAnimate;
            foreach (var se in root.GetComponentsInChildren<Sekai.AnimationClipSoundEvent>(true)) se.OnPlaySeAction = Audio.PlaySe;
            foreach (var director in root.GetComponentsInChildren<PlayableDirector>(true))
            {
                if (!(director.playableAsset is TimelineAsset timeline)) continue;
                var post = root.GetComponentInChildren<Sekai.Core.Graphics.PostEffectV2>(true);
                foreach (var track in timeline.GetOutputTracks())
                    if (track is Sekai.Core.Live.PostEffectTrackAsset || track is Sekai.Core.Live.LutTrack) director.SetGenericBinding(track, post);
                    else if (track is Sekai.Core.Live.MeshFlareParaTrack) director.SetGenericBinding(track, root.GetComponentInChildren<Sekai.Core.MeshFlareParaController>(true));
            }
        }
        static void SetCameras(GameObject root, bool enabled)
        {
            foreach (var post in root.GetComponentsInChildren<Sekai.Core.Graphics.PostEffectV2>(true)) post.enabled = enabled;
            foreach (var camera in root.GetComponentsInChildren<Camera>(true)) camera.enabled = enabled;
        }

        void OnDestroy()
        {
            if (main) foreach (var director in main.GetComponentsInChildren<PlayableDirector>(true)) director.Stop();
            foreach (var effect in Effects.Values) if (effect && effect != main) foreach (var director in effect.GetComponentsInChildren<PlayableDirector>(true)) director.Stop();
            foreach (var effect in Effects.Values) if (effect) Destroy(effect);
            Assets?.Dispose();
            if (Instance == this) Instance = null;
        }
    }
}
