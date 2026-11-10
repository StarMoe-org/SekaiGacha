// 源自恢复工程 ThirdParty.SpringBone/UTJ/AngleLimits.cs。
using System;
using UnityEngine;

namespace UTJ
{
	[Serializable]
	public class AngleLimits
	{
		public bool active;

		[Range(-180f, 0f)]
		public float min;

		[Range(0f, 180f)]
		public float max;

		public static Vector3 GetAngleVector(Vector3 sideVector, Vector3 forwardVector, float degrees)
		{
        float radians = degrees * Mathf.Deg2Rad;
        return sideVector * Mathf.Sin(radians) + forwardVector * Mathf.Cos(radians);
	}

		public void CopyTo(AngleLimits target)
		{
			target.active = active;
			float num = min;
			float num2 = max;
			target.min = num;
			target.max = num2;
		}

		private static float ComputeFalloff(float value, float range)
		{
			if (range > 0f)
			{
				if (!(range <= 0.0001f))
				{
					goto IL_0060;
				}
			}
			else if (!(range >= -0.0001f))
			{
				goto IL_0060;
			}
			return 0f;
			IL_0060:
			if (value / range < 0f)
			{
				return 0f;
			}
			float num = value / range;
			float num2 = 1f;
			float num3 = num;
			uint num4 = (uint)BitConverter.SingleToInt32Bits(num3);
			uint num5 = (uint)BitConverter.SingleToInt32Bits(num2);
			return (num3 == num2) ? BitConverter.Int32BitsToSingle((int)(num4 | num5)) : (((num4 & 0x7FFFFFFF) > 2139095040 && (num4 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num4 | 0x400000)) : (((num5 & 0x7FFFFFFF) > 2139095040 && (num5 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num5 | 0x400000)) : (((num4 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num4 | 0x400000)) : (((num5 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num5 | 0x400000)) : ((!(num3 < num2)) ? num2 : num3)))));
		}

		public bool ConstrainVector(Vector3 basisSide, Vector3 basisUp, Vector3 basisForward, float springStrength, float deltaTime, ref Vector3 vector)
		{
        Vector3 up = basisUp * Vector3.Dot(basisUp, vector);
        Vector3 planar = vector - up;
        float length = Mathf.Sqrt(Vector3.Dot(planar, planar));
        float dot = Mathf.Clamp(Vector3.Dot(basisSide, planar * (1f / length)), -1f, 1f);
        float angle = (float)Math.Asin(dot) * Mathf.Rad2Deg;
        float sprungAngle = angle - angle * springStrength * deltaTime * deltaTime;
        float clamped = Mathf.Clamp(sprungAngle, min, max);
        float limit = clamped < 0f ? min : max;
        float result = limit * ComputeFalloff(clamped, limit);
        float radians = result * Mathf.Deg2Rad;
        vector = up + length * (basisSide * (float)Math.Sin(radians) + basisForward * (float)Math.Cos(radians));
        return result != sprungAngle;
	}
	}
}
