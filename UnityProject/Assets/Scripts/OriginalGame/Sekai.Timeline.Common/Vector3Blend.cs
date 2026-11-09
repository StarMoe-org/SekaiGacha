// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Timeline.Common/Vector3Blend.cs。
using System;
using UnityEngine;

namespace Sekai.Timeline.Common
{
	[Serializable]
	public class Vector3Blend : BlendBase<Vector3>
	{
		public Vector3Blend(Vector3 d = default(Vector3))
			: base(d)
		{
		}

		protected override Vector3 CalcLerp(Vector3 begin, Vector3 end, float t)
		{
			Vector3 result = default;
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
			float z = begin.z;
			float num11 = end.z - begin.z;
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
			result.z = z + num11 * num15;
			return result;
		}
	}
}
