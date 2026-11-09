// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/LightOverlay.cs，适配独立 URP 工程。
using System;
using UnityEngine;
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components
{
	[Serializable]
	[VolumeComponentMenu("Sekai/LightOverlay")]
	public sealed class LightOverlay : SekaiVolumeComponent
	{
		public ColorParameter brightColor = new ColorParameter(new Color
		{
			r = 0.5f,
			g = 0.5f,
			b = 0.5f,
			a = 1f
		});

		public ColorParameter darkColor = new ColorParameter(new Color
		{
			r = 0.5f,
			g = 0.5f,
			b = 0.5f,
			a = 1f
		});

		public Vector2Parameter brightPosition = new Vector2Parameter(Vector2.zero);

		public Vector2Parameter darkPosition = new Vector2Parameter(Vector2.zero);

		public override bool IsActive()
		{
			Color value = brightColor.value;
			bool result;
			if (!((value.a + -1f) * (value.a + -1f) + ((value.b + -0.5f) * (value.b + -0.5f) + ((value.r + -0.5f) * (value.r + -0.5f) + (value.g + -0.5f) * (value.g + -0.5f))) < 9.9999994E-11f))
			{
				result = true;
			}
			else
			{
				Color value2 = darkColor.value;
				result = !((value2.a + -1f) * (value2.a + -1f) + ((value2.b + -0.5f) * (value2.b + -0.5f) + ((value2.r + -0.5f) * (value2.r + -0.5f) + (value2.g + -0.5f) * (value2.g + -0.5f))) < 9.9999994E-11f);
			}
			isActive = result;
			return result;
		}
	}
}
