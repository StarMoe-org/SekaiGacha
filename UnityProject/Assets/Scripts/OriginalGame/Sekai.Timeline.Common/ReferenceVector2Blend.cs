// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/ReferenceVector2Blend.cs。
using System;
using UnityEngine;

namespace Sekai.Timeline.Common
{
	[Serializable]
	public class ReferenceVector2Blend : Vector2Blend, IReferenceParam<Vector2Blend>
	{
		public ReferenceVector2Blend(Vector2 d = default(Vector2))
			: base(d)
		{
		}
	}
}
