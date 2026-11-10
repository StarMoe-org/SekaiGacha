using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using Newtonsoft.Json.Linq;
using UnityEngine;
using UnityEngine.Networking;

namespace SekaiGacha
{
    // 复用 VirtualLiveReverse 的固定版本签名及资源协议。
    public sealed class GachaResources : IDisposable
    {
        readonly string root;
        readonly GachaOfflineCatalog offline;
        readonly Dictionary<string, AssetBundle> loaded = new Dictionary<string, AssetBundle>();
        readonly Dictionary<string, Stream> streams = new Dictionary<string, Stream>();
        readonly Dictionary<string, Shader> shaders = new Dictionary<string, Shader>();
        JObject version, bundles;
        string cookie;
        readonly string installId = Guid.NewGuid().ToString();
        public string Status { get; private set; }
        public int ShaderFailures { get; private set; }
        string AssetBase => "https://" + version["host"] + "-assetbundle.sekai.colorfulpalette.org/" + version["assetVersion"] + "/" + version["assetHash"] + "/android/";
        public GachaResources(string cache)
        {
            root = cache;
#if UNITY_WEBGL
            offline = Resources.Load<GachaOfflineCatalog>("GachaOfflineCatalog");
            if (!offline) throw new InvalidDataException("缺少 WebGL 离线资源目录");
#endif
            if (!offline) Directory.CreateDirectory(root);
        }

        public IEnumerator Initialize()
        {
            foreach (var shader in Resources.LoadAll<Shader>(""))
                if (shader.isSupported && !shaders.ContainsKey(shader.name)) shaders.Add(shader.name, shader);
            if (offline)
            {
                foreach (var asset in offline.entries.Select(e => e.asset).Distinct())
                {
                    if (asset is Material material) Rebind(material);
                    if (asset is GameObject prefab) Rebind(prefab);
                }
                foreach (var variants in offline.entries.Select(e => e.asset).OfType<ShaderVariantCollection>().Distinct())
                    GachaShaderWarmup.WarmUpWhenNotLoaded(variants);
                Debug.Log("GACHA_OFFLINE_READY");
                yield break;
            }
            version = JObject.Parse(Resources.Load<TextAsset>("ResourceVersion").text);
            using (var request = Request("https://issue.sekai.colorfulpalette.org/api/signature", "POST"))
            {
                request.uploadHandler = new UploadHandlerRaw(ProtocolCodec.Crypt(Array.Empty<byte>(), true));
                yield return request.SendWebRequest();
                Check(request);
                var fields = Regex.Matches(request.GetResponseHeader("Set-Cookie") ?? "", @"(CloudFront-(?:Policy|Signature|Key-Pair-Id))=([^;,\s]+)").Cast<Match>().ToArray();
                if (fields.Length != 3) throw new InvalidDataException("CDN 签名不完整");
                cookie = string.Join("; ", fields.Select(m => m.Groups[1].Value + "=" + m.Groups[2].Value));
            }
            string manifest = Path.Combine(root, "manifest.json");
            if (!File.Exists(manifest))
            {
                string url = "https://" + version["host"] + "-assetbundle-info.sekai.colorfulpalette.org/api/version/" + version["assetVersion"] + "/" + version["assetHash"] + "/os/android";
                using (var request = Request(url, "GET"))
                {
                    yield return request.SendWebRequest();
                    Check(request);
                    var decoded = JObject.FromObject(new ProtocolCodec.MessageReader(ProtocolCodec.Crypt(request.downloadHandler.data, false)).Read());
                    File.WriteAllText(manifest, decoded.ToString());
                }
            }
            bundles = (JObject)JObject.Parse(File.ReadAllText(manifest))["bundles"];
            Debug.Log("GACHA_SIGNED_NO_ACCOUNT version=" + version["assetVersion"]);
        }

        UnityWebRequest Request(string url, string method)
        {
            var request = new UnityWebRequest(url, method) { downloadHandler = new DownloadHandlerBuffer(), timeout = 90, redirectLimit = 0 };
            request.SetRequestHeader("Content-Type", "application/octet-stream");
            request.SetRequestHeader("Accept", "application/octet-stream");
            request.SetRequestHeader("X-App-Version", "7.1.0");
            request.SetRequestHeader("X-App-Hash", "833770f2-7169-40b3-bb69-c0d27f312156");
            request.SetRequestHeader("X-Platform", "Android");
            request.SetRequestHeader("X-Install-Id", installId);
            request.SetRequestHeader("X-Request-Id", Guid.NewGuid().ToString());
            request.SetRequestHeader("X-Data-Version", (string)version["dataVersion"]);
            request.SetRequestHeader("X-Asset-Version", (string)version["assetVersion"]);
            if (cookie != null) request.SetRequestHeader("Cookie", cookie);
            return request;
        }
        static void Check(UnityWebRequest request)
        {
            if (request.result != UnityWebRequest.Result.Success)
                throw new IOException("资源请求失败 HTTP " + request.responseCode + ": " + request.error);
        }
        IEnumerable<string> Dependencies(string name, HashSet<string> visited)
        {
            if (!visited.Add(name)) yield break;
            if (bundles[name] == null) throw new InvalidDataException("资源清单缺少 " + name);
            foreach (var dependency in (JArray)bundles[name]["dependencies"] ?? new JArray())
                foreach (string child in Dependencies((string)dependency, visited)) yield return child;
            yield return name;
        }
        public IEnumerator Load(params string[] names)
        {
            if (offline) yield break;
            var visited = new HashSet<string>();
            foreach (string name in names.SelectMany(n => Dependencies(n, visited)))
            {
                if (loaded.ContainsKey(name)) continue;
                Status = "加载资源… " + name;
                string file = Path.Combine(root, (string)bundles[name]["cacheFileName"]);
                if (!File.Exists(file))
                {
                    using (var request = Request(AssetBase + name, "GET"))
                    {
                        yield return request.SendWebRequest();
                        Check(request);
                        File.WriteAllBytes(file, request.downloadHandler.data);
                    }
                }
                var stream = new AssetBundleStream(File.OpenRead(file));
                streams.Add(name, stream);
                var operation = AssetBundle.LoadFromStreamAsync(stream);
                yield return operation;
                if (!operation.assetBundle) throw new InvalidDataException("无法加载资源包 " + name);
                loaded.Add(name, operation.assetBundle);
                foreach (var material in operation.assetBundle.LoadAllAssets<Material>()) Rebind(material);
                // Timeline 引用的特效预制体可能内嵌材质，需在创建播放图前绑定。
                foreach (var prefab in operation.assetBundle.LoadAllAssets<GameObject>()) Rebind(prefab);
                Debug.Log("GACHA_BUNDLE " + name);
            }
        }
        public T Get<T>(string bundle, string name) where T : UnityEngine.Object
        {
            if (offline)
            {
                var found = offline.entries.FirstOrDefault(e => e.bundle == bundle && e.name.Equals(name, StringComparison.OrdinalIgnoreCase) && e.asset is T).asset as T;
                if (!found) throw new InvalidDataException("离线资源缺失 " + bundle + "/" + name);
                return found;
            }
            var value = loaded[bundle];
            T result = value.LoadAsset<T>(name);
            if (!result)
            {
                string path = value.GetAllAssetNames().FirstOrDefault(p => Path.GetFileNameWithoutExtension(p).Equals(name, StringComparison.OrdinalIgnoreCase));
                if (path != null) result = value.LoadAsset<T>(path);
            }
            if (!result) throw new InvalidDataException("资源缺失 " + bundle + "/" + name);
            if (result is GameObject prefab) Rebind(prefab);
            return result;
        }
        public T[] All<T>(string bundle) where T : UnityEngine.Object => offline ? offline.entries.Where(e => e.bundle == bundle).Select(e => e.asset).OfType<T>().Distinct().ToArray() : loaded[bundle].LoadAllAssets<T>();
        // 离线（WebGL）时只含预先打包的资源。
        public bool IsOffline => offline;
        public bool Has(string bundle) => offline ? offline.entries.Any(e => e.bundle == bundle) : bundles?[bundle] != null;
        void Rebind(GameObject prefab)
        {
            foreach (var renderer in prefab.GetComponentsInChildren<Renderer>(true))
            {
                foreach (var material in renderer.sharedMaterials) Rebind(material);
                if (renderer is ParticleSystemRenderer particle) Rebind(particle.trailMaterial);
            }
        }
        public void Rebind(Material material)
        {
            if (!material || !material.shader) return;
            if (shaders.TryGetValue(material.shader.name, out var shader)) material.shader = shader;
            if (!material.shader.isSupported)
            {
                ShaderFailures++;
                Debug.LogError("GACHA_UNSUPPORTED_SHADER " + material.shader.name);
            }
        }
        public void Dispose()
        {
            foreach (var bundle in loaded.Values) bundle.Unload(true);
            foreach (var stream in streams.Values) stream.Dispose();
        }
    }
}
