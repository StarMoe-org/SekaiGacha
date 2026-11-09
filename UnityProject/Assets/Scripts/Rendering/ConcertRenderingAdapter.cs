using Sekai.Rendering;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

// 将原版 Live 绘制 Pass 接入当前 URP 的相机目标管理。
public sealed class ConcertRenderingAdapter : ScriptableRendererFeature
{
    private SekaiBuffer buffer;
    private PreparePass prepare;
    private ResolvePass resolve;
    private FinalFadePass finalFade;
    private Sekai.Rendering.PostPrcessV2.SekaiPostProcessPass originalPost;
    private SekaiDrawObjectsPass[] draws;
    private SekaiCharacterOutlinePass outline;
    public override void Create()
    {
        buffer = new SekaiBuffer();
        prepare = new PreparePass(buffer);
        resolve = new ResolvePass(buffer);
        finalFade = new FinalFadePass(buffer);
        originalPost = new Sekai.Rendering.PostPrcessV2.SekaiPostProcessPass();
        draws = new[]
        {
            Draw("OpaqueForward", "SRPDefaultUnlit", true, 250, RenderQueueRange.opaque),
            Draw("OpaqueToon", "SekaiOutline", true, 250, RenderQueueRange.opaque),
            Draw("Eyelash", "SekaiEyelash", true, 300, new RenderQueueRange(2001,2450)),
            Draw("TransparentForward", "SRPDefaultUnlit", false, 450, RenderQueueRange.transparent),
            Draw("MeshFlarePara", "SekaiMeshFlarePara", false, 499, RenderQueueRange.transparent)
        };
        outline = new SekaiCharacterOutlinePass { renderPassEvent = RenderPassEvent.BeforeRenderingOpaques };
        outline.Setup(new SekaiCharacterOutlinePass.OutlineSettings
        {
            outlineWidthMin = 0.04f, outlineWidthMax = 0.95f,
            outlineDistanceNear = 0.45f, outlineDistanceFar = 20f,
            fovCurve = new AnimationCurve(
                new Keyframe(-0.013763428f,27.812466f,-0.13214514f,-0.13214514f),
                new Keyframe(100.923416f,-0.036206245f,-0.57135975f,-0.57135975f))
        });
    }
    private static SekaiDrawObjectsPass Draw(string name, string tag, bool opaque, int evt, RenderQueueRange range)
    {
        return new SekaiDrawObjectsPass(name, new[]{new ShaderTagId(tag)},opaque,(RenderPassEvent)evt,range) { ColorOnly = tag == "SekaiMeshFlarePara" };
    }
    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData data)
    {
        renderer.EnqueuePass(prepare);
        renderer.EnqueuePass(outline);
        foreach (var draw in draws) renderer.EnqueuePass(draw);
        if (data.cameraData.camera.GetComponent<Sekai.Core.Graphics.PostEffectV2>()) { renderer.EnqueuePass(originalPost); renderer.EnqueuePass(finalFade); }
        else renderer.EnqueuePass(resolve);
    }
    public override void SetupRenderPasses(ScriptableRenderer renderer, in RenderingData data)
    {
        prepare.depth = renderer.cameraDepthTargetHandle;
        resolve.target = renderer.cameraColorTargetHandle;
        finalFade.target = renderer.cameraColorTargetHandle;
        if (data.cameraData.camera.GetComponent<Sekai.Core.Graphics.PostEffectV2>())
            originalPost.Setup(RenderPassEvent.BeforeRenderingPostProcessing, buffer, data.cameraData.cameraTargetDescriptor, buffer.SekaiBufferColorHandle, renderer.cameraColorTargetHandle);
        foreach (var draw in draws) draw.Setup(-1, StencilState.defaultValue, 0, buffer);
    }
    protected override void Dispose(bool disposing) { originalPost?.Dispose(); finalFade?.Dispose(); buffer?.ReleaseMRT(); }
    private sealed class PreparePass : ScriptableRenderPass
    {
        private readonly SekaiBuffer buffer;
        public RTHandle depth;
        public PreparePass(SekaiBuffer value) { buffer=value;renderPassEvent=(RenderPassEvent)249; }
        public override void Configure(CommandBuffer cmd, RenderTextureDescriptor descriptor)
        {
            buffer.AllocSekaiBufferHandles(descriptor);
            buffer.Setup(cmd,depth);
            ConfigureTarget(buffer.SekaiBufferHandles,depth);
            ConfigureClear(ClearFlag.All,Color.black);
        }
        public override void Execute(ScriptableRenderContext context, ref RenderingData data)
        {
            var cmd=CommandBufferPool.Get();
            foreach(var handle in buffer.SekaiBufferHandles) cmd.SetGlobalTexture(handle.name,handle.nameID);
            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }
    }
    // 源自 Sekai.Rendering/SekaiAfterPostProcessRenderPass.cs 的最终淡出段。
    private sealed class FinalFadePass : ScriptableRenderPass
    {
        readonly SekaiBuffer buffer;
        readonly Material material;
        public RTHandle target;
        public FinalFadePass(SekaiBuffer value)
        {
            buffer=value;
            renderPassEvent=RenderPassEvent.AfterRenderingPostProcessing;
            material=CoreUtils.CreateEngineMaterial(Shader.Find("Hidden/AfterPostProcess/FadeOutBlend"));
        }
        public void Dispose() { CoreUtils.Destroy(material); }
        public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData data) { ConfigureTarget(target); }
        public override void Execute(ScriptableRenderContext context, ref RenderingData data)
        {
            var fade=VolumeManager.instance.stack.GetComponent<Sekai.Rendering.Components.FadeOut>();
            if (fade==null || !fade.IsActive()) return;
            var cmd=CommandBufferPool.Get();
            Blitter.BlitCameraTexture(cmd,target,buffer.SekaiBufferColorHandle);
            material.SetVector("_FadeOutParams",new Vector4(2*fade.fadeOut.value-1,2*fade.fadeOutLerp.value-1,0,0));
            Blitter.BlitCameraTexture(cmd,buffer.SekaiBufferColorHandle,target,material,0);
            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }
    }
    private sealed class ResolvePass : ScriptableRenderPass
    {
        private readonly SekaiBuffer buffer;
        public RTHandle target;
        public ResolvePass(SekaiBuffer value) { buffer=value;renderPassEvent=RenderPassEvent.BeforeRenderingPostProcessing; }
        public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData data) { ConfigureTarget(target); }
        public override void Execute(ScriptableRenderContext context, ref RenderingData data)
        {
            var cmd=CommandBufferPool.Get();
            Blitter.BlitCameraTexture(cmd,buffer.SekaiBufferColorHandle,target);
            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }
    }
}
