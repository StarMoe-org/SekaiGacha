// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/SaturationBlurTrack.cs。
using System;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	[Serializable]
	[TrackClipType(typeof(SaturationBlurClip))]
	[TrackBindingType(typeof(IPostEffect))]
	[TrackColor(1f, 1f, 1f)]
	public class SaturationBlurTrack : PostEffectTrackBase<SaturationBlurMixerBehaviour, SaturationBlurClip, SaturationBlurParamType>
	{
	}
}
