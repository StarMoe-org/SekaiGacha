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
        // 音效仍用原版 ACB；获得语音来自资源桶的 mp3，用 Unity 音频播放。
        readonly Dictionary<string, CriAtomExAcb> sheets = new Dictionary<string, CriAtomExAcb>();
        readonly float[] samples = new float[256];
        CriAtomExPlayer se;
        // 原版 BGMPlayer 的 0 号通道。
        CriAtomExPlayer bgm;
        string bgmCue;
        AudioSource voice;
        GCHandle acf;
        GameObject criRoot;
        public int VoiceCount { get; private set; }
        // 没有获得语音的揭卡次数。
        public int MissingVoiceCount { get; private set; }
        public float VoicePeak { get; private set; }
        bool muted;
        // 宿主静音：音效不再触发，语音静音。
        public bool Muted
        {
            get => muted;
            set
            {
                muted = value;
                if (voice) voice.mute = value;
                if (value) se?.Stop();
                // BGM 只调音量，保留播放位置。
                if (bgm != null)
                {
                    bgm.SetVolume(value ? 0 : 1);
                    bgm.UpdateAll();
                }
            }
        }
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
            bgm = new CriAtomExPlayer();
            voice = gameObject.AddComponent<AudioSource>();
            voice.playOnAwake = false;
            voice.spatialBlend = 0;
            voice.mute = muted;
        }
        public void Load(GachaResources assets, string bundle)
        {
            if (sheets.ContainsKey(bundle)) return;
            var acb = assets.All<TextAsset>(bundle).First(t => t.name.EndsWith(".acb", StringComparison.OrdinalIgnoreCase));
            var sheet = CriAtomExAcb.LoadAcbData(acb.bytes, null, null);
            if (sheet == null) throw new InvalidOperationException("音频资源加载失败 " + bundle);
            sheets.Add(bundle, sheet);
        }
        // 放在 Resources 的原版音频表：APK StreamingAssets 里的 MenuCommon_Built_in（含 SE_DECIDE1 等通用音效），
        // 以及资源包 sound/menu/menu_bgm/gacha_3rd 里的 BGM_GACHA_SCENE_3RD_ANV。
        public void LoadSheet(string name)
        {
            if (sheets.ContainsKey(name)) return;
            var sheet = CriAtomExAcb.LoadAcbData(Resources.Load<TextAsset>(name + ".acb").bytes, null, null);
            if (sheet == null) throw new InvalidOperationException("音频资源加载失败 " + name);
            sheets.Add(name, sheet);
        }
        public void Stop()
        {
            se?.Stop();
            if (voice) voice.Stop();
        }
        // 原版 SoundManager.StopSEAll：只停音效。
        public void StopSe() => se?.Stop();
        // 原版 OutGameBGMController.LoadAndPlay → SoundManager.PlayBGM（isSameBGMRewind: false，FadeTime 约 0.008 秒）：
        // 同一首已在播放时不从头开始。
        public void PlayBgm(string cue)
        {
            if (bgmCue == cue && bgm.GetStatus() != CriAtomExPlayer.Status.Stop) return;
            var sheet = sheets.Values.FirstOrDefault(s => s.GetCueInfoList().Any(c => c.name == cue));
            if (sheet == null) { Debug.LogWarning("BGM 不存在 " + cue); return; }
            bgm.Stop();
            bgm.SetCue(sheet, cue);
            bgm.SetVolume(muted ? 0 : 1);
            bgm.Start();
            bgmCue = cue;
            Debug.Log("GACHA_BGM " + cue);
        }
        public void StopBgm()
        {
            bgm?.Stop();
            bgmCue = null;
        }
        // 原版 BGMPlayer.SetValueToBGMAISAC：SetAisacControl 后 UpdateAll。
        public void SetBgmAisac(string control, float value)
        {
            bgm.SetAisacControl(control, value);
            bgm.UpdateAll();
            Debug.Log("GACHA_BGM_AISAC " + control + "=" + value);
        }
        public void PlaySe(string cue)
        {
            if (Muted) return;
            var sheet = sheets.Values.FirstOrDefault(s => s.GetCueInfoList().Any(c => c.name == cue));
            if (sheet == null) { Debug.LogWarning("抽卡音效不存在 " + cue); return; }
            se.SetCue(sheet, cue);
            se.Start();
        }
        public double PlayVoice(string card, AudioClip clip)
        {
            voice.Stop();
            if (!clip)
            {
                MissingVoiceCount++;
                Debug.Log("GACHA_NO_VOICE " + card);
                return 0;
            }
            voice.clip = clip;
            voice.Play();
            VoiceCount++;
            Debug.Log("GACHA_VOICE " + card + " durationMs=" + Mathf.RoundToInt(clip.length * 1000));
            return clip.length;
        }
        void Update()
        {
#if !UNITY_WEBGL || UNITY_EDITOR
            // 仅用于编辑器和桌面验证；WebGL 不支持读取输出采样。
            if (!voice || !voice.isPlaying) return;
            voice.GetOutputData(samples, 0);
            float sum = 0;
            foreach (float sample in samples) sum += sample * sample;
            VoicePeak = Mathf.Max(VoicePeak, Mathf.Sqrt(sum / samples.Length));
#endif
        }
        void OnDestroy()
        {
            se?.Dispose();
            bgm?.Dispose();
            foreach (var sheet in sheets.Values) sheet.Dispose();
            if (acf.IsAllocated) { CriAtomEx.UnregisterAcf(); acf.Free(); }
            if (criRoot) Destroy(criRoot);
        }
    }
}
