// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/LightOverlayMixerBehaviour.cs。
using System;
using System.Linq;
using Sekai.Timeline.Common;
using UnityEngine;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	public class LightOverlayMixerBehaviour : PostEffectMixerBehaviourBase<IPostEffectTrack<LightOverlayParamType>, LightOverlayParamType>
	{
		private LightOverlayClip[] m_Clips;

		protected override void OnSetupClip(TimelineClip[] clips)
		{
			if (clips != null)
			{
				m_Clips = clips.Select((TimelineClip c) => c.asset).OfType<LightOverlayClip>().ToArray();
				ReferenceColorBlend[] blends = m_Clips.Select((LightOverlayClip c) => c.BrightColor).ToArray();
				ReferenceColorBlend[] blends2 = m_Clips.Select((LightOverlayClip c) => c.DarkColor).ToArray();
				ReferenceVector2Blend[] blends3 = m_Clips.Select((LightOverlayClip c) => c.BrightPosition).ToArray();
				ReferenceVector2Blend[] blends4 = m_Clips.Select((LightOverlayClip c) => c.DarkPosition).ToArray();
				bool flag = BlendBase<Color>.Setup(blends, clips);
				bool flag2 = BlendBase<Color>.Setup(blends2, clips);
				bool flag3 = BlendBase<Vector2>.Setup(blends3, clips);
				BlendBase<Vector2>.Setup(blends4, clips);
			}
		}

		protected override void DisablePostEffect(IPostEffect target, LightOverlayParamType paramType)
		{
			switch (paramType)
			{
			case LightOverlayParamType.BrightColor:
				target.SetLightOverlayBrightColor(new Color
				{
					r = 0.5f,
					g = 0.5f,
					b = 0.5f,
					a = 1f
				});
				break;
			case LightOverlayParamType.DarkColor:
				target.SetLightOverlayDarkColor(new Color
				{
					r = 0.5f,
					g = 0.5f,
					b = 0.5f,
					a = 1f
				});
				break;
			}
		}

		protected override void ProcessPostEffect(int currentClipIndex, double timelineTimeStamp, IPostEffect target, LightOverlayParamType paramType)
		{
			LightOverlayClip[] clips = m_Clips;
			if ((uint)currentClipIndex >= (uint)clips.Length)
			{
				throw new IndexOutOfRangeException();
			}
			if ((uint)paramType <= 3u)
			{
				LightOverlayClip lightOverlayClip = clips[currentClipIndex];
				switch (paramType)
				{
				case LightOverlayParamType.DarkPosition:
					target.SetLightOverlayDarkPosition(lightOverlayClip.DarkPosition.CalcBlend(timelineTimeStamp));
					break;
				case LightOverlayParamType.BrightPosition:
					target.SetLightOverlayBrightPosition(lightOverlayClip.BrightPosition.CalcBlend(timelineTimeStamp));
					break;
				case LightOverlayParamType.DarkColor:
					target.SetLightOverlayDarkColor(lightOverlayClip.DarkColor.CalcBlend(timelineTimeStamp));
					break;
				default:
					target.SetLightOverlayBrightColor(lightOverlayClip.BrightColor.CalcBlend(timelineTimeStamp));
					break;
				}
			}
		}
	}
}
