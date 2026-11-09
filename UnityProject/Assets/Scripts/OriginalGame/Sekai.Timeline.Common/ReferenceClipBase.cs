// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/ReferenceClipBase.cs。
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Sekai.Timeline.Common
{
	public abstract class ReferenceClipBase : PlayableAsset, ITimelineClipAsset
	{
		public abstract ClipCaps clipCaps { get; }

		private void OnEnable()
		{
			OnEnableClip();
		}

		private void OnValidate()
		{
		}

		protected virtual void OnEnableClip()
		{
		}

		protected virtual void OnChangedParentClip()
		{
		}
	}
}
