// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/FadeOutClip.cs。
using System;
using Sekai.Timeline.Common;
using UnityEngine;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	[Serializable]
	public class FadeOutClip : PostEffectClipBase, IPostEffectClip<FadeOutParamType>
	{
		[SerializeField]
		[Range(0f, 1f)]
		private ReferenceFloatBlend fadeOut = new ReferenceFloatBlend(0.5f);

		[SerializeField]
		[Range(0f, 1f)]
		private ReferenceFloatBlend fadeOutLerp = new ReferenceFloatBlend(0.5f);

		[SerializeField]
		[Range(0f, 1f)]
		private ReferenceFloatBlend fadeOutBeforeProp = new ReferenceFloatBlend(0.5f);

		[SerializeField]
		[Range(0f, 1f)]
		private ReferenceFloatBlend fadeOutBeforePropLerp = new ReferenceFloatBlend(0.5f);

		public ReferenceFloatBlend FadeOut => fadeOut;

		public ReferenceFloatBlend FadeOutLerp => fadeOutLerp;

		public ReferenceFloatBlend FadeOutBeforeProp => fadeOutBeforeProp;

		public ReferenceFloatBlend FadeOutBeforePropLerp => fadeOutBeforePropLerp;

		public FadeOutParamType ParamType { get; private set; }

		public override ClipCaps clipCaps => ClipCaps.None;

		public void SetParamType(FadeOutParamType paramType)
		{
			ParamType = paramType;
		}
	}
}
