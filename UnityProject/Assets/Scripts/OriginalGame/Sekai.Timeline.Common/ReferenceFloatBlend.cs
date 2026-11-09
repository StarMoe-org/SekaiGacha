// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/ReferenceFloatBlend.cs。
using System;

namespace Sekai.Timeline.Common
{
	[Serializable]
	public class ReferenceFloatBlend : FloatBlend, IReferenceParam<FloatBlend>
	{
		public ReferenceFloatBlend(float d = 0f)
			: base(d)
		{
		}
	}
}
