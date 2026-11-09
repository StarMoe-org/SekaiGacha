// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/LegacyBloomClip.cs。
using System;
using Sekai.Timeline.Common;
using UnityEngine;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	[Serializable]
	public class LegacyBloomClip : PostEffectClipBase, IPostEffectClip<LegacyBloomParamType>
	{
		[SerializeField]
		private ReferenceBoolParam newBloomBlend = new ReferenceBoolParam();

		[SerializeField]
		[Range(0f, 1f)]
		private ReferenceFloatBlend intensity = new ReferenceFloatBlend(0.05f);

		[Range(0f, 3f)]
		[SerializeField]
		private ReferenceFloatBlend scatter = new ReferenceFloatBlend(2f);

		public ReferenceBoolParam NewBloomBlend => newBloomBlend;

		public ReferenceFloatBlend Intensity => intensity;

		public ReferenceFloatBlend Scatter => scatter;

		public LegacyBloomParamType ParamType { get; private set; }

		public override ClipCaps clipCaps => ClipCaps.None;

		public void SetParamType(LegacyBloomParamType paramType)
		{
			ParamType = paramType;
		}
	}
}
