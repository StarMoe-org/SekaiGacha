using System;
using System.Linq;
using System.Text.RegularExpressions;
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
    public static void Build() => Build(true, "../Build/WebGL");

    // 供 Moesekai 嵌入的发布版：非 Development，体积更小。
    [MenuItem("SekaiGacha/Build Moesekai WebGL")]
    public static void BuildRelease() => Build(false, "../Build/Moesekai");

    static void Build(bool development, string output)
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
        // 保持不压缩，构建后才能修补 framework.js；压缩交给托管方按 Content-Encoding 处理。
        PlayerSettings.WebGL.compressionFormat = WebGLCompressionFormat.Disabled;
        // 嵌入用模板：画布铺满并保持 16:9，负责与宿主页面通信。
        PlayerSettings.WebGL.template = "PROJECT:SekaiGacha";
        var report = BuildPipeline.BuildPlayer(new BuildPlayerOptions {
            scenes = new[] { "Assets/Scenes/Gacha.unity" },
            target = BuildTarget.WebGL,
            locationPathName = output,
            options = development ? BuildOptions.Development : BuildOptions.None
        });
        Debug.Log("GACHA_WEB_BUILD " + report.summary.result + " errors=" + report.summary.totalErrors + " output=" + output);
        if (report.summary.result != BuildResult.Succeeded) throw new Exception("WebGL 构建失败");
        PatchFramework(output + "/Build/" + System.IO.Path.GetFileName(output) + ".framework.js");
        BuildCjkFont(output);
    }

    // tw、cn、kr 用的字体 SekaiGacha CJK（思源黑体 SC Bold 的子集，见 tools/make-cjk-font.py）单独打成资源包，
    // 放在 StreamingAssets/GachaFonts，运行时用到才下载（GachaApp.LoadCjkFont），不计入首次加载。
    // SIL OFL 1.1 要求字体与许可证一起分发，许可证放在同一目录。
    static void BuildCjkFont(string output)
    {
        const string font = "Assets/GachaFonts/SekaiGachaCJK-Bold.otf", license = "Assets/GachaFonts/LICENSE-SourceHanSans.txt";
        string temp = System.IO.Path.Combine("Temp", "GachaCjkFont");
        if (System.IO.Directory.Exists(temp)) System.IO.Directory.Delete(temp, true);
        System.IO.Directory.CreateDirectory(temp);
        var manifest = BuildPipeline.BuildAssetBundles(temp,
            new[] { new AssetBundleBuild { assetBundleName = "gacha-cjk-font.bundle", assetNames = new[] { font } } },
            BuildAssetBundleOptions.None, BuildTarget.WebGL);
        if (!manifest) throw new Exception("字体资源包构建失败");
        string target = System.IO.Path.Combine(output, "StreamingAssets", "GachaFonts");
        System.IO.Directory.CreateDirectory(target);
        System.IO.File.Copy(System.IO.Path.Combine(temp, "gacha-cjk-font.bundle"), System.IO.Path.Combine(target, "gacha-cjk-font.bundle"), true);
        System.IO.File.Copy(license, System.IO.Path.Combine(target, "LICENSE-SourceHanSans.txt"), true);
        Debug.Log("GACHA_CJK_FONT_BUNDLE bytes=" + new System.IO.FileInfo(System.IO.Path.Combine(target, "gacha-cjk-font.bundle")).Length);
    }

    // Unity 2022 WebGL 预处理器的嵌套 else 必须遵守父分支是否启用，并跳过 #line。
    // 发布版的 framework.js 会被压缩改名，按结构匹配而不是按原文。
    static void PatchFramework(string framework)
    {
        string source = System.IO.File.ReadAllText(framework);
        var elseToggle = new Regex(@"(\w+)\[\1\.length-1\]\s*=\s*1-\1\[\1\.length-1\]");
        var extensionOnly = new Regex(@"(\w+)\s*!=\s*(['""])extension\2\)");
        // 增量构建可能沿用上次输出的 framework.js，已修补过就不再改。
        var elsePatched = new Regex(@"(\w+)\[\1\.length-1\]=\(1-\1\[\1\.length-1\]\)\*\1\[\1\.length-2\]");
        var extensionPatched = new Regex(@"(\w+)!=(['""])extension\2&&\1!=\2line\2\)");
        if (elseToggle.Matches(source).Count == 0 && extensionOnly.Matches(source).Count == 0
            && elsePatched.Matches(source).Count == 1 && extensionPatched.Matches(source).Count == 1)
        {
            Debug.Log("GACHA_FRAMEWORK_ALREADY_PATCHED " + framework);
            return;
        }
        if (elseToggle.Matches(source).Count != 1 || extensionOnly.Matches(source).Count != 1) throw new Exception("WebGL 预处理器结构已变化");
        source = elseToggle.Replace(source, "$1[$1.length-1]=(1-$1[$1.length-1])*$1[$1.length-2]");
        source = extensionOnly.Replace(source, "$1!=$2extension$2&&$1!=$2line$2)");
        System.IO.File.WriteAllText(framework, source);
        Debug.Log("GACHA_FRAMEWORK_PATCHED " + framework);
    }
}
