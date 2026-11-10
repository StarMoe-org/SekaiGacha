using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using CriWare;
using UnityEngine;

namespace SekaiGacha
{
    public sealed class GachaAudio : MonoBehaviour
    {
        readonly Dictionary<string, CriAtomExAcb> sheets = new Dictionary<string, CriAtomExAcb>();
        CriAtomExPlayer se, voice;
        CriAtomExOutputAnalyzer meter;
        GCHandle acf;
        GameObject criRoot;
        public int VoiceCount { get; private set; }
        // 资源清单中没有获得语音的揭卡次数。
        public int MissingVoiceCount { get; private set; }
        public float VoicePeak { get; private set; }
        public bool Muted { get; set; }
        public void Initialize()
        {
            criRoot = new GameObject("CRI Audio");
            criRoot.SetActive(false);
            var init = criRoot.AddComponent<CriWareInitializer>();
            init.initializesMana = false;
            init.atomConfig.outputSamplingRate = 48000;
            criRoot.SetActive(true);
            criRoot.AddComponent<CriAtom>();
            var bytes = Resources.Load<TextAsset>("ProjectSekaiAcf").bytes;
            acf = GCHandle.Alloc(bytes, GCHandleType.Pinned);
            if (!CriAtomEx.RegisterAcf(acf.AddrOfPinnedObject(), bytes.Length)) throw new InvalidOperationException("音频配置加载失败");
            se = new CriAtomExPlayer();
            voice = new CriAtomExPlayer();
            meter = new CriAtomExOutputAnalyzer(new CriAtomExOutputAnalyzer.Config { enableLevelmeter = true });
            if (!meter.AttachExPlayer(voice)) throw new InvalidOperationException("语音音量检查初始化失败");
        }
        public void Load(GachaResources assets, string bundle)
        {
            if (sheets.ContainsKey(bundle)) return;
            var acb = assets.All<TextAsset>(bundle).First(t => t.name.EndsWith(".acb", StringComparison.OrdinalIgnoreCase));
            var sheet = CriAtomExAcb.LoadAcbData(acb.bytes, null, null);
            if (sheet == null) throw new InvalidOperationException("音频资源加载失败 " + bundle);
            sheets.Add(bundle, sheet);
        }
        public void PlaySe(string cue)
        {
            if (Muted) return;
            var sheet = sheets.Values.FirstOrDefault(s => s.GetCueInfoList().Any(c => c.name == cue));
            if (sheet == null) { Debug.LogWarning("抽卡音效不存在 " + cue); return; }
            se.SetCue(sheet, cue);
            se.Start();
        }
        public double PlayVoice(string card)
        {
            string bundle = "sound/gacha/get_voice/" + card;
            if (!sheets.TryGetValue(bundle, out var sheet))
            {
                MissingVoiceCount++;
                return 0;
            }
            var cue = sheet.GetCueInfoList().First();
            voice.Stop();
            voice.SetCue(sheet, cue.id);
            voice.Start();
            VoiceCount++;
            Debug.Log("GACHA_VOICE " + card + " durationMs=" + cue.length);
            return cue.length / 1000.0;
        }
        void Update() { if (meter != null) VoicePeak = Mathf.Max(VoicePeak, meter.GetRms(0)); }
        void OnDestroy()
        {
            meter?.Dispose();
            voice?.Dispose(); se?.Dispose();
            foreach (var sheet in sheets.Values) sheet.Dispose();
            if (acf.IsAllocated) { CriAtomEx.UnregisterAcf(); acf.Free(); }
            if (criRoot) Destroy(criRoot);
        }
    }
}
