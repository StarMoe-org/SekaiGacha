// 源自恢复工程 Assets/Scripts/Assembly-CSharp/LiveEffectClip.cs。
using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
public class LiveEffectClip : PlayableAsset, ITimelineClipAsset
{
	public LiveEffectBehaviour template = new LiveEffectBehaviour();

	public ClipCaps clipCaps => ClipCaps.None;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<LiveEffectBehaviour> scriptPlayable = ScriptPlayable<LiveEffectBehaviour>.Create(graph, template);
		LiveEffectBehaviour behaviour = scriptPlayable.GetBehaviour();
		return scriptPlayable;
	}
}
