// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/LutClip.cs。
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	public class LutClip : PlayableAsset, ITimelineClipAsset
	{
		public LutBehaviour template = new LutBehaviour();

		public LutBehaviour Behaviour { get; private set; }

		public ClipCaps clipCaps => ClipCaps.Blending;

		public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
		{
			ScriptPlayable<LutBehaviour> scriptPlayable = ScriptPlayable<LutBehaviour>.Create(graph, template);
			Behaviour = scriptPlayable.GetBehaviour();
			return scriptPlayable;
		}
	}
}
