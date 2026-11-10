using System;
using System.Linq;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using UnityEngine;
#if UNITY_WEBGL && !UNITY_EDITOR
using System.Runtime.InteropServices;
#endif

namespace SekaiGacha
{
    // 嵌入网页（Moesekai）时与宿主通信；协议说明见 WebGLTemplates/SekaiGacha/index.html。
    // 非嵌入运行（编辑器、桌面、直接打开网页）时不收发消息，GachaApp 照常自动播放演示十连。
    public sealed class GachaEmbed : MonoBehaviour
    {
#if UNITY_WEBGL && !UNITY_EDITOR
        [DllImport("__Internal")] static extern int SekaiGachaEmbedded();
        [DllImport("__Internal")] static extern string SekaiGachaPoll();
        [DllImport("__Internal")] static extern void SekaiGachaPost(string json);
        public static bool Embedded => SekaiGachaEmbedded() != 0;
#else
        public static bool Embedded => false;
        static string SekaiGachaPoll() => null;
        static void SekaiGachaPost(string json) { }
#endif
        const string Prefix = "sekai-gacha:";
        GachaApp app;
        GachaCard[] pending;
        string reported;

        void Awake() { app = GetComponent<GachaApp>(); }

        void Update()
        {
            // 先报上一帧协程里发生的变化（如就绪），再处理新指令。
            Report();
            for (string message = SekaiGachaPoll(); message != null; message = SekaiGachaPoll()) Handle(message);
            if (pending != null && app.CanPlay)
            {
                var cards = pending;
                pending = null;
                Play(cards);
            }
            Report();
        }

        void Handle(string json)
        {
            JObject message;
            try { message = JObject.Parse(json); }
            catch (JsonException) { Reject("invalid_message", "消息不是 JSON 对象"); return; }
            switch ((string)message["type"])
            {
                case Prefix + "play":
                    if (!TryReadCards(message["cards"], out var cards, out string problem)) { Reject("invalid_cards", problem); break; }
                    // 引擎还在启动时先记下，就绪后再播。
                    if (!app.Ready && app.Phase != "失败") pending = cards;
                    else Play(cards);
                    break;
                case Prefix + "skip":
                    app.Skip();
                    break;
                case Prefix + "mute":
                    app.Audio.Muted = message["muted"]?.Type != JTokenType.Boolean || (bool)message["muted"];
                    break;
                default:
                    Reject("invalid_message", "未知消息 " + message["type"]);
                    break;
            }
        }

        // cards 每项为 { id: "res001_no004", rarity: "rarity_4" }（rarity 取主数据 cardRarityType）；
        // 只给资源名字符串的旧写法不知道稀有度，按 ★4 演出。
        static bool TryReadCards(JToken token, out GachaCard[] cards, out string problem)
        {
            cards = null;
            problem = "需要 1 至 10 张卡";
            if (!(token is JArray array) || array.Count < 1 || array.Count > 10) return false;
            var read = new GachaCard[array.Count];
            for (int i = 0; i < array.Count; i++)
            {
                string id;
                GachaRarity rarity = GachaRarity.Rarity4;
                if (array[i].Type == JTokenType.String) id = (string)array[i];
                else if (array[i] is JObject item && item["id"]?.Type == JTokenType.String)
                {
                    id = (string)item["id"];
                    if (item["rarity"]?.Type != JTokenType.String || !GachaCard.TryParseRarity((string)item["rarity"], out rarity))
                    {
                        problem = "第 " + (i + 1) + " 张卡的稀有度无效";
                        return false;
                    }
                }
                else { problem = "第 " + (i + 1) + " 张卡格式无效"; return false; }
                if (!GachaCard.IsValidId(id)) { problem = "第 " + (i + 1) + " 张卡的资源名无效"; return false; }
                read[i] = new GachaCard(id, rarity);
            }
            cards = read;
            return true;
        }

        void Play(GachaCard[] cards)
        {
            if (!app.CanPlay) { Reject("busy", "演出正在进行"); return; }
            try { app.PlayCards(cards); }
            catch (ArgumentException error) { Reject("invalid_cards", error.Message.Split('\n')[0].Trim()); }
        }

        void Reject(string code, string message)
        {
            Debug.LogWarning("GACHA_EMBED_REJECT " + code + " " + message);
            SekaiGachaPost(new JObject { ["type"] = Prefix + "error", ["v"] = 1, ["code"] = code, ["message"] = message }.ToString(Formatting.None));
        }

        // 阶段或揭卡进度变化时上报一次。
        void Report()
        {
            string phase = PhaseCode();
            string key = phase + "|" + app.RevealedCount + "|" + app.DrawCount;
            if (key == reported) return;
            reported = key;
            var state = new JObject { ["type"] = Prefix + "state", ["v"] = 1, ["phase"] = phase, ["revealed"] = app.RevealedCount, ["total"] = app.DrawCount };
            if (phase == "reveal" && app.RevealedCount > 0) state["card"] = app.CurrentResults[app.RevealedCount - 1];
            if (phase == "ready") state["client"] = GachaAssetBucket.UserAgent;
            if (phase == "error") state["error"] = app.Error?.Split('\n')[0].Trim();
            SekaiGachaPost(state.ToString(Formatting.None));
        }

        string PhaseCode()
        {
            switch (app.Phase)
            {
                case "就绪": return "ready";
                case "加载": return app.Ready ? "loading" : "booting";
                case "3D演出": return "intro";
                case "揭卡": return "reveal";
                case "完成": return "complete";
                case "失败": return "error";
                default: return "booting";
            }
        }
    }
}
