// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/Solarisation.cs，适配独立 URP 工程。
using System;
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components
{
	[Serializable]
	[VolumeComponentMenu("Sekai/Solarisation")]
	public class Solarisation : SekaiVolumeComponent
	{
		public ClampedFloatParameter solarisation = new ClampedFloatParameter(0f, 0f, 1f);

		public override bool IsActive()
		{
			float value = solarisation.value;
			isActive = value > 0f;
			return value > 0f;
		}
	}
}
