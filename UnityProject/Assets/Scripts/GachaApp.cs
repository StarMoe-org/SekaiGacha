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
        // 原版 GachaDisplayState.WaitTime，真机只读核对为 2 秒。
        const double CardEndWaitSeconds = 2;
        public static GachaApp Instance { get; private set; }
        public string Phase { get; private set; } = "加载";
        public string Error { get; private set; }
        public int RevealedCount { get; private set; }
        public int DrawCount { get; private set; }
        public string[] CurrentResults { get; private set; }
        public PlayableDirector CurrentDirector { get; private set; }
        public GachaAudio Audio { get; private set; }
        public GachaResources Assets { get; private set; }
        // Resources/GachaPool.json 存在时加载的卡池；否则为 null，沿用 CardCatalog 随机演示。
        public GachaLottery Lottery { get; private set; }
        public GachaPrize[] CurrentPrizes { get; private set; }
        public float MaximumFrameMs { get; private set; }
        public int SlowFrames { get; private set; }
        public event Action PlaybackCompleted;
        TMP_FontAsset tmpFont;
        Camera fallbackCamera;
        GameObject main, reveal;
        readonly List<GameObject> effects = new List<GameObject>();
        readonly List<GameObject> prizeSlots = new List<GameObject>();
        readonly Dictionary<string, Sprite> cards = new Dictionary<string, Sprite>();
        bool busy;

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
            var catalog = JObject.Parse(Resources.Load<TextAsset>("CardCatalog").text)["cards"].Select(c => (string)c["id"]).ToArray();
            GachaPrize[] firstPrizes = null;
            var poolAsset = Resources.Load<TextAsset>("GachaPool");
            // 离线（WebGL）资源只含 CardCatalog 的卡，抽到其他卡会缺资源，因此只在在线模式使用卡池。
            if (poolAsset && Assets.IsOffline) Debug.Log("GACHA_POOL_SKIPPED_OFFLINE");
            else if (poolAsset)
            {
                // 卡池由 Tools/extract_gacha_pool.py 生成；首个十连用卡池模拟，只加载本次抽到的卡。
                var pool = JsonConvert.DeserializeObject<GachaPool>(poolAsset.text);
                Lottery = new GachaLottery(pool, GachaLottery.DefaultWishSelection(pool));
                firstPrizes = Draw(Lottery.DefaultTenPullBehavior());
                catalog = Names(firstPrizes).Distinct().ToArray();
            }
            yield return Assets.Initialize();
            yield return Assets.Load("live_pv/sp/gacha/main", "live_pv/sp/gacha/signal", "effect_asset/gacha_obtain_prize", "gacha/sound/se/se_gacha", "character/label", "live_pv/model/mesh_flare_para/textures/9200");
            Audio.Initialize();
            Audio.Load(Assets, "gacha/sound/se/se_gacha");
            yield return LoadCards(catalog);
            main = InstantiateForSetup(Assets.Get<GameObject>("live_pv/sp/gacha/main", "MainTimeline"));
            main.name = "OriginalGachaTimeline";
            PrepareMain(main, 10);
            reveal = InstantiateForSetup(Assets.Get<GameObject>("effect_asset/gacha_obtain_prize", "fx_gacha_card_r4_01"));
            effects.Add(reveal);
            SetupReveal(reveal, cards[catalog[0]], CharacterId(catalog[0]));
            SetCameras(main, false);
            SetCameras(reveal, false);
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
        static int CharacterId(string card) => int.Parse(card.Substring(3, card.IndexOf('_') - 3));
        IEnumerator LoadCards(IEnumerable<string> results)
        {
            foreach (string id in results.Distinct())
            {
                if (cards.ContainsKey(id)) continue;
                // 卡池模拟会抽到 ★2/★3；资源清单里没有获得语音的卡只显示卡面，不播语音。
                string voice = "sound/gacha/get_voice/" + id;
                if (Assets.Has(voice))
                {
                    yield return Assets.Load("character/member/" + id, voice);
                    Audio.Load(Assets, voice);
                }
                else
                {
                    Debug.LogWarning("GACHA_NO_VOICE " + id);
                    yield return Assets.Load("character/member/" + id);
                }
                var texture = Assets.Get<Texture2D>("character/member/" + id, "card_normal");
                cards.Add(id, Sprite.Create(texture, new Rect(0, 0, texture.width, texture.height), new Vector2(.5f, .5f)));
            }
        }
        // 接收上层给出的结果；当前只播放四星演出，不执行账号或真实抽卡请求。
        public void PlayCards(string[] results)
        {
            if (busy || (Phase != "就绪" && Phase != "完成")) throw new InvalidOperationException("演出正在进行");
            if (results == null || results.Length < 1 || results.Length > 10 || results.Any(id => !System.Text.RegularExpressions.Regex.IsMatch(id ?? "", @"^res\d+_no\d+$")))
                throw new ArgumentException("需要 1 至 10 个有效卡牌资源名", nameof(results));
            CurrentResults = (string[])results.Clone();
            CurrentPrizes = null;
            busy = true;
            StartCoroutine(Guard(Play()));
        }
        IEnumerator Play()
        {
            Phase = "加载";
            yield return LoadCards(CurrentResults);
            DrawCount = CurrentResults.Length;
            RevealedCount = 0;
            MaximumFrameMs = 0;
            SlowFrames = 0;
            for (int i = 0; i < prizeSlots.Count; i++) prizeSlots[i].SetActive(i < DrawCount);
            fallbackCamera.enabled = false;
            SetCameras(reveal, false);
            main.SetActive(true);
            SetCameras(main, true);
            Phase = "3D演出";
            yield return PlayTimeline(main, true);
            main.SetActive(false);
            foreach (string card in CurrentResults)
            {
                SetupReveal(reveal, cards[card], CharacterId(card));
                SetCameras(main, false);
                SetCameras(reveal, true);
                Phase = "揭卡";
                Audio.PlayVoice(card);
                RevealedCount++;
                Debug.Log("GACHA_REVEAL " + RevealedCount + "/" + DrawCount + " " + card);
                yield return PlayTimeline(reveal, false);
            }
            // 无结算界面时停留在原版点击跳转使用的末尾展示段。
            CurrentDirector.time = Math.Max(0, CurrentDirector.duration - CardEndWaitSeconds);
            CurrentDirector.Evaluate();
            CurrentDirector.Pause();
            Phase = "完成";
            busy = false;
            Debug.Log("GACHA_COMPLETE count=" + DrawCount + " voices=" + Audio.VoiceCount + " peak=" + Audio.VoicePeak + " maximumFrameMs=" + MaximumFrameMs + " framesOver100ms=" + SlowFrames);
            PlaybackCompleted?.Invoke();
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
        void PrepareMain(GameObject root, int count)
        {
            var director = root.transform.Find("Timeline").GetComponent<PlayableDirector>();
            director.Stop();
            director.playOnAwake = false;
            var timeline = (TimelineAsset)director.playableAsset;
            string[] slots = { "rot_10/10", "rot_g/rot_move/pos_rot_09/sub_rot/09", "rot_g/rot_move/pos_rot_08/sub_rot/08", "rot_g/rot_move/pos_rot_07/sub_rot/07", "rot_g/rot_move/pos_rot_06/sub_rot/06", "rot_g/rot_move/pos_rot_05/sub_rot/05", "rot_g/rot_move/pos_rot_04/sub_rot/04", "rot_g/rot_move/pos_rot_03/sub_rot/03", "rot_g/rot_move/pos_rot_02/sub_rot/02", "rot_g/rot_move/pos_rot_01/sub_rot/01" };
            var prizeRoot = root.transform.Find("gatya/root");
            for (int i = 0; i < slots.Length; i++)
            {
                var slot = prizeRoot.Find(slots[i]);
                foreach (Transform child in slot) Destroy(child.gameObject);
                prizeSlots.Add(Instantiate(Assets.Get<GameObject>("live_pv/sp/gacha/effect", "eff_9200_gatya_r04"), slot, false));
            }
            var effectRoot = root.transform.Find("Effect");
            foreach (Transform child in effectRoot) child.gameObject.SetActive(false);
            var omoi = effectRoot.Find("eff_9200_omoi_r04");
            foreach (var track in timeline.GetOutputTracks())
            {
                if (track.name == "OmoiEffect") director.SetGenericBinding(track, omoi.gameObject);
                if (track.name == "OmoiAnimation") director.SetGenericBinding(track, omoi.GetComponent<Animator>() ?? omoi.gameObject.AddComponent<Animator>());
                if (track.name == "Light")
                    foreach (var clip in track.GetClips())
                        if (clip.displayName == "gatya_light" && clip.asset is AnimationPlayableAsset animation) animation.clip = Assets.Get<AnimationClip>("live_pv/sp/gacha/timeline", "gatya_light_9100_p");
                if (track.name == "eff_9200_hansya_gosen_r02")
                    foreach (var clip in track.GetClips())
                        if (clip.displayName == "eff_9200_hansya_gosen_r02" && clip.asset is LiveEffectClip effect) effect.template.prefab = Assets.Get<GameObject>("live_pv/sp/gacha/effect", "eff_9200_hansya_gosen_r04");
                if (track is CP.Timeline.LoopTrack) track.muted = false;
            }
            var sphere = root.transform.Find("Stage/stage/stage_9200/Root/stage_9200/pSphere1");
            if (sphere) sphere.GetComponent<Renderer>().material.mainTexture = Assets.Get<Texture>("live_pv/sp/gacha/model/stage", "stage_tex_02");
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
                    reaction.AddListener(() => Audio.PlaySe("SE_GACHA_BRANCH_2_3RD_ANV"));
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
        void SetupReveal(GameObject root, Sprite sprite, int character)
        {
            string[] names = { "root/MainCamera/Main_card", "root/MainCamera/Main_card_blur", "root/MainCamera/Main_card_add" };
            foreach (string name in names)
            {
                var renderer = root.transform.Find(name).GetComponent<SpriteRenderer>();
                Vector2 size = renderer.size;
                renderer.sprite = sprite;
                renderer.size = size;
            }
            var label = root.transform.Find("root/member_name").GetComponent<SpriteRenderer>();
            label.sprite = Assets.Get<Sprite>("character/label", "chr_name_h_" + character);
            root.transform.Find("root/new").GetComponent<SpriteRenderer>().enabled = true;
            foreach (var text in root.GetComponentsInChildren<TMP_Text>(true)) { text.font = tmpFont; text.text = ""; }
            SetupCameras(root);
        }
        IEnumerator PlayTimeline(GameObject root, bool intro)
        {
            var director = intro ? root.transform.Find("Timeline").GetComponent<PlayableDirector>() : root.GetComponent<PlayableDirector>();
            CurrentDirector = director;
            director.Stop();
            director.extrapolationMode = intro ? DirectorWrapMode.Hold : DirectorWrapMode.None;
            director.time = 0;
            director.Play();
            Debug.Log("GACHA_TIMELINE " + root.name + " duration=" + director.duration);
            if (intro)
            {
                var loop = ((TimelineAsset)director.playableAsset).GetOutputTracks().OfType<CP.Timeline.LoopTrack>().Single().GetClips().Single();
                while (director.time <= loop.start) yield return null;
                // 自动点击代替等待 UI；原 LoopBehaviour 负责调整衔接。
                director.GetComponent<CP.Timeline.LoopWaitTimeline>().Trigger = true;
                Audio.PlaySe("SE_GACHA_TAP_3RD_ANV");
                var state = new GachaSpawnPlayback(root);
                bool next = false;
                while (!next)
                {
                    state.Execute(() => next = true, Audio.PlaySe);
                    yield return null;
                }
            }
            else
            {
                // 源自 Cpp2CS GachaDisplayState.Execute。
                while (director.state == PlayState.Playing) yield return null;
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
            foreach (var effect in effects) if (effect) foreach (var director in effect.GetComponentsInChildren<PlayableDirector>(true)) director.Stop();
            if (main) Destroy(main);
            foreach (var effect in effects) if (effect) Destroy(effect);
            Assets?.Dispose();
            if (Instance == this) Instance = null;
        }
    }
}
