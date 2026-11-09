// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/ReferenceColorBlend.cs。
using System;
using UnityEngine;

namespace Sekai.Timeline.Common
{
	[Serializable]
	public class ReferenceColorBlend : ColorBlend, IReferenceParam<ColorBlend>
	{
		public ReferenceColorBlend(Color d = default(Color))
			: base(d)
		{
		}
	}
}
