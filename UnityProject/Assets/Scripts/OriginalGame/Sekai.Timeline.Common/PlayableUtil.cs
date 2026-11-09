// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/PlayableUtil.cs。
using System.Collections.Generic;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Sekai.Timeline.Common
{
	public static class PlayableUtil
	{
		public static int GetCurrentClipIndex(this Playable playable)
		{
			if (playable.GetInputCount() >= 1)
			{
				int num = 0;
				float num2 = 0f;
				int num3 = -1;
				float inputWeight;
				while (true)
				{
					inputWeight = playable.GetInputWeight(num);
					if (num + 1 >= playable.GetInputCount())
					{
						break;
					}
					int num4 = num + 1;
					float num5 = ((!(inputWeight > num2)) ? num2 : inputWeight);
					num3 = ((!(inputWeight > num2)) ? num3 : num);
					num2 = num5;
					num = num4;
				}
				return (!(inputWeight > num2)) ? num3 : num;
			}
			return -1;
		}

		public static int GetCurrentClipIndex(TimelineClip[] clips, double time)
		{
			int num2;
			if (clips != null)
			{
				int num = clips.Length;
				if (num < 1)
				{
					num2 = -1;
				}
				else
				{
					long num3 = 0L;
					num2 = 0;
					while (true)
					{
						TimelineClip timelineClip = clips[(nint)num3];
						if (timelineClip.start <= time)
						{
							if (timelineClip.end > time)
							{
								break;
							}
							num = clips.Length;
						}
						if (num2 + 1 < num)
						{
							num3 = (uint)(num2 + 1);
							num2++;
							continue;
						}
						num2 = -1;
						break;
					}
				}
			}
			else
			{
				num2 = -1;
			}
			return num2;
		}

		public static List<int> GetCurrentClipIndexes(TimelineClip[] clips, double time)
		{
			List<int> list;
			if (clips != null)
			{
				if (clips.Length < 1)
				{
					list = null;
				}
				else
				{
					long num = 0L;
					list = null;
					int num2 = 0;
					while (true)
					{
						TimelineClip timelineClip = clips[(nint)num];
						if (timelineClip.start <= time && timelineClip.end > time)
						{
							if (list == null)
							{
								list = new List<int>();
							}
							list.Add(num2);
						}
						if (num2 + 1 >= clips.Length)
						{
							break;
						}
						num++;
						num2++;
					}
				}
			}
			else
			{
				list = null;
			}
			return list;
		}
	}
}
