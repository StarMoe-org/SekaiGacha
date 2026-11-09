// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/LegacyBloomTrack.cs。
using System;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	[Serializable]
	[TrackColor(1f, 1f, 1f)]
	[TrackClipType(typeof(LegacyBloomClip))]
	[TrackBindingType(typeof(IPostEffect))]
	public class LegacyBloomTrack : PostEffectTrackBase<LegacyBloomMixerBehaviour, LegacyBloomClip, LegacyBloomParamType>
	{
	}
}
