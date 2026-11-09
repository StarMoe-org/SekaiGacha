// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/BoolParam.cs。
using System;

namespace Sekai.Timeline.Common
{
	[Serializable]
	public class BoolParam : ParamBase<bool>
	{
		public BoolParam(bool d = false)
			: base(d)
		{
		}
	}
}
