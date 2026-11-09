// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Core.Live/IPostEffectTrack.cs。
using System;

namespace Sekai.Core.Live
{
	public interface IPostEffectTrack<out TParamType> where TParamType : Enum
	{
		TParamType ParamType { get; }
	}
}
