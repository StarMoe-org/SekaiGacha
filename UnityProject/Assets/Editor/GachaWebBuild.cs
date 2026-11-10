using System;
using System.Linq;
using SekaiGacha;
using UnityEditor;
using UnityEditor.Build.Reporting;
using UnityEngine;

public static class GachaWebBuild
{
    // 单张卡牌的卡面和语音运行时从资源桶下载，不打包进构建。
    static readonly string[] RuntimeBundles = { "character/member/", "character/member_small/", "sound/gacha/get_voice/" };

    static void PrepareCatalog()
    {
        var entries = AssetDatabase.GetAllAssetPaths()
            .Where(path => path.StartsWith("Assets/Offline/") && !AssetDatabase.IsValidFolder(path))
            .OrderBy(path => path, StringComparer.Ordinal)
            .SelectMany(path => AssetDatabase.LoadAllAssetsAtPath(path)
                .Where(asset => asset is GameObject || asset is Texture || asset is Sprite ||
                    asset is Material || asset is TextAsset || asset is AnimationClip || asset is ShaderVariantCollection ||
                    asset is UnityEngine.Timeline.SignalAsset || asset is Sekai.Core.MeshFlareParaTexData)
                .Select(asset => new GachaOfflineCatalog.Entry {
                    bundle = AssetImporter.GetAtPath(path).assetBundleName, name = asset.name, asset = asset }))
            .Where(entry => !string.IsNullOrEmpty(entry.bundle) && !RuntimeBundles.Any(entry.bundle.StartsWith)).ToArray();
        const string path = "Assets/Resources/GachaOfflineCatalog.asset";
        var catalog = AssetDatabase.LoadAssetAtPath<GachaOfflineCatalog>(path);
        if (!catalog) { catalog = ScriptableObject.CreateInstance<GachaOfflineCatalog>(); AssetDatabase.CreateAsset(catalog, path); }
        catalog.entries = entries;
        EditorUtility.SetDirty(catalog);
        AssetDatabase.SaveAssets();
        Debug.Log("GACHA_OFFLINE_CATALOG entries=" + entries.Length);
    }

    [MenuItem("SekaiGacha/Build Offline WebGL")]
    public static void Build()
    {
        PrepareCatalog();
        GachaBuild.Configure();
        foreach (string path in System.IO.Directory.GetFiles("Assets/CRIMW/CriWare/Runtime/Platforms/WebGL2", "*.a"))
        {
            var plugin = (PluginImporter)AssetImporter.GetAtPath(path);
            plugin.SetCompatibleWithAnyPlatform(false);
            plugin.SetCompatibleWithEditor(false);
            plugin.SetCompatibleWithPlatform(BuildTarget.WebGL, true);
            plugin.SaveAndReimport();
        }
        PlayerSettings.SetManagedStrippingLevel(BuildTargetGroup.WebGL, ManagedStrippingLevel.Minimal);
        PlayerSettings.WebGL.compressionFormat = WebGLCompressionFormat.Disabled;
        var report = BuildPipeline.BuildPlayer(new BuildPlayerOptions {
            scenes = new[] { "Assets/Scenes/Gacha.unity" },
            target = BuildTarget.WebGL,
            locationPathName = "../Build/WebGL",
            options = BuildOptions.Development
        });
        Debug.Log("GACHA_WEB_BUILD " + report.summary.result + " errors=" + report.summary.totalErrors);
        if (report.summary.result != BuildResult.Succeeded) throw new Exception("WebGL 构建失败");
        // Unity 2022 WebGL 预处理器的嵌套 else 必须遵守父分支是否启用。
        const string framework = "../Build/WebGL/Build/WebGL.framework.js";
        string source = System.IO.File.ReadAllText(framework);
        const string before = "stack[stack.length-1] = 1-stack[stack.length-1]";
        if (!source.Contains(before) && !source.Contains("(1-stack[stack.length-1]) * stack[stack.length-2]")) throw new Exception("WebGL 预处理器结构已变化");
        source = source.Replace(before, "stack[stack.length-1] = (1-stack[stack.length-1]) * stack[stack.length-2]")
            .Replace("directive != 'extension')", "directive != 'extension' && directive != 'line')");
        System.IO.File.WriteAllText(framework, source);
        const string page = "../Build/WebGL/index.html";
        string html = System.IO.File.ReadAllText(page);
        const string viewportStyle = "<style>#unity-canvas{width:min(100vw,calc((100vh - 38px)*16/9))!important;height:auto!important;aspect-ratio:16/9}#unity-container{width:max-content;max-width:100vw}body{margin:0;overflow:hidden}</style>";
        if (!html.Contains(viewportStyle)) System.IO.File.WriteAllText(page, html.Replace("</head>", viewportStyle + "</head>"));


    }
}
