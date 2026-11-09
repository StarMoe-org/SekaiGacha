// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Core.Live/IPostEffectClip.cs。
using System;

namespace Sekai.Core.Live
{
	public interface IPostEffectClip<in TParamType> where TParamType : Enum
	{
		void SetParamType(TParamType paramType);
	}
}
