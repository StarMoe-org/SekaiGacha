// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/ReferenceBoolParam.cs。
using System;

namespace Sekai.Timeline.Common
{
	[Serializable]
	public class ReferenceBoolParam : BoolParam, IReferenceParam<BoolParam>
	{
		public ReferenceBoolParam(bool d = false)
			: base(d)
		{
		}
	}
}
