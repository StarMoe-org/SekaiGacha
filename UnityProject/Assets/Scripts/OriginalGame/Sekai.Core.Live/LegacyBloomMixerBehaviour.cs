// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/LegacyBloomMixerBehaviour.cs。
using System.Linq;
using Sekai.Timeline.Common;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	public class LegacyBloomMixerBehaviour : PostEffectMixerBehaviourBase<IPostEffectTrack<LegacyBloomParamType>, LegacyBloomParamType>
	{
		private LegacyBloomClip[] m_Clips;

		protected override void OnSetupClip(TimelineClip[] clips)
		{
			if (clips != null)
			{
				m_Clips = clips.Select((TimelineClip c) => c.asset).OfType<LegacyBloomClip>().ToArray();
				ReferenceFloatBlend[] blends = m_Clips.Select((LegacyBloomClip c) => c.Intensity).ToArray();
				ReferenceFloatBlend[] blends2 = m_Clips.Select((LegacyBloomClip c) => c.Scatter).ToArray();
				bool flag = BlendBase<float>.Setup(blends, clips);
				BlendBase<float>.Setup(blends2, clips);
			}
		}

		protected override void DisablePostEffect(IPostEffect target, LegacyBloomParamType paramType)
		{
			switch (paramType)
			{
			case LegacyBloomParamType.NewBloomBlend:
				target.SetBloomUseBlend(useBlend: false);
				break;
			case LegacyBloomParamType.Intensity:
				target.SetBloomIntensity(0.5f);
				break;
			case LegacyBloomParamType.Scatter:
				target.SetBloomScatter(2f);
				break;
			}
		}

		protected override void ProcessPostEffect(int currentClipIndex, double timelineTimeStamp, IPostEffect target, LegacyBloomParamType paramType)
		{
			LegacyBloomClip legacyBloomClip = m_Clips[currentClipIndex];
			switch (paramType)
			{
			case LegacyBloomParamType.NewBloomBlend:
				target.SetBloomUseBlend(legacyBloomClip.NewBloomBlend.Param);
				break;
			case LegacyBloomParamType.Intensity:
				target.SetBloomIntensity(legacyBloomClip.Intensity.CalcBlend(timelineTimeStamp));
				break;
			case LegacyBloomParamType.Scatter:
				target.SetBloomScatter(legacyBloomClip.Scatter.CalcBlend(timelineTimeStamp));
				break;
			}
		}
	}
}
