// 源自 Cpp2CS Assembly-CSharp.dll/Sekai/{IGachaState,GachaTapWaitState,GachaSpawnAnimationState,GachaDisplayState,EffectType,ColorUtility}.cs。
// 分支、数值、对象路径与资源名保持原样；外部依赖替换为：
//   ScreenLayerGachaAnimation → GachaApp，SoundManager → GachaAudio，AssetManager/AssetBundleUtility → GachaResources，
//   UserGachaSpinObtainPrize/MasterCard → GachaCardInfo，Resources 中的 Font/FOT-RodinNTLGPro-EB SDF_Base* → effect_asset/gacha_obtain_prize 中的同名资源。
// 未复刻：BGM（工程没有 BGM 播放）、资源卸载、TAP 提示 UI（安装包内置资源）。
using System;
using System.Collections.Generic;
using System.Linq;
using CP.Timeline;
using TMPro;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace SekaiGacha
{
    // Sekai.CardRarityType
    public enum GachaCardRarity { undefined, rarity_1, rarity_2, rarity_3, rarity_4, rarity_birthday }

    // Sekai.EffectType
    public enum GachaEffectType { CardR2, CardR3, CardR4, Birthday, Main, CardR3AfterTraning, CardR4AfterTraning }

    // 揭卡所需的 MasterCard / MasterGameCharacter 字段与 newFlg。
    public sealed class GachaCardInfo
    {
        public string AssetbundleName;
        public int CharacterId;
        public GachaCardRarity Rarity;
        public string Prefix = "";
        public string GachaPhrase = "";
        // MasterCard.IsOnlyAfterTraining => initialSpecialTrainingStatus == "done"
        public bool IsOnlyAfterTraining;
        public string Unit;
        // UserGachaSpinObtainPrize.newFlg（服务端字段；模拟时为本次运行中首次获得）。
        public bool IsNew;

        public static GachaCardRarity ParseRarity(string rarity) =>
            Enum.TryParse(rarity, out GachaCardRarity value) ? value : GachaCardRarity.undefined;
    }

    interface IGachaState
    {
        bool IsEnableSkip { get; }
        void Init(GachaApp controller);
        void Execute(GachaApp controller);
        void Click(GachaApp controller);
        void Exit(GachaApp controller);
    }

    sealed class GachaTapWaitState : IGachaState
    {
        const string STAGE_TEXTURE_PATH = "Stage/stage/stage_9200/Root/stage_9200/pSphere1";
        static readonly string[] itemSlotPathes = { "rot_10/10", "rot_g/rot_move/pos_rot_09/sub_rot/09", "rot_g/rot_move/pos_rot_08/sub_rot/08", "rot_g/rot_move/pos_rot_07/sub_rot/07", "rot_g/rot_move/pos_rot_06/sub_rot/06", "rot_g/rot_move/pos_rot_05/sub_rot/05", "rot_g/rot_move/pos_rot_04/sub_rot/04", "rot_g/rot_move/pos_rot_03/sub_rot/03", "rot_g/rot_move/pos_rot_02/sub_rot/02", "rot_g/rot_move/pos_rot_01/sub_rot/01" };

        GameObject rootObj;
        PlayableDirector director;
        LoopWaitTimeline waitTimeline;
        readonly Dictionary<string, GameObject> timelineBindingObject = new Dictionary<string, GameObject>();
        readonly GachaCardInfo[] obtainPrize;
        GachaCardRarity maxRarity;
        GachaCardRarity currentSuggestionRarity;
        double loopStart = double.MaxValue;

        public bool IsEnableSkip => true;

        public GachaTapWaitState(GachaCardInfo[] obtainPrize) { this.obtainPrize = obtainPrize; }

        public void Init(GachaApp controller)
        {
            rootObj = controller.Effects[GachaEffectType.Main];
            director = rootObj.transform.Find("Timeline").GetComponent<PlayableDirector>();
            director.Stop();
            director.playOnAwake = false;
            director.extrapolationMode = DirectorWrapMode.Hold;
            waitTimeline = director.GetComponent<LoopWaitTimeline>();
            Transform rootTransform = rootObj.transform.Find("gatya/root");
            var outputTracks = ((TimelineAsset)director.playableAsset).GetOutputTracks().ToList();
            var loopTrack = outputTracks.FirstOrDefault(x => x.name == "Loop Track");
            if (loopTrack != null)
            {
                loopTrack.muted = false;
                var clip = loopTrack.GetClips().FirstOrDefault();
                if (clip != null) loopStart = clip.start;
            }
            else Debug.LogError("Loop Trackがみつかりません");
            SetupPrize(controller, rootTransform);
            SetupRaritySuggestion(controller, outputTracks);
            BindTimeline();
            controller.ShowEffect(rootObj);
            director.Play();
        }

        void SetupPrize(GachaApp controller, Transform rootTransform)
        {
            var list = new List<Transform>();
            foreach (string path in itemSlotPathes)
            {
                Transform transform = rootTransform.Find(path);
                foreach (Transform child in transform) UnityEngine.Object.Destroy(child.gameObject);
                list.Add(transform);
            }
            maxRarity = GachaCardRarity.rarity_2;
            currentSuggestionRarity = default;
            if (obtainPrize == null || list.Count < obtainPrize.Length || obtainPrize.Length < 1) return;
            for (int i = 0; i < obtainPrize.Length; i++)
            {
                GachaCardRarity rarityType = obtainPrize[i].Rarity;
                string text = rarityType == GachaCardRarity.rarity_3 ? "eff_9200_gatya_r03"
                    : (((int)rarityType & ~1) != 4 ? "eff_9200_gatya_r02" : "eff_9200_gatya_r04");
                var instance = UnityEngine.Object.Instantiate(controller.Assets.Get<GameObject>("live_pv/sp/gacha/effect", text), list[i], false);
                instance.name = text;
                controller.PrepareSpawned(rootObj, instance);
                if (rarityType > maxRarity) maxRarity = rarityType;
            }
        }

        void SetupRaritySuggestion(GachaApp controller, List<TrackAsset> tracks)
        {
            Transform transform = rootObj.transform.Find("Effect");
            foreach (Transform child in transform) child.gameObject.SetActive(false);
            int num = UnityEngine.Random.Range(0, 10000);
            GachaCardRarity cardRarityType = maxRarity;
            string text = string.Empty;
            currentSuggestionRarity = cardRarityType;
            string resourceName;
            string text2;
            if ((uint)(cardRarityType - 4) >= 2u)
            {
                if (cardRarityType == GachaCardRarity.rarity_2) text2 = "eff_9200_omoi_r02";
                else if (cardRarityType == GachaCardRarity.rarity_3) text2 = "eff_9200_omoi_r03";
                else text2 = text;
                resourceName = "stage_tex_01";
            }
            else if (num > 6799)
            {
                currentSuggestionRarity = GachaCardRarity.rarity_3;
                resourceName = "stage_tex_01";
                text2 = "eff_9200_omoi_r03";
            }
            else
            {
                resourceName = "stage_tex_02";
                text2 = "eff_9200_omoi_r04";
            }
            ReplaceBindObject(transform, "OmoiEffect", text2);
            ReplaceBindObject(transform, "OmoiAnimation", text2);
            Transform transform2 = rootObj.transform.Find(STAGE_TEXTURE_PATH);
            if (transform2 != null)
            {
                Renderer component = transform2.GetComponent<Renderer>();
                if (component != null)
                {
                    Texture texture = controller.Assets.Get<Texture>("live_pv/sp/gacha/model/stage", resourceName);
                    if (texture != null) component.sharedMaterial.SetTexture(Sekai.ShaderPropertyID.MAIN_TEX_ID, texture);
                }
            }
            GachaCardRarity cardRarityType2 = maxRarity;
            if ((uint)(cardRarityType2 - 4) >= 2u)
            {
                if (cardRarityType2 == GachaCardRarity.rarity_3)
                {
                    text2 = "eff_9200_hansya_gosen_r03";
                    text = "gatya_light_9100_g";
                }
                else if (cardRarityType2 == GachaCardRarity.rarity_2)
                {
                    text2 = "eff_9200_hansya_gosen_r02";
                    text = "gatya_light_9100";
                }
            }
            else
            {
                GachaCardRarity cardRarityType3 = currentSuggestionRarity;
                if (cardRarityType3 == GachaCardRarity.rarity_3)
                {
                    currentSuggestionRarity = cardRarityType2;
                    text2 = "eff_9200_hansya_gosen_r03_r04";
                    text = "gatya_light_9100_g_p";
                }
                else if (((int)cardRarityType3 & ~1) == 4)
                {
                    text2 = "eff_9200_hansya_gosen_r04";
                    text = "gatya_light_9100_p";
                }
            }
            ReplaceEmitEffect(controller, tracks, "eff_9200_hansya_gosen_r02", "eff_9200_hansya_gosen_r02", text2);
            ReplaceAnimationClip(controller, tracks, "Light", "gatya_light", text);
        }

        static void ReplaceEmitEffect(GachaApp controller, IEnumerable<TrackAsset> tracks, string trackName, string clipName, string prefabName)
        {
            TrackAsset trackAsset = tracks.FirstOrDefault(x => x.name == trackName);
            if (trackAsset == null) return;
            TimelineClip timelineClip = trackAsset.GetClips().FirstOrDefault(x => x.displayName == clipName);
            if (timelineClip != null && timelineClip.asset is LiveEffectClip effect)
                effect.template.prefab = controller.Assets.Get<GameObject>("live_pv/sp/gacha/effect", prefabName);
        }

        static void ReplaceAnimationClip(GachaApp controller, IEnumerable<TrackAsset> tracks, string trackName, string clipName, string animationClipName)
        {
            TrackAsset trackAsset = tracks.FirstOrDefault(x => x.name == trackName);
            if (trackAsset == null) return;
            TimelineClip timelineClip = trackAsset.GetClips().FirstOrDefault(x => x.displayName == clipName);
            if (timelineClip != null && timelineClip.asset is AnimationPlayableAsset asset)
            {
                asset.clip = controller.Assets.Get<AnimationClip>("live_pv/sp/gacha/timeline", animationClipName);
                Debug.Log("アニメーションクリップの置き換え " + animationClipName);
            }
        }

        void ReplaceBindObject(Transform targetTrans, string trackName, string replacePath)
        {
            timelineBindingObject[trackName] = targetTrans.Find(replacePath).gameObject;
        }

        void BindTimeline()
        {
            foreach (PlayableBinding binding in director.playableAsset.outputs)
            {
                if (!timelineBindingObject.TryGetValue(binding.streamName, out var value)) continue;
                // 原版以 GameObject 绑定；Animator 类型的轨道在运行时需要组件本身。
                if (binding.outputTargetType == typeof(Animator))
                    director.SetGenericBinding(binding.sourceObject, value.GetComponent<Animator>() ?? value.AddComponent<Animator>());
                else
                    director.SetGenericBinding(binding.sourceObject, value);
            }
            director.time = 0.0;
            director.Evaluate();
        }

        public void Execute(GachaApp controller)
        {
            // 原版等待点击（TAP 提示 UI 在安装包内置资源中，未接入）；自动演示时到循环段即代替点击。
            if (controller.AutoTap && director.time > loopStart) Click(controller);
        }

        public void Click(GachaApp controller)
        {
            waitTimeline.Trigger = true;
            controller.NextState();
            controller.Audio.PlaySe("SE_GACHA_TAP_3RD_ANV");
        }

        public void Exit(GachaApp controller) { }
    }

    sealed class GachaSpawnAnimationState : IGachaState
    {
        const double SE_TIME = 6.199999809265137;
        GameObject rootObj;
        PlayableDirector director;
        LoopWaitTimeline waitTimeline;
        double beforeTime;

        public bool IsEnableSkip => true;

        public void Init(GachaApp controller)
        {
            rootObj = controller.Effects[GachaEffectType.Main];
            director = rootObj.transform.Find("Timeline").GetComponent<PlayableDirector>();
            waitTimeline = director.GetComponent<LoopWaitTimeline>();
        }

        public void Execute(GachaApp controller)
        {
            if (director == null) return;
            if (!(director.time < SE_TIME) && beforeTime < SE_TIME) controller.Audio.PlaySe("SE_GACHA_STAFF");
            if (!(director.time < director.duration - waitTimeline.TriggerInvokedOffesetTime - Time.deltaTime))
                controller.NextState();
            beforeTime = director.time;
        }

        public void Click(GachaApp controller)
        {
            controller.Audio.StopSe();
            controller.NextState();
        }

        public void Exit(GachaApp controller)
        {
            controller.Effects[GachaEffectType.Main].SetActive(false);
        }
    }

    sealed class GachaDisplayState : IGachaState
    {
        static readonly string[] Rarity2CardObjNames = { "root/MainCamera/Card/Main_card", "root/MainCamera/Card_shadow/mask", "root/MainCamera/Card/mask" };
        static readonly string[] Rarity3CardObjNames = { "root/MainCamera/Main_card", "root/MainCamera/Main_card_blur" };
        static readonly string[] Rarity4CardObjNames = { "root/MainCamera/Main_card", "root/MainCamera/Main_card_blur", "root/MainCamera/Main_card_add" };
        static readonly string[] Rarity2CharaColorObjNames = { "root/line_base_pos_center/line_base_pos/line_member", "root/MainCamera/Card_shadow/Main_card_shadow", "root/MainCamera/Card/Main_card_color", "root/MainCamera/color" };
        static readonly string[] Rarity3CharaColorObjNames = { "root/line_base_pos_center/line_base_pos/line_member" };
        static readonly string[] Rarity4CharaColorObjNames = { "root/line_base_pos_center/line_base_pos/line_member" };
        static readonly float WaitTime = 2f;

        // Sekai.ColorUtility.CHARACTER_COLORS
        static readonly Dictionary<int, string> CHARACTER_COLORS = new Dictionary<int, string>
        {
            { 1, "#33aaee" }, { 2, "#ffdd44" }, { 3, "#ee6666" }, { 4, "#bbdd22" }, { 5, "#ffccaa" }, { 6, "#99ccff" },
            { 7, "#ffaacc" }, { 8, "#99eedd" }, { 9, "#ff6699" }, { 10, "#00bbdd" }, { 11, "#ff7722" }, { 12, "#0077dd" },
            { 13, "#ffbb00" }, { 14, "#ff66bb" }, { 15, "#33dd99" }, { 16, "#bb88ee" }, { 17, "#bb6688" }, { 18, "#8888cc" },
            { 19, "#ccaa88" }, { 20, "#ddaacc" }, { 21, "#33ccbb" }, { 22, "#ffcc11" }, { 23, "#ffee11" }, { 24, "#ffbbcc" },
            { 25, "#dd4444" }, { 26, "#3366cc" },
        };

        readonly GachaCardInfo masterCard;
        GameObject effect;
        PlayableDirector director;

        public GachaDisplayState(GachaCardInfo masterCard) { this.masterCard = masterCard; }

        public bool IsEnableSkip
        {
            get
            {
                GachaCardRarity rarityType = masterCard.Rarity;
                if ((uint)(rarityType - 4) < 2u || (rarityType == GachaCardRarity.rarity_3 && masterCard.IsNew)) return false;
                return true;
            }
        }

        static Color GetCharacterColor(int characterId)
        {
            if (CHARACTER_COLORS.TryGetValue(characterId, out var code) && UnityEngine.ColorUtility.TryParseHtmlString(code, out var color)) return color;
            return new Color(1, 1, 1, 0);
        }

        // AssetBundleNames.GetUnitBackgroundFileName
        static string GetUnitBackgroundFileName(string unit) => unit == "piapro" ? "bg_virtual_singer" : "bg_" + unit;

        void SetupCharacter(GachaApp controller, GameObject cardEffect, Sprite sprite, string[] cardObjNames, string[] charaColorObjNames)
        {
            foreach (string n in cardObjNames)
            {
                Transform transform = cardEffect.transform.Find(n);
                SpriteRenderer component = transform.GetComponent<SpriteRenderer>();
                if (component != null)
                {
                    Vector2 size = component.size;
                    component.sprite = sprite;
                    component.size = size;
                }
                else transform.GetComponent<SpriteMask>().sprite = sprite;
            }
            TextMeshPro component2 = cardEffect.transform.Find("root/unit_name").GetComponent<TextMeshPro>();
            component2.font = controller.GachaFont;
            component2.fontMaterial = controller.UnitNameMaterial;
            component2.fontSharedMaterial = controller.UnitNameMaterial;
            component2.text = masterCard.Prefix;
            foreach (string n2 in charaColorObjNames)
            {
                SpriteRenderer component3 = cardEffect.transform.Find(n2).GetComponent<SpriteRenderer>();
                if (component3 == null) continue;
                float a = component3.color.a;
                Color characterColor = GetCharacterColor(masterCard.CharacterId);
                if (component3.sharedMaterial.shader.name == "Shader Forge/TintShader")
                {
                    component3.sharedMaterial.SetColor("_BlackColor", characterColor);
                    component3.sharedMaterial.SetColor("_WhiteColor", characterColor);
                }
                else component3.color = new Color(characterColor.r, characterColor.g, characterColor.b, a);
            }
            cardEffect.transform.Find("root/member_name").GetComponent<SpriteRenderer>().sprite =
                controller.Assets.Get<Sprite>("character/label", "chr_name_h_" + masterCard.CharacterId);
            cardEffect.transform.Find("root/new").GetComponent<SpriteRenderer>().enabled = masterCard.IsNew;
        }

        void SetupBackground(GachaApp controller, GameObject cardEffect)
        {
            cardEffect.transform.Find("root/MainCamera/Main_card_BG").GetComponent<SpriteRenderer>().sprite =
                controller.Assets.Get<Sprite>("unit_background", GetUnitBackgroundFileName(masterCard.Unit));
        }

        void SetupVoice(GachaApp controller, GameObject cardEffect)
        {
            TextMeshPro component = cardEffect.transform.Find("root/MainCamera/Text").GetComponent<TextMeshPro>();
            component.font = controller.GachaFont;
            component.fontMaterial = controller.SerifMaterial;
            component.fontSharedMaterial = controller.SerifMaterial;
            component.text = masterCard.GachaPhrase;
            // ExistsBundleFile 时才播放；没有获得语音的卡只计数。
            controller.Audio.PlayVoice(masterCard.AssetbundleName);
        }

        public void Init(GachaApp controller)
        {
            Sprite sprite;
            string[] cardObjNames;
            string[] charaColorObjNames;
            switch (masterCard.Rarity)
            {
                case GachaCardRarity.rarity_2:
                    effect = controller.Effects[GachaEffectType.CardR2];
                    sprite = controller.Assets.GetSubAsset<Sprite>("character/member_gacha/" + masterCard.AssetbundleName, "normal", "normal");
                    SetupBackground(controller, effect);
                    controller.Audio.CountNoVoice();
                    cardObjNames = Rarity2CardObjNames;
                    charaColorObjNames = Rarity2CharaColorObjNames;
                    break;
                case GachaCardRarity.rarity_3:
                    effect = controller.Effects[masterCard.IsOnlyAfterTraining ? GachaEffectType.CardR3AfterTraning : GachaEffectType.CardR3];
                    sprite = controller.MemberStill(masterCard.AssetbundleName, masterCard.IsOnlyAfterTraining ? "card_after_training" : "card_normal");
                    SetupVoice(controller, effect);
                    cardObjNames = Rarity3CardObjNames;
                    charaColorObjNames = Rarity3CharaColorObjNames;
                    break;
                case GachaCardRarity.rarity_4:
                    effect = controller.Effects[masterCard.IsOnlyAfterTraining ? GachaEffectType.CardR4AfterTraning : GachaEffectType.CardR4];
                    sprite = controller.MemberStill(masterCard.AssetbundleName, masterCard.IsOnlyAfterTraining ? "card_after_training" : "card_normal");
                    SetupVoice(controller, effect);
                    cardObjNames = Rarity4CardObjNames;
                    charaColorObjNames = Rarity4CharaColorObjNames;
                    break;
                case GachaCardRarity.rarity_birthday:
                    effect = controller.Effects[GachaEffectType.Birthday];
                    sprite = controller.MemberStill(masterCard.AssetbundleName, "card_normal");
                    SetupVoice(controller, effect);
                    cardObjNames = Rarity4CardObjNames;
                    charaColorObjNames = Rarity4CharaColorObjNames;
                    break;
                default:
                    throw new NotSupportedException("揭卡演出不支持稀有度 " + masterCard.Rarity + "：" + masterCard.AssetbundleName);
            }
            SetupCharacter(controller, effect, sprite, cardObjNames, charaColorObjNames);
            controller.OnReveal(masterCard);
            // 原版 SetActive(true) 时由 playOnAwake 开始播放；外壳关闭了 playOnAwake，这里显式播放。
            controller.ShowEffect(effect);
            director = effect.GetComponent<PlayableDirector>();
            director.extrapolationMode = DirectorWrapMode.None;
            director.time = 0;
            director.Play();
            controller.CurrentDirector = director;
        }

        public void Execute(GachaApp controller)
        {
            if (director != null && director.state != PlayState.Playing) controller.NextState();
        }

        public void Click(GachaApp controller)
        {
            if (director.time < director.duration - WaitTime)
            {
                director.time = director.duration - WaitTime;
                director.Evaluate();
            }
            else controller.NextState();
        }

        public void Exit(GachaApp controller)
        {
            if (effect != null) effect.SetActive(false);
        }

        // 没有结算界面时停在最后一张：保持原版点击跳转所用的末尾展示段。
        public void Hold()
        {
            if (director == null) return;
            director.time = Math.Max(0, director.duration - WaitTime);
            director.Evaluate();
            director.Pause();
        }
    }
}
