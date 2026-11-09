// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/ColorBlend.cs。
using System;
using UnityEngine;

namespace Sekai.Timeline.Common
{
	[Serializable]
	public class ColorBlend : BlendBase<Color>
	{
		public ColorBlend(Color d = default(Color))
			: base(d)
		{
		}

		protected override Color CalcLerp(Color begin, Color end, float t)
		{
			Color result = default;
			float r = begin.r;
			float num = end.r - begin.r;
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
			result.r = r + num * num5;
			float g = begin.g;
			float num6 = end.g - begin.g;
			float num10;
			if (!(t < 0f))
			{
				float num7 = 1f;
				uint num8 = (uint)BitConverter.SingleToInt32Bits(t);
				uint num9 = (uint)BitConverter.SingleToInt32Bits(num7);
				num10 = ((t == num7) ? BitConverter.Int32BitsToSingle((int)(num8 | num9)) : (((num8 & 0x7FFFFFFF) > 2139095040 && (num8 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num8 | 0x400000)) : (((num9 & 0x7FFFFFFF) > 2139095040 && (num9 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num9 | 0x400000)) : (((num8 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num8 | 0x400000)) : (((num9 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num9 | 0x400000)) : ((!(t < num7)) ? num7 : t))))));
			}
			else
			{
				num10 = 0f;
			}
			result.g = g + num6 * num10;
			float b = begin.b;
			float num11 = end.b - begin.b;
			float num15;
			if (!(t < 0f))
			{
				float num12 = 1f;
				uint num13 = (uint)BitConverter.SingleToInt32Bits(t);
				uint num14 = (uint)BitConverter.SingleToInt32Bits(num12);
				num15 = ((t == num12) ? BitConverter.Int32BitsToSingle((int)(num13 | num14)) : (((num13 & 0x7FFFFFFF) > 2139095040 && (num13 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num13 | 0x400000)) : (((num14 & 0x7FFFFFFF) > 2139095040 && (num14 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num14 | 0x400000)) : (((num13 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num13 | 0x400000)) : (((num14 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num14 | 0x400000)) : ((!(t < num12)) ? num12 : t))))));
			}
			else
			{
				num15 = 0f;
			}
			result.b = b + num11 * num15;
			float a = begin.a;
			float num16 = end.a - begin.a;
			float num20;
			if (!(t < 0f))
			{
				float num17 = 1f;
				uint num18 = (uint)BitConverter.SingleToInt32Bits(t);
				uint num19 = (uint)BitConverter.SingleToInt32Bits(num17);
				num20 = ((t == num17) ? BitConverter.Int32BitsToSingle((int)(num18 | num19)) : (((num18 & 0x7FFFFFFF) > 2139095040 && (num18 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num18 | 0x400000)) : (((num19 & 0x7FFFFFFF) > 2139095040 && (num19 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num19 | 0x400000)) : (((num18 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num18 | 0x400000)) : (((num19 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num19 | 0x400000)) : ((!(t < num17)) ? num17 : t))))));
			}
			else
			{
				num20 = 0f;
			}
			result.a = a + num16 * num20;
			return result;
		}
	}
}
