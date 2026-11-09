// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/SekaiDof.cs，适配独立 URP 工程。
using System;
using UnityEngine;
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components
{
	[Serializable]
	[VolumeComponentMenu("Sekai/SekaiDof")]
	public sealed class SekaiDof : SekaiVolumeComponent
	{
		[Tooltip("ピントが合うまでの距離(m)")]
		public MinFloatParameter focusDistance = new MinFloatParameter(2f, 0.1f);

		[Tooltip("レンズ口径（mm）")]
		public ClampedFloatParameter aperture = new ClampedFloatParameter(6.5f, 0f, 32f);

		[Tooltip("焦点距離(mm)")]
		public ClampedFloatParameter focalLength = new ClampedFloatParameter(150f, 0f, 330f);

		[Tooltip("前景ボケを無効化")]
		public BoolParameter disableForeBokeh = new BoolParameter(value: true);

		public override bool IsActive()
		{
			float value = focalLength.value;
			float epsilon = Mathf.Epsilon;
			isActive = value > epsilon;
			return value > epsilon;
		}

		public void Disable()
		{
			focalLength.value = 0f;
		}
	}
}
