// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/LutTrack.cs。
using System.Linq;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	[TrackColor(1f, 0f, 0f)]
	[TrackClipType(typeof(LutClip))]
	[TrackBindingType(typeof(ILutEffect))]
	public class LutTrack : TrackAsset
	{
		public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
		{
			foreach (TimelineClip clip in GetClips())
			{
				RenameClipDisplayName(clip);
			}
			ScriptPlayable<LutMixerBehaviour> scriptPlayable = ScriptPlayable<LutMixerBehaviour>.Create(graph, inputCount);
			scriptPlayable.GetBehaviour().Clips = GetClips().ToArray();
			scriptPlayable.GetBehaviour().Director = go.GetComponent<PlayableDirector>();
			return scriptPlayable;
		}

		private void RenameClipDisplayName(TimelineClip clip)
		{
			LutBehaviour behaviour = (clip.asset as LutClip).Behaviour;
			if (behaviour != null)
			{
				if ((bool)behaviour.texture3D)
				{
					clip.displayName = "LUT: " + behaviour.texture3D.name;
				}
				else
				{
					clip.displayName = "Non LUT";
				}
			}
		}
	}
}
