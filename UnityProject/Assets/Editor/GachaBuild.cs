using System;
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using SekaiGacha;

[InitializeOnLoad]
public static class GachaBuild
{
    const string Scene = "Assets/Scenes/Gacha.unity";
    static GachaBuild()
    {
        if (SessionState.GetBool("GachaCheck", false)) Register();
    }
    public static void Configure()
    {
        ConcertRenderPipelineSetup.Configure();
        var pipeline = new SerializedObject(GraphicsSettings.defaultRenderPipeline);
        var renderers = pipeline.FindProperty("m_RendererDataList");
        renderers.arraySize = 2;
        renderers.GetArrayElementAtIndex(1).objectReferenceValue = AssetDatabase.LoadAssetAtPath<UniversalRendererData>("Assets/Resources/Rendering/TutorialRenderer.asset");
        pipeline.ApplyModifiedPropertiesWithoutUndo();
        PlayerSettings.companyName = "SekaiGacha";
        PlayerSettings.productName = "SekaiGacha";
        PlayerSettings.defaultScreenWidth = 1280;
        PlayerSettings.defaultScreenHeight = 720;
        PlayerSettings.fullScreenMode = FullScreenMode.Windowed;
        PlayerSettings.runInBackground = true;
        PlayerSettings.allowUnsafeCode = true;
        PlayerSettings.SetUseDefaultGraphicsAPIs(BuildTarget.StandaloneWindows64, false);
        PlayerSettings.SetGraphicsAPIs(BuildTarget.StandaloneWindows64, new[] { GraphicsDeviceType.OpenGLCore });
        if (!File.Exists(Scene)) EditorSceneManager.SaveScene(EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single), Scene);
        EditorBuildSettings.scenes = new[] { new EditorBuildSettingsScene(Scene, true) };
        EditorSceneManager.playModeStartScene = AssetDatabase.LoadAssetAtPath<SceneAsset>(Scene);
        AssetDatabase.SaveAssets();
        Debug.Log("GACHA_COMPILE_OK");
    }
    public static void Visual()
    {
        Configure();
        var view = EditorWindow.GetWindow(typeof(EditorWindow).Assembly.GetType("UnityEditor.GameView"));
        view.Show(); view.maximized = true; view.Focus();
        EditorApplication.EnterPlaymode();
    }
    public static void Smoke() { Begin(true); }
    public static void Validate() { Begin(false); }
    static void Begin(bool smoke)
    {
        Configure();
        SessionState.SetBool("GachaCheck", true);
        SessionState.SetBool("GachaAlignmentChecked", false);
        SessionState.SetBool("GachaSmoke", smoke);
        SessionState.SetString("GachaStart", DateTimeOffset.UtcNow.ToString("O"));
        Register();
        EditorApplication.EnterPlaymode();
    }
    static void Register()
    {
        EditorApplication.update -= Tick;
        EditorApplication.update += Tick;
        Application.logMessageReceived -= OnLog;
        Application.logMessageReceived += OnLog;
    }
    static void Tick()
    {
        if (!SessionState.GetBool("GachaCheck", false)) return;
        if ((DateTimeOffset.UtcNow - DateTimeOffset.Parse(SessionState.GetString("GachaStart", DateTimeOffset.UtcNow.ToString("O")))).TotalSeconds > 360) { Finish("验证超时", false); return; }
        var app = GachaApp.Instance;
        if (!app || !EditorApplication.isPlaying) return;
        if (app.Error != null) { Finish(app.Error, false); return; }
        if (app.DrawCount != 10) return;
        if (SessionState.GetBool("GachaSmoke", false))
        {
            // 卡池模拟可能抽到没有获得语音的卡，此时只要求已揭卡。
            if (app.RevealedCount >= 1 && (app.Audio.VoicePeak > 0 || app.Audio.MissingVoiceCount >= app.RevealedCount))
            {
                if (UnityEngine.Object.FindObjectsOfType<Canvas>(true).Length != 0) { Finish("检测到额外界面", false); return; }
                Finish("默认十连自动进入原版演出和卡牌语音；没有 Canvas 界面", true);
            }
        }
        else if (app.Phase == "完成")
            Finish("十连播放完成，揭卡=" + app.RevealedCount + "，语音=" + app.Audio.VoiceCount + "，无语音资源=" + app.Audio.MissingVoiceCount + "，最大帧耗时=" + app.MaximumFrameMs + "ms", app.RevealedCount == 10 && app.Audio.VoiceCount + app.Audio.MissingVoiceCount == 10 && (app.Audio.VoiceCount == 0 || app.Audio.VoicePeak > 0));
    }
    static void OnLog(string message, string stack, LogType type)
    {
        if (SessionState.GetBool("GachaCheck", false) && (type == LogType.Exception || type == LogType.Error))
            EditorApplication.delayCall += () => Finish(message + "\n" + stack, false);
    }
    static void Finish(string message, bool passed)
    {
        SessionState.SetBool("GachaCheck", false);
        EditorApplication.update -= Tick;
        string evidence = Path.GetFullPath(Application.dataPath + "/../../Evidence");
        Directory.CreateDirectory(evidence);
        File.WriteAllText(Path.Combine(evidence, "render-only-result.txt"), (passed ? "通过：" : "失败：") + message);
        Debug.Log("GACHA_CHECK " + passed + " " + message);
        EditorApplication.Exit(passed ? 0 : 1);
    }
}
