// 源自恢复工程 ThirdParty.SpringBone/UTJ/SpringPanelCollider.cs。
using System;
using UnityEngine;

namespace UTJ
{
	public class SpringPanelCollider : MonoBehaviour
	{
		public enum Axis
		{
			X,
			Y,
			Z,
			AxisCount
		}

		public float width = 0.25f;

		public float height = 0.25f;

		public Renderer linkedRenderer;

		private Matrix4x4 cachedWorldToLocalMatrix;

		private Transform cachedTransform;

		public Vector3 GetPlaneNormal()
		{
			return transform.forward;
		}

		public void PreUpdate()
		{
			cachedTransform = transform;
			cachedWorldToLocalMatrix = cachedTransform.worldToLocalMatrix;
		}

		public SpringBone.CollisionStatus CheckForCollisionAndReact(Vector3 headPosition, float length, ref Vector3 tailPosition, float tailRadius, ref Vector3 hitNormal)
		{
			SpringBone.CollisionStatus collisionStatus;
			Vector3 localTailPosition;
			if (!(linkedRenderer != null) || linkedRenderer.enabled)
			{
				localTailPosition = cachedTransform.InverseTransformPoint(tailPosition);
				Vector3 vector = cachedTransform.InverseTransformDirection(tailRadius, 0f, 0f);
				if (localTailPosition.z >= (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)))
				{
					collisionStatus = SpringBone.CollisionStatus.NoCollision;
				}
				else
				{
					Vector3 localHeadPosition = cachedTransform.InverseTransformPoint(headPosition);
					Vector3 vector2 = cachedTransform.InverseTransformDirection(length, 0f, 0f);
					float num = width;
					if (!(Math.Abs(localTailPosition.x) >= (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)) + num * 0.5f))
					{
						float num2 = height;
						if (Math.Abs(localTailPosition.y) >= (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)) + num2 * 0.5f)
						{
							return SpringBone.CollisionStatus.NoCollision;
						}
						if (localTailPosition.z <= 0f && localHeadPosition.z <= 0f)
						{
							if (Math.Abs(localHeadPosition.y) > num2 * 0.5f)
							{
								float num3 = ((!(localTailPosition.y < 0f)) ? (num2 * 0.5f) : (-(num2 * 0.5f)));
								float z = localTailPosition.z;
								float y = num3;
								collisionStatus = SpringBone.CollisionStatus.TailCollision;
								localTailPosition = new Vector3
								{
									x = localTailPosition.x,
									y = y,
									z = z
								};
							}
							else if (Math.Abs(localHeadPosition.x) > num * 0.5f)
							{
								Vector3 vector3 = new Vector3
								{
									x = ((!(localTailPosition.x < 0f)) ? (num * 0.5f) : (-(num * 0.5f))),
									y = localTailPosition.y,
									z = localTailPosition.z
								};
								float y2 = localTailPosition.y;
								float z2 = localTailPosition.z;
								collisionStatus = SpringBone.CollisionStatus.TailCollision;
								float z = z2;
								float y = y2;
								localTailPosition = vector3;
								localTailPosition = new Vector3
								{
									x = localTailPosition.x,
									y = y,
									z = z
								};
							}
							else
							{
								Vector3 vector4 = new Vector3
								{
									x = localHeadPosition.x,
									y = localTailPosition.y,
									z = localTailPosition.z
								};
								float y3 = localHeadPosition.y;
								float num4 = (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y));
								collisionStatus = SpringBone.CollisionStatus.HeadIsEmbedded;
								float z = num4;
								float y = y3;
								localTailPosition = vector4;
								localTailPosition = new Vector3
								{
									x = localTailPosition.x,
									y = y,
									z = z
								};
							}
						}
						else
						{
							float num12;
							float y;
							float x;
							if (Math.Abs(localTailPosition.y) > num2 * 0.5f)
							{
								float num7;
								float num8;
								float num9;
								if ((float)Math.Sqrt(localTailPosition.z * localTailPosition.z + ((localTailPosition.y - ((!(localTailPosition.y < 0f)) ? (num2 * 0.5f) : (-(num2 * 0.5f)))) * (localTailPosition.y - ((!(localTailPosition.y < 0f)) ? (num2 * 0.5f) : (-(num2 * 0.5f)))) + 0f)) > 1E-05f)
								{
									float num5 = 0f / (float)Math.Sqrt(localTailPosition.z * localTailPosition.z + ((localTailPosition.y - ((!(localTailPosition.y < 0f)) ? (num2 * 0.5f) : (-(num2 * 0.5f)))) * (localTailPosition.y - ((!(localTailPosition.y < 0f)) ? (num2 * 0.5f) : (-(num2 * 0.5f)))) + 0f));
									float num6 = (localTailPosition.y - ((!(localTailPosition.y < 0f)) ? (num2 * 0.5f) : (-(num2 * 0.5f)))) / (float)Math.Sqrt(localTailPosition.z * localTailPosition.z + ((localTailPosition.y - ((!(localTailPosition.y < 0f)) ? (num2 * 0.5f) : (-(num2 * 0.5f)))) * (localTailPosition.y - ((!(localTailPosition.y < 0f)) ? (num2 * 0.5f) : (-(num2 * 0.5f)))) + 0f));
									num7 = localTailPosition.z / (float)Math.Sqrt(localTailPosition.z * localTailPosition.z + ((localTailPosition.y - ((!(localTailPosition.y < 0f)) ? (num2 * 0.5f) : (-(num2 * 0.5f)))) * (localTailPosition.y - ((!(localTailPosition.y < 0f)) ? (num2 * 0.5f) : (-(num2 * 0.5f)))) + 0f));
									num8 = num6;
									num9 = num5;
								}
								else
								{
									num9 = Vector3.zero.x;
									num8 = Vector3.zero.y;
									num7 = Vector3.zero.z;
								}
								float num10 = localTailPosition.x + (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)) * num9;
								float num11 = ((!(localTailPosition.y < 0f)) ? (num2 * 0.5f) : (-(num2 * 0.5f))) + (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)) * num8;
								num12 = (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)) * num7;
								y = num11;
								x = num10;
							}
							else
							{
								if (!(Math.Abs(localTailPosition.x) > num * 0.5f))
								{
									collisionStatus = CheckForCollisionWithAlignedPlaneAndReact(localHeadPosition, (float)Math.Sqrt(vector2.z * vector2.z + (vector2.x * vector2.x + vector2.y * vector2.y)), ref localTailPosition, (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)), Axis.Z);
									if (collisionStatus == SpringBone.CollisionStatus.NoCollision)
									{
										return collisionStatus;
									}
									goto IL_1054;
								}
								float num15;
								float num16;
								float num17;
								if ((float)Math.Sqrt(localTailPosition.z * localTailPosition.z + ((localTailPosition.x - ((!(localTailPosition.x < 0f)) ? (num * 0.5f) : (-(num * 0.5f)))) * (localTailPosition.x - ((!(localTailPosition.x < 0f)) ? (num * 0.5f) : (-(num * 0.5f)))) + 0f)) > 1E-05f)
								{
									float num13 = (localTailPosition.x - ((!(localTailPosition.x < 0f)) ? (num * 0.5f) : (-(num * 0.5f)))) / (float)Math.Sqrt(localTailPosition.z * localTailPosition.z + ((localTailPosition.x - ((!(localTailPosition.x < 0f)) ? (num * 0.5f) : (-(num * 0.5f)))) * (localTailPosition.x - ((!(localTailPosition.x < 0f)) ? (num * 0.5f) : (-(num * 0.5f)))) + 0f));
									float num14 = 0f / (float)Math.Sqrt(localTailPosition.z * localTailPosition.z + ((localTailPosition.x - ((!(localTailPosition.x < 0f)) ? (num * 0.5f) : (-(num * 0.5f)))) * (localTailPosition.x - ((!(localTailPosition.x < 0f)) ? (num * 0.5f) : (-(num * 0.5f)))) + 0f));
									num15 = localTailPosition.z / (float)Math.Sqrt(localTailPosition.z * localTailPosition.z + ((localTailPosition.x - ((!(localTailPosition.x < 0f)) ? (num * 0.5f) : (-(num * 0.5f)))) * (localTailPosition.x - ((!(localTailPosition.x < 0f)) ? (num * 0.5f) : (-(num * 0.5f)))) + 0f));
									num16 = num14;
									num17 = num13;
								}
								else
								{
									num17 = Vector3.zero.x;
									num16 = Vector3.zero.y;
									num15 = Vector3.zero.z;
								}
								float num18 = ((!(localTailPosition.x < 0f)) ? (num * 0.5f) : (-(num * 0.5f))) + (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)) * num17;
								float num19 = localTailPosition.y + (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)) * num16;
								num12 = (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)) * num15;
								y = num19;
								x = num18;
							}
							Vector3 vector5 = new Vector3
							{
								x = x,
								y = localTailPosition.y,
								z = localTailPosition.z
							};
							float z = num12 + 0f;
							localTailPosition = vector5;
							collisionStatus = SpringBone.CollisionStatus.TailCollision;
							localTailPosition = new Vector3
							{
								x = localTailPosition.x,
								y = y,
								z = z
							};
						}
						goto IL_1054;
					}
					collisionStatus = SpringBone.CollisionStatus.NoCollision;
				}
			}
			else
			{
				collisionStatus = SpringBone.CollisionStatus.NoCollision;
			}
			return collisionStatus;
			IL_1054:
			tailPosition = cachedTransform.TransformPoint(localTailPosition);
			Vector3 forward = cachedTransform.forward;
			float z3;
			float y4;
			float x2;
			if ((float)Math.Sqrt(forward.z * forward.z + (forward.x * forward.x + forward.y * forward.y)) > 1E-05f)
			{
				float num20 = forward.x / (float)Math.Sqrt(forward.z * forward.z + (forward.x * forward.x + forward.y * forward.y));
				float num21 = forward.y / (float)Math.Sqrt(forward.z * forward.z + (forward.x * forward.x + forward.y * forward.y));
				z3 = forward.z / (float)Math.Sqrt(forward.z * forward.z + (forward.x * forward.x + forward.y * forward.y));
				y4 = num21;
				x2 = num20;
			}
			else
			{
				x2 = Vector3.zero.x;
				y4 = Vector3.zero.y;
				z3 = Vector3.zero.z;
			}
			hitNormal = new Vector3
			{
				x = x2,
				y = y4,
				z = z3
			};
			return collisionStatus;
		}

		public static SpringBone.CollisionStatus CheckForCollisionWithAlignedPlaneAndReact(Vector3 localHeadPosition, float localLength, ref Vector3 localTailPosition, float localTailRadius, Axis upAxis)
		{
			IndexOutOfRangeException ex;
			float num;
			if (upAxis != Axis.Z)
			{
				if (upAxis != Axis.Y)
				{
					if (upAxis != Axis.X)
					{
						ex = new IndexOutOfRangeException("Invalid Vector3 index!");
						throw ex;
					}
					num = localTailPosition.x;
				}
				else
				{
					num = localTailPosition.y;
				}
			}
			else
			{
				num = localTailPosition.z;
			}
			float num12;
			float num13;
			float num14;
			SpringBone.CollisionStatus result;
			if (!(num >= localTailRadius))
			{
				float num2;
				if (upAxis == Axis.X)
				{
					num2 = localHeadPosition.x;
				}
				else if (upAxis == Axis.Z)
				{
					num2 = localHeadPosition.z;
				}
				else
				{
					if (upAxis != Axis.Y)
					{
						ex = new IndexOutOfRangeException("Invalid Vector3 index!");
						throw ex;
					}
					num2 = localHeadPosition.y;
				}
				if (!(num2 + localLength <= localTailRadius))
				{
					float num3;
					if (upAxis == Axis.X)
					{
						num3 = localHeadPosition.x;
					}
					else if (upAxis == Axis.Z)
					{
						num3 = localHeadPosition.z;
					}
					else
					{
						if (upAxis != Axis.Y)
						{
							ex = new IndexOutOfRangeException("Invalid Vector3 index!");
							throw ex;
						}
						num3 = localHeadPosition.y;
					}
					long num4 = (long)((ulong)((sbyte)(byte)((byte)(upAxis & (Axis)0xFF) + (byte)1) * 1431655766L) >> 63);
					long num5 = (long)((ulong)((sbyte)(byte)((byte)(upAxis & (Axis)0xFF) + (byte)1) * 1431655766L) >> 32);
					float x = localTailPosition.x;
					float y = localTailPosition.y;
					float z = localTailPosition.z;
					float num6;
					if ((sbyte)(byte)((byte)((byte)(upAxis & (Axis)0xFF) + (byte)1) - (byte)((byte)((byte)(num5 & 0xFFL) + (byte)num4) + (byte)((byte)(((int)(num5 & 0x7FL) + (int)num4) & 0x7F) << (1 & 7)))) == 0)
					{
						num6 = x - localHeadPosition.x;
					}
					else if ((sbyte)(byte)((byte)((byte)(upAxis & (Axis)0xFF) + (byte)1) - (byte)((byte)((byte)(num5 & 0xFFL) + (byte)num4) + (byte)((byte)(((int)(num5 & 0x7FL) + (int)num4) & 0x7F) << (1 & 7)))) == 2)
					{
						num6 = z - localHeadPosition.z;
					}
					else
					{
						if ((sbyte)(byte)((byte)((byte)(upAxis & (Axis)0xFF) + (byte)1) - (byte)((byte)((byte)(num5 & 0xFFL) + (byte)num4) + (byte)((byte)(((int)(num5 & 0x7FL) + (int)num4) & 0x7F) << (1 & 7)))) != 1)
						{
							ex = new IndexOutOfRangeException("Invalid Vector3 index!");
							throw ex;
						}
						num6 = y - localHeadPosition.y;
					}
					long num7 = (long)((ulong)((sbyte)(byte)((byte)(upAxis & (Axis)0xFF) + (byte)2) * 1431655766L) >> 63);
					long num8 = (long)((ulong)((sbyte)(byte)((byte)(upAxis & (Axis)0xFF) + (byte)2) * 1431655766L) >> 32);
					float num9;
					if ((sbyte)(byte)((byte)((byte)(upAxis & (Axis)0xFF) + (byte)2) - (byte)((byte)((byte)(num8 & 0xFFL) + (byte)num7) + (byte)((byte)(((int)(num8 & 0x7FL) + (int)num7) & 0x7F) << (1 & 7)))) == 0)
					{
						num9 = x - localHeadPosition.x;
					}
					else if ((sbyte)(byte)((byte)((byte)(upAxis & (Axis)0xFF) + (byte)2) - (byte)((byte)((byte)(num8 & 0xFFL) + (byte)num7) + (byte)((byte)(((int)(num8 & 0x7FL) + (int)num7) & 0x7F) << (1 & 7)))) == 2)
					{
						num9 = z - localHeadPosition.z;
					}
					else
					{
						if ((sbyte)(byte)((byte)((byte)(upAxis & (Axis)0xFF) + (byte)2) - (byte)((byte)((byte)(num8 & 0xFFL) + (byte)num7) + (byte)((byte)(((int)(num8 & 0x7FL) + (int)num7) & 0x7F) << (1 & 7)))) != 1)
						{
							ex = new IndexOutOfRangeException("Invalid Vector3 index!");
							throw ex;
						}
						num9 = y - localHeadPosition.y;
					}
					if ((float)Math.Sqrt(num6 * num6 + num9 * num9) > 0.001f)
					{
						long num10 = (sbyte)(byte)((byte)(upAxis & (Axis)0xFF) + (byte)1) * 1431655766L;
						long num11 = (long)((ulong)num10 >> 32);
						num10 = (long)((ulong)num10 >> 63);
						if ((sbyte)(byte)((byte)((byte)(upAxis & (Axis)0xFF) + (byte)1) - (byte)((byte)((byte)(num11 & 0xFFL) + (byte)num10) + (byte)((byte)(((int)(num11 & 0x7FL) + (int)num10) & 0x7F) << (1 & 7)))) != 0)
						{
							if ((sbyte)(byte)((byte)((byte)(upAxis & (Axis)0xFF) + (byte)1) - (byte)((byte)((byte)(num11 & 0xFFL) + (byte)num10) + (byte)((byte)(((int)(num11 & 0x7FL) + (int)num10) & 0x7F) << (1 & 7)))) != 1)
							{
								if ((sbyte)(byte)((byte)((byte)(upAxis & (Axis)0xFF) + (byte)1) - (byte)((byte)((byte)(num11 & 0xFFL) + (byte)num10) + (byte)((byte)(((int)(num11 & 0x7FL) + (int)num10) & 0x7F) << (1 & 7)))) != 2)
								{
									ex = new IndexOutOfRangeException("Invalid Vector3 index!");
									throw ex;
								}
								float x2 = localHeadPosition.x;
								float y2 = localHeadPosition.y;
								num12 = localHeadPosition.z + num6 * ((float)Math.Sqrt(localLength * localLength - (num3 - localTailRadius) * (num3 - localTailRadius)) / (float)Math.Sqrt(num6 * num6 + num9 * num9));
								num13 = y2;
								num14 = x2;
							}
							else
							{
								float x3 = localHeadPosition.x;
								float num15 = localHeadPosition.y + num6 * ((float)Math.Sqrt(localLength * localLength - (num3 - localTailRadius) * (num3 - localTailRadius)) / (float)Math.Sqrt(num6 * num6 + num9 * num9));
								num12 = localHeadPosition.z;
								num13 = num15;
								num14 = x3;
							}
						}
						else
						{
							float num16 = localHeadPosition.x + num6 * ((float)Math.Sqrt(localLength * localLength - (num3 - localTailRadius) * (num3 - localTailRadius)) / (float)Math.Sqrt(num6 * num6 + num9 * num9));
							float y3 = localHeadPosition.y;
							num12 = localHeadPosition.z;
							num13 = y3;
							num14 = num16;
						}
						long num17 = (sbyte)(byte)((byte)(upAxis & (Axis)0xFF) + (byte)2) * 1431655766L;
						long num18 = (long)((ulong)num17 >> 32);
						num17 = (long)((ulong)num17 >> 63);
						if ((sbyte)(byte)((byte)((byte)(upAxis & (Axis)0xFF) + (byte)2) - (byte)((byte)((byte)(num18 & 0xFFL) + (byte)num17) + (byte)((byte)(((int)(num18 & 0x7FL) + (int)num17) & 0x7F) << (1 & 7)))) != 0)
						{
							if ((sbyte)(byte)((byte)((byte)(upAxis & (Axis)0xFF) + (byte)2) - (byte)((byte)((byte)(num18 & 0xFFL) + (byte)num17) + (byte)((byte)(((int)(num18 & 0x7FL) + (int)num17) & 0x7F) << (1 & 7)))) != 1)
							{
								if ((sbyte)(byte)((byte)((byte)(upAxis & (Axis)0xFF) + (byte)2) - (byte)((byte)((byte)(num18 & 0xFFL) + (byte)num17) + (byte)((byte)(((int)(num18 & 0x7FL) + (int)num17) & 0x7F) << (1 & 7)))) != 2)
								{
									ex = new IndexOutOfRangeException("Invalid Vector3 index!");
									throw ex;
								}
								if (upAxis != Axis.X)
								{
									num12 = num9 * ((float)Math.Sqrt(localLength * localLength - (num3 - localTailRadius) * (num3 - localTailRadius)) / (float)Math.Sqrt(num6 * num6 + num9 * num9)) + num12;
									goto IL_0eea;
								}
								num12 = num9 * ((float)Math.Sqrt(localLength * localLength - (num3 - localTailRadius) * (num3 - localTailRadius)) / (float)Math.Sqrt(num6 * num6 + num9 * num9)) + num12;
								num14 = localTailRadius;
								result = SpringBone.CollisionStatus.TailCollision;
							}
							else
							{
								if (upAxis != Axis.X)
								{
									num13 = num9 * ((float)Math.Sqrt(localLength * localLength - (num3 - localTailRadius) * (num3 - localTailRadius)) / (float)Math.Sqrt(num6 * num6 + num9 * num9)) + num13;
									goto IL_0eea;
								}
								num13 = num9 * ((float)Math.Sqrt(localLength * localLength - (num3 - localTailRadius) * (num3 - localTailRadius)) / (float)Math.Sqrt(num6 * num6 + num9 * num9)) + num13;
								num14 = localTailRadius;
								result = SpringBone.CollisionStatus.TailCollision;
							}
						}
						else
						{
							if (upAxis != Axis.X)
							{
								num14 = num9 * ((float)Math.Sqrt(localLength * localLength - (num3 - localTailRadius) * (num3 - localTailRadius)) / (float)Math.Sqrt(num6 * num6 + num9 * num9)) + num14;
								goto IL_0eea;
							}
							num14 = localTailRadius;
							result = SpringBone.CollisionStatus.TailCollision;
						}
					}
					else
					{
						float x4 = localHeadPosition.x;
						float y4 = localHeadPosition.y;
						float z2 = localHeadPosition.z;
						result = SpringBone.CollisionStatus.TailCollision;
						num12 = z2;
						num13 = y4;
						num14 = x4;
					}
				}
				else
				{
					if (upAxis != Axis.X)
					{
						if (upAxis != Axis.Y)
						{
							if (upAxis != Axis.Z)
							{
								ex = new IndexOutOfRangeException("Invalid Vector3 index!");
								throw ex;
							}
							float x5 = localHeadPosition.x;
							float y5 = localHeadPosition.y;
							num12 = localHeadPosition.z + localLength;
							num13 = y5;
							num14 = x5;
						}
						else
						{
							float x6 = localHeadPosition.x;
							float num19 = localHeadPosition.y + localLength;
							num12 = localHeadPosition.z;
							num13 = num19;
							num14 = x6;
						}
					}
					else
					{
						float num20 = localHeadPosition.x + localLength;
						float y6 = localHeadPosition.y;
						num12 = localHeadPosition.z;
						num13 = y6;
						num14 = num20;
					}
					result = SpringBone.CollisionStatus.HeadIsEmbedded;
				}
				localTailPosition = new Vector3
				{
					x = num14,
					y = num13,
					z = num12
				};
				return result;
			}
			result = SpringBone.CollisionStatus.NoCollision;
			return result;
			IL_0eea:
			if (upAxis != Axis.Z)
			{
				if (upAxis != Axis.Y)
				{
					ex = new IndexOutOfRangeException("Invalid Vector3 index!");
					throw ex;
				}
				num13 = localTailRadius;
				result = SpringBone.CollisionStatus.TailCollision;
			}
			else
			{
				num12 = localTailRadius;
				result = SpringBone.CollisionStatus.TailCollision;
			}
			localTailPosition = new Vector3
			{
				x = num14,
				y = num13,
				z = num12
			};
			return result;
		}
	}
}
