using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Sekai.Rendering
{
    public class SekaiDrawObjectsPass : ScriptableRenderPass
    {
        private FilteringSettings m_FilteringSettings;
        private RenderStateBlock m_RenderStateBlock;
        private readonly List<ShaderTagId> m_ShaderTagIdList;
        private readonly ProfilingSampler m_ProfilingSampler;
        private readonly bool m_IsOpaque;
        private SekaiBuffer m_Buffer;
        public bool ColorOnly { get; set; }
        private static readonly int DrawObjectPassData = Shader.PropertyToID("_DrawObjectPassData");
        private static readonly int ScaleBiasRt = Shader.PropertyToID("_ScaleBiasRt");

        public SekaiDrawObjectsPass(string profilerTag, ShaderTagId[] tags, bool opaque, RenderPassEvent evt, RenderQueueRange range)
        {
            profilingSampler = new ProfilingSampler("SekaiDrawObjectsPass");
            renderPassEvent = evt;
            m_ProfilingSampler = new ProfilingSampler(profilerTag);
            m_ShaderTagIdList = tags.ToList();
            m_FilteringSettings = new FilteringSettings(range);
            m_RenderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);
            m_IsOpaque = opaque;
        }

        internal void Setup(LayerMask layerMask, StencilState stencil, int reference, SekaiBuffer buffer)
        {
            m_FilteringSettings.layerMask = layerMask;
            m_Buffer = buffer;
            if (stencil.enabled)
            {
                m_RenderStateBlock.stencilReference = reference;
                m_RenderStateBlock.mask = RenderStateMask.Stencil;
                m_RenderStateBlock.stencilState = stencil;
            }
            if (!m_IsOpaque)
            {
                ConfigureColorStoreAction(RenderBufferStoreAction.Store);
                ConfigureDepthStoreAction(RenderBufferStoreAction.DontCare);
            }
        }

        public override void Configure(CommandBuffer cmd, RenderTextureDescriptor descriptor)
        {
            if (m_Buffer == null) return;
            m_Buffer.AllocSekaiBufferHandles(descriptor);
            if (ColorOnly) ConfigureTarget(m_Buffer.SekaiBufferColorHandle, m_Buffer.DepthAttachment);
            else ConfigureTarget(m_Buffer.SekaiBufferHandles, m_Buffer.DepthAttachment);
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            var cmd = CommandBufferPool.Get();
            using (new ProfilingScope(cmd, m_ProfilingSampler))
            {
                cmd.SetGlobalVector(DrawObjectPassData, new Vector4(0f, 0f, 0f, m_IsOpaque ? 1f : 0f));
                bool flipped = renderingData.cameraData.IsCameraProjectionMatrixFlipped();
                cmd.SetGlobalVector(ScaleBiasRt, new Vector4(flipped ? -1f : 1f, flipped ? 1f : 0f, flipped ? -1f : 1f, 1f));
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
                var drawing = CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, m_IsOpaque ? renderingData.cameraData.defaultOpaqueSortFlags : SortingCriteria.CommonTransparent);
                var filtering = m_FilteringSettings;
                context.DrawRenderers(renderingData.cullResults, ref drawing, ref filtering, ref m_RenderStateBlock);
            }
            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }
    }
}
