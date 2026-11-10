using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEngine;
using UnityEngine.Networking;

namespace SekaiGacha
{
    // 单张卡牌的卡面和获得语音运行时从 Moesekai 资源桶下载；演出资源已打包进工程，不访问官方服务器。
    public sealed class GachaAssetBucket
    {
        // 两条线是同一份资源：主线失败时换海外线，资源不存在（404）时不再重试。
        static readonly string[] Hosts = { "https://storage.exmeaning.com", "https://storage.pjsk.moe" };
        const string Region = "jp";
        public static string UserAgent => "SekaiGacha/" + Application.version + " (" + Application.platform + "; Unity " + Application.unityVersion + ")";

        public sealed class Card
        {
            public Texture2D Art;
            // 没有获得语音的卡（全部 ★1/★2 及少数 ★3/★4）为 null。
            public AudioClip Voice;
            public void Release()
            {
                if (Art) UnityEngine.Object.Destroy(Art);
                if (Voice) UnityEngine.Object.Destroy(Voice);
            }
        }

        readonly MonoBehaviour runner;
        public GachaAssetBucket(MonoBehaviour runner) { this.runner = runner; }

        // 并行下载 into 中还没有的卡；卡面缺失视为失败，语音缺失按无语音处理。
        public IEnumerator Load(IEnumerable<string> ids, IDictionary<string, Card> into)
        {
            var jobs = ids.Distinct().Where(id => !into.ContainsKey(id)).Select(id => new Job(id)).ToArray();
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
            public readonly Card Result = new Card();
            public bool Done;
            public string Error;
            public Job(string id) { Id = id; }

            public IEnumerator Run()
            {
                Error = "卡牌下载中断 " + Id;
                try
                {
                    long status = 0;
                    string message = null;
                    // 初始即特训的卡只有特训后卡面。
                    foreach (string name in new[] { "card_normal", "card_after_training" })
                    {
                        yield return Fetch("character/member/" + Id + "/" + name + ".png",
                            url => UnityWebRequestTexture.GetTexture(url, true),
                            request => Result.Art = DownloadHandlerTexture.GetContent(request),
                            (code, error) => { status = code; message = error; });
                        if (Result.Art || status != 404) break;
                    }
                    if (!Result.Art)
                    {
                        Error = "卡面下载失败 " + Id + " HTTP " + status + ": " + message;
                        yield break;
                    }
                    Result.Art.wrapMode = TextureWrapMode.Clamp;
                    yield return Fetch("sound/gacha/get_voice/" + Id + "/" + Id + ".mp3",
                        url => UnityWebRequestMultimedia.GetAudioClip(url, AudioType.MPEG),
                        request => Result.Voice = DownloadHandlerAudioClip.GetContent(request),
                        (code, error) => { if (code != 404) Debug.LogWarning("GACHA_VOICE_DOWNLOAD_FAILED " + Id + " HTTP " + code + ": " + error); });
                    Error = null;
                }
                finally { Done = true; }
            }
        }

        static IEnumerator Fetch(string path, Func<string, UnityWebRequest> create, Action<UnityWebRequest> success, Action<long, string> fail)
        {
            long code = 0;
            string error = null;
            foreach (string host in Hosts)
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
#if UNITY_WEBGL && !UNITY_EDITOR
            // 浏览器不允许脚本改 User-Agent，改用自定义请求头；资源桶的跨域预检放行该请求头。
            request.SetRequestHeader("X-SekaiGacha-Client", UserAgent);
#else
            request.SetRequestHeader("User-Agent", UserAgent);
#endif
        }
    }
}
