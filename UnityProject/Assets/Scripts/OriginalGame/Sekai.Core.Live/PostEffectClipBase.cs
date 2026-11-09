// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Core.Live/PostEffectClipBase.cs。
using Sekai.Timeline.Common;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	public class PostEffectClipBase : ReferenceClipBase
	{
		public override ClipCaps clipCaps => ClipCaps.None;

		public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
		{
			return ScriptPlayable<EmptyPlayableBehaviour>.Create(graph, null);
		}

		private void OnDestroy()
		{
		}
	}
}
