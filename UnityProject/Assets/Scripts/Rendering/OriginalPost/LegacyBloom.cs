// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/LegacyBloom.cs，适配独立 URP 工程。
using System;
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components
{
	[Serializable]
	[VolumeComponentMenu("Sekai/Bloom")]
	public class LegacyBloom : SekaiVolumeComponent
	{
		public ClampedFloatParameter intensity = new ClampedFloatParameter(0f, 0f, 1f);

		public ClampedFloatParameter scatter = new ClampedFloatParameter(2f, 0f, 3f);

		public BoolParameter useNewBlend = new BoolParameter(value: false);

		public override bool IsActive()
		{
			float value = intensity.value;
			isActive = value > 0f;
			return value > 0f;
		}
	}
}
