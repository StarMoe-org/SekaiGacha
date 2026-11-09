// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/FadeOut.cs，适配独立 URP 工程。
using System;
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components
{
	[Serializable]
	[VolumeComponentMenu("Sekai/FadeOut")]
	public class FadeOut : SekaiVolumeComponent
	{
		public ClampedFloatParameter fadeOut = new ClampedFloatParameter(0.5f, 0f, 1f);

		public ClampedFloatParameter fadeOutLerp = new ClampedFloatParameter(0.5f, 0f, 1f);

		public override bool IsActive()
		{
			return isActive = Math.Abs(fadeOut.value + -0.5f) > 0.01f || Math.Abs(fadeOutLerp.value + -0.5f) > 0.01f;
		}
	}
}
