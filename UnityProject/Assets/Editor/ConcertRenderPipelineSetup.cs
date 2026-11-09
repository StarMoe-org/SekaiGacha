using System.IO;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public static class ConcertRenderPipelineSetup
{
    public static void Configure()
    {
        const string folder = "Assets/Resources/Rendering";
        Directory.CreateDirectory(folder);
        var data = AssetDatabase.LoadAssetAtPath<UniversalRendererData>(folder + "/TutorialRenderer.asset");
        if (!data)
        {
            data = ScriptableObject.CreateInstance<UniversalRendererData>();
            data.name = "TutorialRenderer";
            ResourceReloader.ReloadAllNullIn(data, UniversalRenderPipelineAsset.packagePath);
            AssetDatabase.CreateAsset(data, folder + "/TutorialRenderer.asset");
        }
        var pipeline = AssetDatabase.LoadAssetAtPath<UniversalRenderPipelineAsset>(folder + "/TutorialPipeline.asset");
        if (!pipeline)
        {
            pipeline = UniversalRenderPipelineAsset.Create(data);
            AssetDatabase.CreateAsset(pipeline, folder + "/TutorialPipeline.asset");
        }
        pipeline.supportsHDR = false;
        pipeline.msaaSampleCount = 1;
        pipeline.renderScale = 1f;
        pipeline.supportsCameraDepthTexture = false;
        pipeline.supportsCameraOpaqueTexture = false;
        var liveData = AssetDatabase.LoadAssetAtPath<UniversalRendererData>(folder + "/LiveRenderer.asset");
        if (!liveData)
        {
            liveData = ScriptableObject.CreateInstance<UniversalRendererData>();
            ResourceReloader.ReloadAllNullIn(liveData, UniversalRenderPipelineAsset.packagePath);
            liveData.opaqueLayerMask = 0;
            liveData.transparentLayerMask = 0;
            AssetDatabase.CreateAsset(liveData, folder + "/LiveRenderer.asset");
            var adapter = ScriptableObject.CreateInstance<ConcertRenderingAdapter>();
            adapter.name = "OriginalLivePasses";
            AssetDatabase.AddObjectToAsset(adapter, liveData);
            liveData.rendererFeatures.Add(adapter);
            EditorUtility.SetDirty(liveData);
        }
        liveData.intermediateTextureMode = IntermediateTextureMode.Always;
        EditorUtility.SetDirty(liveData);
        pipeline.useSRPBatcher = false;
        var serialized = new SerializedObject(pipeline);
        var renderers = serialized.FindProperty("m_RendererDataList");
        renderers.arraySize = 1;
        for (int i = 0; i < renderers.arraySize; i++) renderers.GetArrayElementAtIndex(i).objectReferenceValue = liveData;
        serialized.FindProperty("m_MainLightRenderingMode").intValue = 0;
        serialized.FindProperty("m_AdditionalLightsRenderingMode").intValue = 0;
        serialized.ApplyModifiedPropertiesWithoutUndo();
        GraphicsSettings.defaultRenderPipeline = pipeline;
        QualitySettings.renderPipeline = pipeline;
        EditorUtility.SetDirty(pipeline);
        AssetDatabase.SaveAssets();
    }

}