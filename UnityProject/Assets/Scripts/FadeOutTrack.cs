// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/FadeOutTrack.cs。
using System;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	[Serializable]
	[TrackBindingType(typeof(IPostEffect))]
	[TrackClipType(typeof(FadeOutClip))]
	[TrackColor(1f, 1f, 1f)]
	public class FadeOutTrack : PostEffectTrackBase<FadeOutMixerBehaviour, FadeOutClip, FadeOutParamType>
	{
	}
}
