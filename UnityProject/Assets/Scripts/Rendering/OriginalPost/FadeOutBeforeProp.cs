// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/FadeOutBeforeProp.cs，适配独立 URP 工程。
using System;
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components
{
	[Serializable]
	[VolumeComponentMenu("Sekai/FadeOutBeforeProp")]
	public class FadeOutBeforeProp : SekaiVolumeComponent
	{
		public ClampedFloatParameter fadeOutBeforeProp = new ClampedFloatParameter(0.5f, 0f, 1f);

		public ClampedFloatParameter fadeOutBeforePropLerp = new ClampedFloatParameter(0.5f, 0f, 1f);

		public override bool IsActive()
		{
			return isActive = Math.Abs(fadeOutBeforeProp.value + -0.5f) > 0.01f || Math.Abs(fadeOutBeforePropLerp.value + -0.5f) > 0.01f;
		}
	}
}
