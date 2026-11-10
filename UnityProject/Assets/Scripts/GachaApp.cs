using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Newtonsoft.Json.Linq;
using TMPro;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Rendering.Universal;
using UnityEngine.TextCore.LowLevel;
using UnityEngine.Timeline;
using UnityEngine.UI;

namespace SekaiGacha
{
    public sealed class GachaApp : MonoBehaviour
    {
        // 原版 GachaDisplayState.WaitTime，真机只读核对为 2 秒。
        const double CardEndWaitSeconds = 2;
        public static GachaApp Instance { get; private set; }
        public string Phase { get; private set; } = "加载";
        public string Error { get; private set; }
        // 初始化完成后为 true；之后可多次播放，单次播放失败也可以重试。
        public bool Ready { get; private set; }
        public bool CanPlay => Ready && !busy;
        public int RevealedCount { get; private set; }
        public int DrawCount { get; private set; }
        public string[] CurrentResults { get; private set; }
        public PlayableDirector CurrentDirector { get; private set; }
        public GachaAudio Audio { get; private set; }
        public GachaResources Assets { get; private set; }
        public GachaAssetBucket Bucket { get; private set; }
        public float MaximumFrameMs { get; private set; }
        public int SlowFrames { get; private set; }
        public event Action PlaybackCompleted;
        TMP_FontAsset tmpFont;
        // 原版 ScreenLayerGachaAnimation.LoadedMaterial：卡名用 Gacha，招募台词用 Gacha2。
        Material unitNameMaterial, phraseMaterial;
        Camera fallbackCamera;
        // 原版 ScreenLayerGachaAnimation.tapToStartObj。
        GameObject tapToStart;
        // 原版铺满画面的 screenButton 的一次点击，交给当前状态的 Click 处理。
        bool pointerDown, clickRequested;
        GameObject main, reveal;
        readonly List<GameObject> effects = new List<GameObject>();
        // 每个槽位预置 ★2/★3/★4 三种特效，按本次结果启用其一。
        readonly List<GameObject[]> prizeSlots = new List<GameObject[]>();
        // 揭卡演出按稀有度选用，与原版 ScreenLayerGachaAnimation.Effects 相同，预先全部实例化。
        readonly Dictionary<string, GameObject> reveals = new Dictionary<string, GameObject>();
        GachaCard[] currentCards;
        GachaRarity maxRarity = GachaRarity.Rarity4;
        readonly Dictionary<string, Sprite> cards = new Dictionary<string, Sprite>();
        readonly Dictionary<string, GachaAssetBucket.Card> cardMedia = new Dictionary<string, GachaAssetBucket.Card>();
        bool busy;
        // 原版 ScreenLayerGachaAnimation.triggerSkip：按下跳过后直到演出结束都保持，DequeueNext 据此跳过可跳的状态。
        bool triggerSkip;
        // 一次跳过（原版 OnClickSkipButton 里的 NextState）：立即结束当前状态。
        bool skipPressed;
        // 宿主要求立即结束（关闭页面等）；原版没有，嵌入专用。
        bool finishRequested;
        // 每张卡都按新获得处理：root/new 始终显示，★3 也因此不可跳过（原版 GachaDisplayState.IsEnableSkip）。
        const bool NewCard = true;

        [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
        static void Boot() { if (!FindObjectOfType<GachaApp>()) new GameObject("SekaiGacha").AddComponent<GachaApp>(); }
        void Awake()
        {
            Instance = this;
            Application.runInBackground = true;
#if UNITY_WEBGL && !UNITY_EDITOR
            // 浏览器按 requestAnimationFrame 驱动；设定帧率会改用定时器，容易卡顿。
            Application.targetFrameRate = -1;
#else
            Application.targetFrameRate = 60;
#endif
            QualitySettings.vSyncCount = 0;
            // GachaFont 即原版 FOT-RodinNTLG Pro EB；包内的 SDF_Base 只是占位，按原版生成参数（35pt、padding 5）
            // 动态生成图集，原版材质的描边和粗细才能原样使用。
            tmpFont = TMP_FontAsset.CreateFontAsset(Resources.Load<Font>("GachaFont"), 35, 5, GlyphRenderMode.SDFAA, 1024, 1024, AtlasPopulationMode.Dynamic, true);
            fallbackCamera = new GameObject("Loading Camera").AddComponent<Camera>();
            fallbackCamera.clearFlags = CameraClearFlags.SolidColor;
            fallbackCamera.backgroundColor = Color.black;
            fallbackCamera.cullingMask = 0;
            fallbackCamera.GetUniversalAdditionalCameraData().SetRenderer(1);
            fallbackCamera.gameObject.AddComponent<AudioListener>();
            CreateTapToStart();
            Audio = gameObject.AddComponent<GachaAudio>();
            gameObject.AddComponent<GachaEmbed>();
            Assets = new GachaResources();
            Bucket = new GachaAssetBucket(this);
            Debug.Log("GACHA_CLIENT " + GachaAssetBucket.UserAgent);
            StartCoroutine(Guard(Initialize()));
        }
        IEnumerator Initialize()
        {
            var catalog = JObject.Parse(Resources.Load<TextAsset>("CardCatalog").text)["cards"]
                .Select(c => new GachaCard((string)c["id"], (GachaRarity)(int)c["rarity"], (string)c["prefix"] ?? "", (string)c["phrase"] ?? "")).ToArray();
            yield return Assets.Initialize();
            unitNameMaterial = TextMaterial("FOT-RodinNTLGPro-EB SDF_Base Gacha");
            phraseMaterial = TextMaterial("FOT-RodinNTLGPro-EB SDF_Base Gacha2");
            Audio.Initialize();
            Audio.Load(Assets, "gacha/sound/se/se_gacha");
            Audio.LoadBuiltIn("MenuCommon_Built_in");
            yield return LoadCards(catalog);
            main = InstantiateForSetup(Assets.Get<GameObject>("live_pv/sp/gacha/main", "MainTimeline"));
            main.name = "OriginalGachaTimeline";
            PrepareMain(main);
            foreach (string name in RevealEffects)
            {
                var effect = InstantiateForSetup(Assets.Get<GameObject>("effect_asset/gacha_obtain_prize", name));
                effect.name = name;
                reveals.Add(name, effect);
                effects.Add(effect);
                SetupCameras(effect);
                SetCameras(effect, false);
                effect.SetActive(false);
            }
            SetupReveal(catalog[0]);
            SetCameras(main, false);
            SetCameras(reveal, false);
            // 装载结束后跨过当前帧，避免初始化耗时进入演出的首帧时钟。
            yield return null;
            yield return new WaitForEndOfFrame();
            Phase = "就绪";
            Ready = true;
            Debug.Log("GACHA_READY");
            // 嵌入网页时等宿主指定卡牌，否则自动播放演示十连。
            if (!GachaEmbed.Embedded) PlayCards(Enumerable.Range(0, 10).Select(_ => catalog[UnityEngine.Random.Range(0, catalog.Length)]).ToArray());
        }
        static GameObject InstantiateForSetup(GameObject prefab)
        {
            // 先完成管理器和轨道绑定，再由外壳启动原版 Timeline。
            foreach (var director in prefab.GetComponentsInChildren<PlayableDirector>(true)) director.playOnAwake = false;
            return Instantiate(prefab);
        }
        IEnumerator LoadCards(GachaCard[] draw)
        {
            yield return Bucket.Load(draw, cardMedia);
            var results = draw.Select(card => card.Id).ToArray();
            foreach (string id in results.Distinct())
            {
                if (cards.ContainsKey(id)) continue;
                var texture = cardMedia[id].Art;
                cards.Add(id, Sprite.Create(texture, new Rect(0, 0, texture.width, texture.height), new Vector2(.5f, .5f), 100, 0, SpriteMeshType.FullRect));
            }
            // 只保留本次结果用到的卡，避免浏览器里纹理随抽卡次数累积。
            foreach (string id in cards.Keys.Except(results).ToArray()) ReleaseCard(id);
        }
        void ReleaseCard(string id)
        {
            if (cards.TryGetValue(id, out var sprite)) Destroy(sprite);
            if (cardMedia.TryGetValue(id, out var media)) media.Release();
            cards.Remove(id);
            cardMedia.Remove(id);
        }
        // 只给资源名的旧调用：不知道稀有度，按 ★4 演出播放。
        public void PlayCards(string[] results)
        {
            if (results == null || results.Any(id => !GachaCard.IsValidId(id)))
                throw new ArgumentException("需要 1 至 10 个有效卡牌资源名", nameof(results));
            PlayCards(results.Select(id => new GachaCard(id, GachaRarity.Rarity4)).ToArray());
        }
        // 接收上层给出的结果，按每张卡的稀有度演出；不执行账号或真实抽卡请求。
        public void PlayCards(GachaCard[] draw)
        {
            if (!CanPlay) throw new InvalidOperationException("演出正在进行");
            if (draw == null || draw.Length < 1 || draw.Length > 10 || draw.Any(card => card.Id == null))
                throw new ArgumentException("需要 1 至 10 个有效卡牌资源名", nameof(draw));
            currentCards = (GachaCard[])draw.Clone();
            CurrentResults = currentCards.Select(card => card.Id).ToArray();
            Error = null;
            triggerSkip = skipPressed = finishRequested = false;
            clickRequested = false;
            busy = true;
            StartCoroutine(Guard(Play()));
        }
        IEnumerator Play()
        {
            DrawCount = CurrentResults.Length;
            RevealedCount = 0;
            Phase = "加载";
            yield return LoadCards(currentCards);
            MaximumFrameMs = 0;
            SlowFrames = 0;
            SetupMain(currentCards);
            fallbackCamera.enabled = false;
            SetCameras(reveal, false);
            main.SetActive(true);
            SetCameras(main, true);
            Phase = "3D演出";
            // 原版 CreateState：GachaTapWaitState、GachaSpawnAnimationState，再每张卡一个 GachaDisplayState。
            // 开场两段 IsEnableSkip 都为 true，已在跳过模式（下载卡牌期间按了跳过）时由 DequeueNext 直接跳过。
            if (!triggerSkip && !finishRequested) yield return PlayTimeline(main, true);
            skipPressed = false;
            if (triggerSkip || finishRequested) main.transform.Find("Timeline").GetComponent<PlayableDirector>().Stop();
            main.SetActive(false);
            bool shown = false;
            for (int i = 0; i < currentCards.Length && !finishRequested; i++)
            {
                var card = currentCards[i];
                RevealedCount = i + 1;
                // 原版 DequeueNext：triggerSkip 后跳过 IsEnableSkip 的 GachaDisplayState。
                if (triggerSkip && IsEnableSkip(card))
                {
                    Debug.Log("GACHA_SKIP_CARD " + RevealedCount + "/" + DrawCount + " " + card.Id + " " + card.Rarity);
                    continue;
                }
                SetupReveal(card);
                SetCameras(main, false);
                SetCameras(reveal, true);
                Phase = "揭卡";
                // 原版 ★2 不播获得语音（GachaDisplayState 只对 ★3 以上调用 SetupVoice）。
                if (card.Rarity != GachaRarity.Rarity2) Audio.PlayVoice(card.Id, cardMedia[card.Id].Voice);
                shown = true;
                Debug.Log("GACHA_REVEAL " + RevealedCount + "/" + DrawCount + " " + card.Id + " " + card.Rarity + " " + reveal.name);
                yield return PlayTimeline(reveal, false);
                skipPressed = false;
            }
            RevealedCount = DrawCount;
            if (finishRequested || !shown)
            {
                // 原版此后进入结算画面；这里没有结算画面，宿主要求立即结束或跳过后一张也没展示时，
                // 停在最后一张卡的末尾展示段。
                SetupReveal(currentCards[currentCards.Length - 1]);
                SetCameras(main, false);
                SetCameras(reveal, true);
                CurrentDirector = reveal.GetComponent<PlayableDirector>();
                CurrentDirector.extrapolationMode = DirectorWrapMode.None;
                CurrentDirector.Play();
                Debug.Log("GACHA_SKIPPED");
            }
            // 无结算界面时停留在原版点击跳转使用的末尾展示段。
            CurrentDirector.time = Math.Max(0, CurrentDirector.duration - CardEndWaitSeconds);
            CurrentDirector.Evaluate();
            CurrentDirector.Pause();
            // 原版跳过后各状态 Exit 时卸载语音；这里结束时停掉。
            if (triggerSkip || finishRequested) Audio.Stop();
            Phase = "完成";
            busy = false;
            Debug.Log("GACHA_COMPLETE count=" + DrawCount + " voices=" + Audio.VoiceCount + " peak=" + Audio.VoicePeak + " maximumFrameMs=" + MaximumFrameMs + " framesOver100ms=" + SlowFrames);
            PlaybackCompleted?.Invoke();
        }
        void Update()
        {
            // 原版 screenButton 是铺满画面的按钮（OnClickScreenButton → currentState.Click）；按下后松开算一次点击。
            if (Input.GetMouseButtonDown(0)) pointerDown = true;
            if (Input.GetMouseButtonUp(0) && pointerDown)
            {
                pointerDown = false;
                if (busy) clickRequested = true;
            }
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
                    busy = false;
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
            var timeline = (TimelineAsset)director.playableAsset;
            string[] slots = { "rot_10/10", "rot_g/rot_move/pos_rot_09/sub_rot/09", "rot_g/rot_move/pos_rot_08/sub_rot/08", "rot_g/rot_move/pos_rot_07/sub_rot/07", "rot_g/rot_move/pos_rot_06/sub_rot/06", "rot_g/rot_move/pos_rot_05/sub_rot/05", "rot_g/rot_move/pos_rot_04/sub_rot/04", "rot_g/rot_move/pos_rot_03/sub_rot/03", "rot_g/rot_move/pos_rot_02/sub_rot/02", "rot_g/rot_move/pos_rot_01/sub_rot/01" };
            var prizeRoot = root.transform.Find("gatya/root");
            for (int i = 0; i < slots.Length; i++)
            {
                var slot = prizeRoot.Find(slots[i]);
                foreach (Transform child in slot) Destroy(child.gameObject);
                prizeSlots.Add(SlotEffects.Select(name =>
                {
                    var effect = Instantiate(Assets.Get<GameObject>("live_pv/sp/gacha/effect", name), slot, false);
                    effect.name = name;
                    effect.SetActive(false);
                    return effect;
                }).ToArray());
            }
            // 预告特效的动画轨道绑定 Animator；先补齐，再由 SetupCameras 统一设置。
            foreach (string name in new[] { "eff_9200_omoi_r02", "eff_9200_omoi_r03", "eff_9200_omoi_r04" })
            {
                var omoi = root.transform.Find("Effect/" + name).gameObject;
                if (!omoi.GetComponent<Animator>()) omoi.AddComponent<Animator>();
            }
            foreach (var track in timeline.GetOutputTracks())
                if (track is CP.Timeline.LoopTrack) track.muted = false;
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
                    // 原版 ScreenLayerGachaAnimation.OnPlayTimelineSE：按本次最高稀有度分支。
                    reaction.AddListener(() => Audio.PlaySe(GachaCard.IsTopRarity(maxRarity) ? "SE_GACHA_BRANCH_2_3RD_ANV" : "SE_GACHA_BRANCH_1_3RD_ANV"));
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
        // 开场按本次结果设置（原版 GachaTapWaitState.SetupPrize 与 SetupRaritySuggestion）：
        // 槽位特效按每张卡的稀有度，预告、舞台贴图、反射光与灯光按最高稀有度。
        void SetupMain(GachaCard[] draw)
        {
            maxRarity = GachaRarity.Rarity2;
            for (int i = 0; i < prizeSlots.Count; i++)
            {
                int variant = i < draw.Length ? SlotVariant(draw[i].Rarity) : -1;
                for (int v = 0; v < prizeSlots[i].Length; v++) prizeSlots[i][v].SetActive(v == variant);
                if (i < draw.Length && draw[i].Rarity > maxRarity) maxRarity = draw[i].Rarity;
            }
            string omoi, stage, hansya, light;
            if (GachaCard.IsTopRarity(maxRarity))
            {
                // 最高档有 32% 先以 ★3 的预告出场，中途再翻成 ★4。
                bool feint = UnityEngine.Random.Range(0, 10000) > 6799;
                omoi = feint ? "eff_9200_omoi_r03" : "eff_9200_omoi_r04";
                stage = feint ? "stage_tex_01" : "stage_tex_02";
                hansya = feint ? "eff_9200_hansya_gosen_r03_r04" : "eff_9200_hansya_gosen_r04";
                light = feint ? "gatya_light_9100_g_p" : "gatya_light_9100_p";
            }
            else if (maxRarity == GachaRarity.Rarity3)
            {
                omoi = "eff_9200_omoi_r03";
                stage = "stage_tex_01";
                hansya = "eff_9200_hansya_gosen_r03";
                light = "gatya_light_9100_g";
            }
            else
            {
                omoi = "eff_9200_omoi_r02";
                stage = "stage_tex_01";
                hansya = "eff_9200_hansya_gosen_r02";
                light = "gatya_light_9100";
            }
            var director = main.transform.Find("Timeline").GetComponent<PlayableDirector>();
            var effectRoot = main.transform.Find("Effect");
            foreach (Transform child in effectRoot) child.gameObject.SetActive(false);
            var omoiObject = effectRoot.Find(omoi).gameObject;
            // 改动在下一次 Play 重建 PlayableGraph 时生效（PlayTimeline 先 Stop 再 Play）。
            foreach (var track in ((TimelineAsset)director.playableAsset).GetOutputTracks())
            {
                if (track.name == "OmoiEffect") director.SetGenericBinding(track, omoiObject);
                if (track.name == "OmoiAnimation") director.SetGenericBinding(track, omoiObject.GetComponent<Animator>());
                if (track.name == "Light")
                    foreach (var clip in track.GetClips())
                        if (clip.displayName == "gatya_light" && clip.asset is AnimationPlayableAsset animation) animation.clip = Assets.Get<AnimationClip>("live_pv/sp/gacha/timeline", light);
                if (track.name == "eff_9200_hansya_gosen_r02")
                    foreach (var clip in track.GetClips())
                        if (clip.displayName == "eff_9200_hansya_gosen_r02" && clip.asset is LiveEffectClip effect) effect.template.prefab = Assets.Get<GameObject>("live_pv/sp/gacha/effect", hansya);
            }
            var sphere = main.transform.Find("Stage/stage/stage_9200/Root/stage_9200/pSphere1");
            if (sphere) sphere.GetComponent<Renderer>().material.mainTexture = Assets.Get<Texture>("live_pv/sp/gacha/model/stage", stage);
            Debug.Log("GACHA_MAIN max=" + maxRarity + " omoi=" + omoi + " light=" + light);
        }
        static int SlotVariant(GachaRarity rarity) => GachaCard.IsTopRarity(rarity) ? 2 : rarity == GachaRarity.Rarity3 ? 1 : 0;

        // 原版 GachaDisplayState.Init：按稀有度（及是否只有特训后卡面）选择演出，并填入卡面、角色色和名牌。
        void SetupReveal(GachaCard card)
        {
            string name;
            string[] cardNodes, colorNodes;
            bool afterTraining = cardMedia[card.Id].AfterTrainingOnly;
            switch (card.Rarity)
            {
                case GachaRarity.Rarity2:
                    name = "fx_gacha_card_r2_01"; cardNodes = Rarity2CardNodes; colorNodes = Rarity2ColorNodes; break;
                case GachaRarity.Rarity3:
                    name = afterTraining ? "fx_gacha_card_r3_afterTraining_01" : "fx_gacha_card_r3_01"; cardNodes = Rarity3CardNodes; colorNodes = LineColorNodes; break;
                case GachaRarity.Rarity4:
                    name = afterTraining ? "fx_gacha_card_r4_afterTraining_01" : "fx_gacha_card_r4_01"; cardNodes = Rarity4CardNodes; colorNodes = LineColorNodes; break;
                default:
                    name = "fx_gacha_card_birthday_01"; cardNodes = Rarity4CardNodes; colorNodes = LineColorNodes; break;
            }
            var root = reveals[name];
            if (reveal && reveal != root)
            {
                SetCameras(reveal, false);
                reveal.SetActive(false);
            }
            reveal = root;
            root.SetActive(true);
            var sprite = cards[card.Id];
            foreach (string node in cardNodes)
            {
                var target = root.transform.Find(node);
                var renderer = target.GetComponent<SpriteRenderer>();
                if (renderer)
                {
                    Vector2 size = renderer.size;
                    renderer.sprite = sprite;
                    renderer.size = size;
                }
                else target.GetComponent<SpriteMask>().sprite = sprite;
            }
            Color color = CharacterColor(card.CharacterId);
            foreach (string node in colorNodes)
            {
                var renderer = root.transform.Find(node).GetComponent<SpriteRenderer>();
                if (!renderer) continue;
                var material = renderer.sharedMaterial;
                if (material && material.shader && material.shader.name == "Shader Forge/TintShader")
                {
                    material.SetColor("_BlackColor", color);
                    material.SetColor("_WhiteColor", color);
                }
                else renderer.color = new Color(color.r, color.g, color.b, renderer.color.a);
            }
            if (card.Rarity == GachaRarity.Rarity2)
                root.transform.Find("root/MainCamera/Main_card_BG").GetComponent<SpriteRenderer>().sprite = Assets.Get<Sprite>("unit_background", UnitBackground(card.CharacterId));
            var label = root.transform.Find("root/member_name").GetComponent<SpriteRenderer>();
            label.sprite = Assets.Get<Sprite>("character/label", "chr_name_h_" + card.CharacterId);
            root.transform.Find("root/new").GetComponent<SpriteRenderer>().enabled = NewCard;
            // 原版 SetupCharacter 在 unit_name 显示卡名，SetupVoice（★3 以上）在 MainCamera/Text 显示招募台词。
            // prefab 里的文字是占位，先全部清空。
            foreach (var text in root.GetComponentsInChildren<TMP_Text>(true)) { text.font = tmpFont; text.text = ""; }
            SetText(root.transform.Find("root/unit_name"), unitNameMaterial, card.Prefix);
            if (card.Rarity != GachaRarity.Rarity2) SetText(root.transform.Find("root/MainCamera/Text"), phraseMaterial, card.Phrase);
            SetupCameras(root);
        }
        // 文字来自宿主，按纯文本显示。
        static void SetText(Transform node, Material material, string value)
        {
            var text = node.GetComponent<TMP_Text>();
            text.fontSharedMaterial = material;
            text.richText = false;
            text.text = value;
        }
        // 复制原版材质，换成动态图集；着色器在当前平台不可用时改用字体的默认着色器。
        Material TextMaterial(string name)
        {
            var material = new Material(Assets.Get<Material>("effect_asset/gacha_obtain_prize", name)) { name = name + " (Dynamic)" };
            if (!material.shader || !material.shader.isSupported) material.shader = tmpFont.material.shader;
            material.SetTexture(ShaderUtilities.ID_MainTex, tmpFont.atlasTexture);
            material.SetFloat(ShaderUtilities.ID_TextureWidth, tmpFont.atlasWidth);
            material.SetFloat(ShaderUtilities.ID_TextureHeight, tmpFont.atlasHeight);
            material.SetFloat(ShaderUtilities.ID_GradientScale, tmpFont.atlasPadding + 1);
            Debug.Log("GACHA_TEXT_MATERIAL " + name + " shader=" + material.shader.name);
            return material;
        }
        static readonly string[] RevealEffects = { "fx_gacha_card_r2_01", "fx_gacha_card_r3_01", "fx_gacha_card_r3_afterTraining_01", "fx_gacha_card_r4_01", "fx_gacha_card_r4_afterTraining_01", "fx_gacha_card_birthday_01" };
        static readonly string[] SlotEffects = { "eff_9200_gatya_r02", "eff_9200_gatya_r03", "eff_9200_gatya_r04" };
        static readonly string[] Rarity2CardNodes = { "root/MainCamera/Card/Main_card", "root/MainCamera/Card_shadow/mask", "root/MainCamera/Card/mask" };
        static readonly string[] Rarity3CardNodes = { "root/MainCamera/Main_card", "root/MainCamera/Main_card_blur" };
        static readonly string[] Rarity4CardNodes = { "root/MainCamera/Main_card", "root/MainCamera/Main_card_blur", "root/MainCamera/Main_card_add" };
        static readonly string[] Rarity2ColorNodes = { "root/line_base_pos_center/line_base_pos/line_member", "root/MainCamera/Card_shadow/Main_card_shadow", "root/MainCamera/Card/Main_card_color", "root/MainCamera/color" };
        static readonly string[] LineColorNodes = { "root/line_base_pos_center/line_base_pos/line_member" };
        // 原版 ColorUtility.CHARACTER_COLORS，按角色 ID 1–26。
        static readonly string[] CharacterColors = { "#33aaee", "#ffdd44", "#ee6666", "#bbdd22", "#ffccaa", "#99ccff", "#ffaacc", "#99eedd", "#ff6699", "#00bbdd", "#ff7722", "#0077dd", "#ffbb00", "#ff66bb", "#33dd99", "#bb88ee", "#bb6688", "#8888cc", "#ccaa88", "#ddaacc", "#33ccbb", "#ffcc11", "#ffee11", "#ffbbcc", "#dd4444", "#3366cc" };
        static Color CharacterColor(int character) =>
            character >= 1 && character <= CharacterColors.Length && UnityEngine.ColorUtility.TryParseHtmlString(CharacterColors[character - 1], out var color) ? color : new Color(1, 1, 1, 0);
        // 原版 AssetBundleNames.GetUnitBackgroundFileName；角色 ID 每 4 人一个团，21–26 为虚拟歌手。
        static string UnitBackground(int character) =>
            character <= 4 ? "bg_light_sound" : character <= 8 ? "bg_idol" : character <= 12 ? "bg_street" : character <= 16 ? "bg_theme_park" : character <= 20 ? "bg_school_refusal" : "bg_virtual_singer";
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
                // 原版 GachaTapWaitState：Init 显示 TapToStart，时间轴在 Loop Track 上循环；Execute 什么也不做。
                // Click：隐藏提示，触发 LoopWaitTimeline，NextState，再播放点击音效（原版还调 BGM 的 AISAC，这里没有 BGM）。
                tapToStart.SetActive(true);
                Phase = "等待点击";
                Debug.Log("GACHA_TAP_WAIT");
                while (!skipPressed && !finishRequested && !TakeClick()) yield return null;
                // 原版 OnClickSkipButton 同样先隐藏提示。
                tapToStart.SetActive(false);
                if (skipPressed || finishRequested) yield break;
                Phase = "3D演出";
                Debug.Log("GACHA_TAP time=" + director.time.ToString("F3"));
                director.GetComponent<CP.Timeline.LoopWaitTimeline>().Trigger = true;
                var state = new GachaSpawnPlayback(root);
                Audio.PlaySe("SE_GACHA_TAP_3RD_ANV");
                // 原版 GachaSpawnAnimationState：Execute 判定时间轴将到末尾（减去 deltaTime）即 NextState；
                // Click 停掉音效并 NextState。两者都在同一帧隐藏开场、开始揭卡，否则白闪之后会露出一帧 3D 场景。
                while (!skipPressed && !finishRequested)
                {
                    if (TakeClick())
                    {
                        Audio.StopSe();
                        Debug.Log("GACHA_SPAWN_CLICK time=" + director.time.ToString("F3"));
                        yield break;
                    }
                    bool next = false;
                    state.Execute(() => next = true, Audio.PlaySe);
                    if (next)
                    {
                        double end = director.duration - director.GetComponent<CP.Timeline.LoopWaitTimeline>().TriggerInvokedOffesetTime;
                        Debug.Log("GACHA_INTRO_END time=" + director.time.ToString("F3") + " step=" + Time.deltaTime.ToString("F3") + " end=" + end.ToString("F3"));
                        yield break;
                    }
                    yield return null;
                }
            }
            else
            {
                // 原版 GachaDisplayState：Execute 在时间轴停止后 NextState；
                // Click 在末尾展示段（duration - WaitTime）之前跳到该段并立即求值，已在该段则 NextState。
                while (!skipPressed && !finishRequested)
                {
                    if (TakeClick())
                    {
                        if (director.time < director.duration - CardEndWaitSeconds)
                        {
                            director.time = director.duration - CardEndWaitSeconds;
                            director.Evaluate();
                            Debug.Log("GACHA_DISPLAY_CLICK jump");
                        }
                        else
                        {
                            Debug.Log("GACHA_DISPLAY_CLICK next");
                            yield break;
                        }
                    }
                    if (director.state != PlayState.Playing) yield break;
                    yield return null;
                }
            }
        }
        bool TakeClick()
        {
            bool click = clickRequested;
            clickRequested = false;
            return click;
        }
        // 原版 ScreenLayerGachaAnimation 的 TapToStart：1920×1080 画布底部居中上移 200，486×56 的 txt_taptostart，
        // 带 TweenAlpha。贴图从原版 GachaAtlas 按该精灵的矩形裁出。
        void CreateTapToStart()
        {
            var canvas = new GameObject("TapToStartCanvas", typeof(Canvas), typeof(CanvasScaler)).GetComponent<Canvas>();
            canvas.renderMode = RenderMode.ScreenSpaceOverlay;
            canvas.sortingOrder = 100;
            var scaler = canvas.GetComponent<CanvasScaler>();
            scaler.uiScaleMode = CanvasScaler.ScaleMode.ScaleWithScreenSize;
            scaler.referenceResolution = new Vector2(1920, 1080);
            scaler.screenMatchMode = CanvasScaler.ScreenMatchMode.MatchWidthOrHeight;
            scaler.matchWidthOrHeight = 0;
            DontDestroyOnLoad(canvas.gameObject);
            tapToStart = new GameObject("TapToStart", typeof(RectTransform), typeof(RawImage));
            var rect = (RectTransform)tapToStart.transform;
            rect.SetParent(canvas.transform, false);
            rect.anchorMin = rect.anchorMax = new Vector2(0.5f, 0);
            rect.pivot = new Vector2(0.5f, 0.5f);
            rect.anchoredPosition = new Vector2(0, 200);
            rect.sizeDelta = new Vector2(486, 56);
            var image = tapToStart.GetComponent<RawImage>();
            image.texture = Resources.Load<Texture2D>("GachaTapToStart");
            image.raycastTarget = false;
            tapToStart.AddComponent<GachaTapToStartTween>();
            tapToStart.SetActive(false);
        }
        // 播放中（含下载卡牌时）请求跳过，演出在下一帧停到结束画面。
        // 原版 OnClickSkipButton：PlaySEOneShot("SE_DECIDE1")，隐藏 TapToStart，triggerSkip，StopSEAll，NextState。
        // 顺序照原版：确认音刚开始就被 StopSEAll 停掉，原版也是如此。下载卡牌期间按下时，开场开始前就进入跳过模式。
        public void Skip()
        {
            if (!busy) return;
            Audio.PlaySe("SE_DECIDE1");
            tapToStart.SetActive(false);
            triggerSkip = true;
            Audio.StopSe();
            skipPressed = true;
            Debug.Log("GACHA_SKIP");
        }
        // 宿主专用：立即结束，停在最后一张卡的末尾展示段。
        public void Finish() { if (busy) finishRequested = true; }
        // 原版 GachaDisplayState.IsEnableSkip。
        static bool IsEnableSkip(GachaCard card) => !(GachaCard.IsTopRarity(card.Rarity) || (card.Rarity == GachaRarity.Rarity3 && NewCard));
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
            foreach (string id in cards.Keys.ToArray()) ReleaseCard(id);
            if (Instance == this) Instance = null;
        }
    }
}
