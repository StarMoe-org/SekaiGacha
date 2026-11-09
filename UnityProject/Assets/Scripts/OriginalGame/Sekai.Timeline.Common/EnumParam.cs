// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/EnumParam.cs。
using System;

namespace Sekai.Timeline.Common
{
	[Serializable]
	public class EnumParam<T> : ParamBase<T> where T : Enum
	{
		public EnumParam(T d = default(T))
			: base(d)
		{
		}
	}
}
