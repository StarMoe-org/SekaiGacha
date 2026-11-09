// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/SaturationMixerBehaviour.cs。
using System;
using System.Linq;
using Sekai.Timeline.Common;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	public class SaturationMixerBehaviour : PostEffectMixerBehaviourBase<IPostEffectTrack<SaturationParamType>, SaturationParamType>
	{
		private SaturationClip[] m_Clips;

		protected override void OnSetupClip(TimelineClip[] clips)
		{
			if (clips != null)
			{
				m_Clips = clips.Select((TimelineClip c) => c.asset).OfType<SaturationClip>().ToArray();
				BlendBase<float>.Setup(m_Clips.Select((SaturationClip c) => c.Saturation).ToArray(), clips);
			}
		}

		protected override void DisablePostEffect(IPostEffect target, SaturationParamType paramType)
		{
			if (paramType == SaturationParamType.Saturation)
			{
				target.SetSaturationModuleSaturation(1f);
			}
		}

		protected override void ProcessPostEffect(int currentClipIndex, double timelineTimeStamp, IPostEffect target, SaturationParamType paramType)
		{
			SaturationClip[] clips = m_Clips;
			if ((uint)currentClipIndex >= (uint)clips.Length)
			{
				throw new IndexOutOfRangeException();
			}
			if (paramType == SaturationParamType.Saturation)
			{
				target.SetSaturationModuleSaturation(clips[currentClipIndex].Saturation.CalcBlend(timelineTimeStamp));
			}
		}
	}
}
