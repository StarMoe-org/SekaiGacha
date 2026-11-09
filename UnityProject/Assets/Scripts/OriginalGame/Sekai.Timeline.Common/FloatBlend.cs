// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/FloatBlend.cs。
using System;

namespace Sekai.Timeline.Common
{
	[Serializable]
	public class FloatBlend : BlendBase<float>
	{
		public FloatBlend(float d = 0f)
			: base(d)
		{
		}

		protected override float CalcLerp(float begin, float end, float t)
		{
			float num = end - begin;
			float num5;
			if (!(t < 0f))
			{
				float num2 = 1f;
				uint num3 = (uint)BitConverter.SingleToInt32Bits(t);
				uint num4 = (uint)BitConverter.SingleToInt32Bits(num2);
				num5 = ((t == num2) ? BitConverter.Int32BitsToSingle((int)(num3 | num4)) : (((num3 & 0x7FFFFFFF) > 2139095040 && (num3 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : (((num4 & 0x7FFFFFFF) > 2139095040 && (num4 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num4 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : (((num4 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num4 | 0x400000)) : ((!(t < num2)) ? num2 : t))))));
			}
			else
			{
				num5 = 0f;
			}
			return num * num5 + begin;
		}
	}
}
