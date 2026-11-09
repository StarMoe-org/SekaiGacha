// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Core.Live/IPostEffectMixerBehaviour.cs。
using System;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	public interface IPostEffectMixerBehaviour<in TTrack, TParamType> where TTrack : IPostEffectTrack<TParamType> where TParamType : Enum
	{
		void Setup(PlayableDirector director, TimelineClip[] clips, IPostEffect target, TTrack track);
	}
}
