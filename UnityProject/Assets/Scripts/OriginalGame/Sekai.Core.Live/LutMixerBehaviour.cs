// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/LutMixerBehaviour.cs。
using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	public class LutMixerBehaviour : PlayableBehaviour
	{
		private static readonly Vector2 WHOLE_LUT_POINT = new Vector2
		{
			x = 2f,
			y = 2f
		};

		private static readonly Vector2 WHOLE_NON_LUT_POINT = new Vector2
		{
			x = 3f,
			y = 3f
		};

		public TimelineClip[] Clips { get; set; }

		public PlayableDirector Director { get; set; }

		public override void ProcessFrame(Playable playable, FrameData info, object playerData)
		{
			if (!(playerData is ILutEffect lutEffect))
			{
				return;
			}
			double time = Director.time;
			TimelineClip[] array = Clips;
			int num = 0;
			long num2 = 0L;
			int num3 = 0;
			bool flag = true;
			while (num < array.Length)
			{
				TimelineClip timelineClip = array[(nint)num2];
				UnityEngine.Object asset = timelineClip.asset;
				LutClip lutClip = (((object)asset == null || ((asset is LutClip) ? 1u : 0u) == (byte)0) ? null : (asset as LutClip));
				if (!(lutClip == null))
				{
					float inputWeight = playable.GetInputWeight(num);
					if ((object)lutClip == null)
					{
						throw new NullReferenceException();
					}
					double start = timelineClip.start;
					double duration = timelineClip.duration;
					if ((float)((time - start) / duration) >= 0f && (float)((time - start) / duration) <= 1f)
					{
						LutBehaviour template = lutClip.template;
						switch (num3)
						{
						case 0:
							lutEffect.SetFrontLutTex(template.texture3D);
							lutEffect.SetBackLutTex(null);
							lutEffect.SetFrontLutBlend(inputWeight);
							lutEffect.SetBackLutBlend(0f);
							if (template.isWholeLut)
							{
								lutEffect.SetFrontLutPoint(WHOLE_LUT_POINT);
								lutEffect.SetFrontNonLutPoint(WHOLE_NON_LUT_POINT);
							}
							else
							{
								lutEffect.SetFrontLutPoint(template.lutPosition);
								lutEffect.SetFrontNonLutPoint(template.nonLutPosition);
							}
							lutEffect.SetBackLutPoint(Vector2.zero);
							lutEffect.SetBackNonLutPoint(Vector2.zero);
							break;
						case 1:
							lutEffect.SetBackLutTex(template.texture3D);
							lutEffect.SetBackLutBlend(inputWeight);
							if (template.isWholeLut)
							{
								lutEffect.SetBackLutPoint(WHOLE_LUT_POINT);
								lutEffect.SetBackNonLutPoint(WHOLE_NON_LUT_POINT);
							}
							else
							{
								lutEffect.SetBackLutPoint(template.lutPosition);
								lutEffect.SetBackNonLutPoint(template.nonLutPosition);
							}
							break;
						}
						num3++;
						flag = false;
					}
				}
				array = Clips;
				if (array == null)
				{
					throw new NullReferenceException();
				}
				num2 = (uint)(num + 1);
				num++;
			}
			if (flag)
			{
				lutEffect.SetFrontLutTex(null);
				lutEffect.SetBackLutTex(null);
				lutEffect.SetFrontLutBlend(0f);
				lutEffect.SetBackLutBlend(0f);
			}
		}
	}
}
