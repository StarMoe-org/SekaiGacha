// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Timeline.Common/TrackAssetExtensions.cs。
using System;
using System.Collections.Generic;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Sekai.Timeline.Common
{
	public static class TrackAssetExtensions
	{
		public static (int indexOnAllTracks, int indexOnTargetTracks) FindIndex(this TrackAsset trackAsset)
		{
			(int, int) tuple = default;
			tuple = (-1, -1);
			IEnumerator<PlayableBinding> enumerator;
			(int, int) tuple2;
			Exception ex2;
			int num3;
			if (!(trackAsset == null))
			{
				PlayableAsset parent = trackAsset.parent;
				if (!(parent == null))
				{
					Type type = trackAsset.GetType();
					enumerator = parent.outputs.GetEnumerator();
					try
					{
						int num = 0;
						int num2 = 0;
						for (; enumerator.MoveNext(); num++)
						{
							PlayableBinding current = enumerator.Current;
							if (current.sourceObject == null)
							{
								continue;
							}
							if (!(current.sourceObject == trackAsset))
							{
								num2 += ((current.sourceObject.GetType() == type) ? 1 : 0);
								continue;
							}
							tuple2 = default;
							tuple2 = (num, num2);
							ex2 = null;
							num3 = 8;
							goto IL_0245;
						}
					}
					catch (Exception ex)
					{
						ex2 = ex;
						tuple2 = default;
						num3 = 0;
						goto IL_0245;
					}
					tuple2 = default;
					num3 = 10;
					ex2 = null;
					goto IL_0245;
				}
				tuple2 = tuple;
			}
			else
			{
				tuple2 = tuple;
			}
			return tuple2;
			IL_0245:
			enumerator?.Dispose();
			if (ex2 == null)
			{
				switch (num3)
				{
				case 10:
					tuple2 = tuple;
					break;
				case 0:
					tuple2 = tuple;
					break;
				}
				return tuple2;
			}
			throw ex2;
		}
	}
}
