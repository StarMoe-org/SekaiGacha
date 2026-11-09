// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/ReferenceEnumParam.cs。
using System;

namespace Sekai.Timeline.Common
{
	[Serializable]
	public class ReferenceEnumParam<T> : EnumParam<T>, IReferenceParam<EnumParam<T>> where T : Enum
	{
		public ReferenceEnumParam(T d = default(T))
			: base(d)
		{
		}
	}
}
