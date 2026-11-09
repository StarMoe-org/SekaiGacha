// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/BlendBase.cs。
using System;
using System.Linq;

using UnityEngine;
using UnityEngine.Timeline;

namespace Sekai.Timeline.Common
{
	[Serializable]
	public abstract class BlendBase<T>
	{
		[SerializeField]
		protected InClipBlendType blendType;

		[SerializeField]
		protected AnimationCurve blendCurve;

		[SerializeField]
		protected T beginValue;

		[SerializeField]
		protected T endValue;

		public InClipBlendType BlendType => blendType;

		public AnimationCurve BlendCurve => blendCurve;

		public T BeginValue => beginValue;

		public T EndValue => endValue;

		public double RuntimeBeginTimeStamp { get; private set; }

		public double RuntimeEndTimeStamp { get; private set; }

		protected BlendBase(T d = default(T))
		{
			endValue = d;
			beginValue = d;
		}

		public T CalcBlend(double timelineTimeStamp)
		{
            double duration = RuntimeEndTimeStamp - RuntimeBeginTimeStamp;
            if (blendType == InClipBlendType.Const || duration <= Mathf.Epsilon) return beginValue;
            float t = (float)((timelineTimeStamp - RuntimeBeginTimeStamp) / duration);
            if (blendCurve != null) t = blendCurve.Evaluate(t);
            return CalcLerp(beginValue, endValue, t);
        }

		protected abstract T CalcLerp(T begin, T end, float t);

		public static bool Setup(BlendBase<T>[] blends, TimelineClip[] timelineClips)
		{
			bool flag = SetupRuntimeTimeStamp(blends, timelineClips);
			if (!flag)
			{
				Debug.LogError("[Setup " + typeof(BlendBase<T>).Name + "] 時刻のセットアップに失敗しました");
			}
			return flag;
		}

		private static bool SetupRuntimeTimeStamp(BlendBase<T>[] blends, TimelineClip[] timelineClips)
		{
			if (blends == null)
			{
				return false;
			}
			if (timelineClips == null)
			{
				return false;
			}
			int num = blends.Length;
			if (num == timelineClips.Length)
			{
				bool flag = blends.Any((BlendBase<T> b) => b == null);
				bool flag2 = timelineClips.Any((TimelineClip c) => c == null);
				if (flag || flag2)
				{
					return false;
				}
				if (num >= 1)
				{
					int num2 = 0;
					long num3 = 0L;
					while (true)
					{
						if ((uint)num2 >= (uint)blends.Length)
						{
							throw new IndexOutOfRangeException();
						}
						TimelineClip timelineClip = timelineClips[(nint)num3];
						if (timelineClip == null)
						{
							throw new NullReferenceException();
						}
						BlendBase<T> blendBase = blends[(nint)num3];
						blendBase.RuntimeBeginTimeStamp = timelineClip.start;
						blendBase.RuntimeEndTimeStamp = timelineClip.end;
						if (num == num2 + 1)
						{
							break;
						}
						num3 = (uint)(num2 + 1);
						num2++;
					}
					return true;
				}
				return true;
			}
			return false;
		}
	}
}
