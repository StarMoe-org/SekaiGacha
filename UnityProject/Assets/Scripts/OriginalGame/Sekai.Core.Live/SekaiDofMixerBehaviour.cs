// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/SekaiDofMixerBehaviour.cs。
using System;
using System.Linq;
using Sekai.Timeline.Common;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	public class SekaiDofMixerBehaviour : PostEffectMixerBehaviourBase<IPostEffectTrack<SekaiDofParamType>, SekaiDofParamType>
	{
		private SekaiDofClip[] m_Clips;

		protected override void OnSetupClip(TimelineClip[] clips)
		{
			if (clips != null)
			{
				m_Clips = clips.Select((TimelineClip c) => c.asset).OfType<SekaiDofClip>().ToArray();
				ReferenceFloatBlend[] blends = m_Clips.Select((SekaiDofClip c) => c.Aperture).ToArray();
				ReferenceFloatBlend[] blends2 = m_Clips.Select((SekaiDofClip c) => c.FocalLength).ToArray();
				ReferenceBoolParam[] array = m_Clips.Select((SekaiDofClip c) => c.DisableForeBokeh).ToArray();
				bool flag = BlendBase<float>.Setup(blends, clips);
				BlendBase<float>.Setup(blends2, clips);
			}
		}

		protected override void DisablePostEffect(IPostEffect target, SekaiDofParamType paramType)
		{
			switch (paramType)
			{
			case SekaiDofParamType.Aperture:
				target.SetAperture(32f);
				break;
			case SekaiDofParamType.FocalLength:
				target.SetFocalLength(0f);
				break;
			case SekaiDofParamType.DisableForeBokeh:
				target.SetDisableForeBokeh(disableForeBokeh: false);
				break;
			}
		}

		protected override void ProcessPostEffect(int currentClipIndex, double timelineTimeStamp, IPostEffect target, SekaiDofParamType paramType)
		{
			SekaiDofClip[] clips = m_Clips;
			if ((uint)currentClipIndex >= (uint)clips.Length)
			{
				throw new IndexOutOfRangeException();
			}
			if (paramType != SekaiDofParamType.DisableForeBokeh)
			{
				SekaiDofClip sekaiDofClip = clips[currentClipIndex];
				switch (paramType)
				{
				case SekaiDofParamType.Aperture:
					target.SetAperture(sekaiDofClip.Aperture.CalcBlend(timelineTimeStamp));
					break;
				case SekaiDofParamType.FocalLength:
					target.SetFocalLength(sekaiDofClip.FocalLength.CalcBlend(timelineTimeStamp));
					break;
				}
			}
			else
			{
				target.SetDisableForeBokeh(disableForeBokeh: true);
			}
		}
	}
}
