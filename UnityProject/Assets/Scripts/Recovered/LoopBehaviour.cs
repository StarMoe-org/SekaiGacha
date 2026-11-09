using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace CP.Timeline
{
	[Serializable]
	public class LoopBehaviour : PlayableBehaviour
	{
		public struct ClipParam
		{
			public double Start;

			public double BlendInDuration;

			public double BlendOutDuration;
		}

		private Dictionary<TimelineClip, ClipParam> clipDict = new Dictionary<TimelineClip, ClipParam>();

		private List<Marker> markerList = new List<Marker>();

		public PlayableDirector Director { get; set; }

		public LoopWaitTimeline WaitTimeline { get; set; }

		public TimelineClip TimelineClip { get; set; }

		public override void OnGraphStart(Playable playable)
		{
			CreateClipDict();
		}

		public override void OnGraphStop(Playable playable)
		{
			Reset();
		}

		public override void OnBehaviourPlay(Playable playable, FrameData info)
		{
			WaitTimeline.AddTrigger(OnTrigger);
		}

		public override void OnBehaviourPause(Playable playable, FrameData info)
		{
			LoopWaitTimeline loopWaitTimeline = WaitTimeline;
			if (loopWaitTimeline.Trigger)
			{
				loopWaitTimeline.Trigger = false;
				loopWaitTimeline.RemoveTrigger(OnTrigger);
			}
			else if (playable.GetTime() >= 1.0)
			{
				PlayableDirector playableDirector = Director;
				playableDirector.time -= playable.GetDuration();
			}
		}

		private void OnTrigger()
		{
			double end = TimelineClip.end;
			double time = Director.time;
			double time2 = Director.time;
			Director.Stop();
			IEnumerable<TrackAsset> outputTracks = (Director.playableAsset as TimelineAsset).GetOutputTracks();
			foreach (KeyValuePair<TimelineClip, ClipParam> item in clipDict)
			{
				double end2 = TimelineClip.end;
				double start = item.Key.start;
				if (!(end2 <= start))
				{
					if (TimelineClip.end < item.Key.end)
					{
						double duration = item.Key.duration;
						item.Key.duration = duration - (end - time);
					}
					else
					{
						item.Key.blendOutDuration = end - time;
						item.Key.mixOutCurve = null;
					}
					continue;
				}
				item.Key.start = start - (end - time);
				TimelineClip timelineClip = TimelineClip;
				if (item.Key.start <= timelineClip.end)
				{
					item.Key.blendInDuration = end - time;
					item.Key.mixInCurve = null;
				}
			}
			foreach (Marker marker in markerList)
			{
				marker.time -= end - time;
			}
			TrackAsset trackAsset = outputTracks.FirstOrDefault((TrackAsset x) =>
			{
				if ((object)x != null)
				{
					bool flag = x is LoopTrack;
					if ((flag ? 1u : 0u) == (byte)0)
					{
						return false;
					}
					LoopTrack loopTrack = x as LoopTrack;
					return (flag ? 1u : 0u) != (byte)0;
				}
				return false;
			});
			if (trackAsset != null)
			{
				trackAsset.muted = true;
			}
			Director.Play();
			Director.time = time2;
			WaitTimeline.TriggerInvokedOffesetTime = end - time;
		}

		private void Reset()
		{
			if (!Application.isPlaying)
			{
				foreach (KeyValuePair<TimelineClip, ClipParam> item in clipDict)
				{
					item.Key.start = item.Value.Start;
					item.Key.blendInDuration = item.Value.BlendInDuration;
					item.Key.blendOutDuration = item.Value.BlendOutDuration;
				}
			}
			clipDict.Clear();
			markerList.Clear();
		}

		private void CreateClipDict()
		{
			Reset();
			IEnumerable<TrackAsset> outputTracks = ((TimelineAsset)Director.playableAsset).GetOutputTracks();
			TimelineClip[] array = outputTracks.SelectMany((TrackAsset x) => x.GetClips()).ToArray();
			IMarker[] array2 = outputTracks.SelectMany((TrackAsset x) => x.GetMarkers()).ToArray();
			if (array.Length >= 1)
			{
				long num = 0L;
				int num2 = 0;
				while (true)
				{
					TimelineClip timelineClip = array[(nint)num];
					double start = timelineClip.start;
					double blendInDuration = timelineClip.blendInDuration;
					double blendOutDuration = timelineClip.blendOutDuration;
					clipDict.Add(timelineClip, new ClipParam
					{
						Start = start,
						BlendInDuration = blendInDuration,
						BlendOutDuration = blendOutDuration
					});
					if (num2 + 1 >= array.Length)
					{
						break;
					}
					num = (uint)(num2 + 1);
					num2++;
				}
			}
			int num3 = array2.Length;
			if (num3 < 1)
			{
				return;
			}
			long num4 = 0L;
			uint num5 = (uint)num3;
			while (true)
			{
				if ((uint)num4 >= num5)
				{
					throw new IndexOutOfRangeException();
				}
				List<Marker> list = markerList;
				if (list == null)
				{
					throw new NullReferenceException();
				}
				IMarker marker = array2[(nint)num4];
				if (marker != null)
				{
					bool flag = marker is Marker;
					if ((flag ? 1u : 0u) == (byte)0)
					{
						throw new InvalidCastException();
					}
					if ((flag ? 1u : 0u) == (byte)0)
					{
						throw new InvalidCastException();
					}
				}
				list.Add((Marker)marker);
				int num6 = array2.Length;
				if (num4 + 1L >= num6)
				{
					break;
				}
				num4++;
				num5 = (uint)num6;
			}
		}
	}
}
