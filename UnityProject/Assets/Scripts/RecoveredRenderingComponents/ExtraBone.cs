using System;

using Unity.Mathematics;
using UnityEngine;

namespace Sekai.Rendering {

[ExecuteAlways]
public class ExtraBone : MonoBehaviour
{
	[SerializeField]
	public Transform referenceBone;

	[SerializeField]
	public math.RotationOrder rotationOrder;

	[Range(-1f, 1f)]
	[SerializeField]
	public float coefficient;

	[SerializeField]
	public Vector3 defaultEulerAngles;

	[SerializeField]
	public bool axisX;

	[SerializeField]
	public bool axisY;

	[SerializeField]
	public bool axisZ;

	private Quaternion defaultRotation;

	private void Start()
	{
		if (Application.isPlaying && referenceBone == null)
		{
			Debug.LogError("Reference Boneが指定されていません");
			enabled = false;
		}
		Initialize();
	}

	private void Initialize()
	{
		Vector3 vector = defaultEulerAngles;
		defaultRotation = Quaternion.Euler(vector);
	}

	private void LateUpdate()
	{
		Vector3 vector2 = referenceBone.localRotation.eulerAngles;
		float num = coefficient;
		float num2 = 0f - (((!(num > 0f)) ? 0f : 1f) - ((!(num < 0f)) ? 0f : 1f));
		float3 float5 = new Vector3
		{
			x = (axisX ? vector2.x : 0f) * num2,
			y = (axisY ? vector2.y : 0f) * num2,
			z = (axisZ ? vector2.z : 0f) * num2
		};
		Quaternion b = ConvertEulerToQuaternion(new float3(float5.x * ((float)3.141592653589793 / 180f), float5.y * ((float)3.141592653589793 / 180f), float5.z * ((float)3.141592653589793 / 180f)), rotationOrder);
		transform.localRotation = Quaternion.Lerp(defaultRotation, b, BitConverter.Int32BitsToSingle(BitConverter.SingleToInt32Bits(coefficient) & 0x7FFFFFFF));
	}

	private (float3x3, float3x3, float3x3) EulerToRotationMatrix(float3 euler)
	{
        float cx=(float)Math.Cos(euler.x),sx=(float)Math.Sin(euler.x);
        float cy=(float)Math.Cos(euler.y),sy=(float)Math.Sin(euler.y);
        float cz=(float)Math.Cos(euler.z),sz=(float)Math.Sin(euler.z);
        return (new float3x3(1,0,0,0,cx,-sx,0,sx,cx),
            new float3x3(cy,0,sy,0,1,0,-sy,0,cy),
            new float3x3(cz,-sz,0,sz,cz,0,0,0,1));
    }

	private float3 RotationMatrixToEuler(float3x3 rotationMatrix)
	{
        return new float3((float)Math.Atan2(rotationMatrix.c1.z,rotationMatrix.c2.z),
            (float)Math.Asin(-rotationMatrix.c0.z),(float)Math.Atan2(rotationMatrix.c0.y,rotationMatrix.c0.x));
    }

	public static quaternion QuaternionFromMatrix(float3x3 m)
	{
		float x = m.c0.x;
		float y = m.c0.y;
		float y2 = m.c1.y;
		float z = m.c1.z;
		float x2 = m.c2.x;
		float num = x + 1f;
		float num2 = 1f - x;
		float z2 = m.c0.z;
		float x3 = m.c1.x;
		float y3 = m.c2.y;
		float z3 = m.c2.z;
		float num3 = num - y2 - z3;
		float num4 = 0f;
		float num5 = num3;
		uint num6 = (uint)BitConverter.SingleToInt32Bits(num5);
		uint num7 = (uint)BitConverter.SingleToInt32Bits(num4);
		float num8 = (float)Math.Sqrt((num5 == num4) ? BitConverter.Int32BitsToSingle((int)(num6 & num7)) : (((num6 & 0x7FFFFFFF) > 2139095040 && (num6 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num6 | 0x400000)) : (((num7 & 0x7FFFFFFF) > 2139095040 && (num7 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num7 | 0x400000)) : (((num6 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num6 | 0x400000)) : (((num7 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num7 | 0x400000)) : ((!(num5 > num4)) ? num4 : num5))))));
		float num9 = num2 + y2 - z3;
		float num10 = 0f;
		float num11 = num9;
		uint num12 = (uint)BitConverter.SingleToInt32Bits(num11);
		uint num13 = (uint)BitConverter.SingleToInt32Bits(num10);
		float num14 = (float)Math.Sqrt((num11 == num10) ? BitConverter.Int32BitsToSingle((int)(num12 & num13)) : (((num12 & 0x7FFFFFFF) > 2139095040 && (num12 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num12 | 0x400000)) : (((num13 & 0x7FFFFFFF) > 2139095040 && (num13 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num13 | 0x400000)) : (((num12 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num12 | 0x400000)) : (((num13 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num13 | 0x400000)) : ((!(num11 > num10)) ? num10 : num11))))));
		float num15 = num2 - y2 + z3;
		float num16 = 0f;
		float num17 = num15;
		uint num18 = (uint)BitConverter.SingleToInt32Bits(num17);
		uint num19 = (uint)BitConverter.SingleToInt32Bits(num16);
		float num20 = (float)Math.Sqrt((num17 == num16) ? BitConverter.Int32BitsToSingle((int)(num18 & num19)) : (((num18 & 0x7FFFFFFF) > 2139095040 && (num18 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num18 | 0x400000)) : (((num19 & 0x7FFFFFFF) > 2139095040 && (num19 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num19 | 0x400000)) : (((num18 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num18 | 0x400000)) : (((num19 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num19 | 0x400000)) : ((!(num17 > num16)) ? num16 : num17))))));
		float num21 = num8 * 0.5f;
		float num22 = num14 * 0.5f;
		float num23 = num20 * 0.5f;
		quaternion result = new quaternion
		{
			value = 
			{
				x = ((!((y3 - z) * num21 >= 0f)) ? (0f - num8 * 0.5f) : num21),
				y = ((!(num22 * (z2 - x2) >= 0f)) ? (0f - num14 * 0.5f) : num22),
				z = ((!(num23 * (x3 - y) >= 0f)) ? (0f - num20 * 0.5f) : num23)
			}
		};
		ref float4 value = ref result.value;
		float num24 = num + y2 + z3;
		float num25 = 0f;
		float num26 = num24;
		uint num27 = (uint)BitConverter.SingleToInt32Bits(num26);
		uint num28 = (uint)BitConverter.SingleToInt32Bits(num25);
		value.w = (float)Math.Sqrt((num26 == num25) ? BitConverter.Int32BitsToSingle((int)(num27 & num28)) : (((num27 & 0x7FFFFFFF) > 2139095040 && (num27 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num27 | 0x400000)) : (((num28 & 0x7FFFFFFF) > 2139095040 && (num28 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num28 | 0x400000)) : (((num27 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num27 | 0x400000)) : (((num28 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num28 | 0x400000)) : ((!(num26 > num25)) ? num25 : num26)))))) * 0.5f;
		return result;
	}

	private float3 ConvertEulerRotationOrder(float3 euler, math.RotationOrder rotationOrder)
	{
		//IL_0ba3: Expected I4, but got F4
		//IL_0bab: Expected I4, but got F4
		(float3x3, float3x3, float3x3) tuple = EulerToRotationMatrix(euler);
		float x = tuple.Item1.c0.x;
		float y = tuple.Item1.c0.y;
		float z = tuple.Item1.c0.z;
		float x2 = tuple.Item1.c1.x;
		float y2 = tuple.Item1.c1.y;
		float z2 = tuple.Item1.c1.z;
		float x3 = tuple.Item1.c2.x;
		float y3 = tuple.Item1.c2.y;
		float z3 = tuple.Item1.c2.z;
		float x4 = tuple.Item2.c0.x;
		float y4 = tuple.Item2.c0.y;
		float z4 = tuple.Item2.c0.z;
		float x5 = tuple.Item2.c1.x;
		float y5 = tuple.Item2.c1.y;
		float z5 = tuple.Item2.c1.z;
		float x6 = tuple.Item2.c2.x;
		float y6 = tuple.Item2.c2.y;
		float z6 = tuple.Item2.c2.z;
		float x7 = tuple.Item3.c0.x;
		float y7 = tuple.Item3.c0.y;
		float z7 = tuple.Item3.c0.z;
		float x8 = tuple.Item3.c1.x;
		float y8 = tuple.Item3.c1.y;
		float z8 = tuple.Item3.c1.z;
		float x9 = tuple.Item3.c2.x;
		float y9 = tuple.Item3.c2.y;
		float z9 = tuple.Item3.c2.z;
		float num66;
		float num67;
		float y10;
		float x10;
		float y11;
		float x11;
		float z10;
		float num68;
		float num69;
		float num70;
		float z11;
		float num71;
		if ((rotationOrder & (math.RotationOrder)0xFF) != 0)
		{
			float num = x7 * x;
			float num2 = y7 * x;
			float num3 = x9 * z;
			float num4 = y9 * z;
			float num5 = x9 * z2;
			float num6 = y9 * z2;
			float num7 = x9 * z3;
			float num8 = y9 * z3;
			float num9 = x8 * y;
			float num10 = y8 * y;
			float num11 = num + num9;
			float num12 = num2 + num10;
			float num13 = x7 * x2;
			float num14 = y7 * x2;
			float num15 = x8 * y2;
			float num16 = y8 * y2;
			float num17 = num13 + num15;
			float num18 = num14 + num16;
			float num19 = y3 * x8;
			float num20 = x3 * y7;
			float num21 = x3 * x7;
			float num22 = y3 * y8;
			float num23 = num11 + num3;
			float num24 = num12 + num4;
			float num25 = z7 * x + z8 * y + z * z9;
			float num26 = num17 + num5;
			float num27 = num18 + num6;
			float num28 = z7 * x2 + z8 * y2 + z2 * z9;
			float num29 = z7 * x3 + z8 * y3 + z3 * z9;
			float num30 = num21 + num19;
			float num31 = num22 + num20;
			float num32 = num23 * x4;
			float num33 = num24 * x4;
			float num34 = num26 * y4;
			float num35 = num27 * y4;
			float num36 = num23 * x5;
			float num37 = num24 * x5;
			float num38 = num26 * y5;
			float num39 = num27 * y5;
			float num40 = num23 * x6;
			float num41 = num24 * x6;
			float num42 = num30 + num7;
			float num43 = num31 + num8;
			float num44 = num26 * y6;
			float num45 = num27 * y6;
			float num46 = num32 + num34;
			float num47 = num33 + num35;
			float num48 = num36 + num38;
			float num49 = num37 + num39;
			float num50 = x6 * num25 + y6 * num28;
			float num51 = num42 * z4;
			float num52 = num43 * z4;
			float num53 = num42 * z5;
			float num54 = num43 * z5;
			float num55 = num40 + num44;
			float num56 = num41 + num45;
			float num57 = z4 * num29 + (x4 * num25 + y4 * num28);
			float num58 = z5 * num29 + (x5 * num25 + y5 * num28);
			float num59 = num42 * z6;
			float num60 = num43 * z6;
			float num61 = num51 + num46;
			float num62 = num52 + num47;
			float num63 = num53 + num48;
			float num64 = num54 + num49;
			float num65 = z6 * num29;
			num66 = num60;
			num67 = num59;
			y10 = num62;
			x10 = num61;
			y11 = num64;
			x11 = num63;
			z10 = num57;
			num68 = num56;
			num69 = num55;
			num70 = num50;
			z11 = num58;
			num71 = num65;
		}
		else
		{
			float num72 = x * x4;
			float num73 = y * x4;
			float num74 = x2 * y4;
			float num75 = y2 * y4;
			float num76 = x * x5;
			float num77 = y * x5;
			float num78 = x * x6;
			float num79 = y * x6;
			float num80 = x2 * y5;
			float num81 = y2 * y5;
			float num82 = x3 * z4;
			float num83 = y3 * z4;
			float num84 = x2 * y6;
			float num85 = y2 * y6;
			float num86 = x3 * z5;
			float num87 = y3 * z5;
			float num88 = x3 * z6;
			float num89 = y3 * z6;
			float num90 = num72 + num74;
			float num91 = num73 + num75;
			float num92 = num76 + num80;
			float num93 = num77 + num81;
			float num94 = num78 + num84;
			float num95 = num79 + num85;
			float num96 = num90 + num82;
			float num97 = num91 + num83;
			float num98 = z * x4 + z2 * y4 + z3 * z4;
			float num99 = num92 + num86;
			float num100 = num93 + num87;
			float num101 = z * x5 + z2 * y5 + z3 * z5;
			float num102 = num94 + num88;
			float num103 = num95 + num89;
			float num104 = z * x6 + z2 * y6 + z3 * z6;
			float num105 = num96 * x7;
			float num106 = num97 * x7;
			float num107 = num99 * y7;
			float num108 = num100 * y7;
			float num109 = num96 * x8;
			float num110 = num97 * x8;
			float num111 = num99 * y8;
			float num112 = num100 * y8;
			float num113 = num102 * z7;
			float num114 = num103 * z7;
			float num115 = num102 * z8;
			float num116 = num103 * z8;
			float num117 = num96 * x9;
			float num118 = num97 * x9;
			float num119 = num99 * y9;
			float num120 = num100 * y9;
			float num121 = num102 * z9;
			float num122 = num103 * z9;
			float num123 = num105 + num107;
			float num124 = num106 + num108;
			float num125 = num109 + num111;
			float num126 = num110 + num112;
			float num127 = num117 + num119;
			float num128 = num118 + num120;
			float num129 = num98 * x9 + num101 * y9;
			float num130 = num123 + num113;
			float num131 = num124 + num114;
			float num132 = num98 * x7 + num101 * y7 + num104 * z7;
			float num133 = num125 + num115;
			float num134 = num126 + num116;
			float num135 = num98 * x8 + num101 * y8 + num104 * z8;
			float num136 = num104 * z9;
			num66 = num128;
			num67 = num127;
			y10 = num131;
			x10 = num130;
			y11 = num134;
			x11 = num133;
			z10 = num132;
			num68 = num122;
			num69 = num121;
			num70 = num136;
			z11 = num135;
			num71 = num129;
		}
		uint value = (uint)(int)num69;
		uint value2 = (uint)(int)num67;
		float3x3 rotationMatrix = default;
		rotationMatrix.c0 = new float3(x10, y10, z10);
		rotationMatrix.c1 = new float3(x11, y11, z11);
		rotationMatrix.c2 = new float3(BitConverter.Int32BitsToSingle((int)value2) + BitConverter.Int32BitsToSingle((int)value), num66 + num68, num71 + num70);
		return RotationMatrixToEuler(rotationMatrix);
	}

	private Quaternion ConvertEulerToQuaternion(float3 euler, math.RotationOrder rotationOrder)
	{
        var (x,y,z)=EulerToRotationMatrix(euler);
        float3x3 matrix;
        switch(rotationOrder) {
            case math.RotationOrder.XYZ: matrix=math.mul(math.mul(x,y),z);break;
            case math.RotationOrder.XZY: matrix=math.mul(math.mul(x,z),y);break;
            case math.RotationOrder.YXZ: matrix=math.mul(math.mul(y,x),z);break;
            case math.RotationOrder.YZX: matrix=math.mul(math.mul(y,z),x);break;
            case math.RotationOrder.ZYX: matrix=math.mul(math.mul(z,y),x);break;
            default: matrix=math.mul(math.mul(z,x),y);break;
        }
        return QuaternionFromMatrix(matrix);
    }
}

}
