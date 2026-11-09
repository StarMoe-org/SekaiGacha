// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/SaturationTrack.cs。
using System;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	[Serializable]
	[TrackBindingType(typeof(IPostEffect))]
	[TrackColor(1f, 1f, 1f)]
	[TrackClipType(typeof(SaturationClip))]
	public class SaturationTrack : PostEffectTrackBase<SaturationMixerBehaviour, SaturationClip, SaturationParamType>
	{
	}
}
