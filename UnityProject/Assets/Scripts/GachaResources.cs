using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEngine;

namespace SekaiGacha
{
    // 演出资源已导出为工程资源，由 GachaOfflineCatalog 按原资源包名索引，各平台相同，运行时不访问官方服务器。
    // 单张卡牌的卡面和语音见 GachaAssetBucket。
    public sealed class GachaResources
    {
        readonly GachaOfflineCatalog offline;
        readonly Dictionary<string, Shader> shaders = new Dictionary<string, Shader>();
        public int ShaderFailures { get; private set; }
        public GachaResources()
        {
            offline = Resources.Load<GachaOfflineCatalog>("GachaOfflineCatalog");
            if (!offline) throw new InvalidDataException("缺少离线资源目录 GachaOfflineCatalog");
        }

        public IEnumerator Initialize()
        {
            foreach (var shader in Resources.LoadAll<Shader>(""))
                if (shader.isSupported && !shaders.ContainsKey(shader.name)) shaders.Add(shader.name, shader);
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

        public T Get<T>(string bundle, string name) where T : UnityEngine.Object
        {
            var found = offline.entries.FirstOrDefault(e => e.bundle == bundle && e.name.Equals(name, StringComparison.OrdinalIgnoreCase) && e.asset is T).asset as T;
            if (!found) throw new InvalidDataException("离线资源缺失 " + bundle + "/" + name);
            return found;
        }
        public T[] All<T>(string bundle) where T : UnityEngine.Object => offline.entries.Where(e => e.bundle == bundle).Select(e => e.asset).OfType<T>().Distinct().ToArray();
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
    }
}
