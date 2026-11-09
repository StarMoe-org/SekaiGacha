// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/Saturation.cs，适配独立 URP 工程。
using System;
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components
{
	[Serializable]
	[VolumeComponentMenu("Sekai/Saturation")]
	public class Saturation : SekaiVolumeComponent
	{
		public FloatParameter saturation = new ClampedFloatParameter(1f, -1f, 2f);

		public override bool IsActive()
		{
			float value = saturation.value;
			isActive = Math.Abs(value + -1f) > 0.01f;
			return Math.Abs(value + -1f) > 0.01f;
		}
	}
}
