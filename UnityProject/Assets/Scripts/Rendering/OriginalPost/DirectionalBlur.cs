// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/DirectionalBlur.cs，适配独立 URP 工程。
using System;
using UnityEngine;
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components
{
	[Serializable]
	[VolumeComponentMenu("Sekai/DirectionalBlur")]
	public class DirectionalBlur : SekaiVolumeComponent
	{
		[Serializable]
		public enum BlurType
		{
			Directional,
			Radial
		}

		[Tooltip("ブラーの種類")]
		public IntParameter blurType = new IntParameter(0);

		[Tooltip("ブラーの掛かる強さ")]
		public MinFloatParameter blurStrength = new MinFloatParameter(0f, 0f);

		[Tooltip("DirectionalBlur限定 ブラーの掛かる方向 0：上 90：右 180：下 270：左")]
		public ClampedFloatParameter blurDirection = new ClampedFloatParameter(0f, -360f, 360f);

		[Tooltip("RadialBlur限定 ブラーの中心座標")]
		public Vector2Parameter blurCenterPosition = new Vector2Parameter(Vector2.zero);

		public override bool IsActive()
		{
			float value = blurStrength.value;
			isActive = value > 0f;
			return value > 0f;
		}

		public BlurType GetBlurType()
		{
			return (BlurType)blurType.value;
		}
	}
}
