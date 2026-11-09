// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/SaturationBlur.cs，适配独立 URP 工程。
using System;
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components
{
	[Serializable]
	[VolumeComponentMenu("Sekai/SaturationBlur")]
	public class SaturationBlur : SekaiVolumeComponent
	{
		public SaturationBlurTypeParameter saturationBlurType = new SaturationBlurTypeParameter(SaturationBlurVolumeType.V1);

		public ClampedFloatParameter saturation = new ClampedFloatParameter(1f, 0f, 2f);

		public ClampedFloatParameter alpha = new ClampedFloatParameter(0f, 0f, 1f);

		public float SaturationValue => saturation.value;

		public override bool IsActive()
		{
			float value = alpha.value;
			isActive = value > 0f;
			return value > 0f;
		}
	}
}
