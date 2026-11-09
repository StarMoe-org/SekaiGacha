// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/Vector2Blend.cs。
using System;
using UnityEngine;

namespace Sekai.Timeline.Common
{
	[Serializable]
	public class Vector2Blend : BlendBase<Vector2>
	{
		public Vector2Blend(Vector2 d = default(Vector2))
			: base(d)
		{
		}

		protected override Vector2 CalcLerp(Vector2 begin, Vector2 end, float t)
		{
			Vector2 result = default;
			float x = begin.x;
			float num = end.x - begin.x;
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
			result.x = x + num * num5;
			float y = begin.y;
			float num6 = end.y - begin.y;
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
			result.y = y + num6 * num10;
			return result;
		}
	}
}
