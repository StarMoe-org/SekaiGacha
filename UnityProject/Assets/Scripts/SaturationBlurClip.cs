// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/SaturationBlurClip.cs。
using System;
using Sekai.Timeline.Common;
using UnityEngine;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	[Serializable]
	public class SaturationBlurClip : PostEffectClipBase, IPostEffectClip<SaturationBlurParamType>
	{
		[SerializeField]
		[Range(0f, 2f)]
		private ReferenceFloatBlend sat = new ReferenceFloatBlend(1f);

		[SerializeField]
		[Range(0f, 1f)]
		private ReferenceFloatBlend satAlpha = new ReferenceFloatBlend();

		public ReferenceFloatBlend Sat => sat;

		public ReferenceFloatBlend SatAlpha => satAlpha;

		public SaturationBlurParamType ParamType { get; private set; }

		public override ClipCaps clipCaps => ClipCaps.None;

		public void SetParamType(SaturationBlurParamType paramType)
		{
			ParamType = paramType;
		}
	}
}
