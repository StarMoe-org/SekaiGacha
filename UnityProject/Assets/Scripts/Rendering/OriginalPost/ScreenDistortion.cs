// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/ScreenDistortion.cs，适配独立 URP 工程。
using System;
using UnityEngine;
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components
{
	[Serializable]
	[VolumeComponentMenu("Sekai/ExtraPostProcess/ScreenDistortion")]
	public class ScreenDistortion : SekaiVolumeComponent
	{
		public FloatParameter IntensityAmount = new FloatParameter(0f);

		public FloatParameter ScaleAmount = new FloatParameter(30f);

		public FloatParameter OffsetAmount = new FloatParameter(0f);

		public BoolParameter UseNoise = new BoolParameter(value: false);

		public Vector2Parameter NoiseScale = new Vector2Parameter(Vector2.one);

		public Vector2Parameter NoiseScrollSpeed = new Vector2Parameter(Vector2.zero);

		[HideInInspector]
		public FloatParameter Time = new FloatParameter(0f);

		public new bool IsActive()
		{
			return IntensityAmount.value > 0f;
		}

		private void Reset()
		{
			ResetName();
		}

		private void ResetName()
		{
			displayName = "Screen Distortion (Sekai)";
		}
	}
}
