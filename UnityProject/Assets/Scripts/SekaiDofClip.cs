// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/SekaiDofClip.cs。
using System;
using Sekai.Timeline.Common;
using UnityEngine;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	[Serializable]
	public class SekaiDofClip : PostEffectClipBase, IPostEffectClip<SekaiDofParamType>
	{
		[SerializeField]
		[Range(0f, 32f)]
		private ReferenceFloatBlend aperture = new ReferenceFloatBlend(32f);

		[SerializeField]
		[Range(0f, 300f)]
		private ReferenceFloatBlend focalLength = new ReferenceFloatBlend();

		[SerializeField]
		private ReferenceBoolParam disableForeBokeh = new ReferenceBoolParam();

		public ReferenceFloatBlend Aperture => aperture;

		public ReferenceFloatBlend FocalLength => focalLength;

		public ReferenceBoolParam DisableForeBokeh => disableForeBokeh;

		public SekaiDofParamType ParamType { get; private set; }

		public override ClipCaps clipCaps => ClipCaps.None;

		public void SetParamType(SekaiDofParamType paramType)
		{
			ParamType = paramType;
		}
	}
}
