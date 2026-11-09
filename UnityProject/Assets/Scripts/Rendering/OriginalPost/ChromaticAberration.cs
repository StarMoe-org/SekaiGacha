// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/sekai_rendering.Runtime.Components/ChromaticAberration.cs，适配独立 URP 工程。
using System;
using Sekai.Rendering.Components;
using UnityEngine;
using UnityEngine.Rendering;

namespace sekai_rendering.Runtime.Components
{
	[Serializable]
	[VolumeComponentMenu("Sekai/ChromaticAberration")]
	public class ChromaticAberration : SekaiVolumeComponent
	{
		[Serializable]
		public enum ChromaticAberrationType
		{
			FullScreen,
			Lateral
		}

		public IntParameter ChromaticAberrationMode = new IntParameter(0);

		public Vector2Parameter OffsetR = new Vector2Parameter(Vector2.zero);

		public Vector2Parameter OffsetG = new Vector2Parameter(Vector2.zero);

		public Vector2Parameter OffsetB = new Vector2Parameter(Vector2.zero);

		public FloatParameter ScaleR = new FloatParameter(0f);

		public FloatParameter ScaleG = new FloatParameter(0f);

		public FloatParameter ScaleB = new FloatParameter(0f);

		public new bool IsActive()
		{
			Vector2 value = OffsetR.value;
			float x = Vector2.zero.x;
			float y = Vector2.zero.y;
			sbyte b;
			if ((value.x - x) * (value.x - x) + (value.y - y) * (value.y - y) < 9.9999994E-11f)
			{
				Vector2 value2 = OffsetG.value;
				float x2 = Vector2.zero.x;
				float y2 = Vector2.zero.y;
				if (!((value2.x - x2) * (value2.x - x2) + (value2.y - y2) * (value2.y - y2) < 9.9999994E-11f))
				{
					b = 1;
				}
				else
				{
					Vector2 value3 = OffsetB.value;
					float x3 = Vector2.zero.x;
					float y3 = Vector2.zero.y;
					b = (sbyte)(byte)(((!((value3.x - x3) * (value3.x - x3) + (value3.y - y3) * (value3.y - y3) < 9.9999994E-11f)) ? 1 : 0) & 1);
				}
			}
			else
			{
				b = 1;
			}
			float value4 = ScaleR.value;
			float epsilon = Mathf.Epsilon;
			float num = Math.Abs(0f - value4);
			float num2 = Math.Abs(value4);
			float num3 = 0f;
			float num4 = num2;
			uint num5 = (uint)BitConverter.SingleToInt32Bits(num4);
			uint num6 = (uint)BitConverter.SingleToInt32Bits(num3);
			float num12;
			if (((num4 == num3) ? BitConverter.Int32BitsToSingle((int)(num5 & num6)) : (((num5 & 0x7FFFFFFF) > 2139095040 && (num5 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num5 | 0x400000)) : (((num6 & 0x7FFFFFFF) > 2139095040 && (num6 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num6 | 0x400000)) : (((num5 & 0x7FFFFFFF) > 2139095040) ? (((num6 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num5 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num6)) : (((num6 & 0x7FFFFFFF) > 2139095040) ? (((num5 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num6 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num5)) : ((!(num4 > num3)) ? num3 : num4)))))) * 1E-06f > epsilon * 8f)
			{
				float num7 = Math.Abs(value4);
				float num8 = 0f;
				float num9 = num7;
				uint num10 = (uint)BitConverter.SingleToInt32Bits(num9);
				uint num11 = (uint)BitConverter.SingleToInt32Bits(num8);
				num12 = ((num9 == num8) ? BitConverter.Int32BitsToSingle((int)(num10 & num11)) : (((num10 & 0x7FFFFFFF) > 2139095040 && (num10 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num10 | 0x400000)) : (((num11 & 0x7FFFFFFF) > 2139095040 && (num11 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num11 | 0x400000)) : (((num10 & 0x7FFFFFFF) > 2139095040) ? (((num11 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num10 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num11)) : (((num11 & 0x7FFFFFFF) > 2139095040) ? (((num10 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num11 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num10)) : ((!(num9 > num8)) ? num8 : num9)))))) * 1E-06f;
			}
			else
			{
				num12 = epsilon * 8f;
			}
			sbyte b2;
			if (num < num12)
			{
				float value5 = ScaleG.value;
				float epsilon2 = Mathf.Epsilon;
				float num13 = Math.Abs(0f - value5);
				float num14 = Math.Abs(value5);
				float num15 = 0f;
				float num16 = num14;
				uint num17 = (uint)BitConverter.SingleToInt32Bits(num16);
				uint num18 = (uint)BitConverter.SingleToInt32Bits(num15);
				float num24;
				if (((num16 == num15) ? BitConverter.Int32BitsToSingle((int)(num17 & num18)) : (((num17 & 0x7FFFFFFF) > 2139095040 && (num17 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num17 | 0x400000)) : (((num18 & 0x7FFFFFFF) > 2139095040 && (num18 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num18 | 0x400000)) : (((num17 & 0x7FFFFFFF) > 2139095040) ? (((num18 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num17 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num18)) : (((num18 & 0x7FFFFFFF) > 2139095040) ? (((num17 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num18 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num17)) : ((!(num16 > num15)) ? num15 : num16)))))) * 1E-06f > epsilon2 * 8f)
				{
					float num19 = Math.Abs(value5);
					float num20 = 0f;
					float num21 = num19;
					uint num22 = (uint)BitConverter.SingleToInt32Bits(num21);
					uint num23 = (uint)BitConverter.SingleToInt32Bits(num20);
					num24 = ((num21 == num20) ? BitConverter.Int32BitsToSingle((int)(num22 & num23)) : (((num22 & 0x7FFFFFFF) > 2139095040 && (num22 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num22 | 0x400000)) : (((num23 & 0x7FFFFFFF) > 2139095040 && (num23 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num23 | 0x400000)) : (((num22 & 0x7FFFFFFF) > 2139095040) ? (((num23 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num22 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num23)) : (((num23 & 0x7FFFFFFF) > 2139095040) ? (((num22 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num23 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num22)) : ((!(num21 > num20)) ? num20 : num21)))))) * 1E-06f;
				}
				else
				{
					num24 = epsilon2 * 8f;
				}
				if (!(num13 < num24))
				{
					b2 = 1;
				}
				else
				{
					float value6 = ScaleB.value;
					float epsilon3 = Mathf.Epsilon;
					float num25 = Math.Abs(0f - value6);
					float num26 = Math.Abs(value6);
					float num27 = 0f;
					float num28 = num26;
					uint num29 = (uint)BitConverter.SingleToInt32Bits(num28);
					uint num30 = (uint)BitConverter.SingleToInt32Bits(num27);
					float num36;
					if (((num28 == num27) ? BitConverter.Int32BitsToSingle((int)(num29 & num30)) : (((num29 & 0x7FFFFFFF) > 2139095040 && (num29 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num29 | 0x400000)) : (((num30 & 0x7FFFFFFF) > 2139095040 && (num30 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num30 | 0x400000)) : (((num29 & 0x7FFFFFFF) > 2139095040) ? (((num30 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num29 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num30)) : (((num30 & 0x7FFFFFFF) > 2139095040) ? (((num29 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num30 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num29)) : ((!(num28 > num27)) ? num27 : num28)))))) * 1E-06f > epsilon3 * 8f)
					{
						float num31 = Math.Abs(value6);
						float num32 = 0f;
						float num33 = num31;
						uint num34 = (uint)BitConverter.SingleToInt32Bits(num33);
						uint num35 = (uint)BitConverter.SingleToInt32Bits(num32);
						num36 = ((num33 == num32) ? BitConverter.Int32BitsToSingle((int)(num34 & num35)) : (((num34 & 0x7FFFFFFF) > 2139095040 && (num34 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num34 | 0x400000)) : (((num35 & 0x7FFFFFFF) > 2139095040 && (num35 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num35 | 0x400000)) : (((num34 & 0x7FFFFFFF) > 2139095040) ? (((num35 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num34 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num35)) : (((num35 & 0x7FFFFFFF) > 2139095040) ? (((num34 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num35 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num34)) : ((!(num33 > num32)) ? num32 : num33)))))) * 1E-06f;
					}
					else
					{
						num36 = epsilon3 * 8f;
					}
					b2 = (sbyte)(byte)(((!(num25 < num36)) ? 1 : 0) & 1);
				}
			}
			else
			{
				b2 = 1;
			}
			return (byte)(sbyte)((byte)b2 | (byte)b) != 0;
		}

		private void Reset()
		{
			ResetName();
		}

		private void ResetName()
		{
			displayName = "Chromatic Aberration (Sekai)";
		}
	}
}
