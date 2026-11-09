// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/ReferenceVector3Blend.cs。
using System;
using UnityEngine;

namespace Sekai.Timeline.Common
{
	[Serializable]
	public class ReferenceVector3Blend : Vector3Blend, IReferenceParam<Vector3Blend>
	{
		public ReferenceVector3Blend(Vector3 d = default(Vector3))
			: base(d)
		{
		}
	}
}
