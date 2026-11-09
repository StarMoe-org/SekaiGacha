// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/LightOverlayClip.cs。
using System;
using Sekai.Timeline.Common;
using UnityEngine;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	[Serializable]
	public class LightOverlayClip : PostEffectClipBase, IPostEffectClip<LightOverlayParamType>
	{
		[SerializeField]
		private ReferenceColorBlend brightColor = new ReferenceColorBlend(new Color
		{
			r = 0.5f,
			g = 0.5f,
			b = 0.5f,
			a = 1f
		});

		[SerializeField]
		private ReferenceColorBlend darkColor = new ReferenceColorBlend(new Color
		{
			r = 0.5f,
			g = 0.5f,
			b = 0.5f,
			a = 1f
		});

		[SerializeField]
		private ReferenceVector2Blend brightPosition = new ReferenceVector2Blend(Vector2.zero);

		[SerializeField]
		private ReferenceVector2Blend darkPosition = new ReferenceVector2Blend(Vector2.zero);

		public ReferenceColorBlend BrightColor => brightColor;

		public ReferenceColorBlend DarkColor => darkColor;

		public ReferenceVector2Blend BrightPosition => brightPosition;

		public ReferenceVector2Blend DarkPosition => darkPosition;

		public LightOverlayParamType ParamType { get; private set; }

		public override ClipCaps clipCaps => ClipCaps.None;

		public void SetParamType(LightOverlayParamType paramType)
		{
			ParamType = paramType;
		}
	}
}
