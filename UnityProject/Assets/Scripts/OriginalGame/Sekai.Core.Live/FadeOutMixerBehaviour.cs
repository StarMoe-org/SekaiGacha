// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/FadeOutMixerBehaviour.cs。
using System;
using System.Linq;
using Sekai.Timeline.Common;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	public class FadeOutMixerBehaviour : PostEffectMixerBehaviourBase<IPostEffectTrack<FadeOutParamType>, FadeOutParamType>
	{
		private FadeOutClip[] m_Clips;

		protected override void OnSetupClip(TimelineClip[] clips)
		{
			if (clips != null)
			{
				m_Clips = clips.Select((TimelineClip c) => c.asset).OfType<FadeOutClip>().ToArray();
				ReferenceFloatBlend[] blends = m_Clips.Select((FadeOutClip c) => c.FadeOut).ToArray();
				ReferenceFloatBlend[] blends2 = m_Clips.Select((FadeOutClip c) => c.FadeOutLerp).ToArray();
				ReferenceFloatBlend[] blends3 = m_Clips.Select((FadeOutClip c) => c.FadeOutBeforeProp).ToArray();
				ReferenceFloatBlend[] blends4 = m_Clips.Select((FadeOutClip c) => c.FadeOutBeforePropLerp).ToArray();
				bool flag = BlendBase<float>.Setup(blends, clips);
				bool flag2 = BlendBase<float>.Setup(blends2, clips);
				bool flag3 = BlendBase<float>.Setup(blends3, clips);
				BlendBase<float>.Setup(blends4, clips);
			}
		}

		protected override void DisablePostEffect(IPostEffect target, FadeOutParamType paramType)
		{
			if ((uint)paramType <= 3u)
			{
				switch (paramType)
				{
				case FadeOutParamType.FadeOutBeforePropLerp:
					target.SetFadeOutBeforePropLerp(0.5f);
					break;
				case FadeOutParamType.FadeOutBeforeProp:
					target.SetFadeOutBeforeProp(0.5f);
					break;
				case FadeOutParamType.FadeOutLerp:
					target.SetFadeOutLerp(0.5f);
					break;
				default:
					target.SetFadeOut(0.5f);
					break;
				}
			}
		}

		protected override void ProcessPostEffect(int currentClipIndex, double timelineTimeStamp, IPostEffect target, FadeOutParamType paramType)
		{
			FadeOutClip[] clips = m_Clips;
			if ((uint)currentClipIndex >= (uint)clips.Length)
			{
				throw new IndexOutOfRangeException();
			}
			if ((uint)paramType <= 3u)
			{
				FadeOutClip fadeOutClip = clips[currentClipIndex];
				switch (paramType)
				{
				case FadeOutParamType.FadeOutBeforePropLerp:
					target.SetFadeOutBeforePropLerp(fadeOutClip.FadeOutBeforePropLerp.CalcBlend(timelineTimeStamp));
					break;
				case FadeOutParamType.FadeOutBeforeProp:
					target.SetFadeOutBeforeProp(fadeOutClip.FadeOutBeforeProp.CalcBlend(timelineTimeStamp));
					break;
				case FadeOutParamType.FadeOutLerp:
					target.SetFadeOutLerp(fadeOutClip.FadeOutLerp.CalcBlend(timelineTimeStamp));
					break;
				default:
					target.SetFadeOut(fadeOutClip.FadeOut.CalcBlend(timelineTimeStamp));
					break;
				}
			}
		}
	}
}
