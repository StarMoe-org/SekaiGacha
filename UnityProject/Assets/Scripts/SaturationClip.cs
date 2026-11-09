// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/SaturationClip.cs。
using System;
using Sekai.Timeline.Common;
using UnityEngine;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	[Serializable]
	public class SaturationClip : PostEffectClipBase, IPostEffectClip<SaturationParamType>
	{
		[SerializeField]
		[Range(-1f, 2f)]
		private ReferenceFloatBlend saturation = new ReferenceFloatBlend(1f);

		public ReferenceFloatBlend Saturation => saturation;

		public SaturationParamType ParamType { get; private set; }

		public override ClipCaps clipCaps => ClipCaps.None;

		public void SetParamType(SaturationParamType paramType)
		{
			ParamType = paramType;
		}
	}
}
