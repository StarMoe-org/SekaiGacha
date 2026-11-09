// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Core.Live/PostEffectMixerBehaviourBase.cs。
using System;
using Sekai.Timeline.Common;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	public abstract class PostEffectMixerBehaviourBase<TTrack, TParamType> : PlayableBehaviour, IPostEffectMixerBehaviour<TTrack, TParamType> where TTrack : IPostEffectTrack<TParamType> where TParamType : Enum
	{
		protected PlayableDirector Director { get; private set; }

		protected TimelineClip[] TimelineClips { get; private set; }

		protected IPostEffect Target { get; private set; }

		protected TTrack Track { get; private set; }

		public void Setup(PlayableDirector director, TimelineClip[] clips, IPostEffect target, TTrack track)
		{
			Director = director;
			TimelineClips = clips;
			Target = target;
			Track = track;
			OnSetupClip(clips);
		}

		public override void OnPlayableCreate(Playable playable)
		{
			if (this == null)
			{
				throw new NullReferenceException();
			}
			base.OnPlayableCreate(playable);
		}

		public override void OnPlayableDestroy(Playable playable)
		{
			if (this == null)
			{
				throw new NullReferenceException();
			}
			base.OnPlayableDestroy(playable);
		}

		private void OnChangeTrack(TrackAsset track)
		{
		}

		private void OnDestroyClip(PlayableAsset clip)
		{
		}

		public override void PrepareFrame(Playable playable, FrameData info)
		{
			string message;
			if (Target != null)
			{
				if (Track != null)
				{
					if ((uint)playable.GetCurrentClipIndex() >> 31 << 31 != 0)
					{
						TTrack val = Track;
						DisablePostEffect(Target, val.ParamType);
					}
					return;
				}
				message = "[NullReferenceException] Track is null";
			}
			else
			{
				message = "[NullReferenceException] Target(IPostEffect) is null";
			}
			Debug.LogError(message);
		}

		public override void ProcessFrame(Playable playable, FrameData info, object playerData)
		{
			if (!(Director == null) && Target != null && Track != null)
			{
				int currentClipIndex = playable.GetCurrentClipIndex();
				if ((uint)currentClipIndex >> 31 << 31 == 0)
				{
					double time = Director.time;
					TTrack val = Track;
					ProcessPostEffect(currentClipIndex, time, Target, val.ParamType);
				}
			}
		}

		protected abstract void OnSetupClip(TimelineClip[] clips);

		protected abstract void DisablePostEffect(IPostEffect target, TParamType paramType);

		protected abstract void ProcessPostEffect(int currentClipIndex, double timelineTimeStamp, IPostEffect target, TParamType paramType);
	}
}
