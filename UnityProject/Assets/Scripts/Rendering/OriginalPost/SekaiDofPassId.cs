// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.PostPrcessV2/SekaiDofPassId.cs，适配独立 URP 工程。
namespace Sekai.Rendering.PostPrcessV2
{
	public enum SekaiDofPassId
	{
		Alpha_CoC,
		Mid_DownSample_MRT,
		Blur_Mid_Bg,
		Blur_Low_Bg,
		Downsample_With_Coc_Conserve,
		Blur_Mid_Fg,
		Blur_Low_Fg,
		Apply_Source_Bg_Fg,
		Apply_Source_Bg
	}
}
