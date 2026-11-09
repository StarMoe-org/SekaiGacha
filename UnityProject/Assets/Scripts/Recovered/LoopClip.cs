using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace CP.Timeline
{
	[Serializable]
	public class LoopClip : PlayableAsset, ITimelineClipAsset
	{
		public TimelineClip TimelineClip { get; set; }

		public ClipCaps clipCaps => ClipCaps.None;

		public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
		{
			ScriptPlayable<LoopBehaviour> scriptPlayable = ScriptPlayable<LoopBehaviour>.Create(graph);
			LoopBehaviour behaviour = scriptPlayable.GetBehaviour();
			behaviour.Director = owner.GetComponent<PlayableDirector>();
			LoopWaitTimeline loopWaitTimeline = owner.GetComponent<LoopWaitTimeline>();
			if ((object)loopWaitTimeline == null)
			{
				loopWaitTimeline = owner.AddComponent<LoopWaitTimeline>();
			}
			behaviour.WaitTimeline = loopWaitTimeline;
			behaviour.TimelineClip = TimelineClip;
			return scriptPlayable;
		}
	}
}
