// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.PostPrcessV2/Property.cs，适配独立 URP 工程。
using UnityEngine;

namespace Sekai.Rendering.PostPrcessV2
{
	internal static class Property
	{
		public static class Vignette
		{
			public static readonly int Vignette_Params1 = Shader.PropertyToID("_Vignette_Params1");

			public static readonly int Vignette_Params2 = Shader.PropertyToID("_Vignette_Params2");
		}

		public static readonly int DarkColor = Shader.PropertyToID("_DarkColor");

		public static readonly int BrightColor = Shader.PropertyToID("_BrightColor");

		public static readonly int DarkPosition = Shader.PropertyToID("_DarkPosition");

		public static readonly int LightVector = Shader.PropertyToID("_LightVector");

		public static readonly int IncidentLightColor = Shader.PropertyToID("_IncidentLightColor");

		public static readonly int IncidentLightVector = Shader.PropertyToID("_IncidentLightVector");

		public static readonly int Saturation = Shader.PropertyToID("_Saturation");

		public static readonly int Solarisation = Shader.PropertyToID("_Solarisation");

		public static readonly int ChromaticAberrationParamType = Shader.PropertyToID("_ChromaticAberrationParamType");

		public static readonly int ChromaticAberrationOffsetR = Shader.PropertyToID("_ChromaticAberrationOffsetR");

		public static readonly int ChromaticAberrationOffsetG = Shader.PropertyToID("_ChromaticAberrationOffsetG");

		public static readonly int ChromaticAberrationOffsetB = Shader.PropertyToID("_ChromaticAberrationOffsetB");

		public static readonly int ChromaticAberrationScale = Shader.PropertyToID("_ChromaticAberrationScale");

		public static readonly int FadeOutBeforeProp = Shader.PropertyToID("_FadeOutBeforeProp");

		public static readonly int FadeOutBeforePropLerp = Shader.PropertyToID("_FadeOutBeforePropLerp");

		public static readonly int FadeOutParams = Shader.PropertyToID("_FadeOutParams");

		public static readonly int FadeOutSourceTex = Shader.PropertyToID("_FadeOutSourceTex");

		public static readonly int FadeOutFullscreenProjMat = Shader.PropertyToID("_FadeOutFullscreenProjMat");

		public static readonly string BlurTexName = "_BlurTex";

		public static readonly int Sat = Shader.PropertyToID("_Sat");

		public static readonly int SatAlpha = Shader.PropertyToID("_SatAlpha");

		public static readonly string SatTexName = "_SatTex";

		public static readonly int SatTex = Shader.PropertyToID(SatTexName);

		public static readonly string DofTexName = "_DepthTexture";

		public static readonly string ColorCoCTexName = "_ColorCoCTex";

		public static readonly string[] BlurTmpName = new string[2] { "_BlurTmpMidTex", "_BlurTmpLowTex" };

		public static readonly int Offsets = Shader.PropertyToID("_Offsets");

		public static readonly int InvRenderTargetSize = Shader.PropertyToID("_InvRenderTargetSize");

		public static readonly string[] BlurMidNames = new string[2] { "_BlurBgMidTex", "_BlurFgMidTex" };

		public static readonly string[] BlurLowNames = new string[2] { "_BlurBgLowTex", "_BlurFgLowTex" };

		public static readonly int FrontLut = Shader.PropertyToID("_FrontLut");

		public static readonly int FrontNonLutPosition = Shader.PropertyToID("_FrontNonLutPosition");

		public static readonly int FrontLutVector = Shader.PropertyToID("_FrontLutVector");

		public static readonly int BackLut = Shader.PropertyToID("_BackLut");

		public static readonly int BackNonLutPosition = Shader.PropertyToID("_BackNonLutPosition");

		public static readonly int BackLutVector = Shader.PropertyToID("_BackLutVector");

		public static readonly int FrontLutBlend = Shader.PropertyToID("_FrontLutBlend");

		public static readonly int BackLutBlend = Shader.PropertyToID("_BackLutBlend");

		public static readonly int HalfCol = Shader.PropertyToID("_HalfCol");

		public static readonly int Threshold = Shader.PropertyToID("_Threshold");

		public static readonly string BloomTexName = "_BloomTex";

		public static readonly int BloomTex = Shader.PropertyToID(BloomTexName);

		public static readonly int BloomBlendMode = Shader.PropertyToID("_BloomBlendMode");

		public static readonly int DirBlurStrength = Shader.PropertyToID("_DirBlurStrength");

		public static readonly int DirBlurDirection = Shader.PropertyToID("_DirBlurDirection");

		public static readonly int DirBlurCenterPosition = Shader.PropertyToID("_DirBlurCenterPosition");

		public static readonly string DirBlurName = "_DirBlurTex";

		public static readonly int Metrics = Shader.PropertyToID("_Metrics");

		public static readonly int AreaTexture = Shader.PropertyToID("_AreaTexture");

		public static readonly int SearchTexture = Shader.PropertyToID("_SearchTexture");

		public static readonly string EdgeStencilTexture = "_EdgeStencilTexture";

		public static readonly string EdgeColorTexture = "_EdgeColorTexture";

		public static readonly string BlendTexture = "_BlendTexture";

		public static readonly int StencilRef = Shader.PropertyToID("_StencilRef");

		public static readonly int StencilMask = Shader.PropertyToID("_StencilMask");

		public static readonly string SmaaTemp = "_SmaaTempBuffer";

		public static readonly int ScreenDistortionParam = Shader.PropertyToID("_SekaiScreenDistortionParam");

		public static readonly int ScreenDistortionNoiseTextureParam = Shader.PropertyToID("_SekaiScreenDistortionNoiseTextureParam");

		public static readonly string[] BoxBlurTexNames = new string[2] { "_BoxBlur0", "_BoxBlur1" };
	}
}
