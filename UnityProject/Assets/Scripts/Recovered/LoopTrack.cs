using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace CP.Timeline
{
	[TrackClipType(typeof(LoopClip))]
	[TrackColor(1f, 0.2794118f, 0.7117646f)]
	public class LoopTrack : TrackAsset
	{
		public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
		{
			foreach (TimelineClip clip in GetClips())
			{
				(clip.asset as LoopClip).TimelineClip = clip;
			}
			return base.CreateTrackMixer(graph, go, inputCount);
		}
	}
}
