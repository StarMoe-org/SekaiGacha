// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/LegacyLut.cs，适配独立 URP 工程。
using System;
using UnityEngine;
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components
{
	[Serializable]
	[VolumeComponentMenu("Sekai/LUT")]
	public class LegacyLut : SekaiVolumeComponent
	{
		public TextureParameter frontTex = new TextureParameter(null);

		public TextureParameter backTex = new TextureParameter(null);

		public FloatParameter frontBlend = new FloatParameter(0f);

		public FloatParameter backBlend = new FloatParameter(0f);

		public Vector2Parameter frontPoint = new Vector2Parameter(Vector2.zero);

		public Vector2Parameter frontNonPoint = new Vector2Parameter(Vector2.zero);

		public Vector2Parameter backPoint = new Vector2Parameter(Vector2.zero);

		public Vector2Parameter backNonPoint = new Vector2Parameter(Vector2.zero);

		public override bool IsActive()
		{
			return isActive = (frontTex.value != null && frontBlend.value > 0f) || (backTex.value != null && backBlend.value > 0f);
		}
	}
}
