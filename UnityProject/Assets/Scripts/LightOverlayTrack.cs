// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/LightOverlayTrack.cs。
using System;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	[Serializable]
	[TrackColor(1f, 1f, 1f)]
	[TrackClipType(typeof(LightOverlayClip))]
	[TrackBindingType(typeof(IPostEffect))]
	public class LightOverlayTrack : PostEffectTrackBase<LightOverlayMixerBehaviour, LightOverlayClip, LightOverlayParamType>
	{
	}
}
