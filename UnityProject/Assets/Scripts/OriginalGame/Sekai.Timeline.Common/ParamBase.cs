// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/ParamBase.cs。
using System;
using UnityEngine;

namespace Sekai.Timeline.Common
{
	[Serializable]
	public class ParamBase<T>
	{
		[SerializeField]
		protected T param;

		public T Param => param;

		public ParamBase(T d = default(T))
		{
			param = d;
		}
	}
}
