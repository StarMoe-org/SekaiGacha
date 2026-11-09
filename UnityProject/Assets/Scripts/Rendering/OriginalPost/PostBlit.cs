// 源自 Unity URP 14.0.12 RenderingUtils.Blit，保留原重建工程的调用语义。
using UnityEngine;
using UnityEngine.Rendering;
namespace Sekai.Rendering.PostPrcessV2 { internal static class PostBlit {
        internal static void Blit(CommandBuffer cmd,
            RTHandle source,
            Rect viewport,
            RTHandle destination,
            RenderBufferLoadAction loadAction,
            RenderBufferStoreAction storeAction,
            ClearFlag clearFlag,
            Color clearColor,
            Material material,
            int passIndex = 0)
        {
            Vector2 viewportScale = source.useScaling ? new Vector2(source.rtHandleProperties.rtHandleScale.x, source.rtHandleProperties.rtHandleScale.y) : Vector2.one;
            CoreUtils.SetRenderTarget(cmd, destination, loadAction, storeAction, ClearFlag.None, Color.clear);
            cmd.SetViewport(viewport);
            Blitter.BlitTexture(cmd, source, viewportScale, material, passIndex);
        }

        internal static void Blit(CommandBuffer cmd,
            RTHandle source,
            Rect viewport,
            RTHandle destinationColor,
            RenderBufferLoadAction colorLoadAction,
            RenderBufferStoreAction colorStoreAction,
            RTHandle destinationDepthStencil,
            RenderBufferLoadAction depthStencilLoadAction,
            RenderBufferStoreAction depthStencilStoreAction,
            ClearFlag clearFlag,
            Color clearColor,
            Material material,
            int passIndex = 0)
        {
            Vector2 viewportScale = source.useScaling ? new Vector2(source.rtHandleProperties.rtHandleScale.x, source.rtHandleProperties.rtHandleScale.y) : Vector2.one;
            CoreUtils.SetRenderTarget(cmd,
                destinationColor, colorLoadAction, colorStoreAction,
                destinationDepthStencil, depthStencilLoadAction, depthStencilStoreAction,
                clearFlag, clearColor); // implicit depth=1.0f stencil=0x0
            cmd.SetViewport(viewport);
            Blitter.BlitTexture(cmd, source, viewportScale, material, passIndex);
        }


} }