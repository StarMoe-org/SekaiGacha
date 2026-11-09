// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/Antialiasing.cs，适配独立 URP 工程。
using System;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Sekai.Rendering.Components
{
	[Serializable]
	[VolumeComponentMenu("Sekai/Antialiasing")]
	public class Antialiasing : SekaiVolumeComponent
	{
		public AntialiasingModeParameter mode = new AntialiasingModeParameter(AntialiasingMode.None);

		public AntialiasingQualityParameter antialiasingQuality = new AntialiasingQualityParameter(AntialiasingQuality.High);

		public override bool IsActive()
		{
			AntialiasingMode value = mode.value;
			isActive = value != AntialiasingMode.None;
			return value != AntialiasingMode.None;
		}
	}
}
