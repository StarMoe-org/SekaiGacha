// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/SekaiDofTrack.cs。
using System;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	[Serializable]
	[TrackColor(1f, 1f, 1f)]
	[TrackClipType(typeof(SekaiDofClip))]
	[TrackBindingType(typeof(IPostEffect))]
	public class SekaiDofTrack : PostEffectTrackBase<SekaiDofMixerBehaviour, SekaiDofClip, SekaiDofParamType>
	{
	}
}
