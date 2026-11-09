// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components.PostProcessV2/Vignette.cs，适配独立 URP 工程。
using System;
using UnityEngine;
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components.PostProcessV2
{
	[Serializable]
	[VolumeComponentMenu("Sekai/Vignette")]
	public sealed class Vignette : SekaiVolumeComponent
	{
		[Tooltip("Vignette color.")]
		public ColorParameter color = new ColorParameter(new Color
		{
			a = 1f
		}, hdr: false, showAlpha: false, showEyeDropper: true);

		[Tooltip("Sets the vignette center point (screen center is [0.5,0.5]).")]
		public Vector2Parameter center = new Vector2Parameter(new Vector2
		{
			x = 0.5f,
			y = 0.5f
		});

		[Tooltip("Amount of vignetting on screen.")]
		public ClampedFloatParameter intensity = new ClampedFloatParameter(0f, 0f, 1f);

		[Tooltip("Smoothness of the vignette borders.")]
		public ClampedFloatParameter smoothness = new ClampedFloatParameter(0.2f, 0.01f, 1f);

		[Tooltip("Should the vignette be perfectly round or be dependent on the current aspect ratio?")]
		public FloatParameter roundness = new ClampedFloatParameter(0f, 0f, 1f);

		public override bool IsActive()
		{
			float value = intensity.value;
			isActive = value > 0f;
			return value > 0f;
		}

		protected override void OnEnable()
		{
			base.OnEnable();
			displayName = "Vignette (Sekai)";
		}
	}
}
