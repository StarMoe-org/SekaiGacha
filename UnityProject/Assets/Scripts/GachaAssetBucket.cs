using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
#if UNITY_WEBGL && !UNITY_EDITOR
using System.Runtime.InteropServices;
#endif
using UnityEngine;
using UnityEngine.Networking;

namespace SekaiGacha
{
    // 单张卡牌的卡面和获得语音运行时从 Moesekai 资源桶下载；演出资源已打包进工程，不访问官方服务器。
    // 与原版 GachaDisplayState 相同：★2 用 member_gacha 的立绘且不播语音，★3 以上用卡面并播语音。
    public sealed class GachaAssetBucket
    {
#if UNITY_WEBGL && !UNITY_EDITOR
        [DllImport("__Internal")] static extern int SekaiGachaStartImageLoad(string path, string hostsCsv);
        [DllImport("__Internal")] static extern int SekaiGachaPollImageLoad(int handle, out int width, out int height, out int status, out IntPtr pixelsPtr, out int pixelsLen);
        [DllImport("__Internal")] static extern string SekaiGachaGetImageError(int handle);
        [DllImport("__Internal")] static extern void SekaiGachaReleaseImageLoad(int handle);
#endif
        public const string AssetSourceMain = "main";
        public const string AssetSourceBackup = "backup";
        // 两条线是同一份资源，默认顺序与 Moesekai 主站一致：主线 storage.pjsk.moe（Cloudflare）失败时换备用线
        // storage.exmeaning.com（EdgeOne）；宿主指定 backup 时顺序相反；资源不存在（404）时不再重试。
        static readonly string[] MainHosts = { "https://storage.pjsk.moe", "https://storage.exmeaning.com" };
        static readonly string[] BackupHosts = { "https://storage.exmeaning.com", "https://storage.pjsk.moe" };
        const string Region = "jp";
        string assetSource = AssetSourceMain;
        public string AssetSource
        {
            get => assetSource;
            set => assetSource = value == AssetSourceBackup ? AssetSourceBackup : AssetSourceMain;
        }
        public static bool IsValidAssetSource(string value) => value == AssetSourceMain || value == AssetSourceBackup;
        string[] OrderedHosts() => assetSource == AssetSourceBackup ? BackupHosts : MainHosts;
        public static string UserAgent => "SekaiGacha/" + Application.version + " (" + Application.platform + "; Unity " + Application.unityVersion + ")";

        public sealed class Card
        {
            public Texture2D Art;
            // ★2 和没有获得语音的少数 ★3/★4 为 null。
            public AudioClip Voice;
            // 只有特训后卡面（初始即特训）的卡，原版改用 afterTraining 演出。
            public bool AfterTrainingOnly;
            public void Release()
            {
                if (Art) UnityEngine.Object.Destroy(Art);
                if (Voice) UnityEngine.Object.Destroy(Voice);
            }
        }

        readonly MonoBehaviour runner;
        public GachaAssetBucket(MonoBehaviour runner) { this.runner = runner; }

        // 并行下载 into 中还没有的卡；卡面缺失视为失败，语音缺失按无语音处理。
        public IEnumerator Load(IEnumerable<GachaCard> cards, IDictionary<string, Card> into)
        {
            var hosts = OrderedHosts();
            var jobs = cards.GroupBy(card => card.Id).Select(group => group.First()).Where(card => !into.ContainsKey(card.Id)).Select(card => new Job(card, hosts)).ToArray();
            foreach (var job in jobs) runner.StartCoroutine(job.Run());
            while (jobs.Any(job => !job.Done)) yield return null;
            var failed = jobs.FirstOrDefault(job => job.Error != null);
            if (failed != null)
            {
                foreach (var job in jobs) job.Result.Release();
                throw new IOException(failed.Error);
            }
            foreach (var job in jobs) into.Add(job.Id, job.Result);
        }

        sealed class Job
        {
            public readonly string Id;
            readonly GachaRarity rarity;
            readonly string[] hosts;
            public readonly Card Result = new Card();
            public bool Done;
            public string Error;
            public Job(GachaCard card, string[] hosts) { Id = card.Id; rarity = card.Rarity; this.hosts = hosts; }

            public IEnumerator Run()
            {
                Error = "卡牌下载中断 " + Id;
                try
                {
                    long status = 0;
                    string message = null;
                    // ★2 的演出用 member_gacha 立绘；初始即特训的卡只有特训后卡面。
                    // WebGL 端走浏览器原生 WebP 解码（体积远小于 PNG）并配合 Cache Storage 缓存；编辑器/桌面沿用 PNG。
#if UNITY_WEBGL && !UNITY_EDITOR
                    string[] arts = rarity == GachaRarity.Rarity2
                        ? new[] { "character/member_gacha/" + Id + "/normal.webp" }
                        : new[] { "character/member/" + Id + "/card_normal.webp", "character/member/" + Id + "/card_after_training.webp" };
                    for (int i = 0; i < arts.Length; i++)
                    {
                        yield return FetchWebImage(arts[i], hosts,
                            texture => Result.Art = texture,
                            (code, error) => { status = code; message = error; });
                        Result.AfterTrainingOnly = i == 1;
                        if (Result.Art || status != 404) break;
                    }
#else
                    string[] arts = rarity == GachaRarity.Rarity2
                        ? new[] { "character/member_gacha/" + Id + "/normal.png" }
                        : new[] { "character/member/" + Id + "/card_normal.png", "character/member/" + Id + "/card_after_training.png" };
                    for (int i = 0; i < arts.Length; i++)
                    {
                        yield return Fetch(arts[i], hosts,
                            url => UnityWebRequestTexture.GetTexture(url, true),
                            request => Result.Art = DownloadHandlerTexture.GetContent(request),
                            (code, error) => { status = code; message = error; });
                        Result.AfterTrainingOnly = i == 1;
                        if (Result.Art || status != 404) break;
                    }
#endif
                    if (!Result.Art)
                    {
                        Error = "卡面下载失败 " + Id + " HTTP " + status + ": " + message;
                        yield break;
                    }
                    Result.Art.wrapMode = TextureWrapMode.Clamp;
                    // 原版 ★2 不播获得语音。
                    if (rarity == GachaRarity.Rarity2)
                    {
                        Error = null;
                        yield break;
                    }
                    yield return Fetch("sound/gacha/get_voice/" + Id + "/" + Id + ".mp3", hosts,
                        url => UnityWebRequestMultimedia.GetAudioClip(url, AudioType.MPEG),
                        request => Result.Voice = DownloadHandlerAudioClip.GetContent(request),
                        (code, error) => { if (code != 404) Debug.LogWarning("GACHA_VOICE_DOWNLOAD_FAILED " + Id + " HTTP " + code + ": " + error); });
                    Error = null;
                }
                finally { Done = true; }
            }
        }

#if UNITY_WEBGL && !UNITY_EDITOR
        static IEnumerator FetchWebImage(string path, string[] hosts, Action<Texture2D> success, Action<long, string> fail)
        {
            int handle = SekaiGachaStartImageLoad(path, string.Join(",", hosts));
            if (handle <= 0)
            {
                fail(0, "image_loader_unavailable");
                yield break;
            }
            try
            {
                while (true)
                {
                    int state = SekaiGachaPollImageLoad(handle, out int width, out int height, out int status, out IntPtr pixelsPtr, out int pixelsLen);
                    if (state == 0)
                    {
                        yield return null;
                        continue;
                    }
                    if (state > 0 && pixelsPtr != IntPtr.Zero && width > 0 && height > 0 && (long)width * height * 4L == pixelsLen)
                    {
                        var texture = new Texture2D(width, height, TextureFormat.RGBA32, false, false);
                        try
                        {
                            texture.LoadRawTextureData(pixelsPtr, pixelsLen);
                            texture.Apply(false, true);
                            success(texture);
                        }
                        catch (Exception exception)
                        {
                            UnityEngine.Object.Destroy(texture);
                            fail(status, exception.Message);
                        }
                    }
                    else
                    {
                        string error = SekaiGachaGetImageError(handle);
                        fail(status, string.IsNullOrEmpty(error) ? "image_load_failed" : error);
                    }
                    yield break;
                }
            }
            finally
            {
                SekaiGachaReleaseImageLoad(handle);
            }
        }
#endif

        static IEnumerator Fetch(string path, string[] hosts, Func<string, UnityWebRequest> create, Action<UnityWebRequest> success, Action<long, string> fail)
        {
            long code = 0;
            string error = null;
            foreach (string host in hosts)
            {
                using (var request = create(host + "/sekai-" + Region + "-assets/" + path))
                {
                    Identify(request);
                    request.timeout = 60;
                    yield return request.SendWebRequest();
                    code = request.responseCode;
                    error = request.error;
                    bool done = false;
                    if (request.result == UnityWebRequest.Result.Success)
                    {
                        try { success(request); done = true; }
                        catch (Exception exception) { error = exception.Message; }
                    }
                    if (done) yield break;
                }
                if (code == 404) break;
            }
            fail(code, error);
        }

        static void Identify(UnityWebRequest request)
        {
#if !UNITY_WEBGL || UNITY_EDITOR
            request.SetRequestHeader("User-Agent", UserAgent);
#endif
        }
    }
}
