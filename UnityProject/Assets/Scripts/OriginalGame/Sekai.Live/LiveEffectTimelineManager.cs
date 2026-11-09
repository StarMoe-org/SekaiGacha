// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Live/LiveEffectTimelineManager.cs。
using UnityEngine;

namespace Sekai.Live
{
	public class LiveEffectTimelineManager : MonoBehaviour
	{
		private bool _isCutIn;

		private int _cutInOrder;

		private bool _isNowPlayingOnRetry;

		private bool _isSwitchExecutableOnRetry;

		public bool IsNowPlaying { get; private set; }

		public bool IsSwitchExecutable { get; set; }

		public void Setup(bool isCutIn, int cutInOrder)
		{
			_isCutIn = isCutIn;
			_cutInOrder = cutInOrder;
			IsSwitchExecutable = false;
			IsNowPlaying = !isCutIn;
			_isNowPlayingOnRetry = !isCutIn;
			_isSwitchExecutableOnRetry = false;
		}

		private void SaveOnRetry(bool isNowPlaying, bool isSwitchExecutable)
		{
			_isNowPlayingOnRetry = isNowPlaying;
			_isSwitchExecutableOnRetry = isSwitchExecutable;
		}

		public void OnRetry()
		{
			bool isNowPlayingOnRetry = _isNowPlayingOnRetry;
			bool isSwitchExecutableOnRetry = _isSwitchExecutableOnRetry;
			IsNowPlaying = isNowPlayingOnRetry;
			IsSwitchExecutable = isSwitchExecutableOnRetry;
		}

		public void SetTimelineActive(bool active)
		{
			if (active)
			{
				if (IsNowPlaying)
				{
					IsNowPlaying = active;
					return;
				}
				IsSwitchExecutable = true;
			}
			IsNowPlaying = active;
		}
	}
}
