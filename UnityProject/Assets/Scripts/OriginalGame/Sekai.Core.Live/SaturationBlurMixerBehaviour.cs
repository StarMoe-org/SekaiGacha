// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/SaturationBlurMixerBehaviour.cs。
using System.Linq;
using Sekai.Timeline.Common;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	public class SaturationBlurMixerBehaviour : PostEffectMixerBehaviourBase<IPostEffectTrack<SaturationBlurParamType>, SaturationBlurParamType>
	{
		private SaturationBlurClip[] m_Clips;

		protected override void OnSetupClip(TimelineClip[] clips)
		{
			if (clips != null)
			{
				m_Clips = clips.Select((TimelineClip c) => c.asset).OfType<SaturationBlurClip>().ToArray();
				ReferenceFloatBlend[] blends = m_Clips.Select((SaturationBlurClip c) => c.Sat).ToArray();
				ReferenceFloatBlend[] blends2 = m_Clips.Select((SaturationBlurClip c) => c.SatAlpha).ToArray();
				bool flag = BlendBase<float>.Setup(blends, clips);
				BlendBase<float>.Setup(blends2, clips);
			}
		}

		protected override void DisablePostEffect(IPostEffect target, SaturationBlurParamType paramType)
		{
			if (paramType == SaturationBlurParamType.SatAlpha)
			{
				target.SetSatAlpha(0f);
			}
		}

		protected override void ProcessPostEffect(int currentClipIndex, double timelineTimeStamp, IPostEffect target, SaturationBlurParamType paramType)
		{
			SaturationBlurClip saturationBlurClip = m_Clips[currentClipIndex];
			switch (paramType)
			{
			case SaturationBlurParamType.Sat:
				target.SetSat(saturationBlurClip.Sat.CalcBlend(timelineTimeStamp));
				break;
			case SaturationBlurParamType.SatAlpha:
				target.SetSatAlpha(saturationBlurClip.SatAlpha.CalcBlend(timelineTimeStamp));
				break;
			}
		}
	}
}
