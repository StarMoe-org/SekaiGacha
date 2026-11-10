// 源自恢复工程 ThirdParty.SpringBone/UTJ/SpringBone.cs。
using System;
using System.Collections.Generic;
using System.Linq;
using CP;
using UnityEngine;

namespace UTJ
{
	public class SpringBone : MonoBehaviour
	{
		public enum CollisionStatus
		{
			NoCollision,
			HeadIsEmbedded,
			TailCollision
		}

		[Range(0f, 5000f)]
		public float stiffnessForce = 0.01f;

		[Range(0f, 1f)]
		public float dragForce = 0.4f;

		public Vector3 springForce;

		[Range(0f, 1f)]
		public float windInfluence;

		[Range(0f, 1500f)]
		public float SpringConstant = 0.5f;

		public Transform pivotNode;

		public float angularStiffness;

		public AngleLimits yAngleLimits;

		public AngleLimits zAngleLimits;

		public Transform[] lengthLimitTargets;

		[Range(0f, 0.5f)]
		public float radius;

		public SpringSphereCollider[] sphereColliders;

		public SpringCapsuleCollider[] capsuleColliders;

		public SpringPanelCollider[] panelColliders;

		private SpringManager manager;

		private Vector3 boneAxis;

		private float springLength;

		private Quaternion skinAnimationLocalRotation;

		private Quaternion initialLocalRotation;

		private Quaternion actualLocalRotation;

		private Vector3 currTipPos;

		private Vector3 prevTipPos;

		private float[] lengthsToLimitTargets;

		private float appliedLengthScale;

		private Transform localTransform;

		private Transform parentTransform;

		private Vector3 cachedPosition;

		private Vector3 movement;

		private Vector3 angleForward;

		private Vector3 angleBack;

		private Vector3 angleDown;

		private bool hasPivotNode;

		public Vector3 CurrentTipPosition => currTipPos;

		public void Initialize(SpringManager owner)
		{
			manager = owner;
			localTransform = base.transform;
			parentTransform = localTransform.parent;
			Vector3 position = ComputeChildPosition();
			Vector3 vector = localTransform.InverseTransformPoint(position);
			float z;
			float y;
			float x;
			if ((float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)) > 1E-05f)
			{
				float num = vector.x / (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y));
				float num2 = vector.y / (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y));
				z = vector.z / (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y));
				y = num2;
				x = num;
			}
			else
			{
				x = Vector3.zero.x;
				y = Vector3.zero.y;
				z = Vector3.zero.z;
			}
			Transform transform = localTransform;
			boneAxis = new Vector3
			{
				x = x,
				y = y,
				z = z
			};
			Quaternion localRotation = transform.localRotation;
			SpringSphereCollider[] source = sphereColliders;
			initialLocalRotation = localRotation;
			actualLocalRotation = initialLocalRotation;
			sphereColliders = source.Where((SpringSphereCollider item) => item != null).ToArray();
			capsuleColliders = capsuleColliders.Where((SpringCapsuleCollider item) => item != null).ToArray();
			panelColliders = panelColliders.Where((SpringPanelCollider item) => item != null).ToArray();
			Transform[] array = lengthLimitTargets;
			Transform[] array2;
			if (array != null)
			{
				array2 = array.Where((Transform target) => target != null).ToArray();
				if (array == null)
				{
					throw new NullReferenceException();
				}
			}
			else
			{
				array2 = new Transform[0];
			}
			lengthLimitTargets = array2;
			InitializeSpringLengthAndTipPosition();
		}

		public Vector3 ComputeChildPosition()
		{
			IList<Transform> validChildren = GetValidChildren(localTransform);
			int count = validChildren.Count;
			float z;
			float y2;
			float x2;
			switch (count)
			{
			case 0:
			{
				Vector3 position4 = localTransform.position;
				Vector3 right = localTransform.right;
				float num24 = position4.x - right.x * 0.1f;
				float num25 = position4.y - right.y * 0.1f;
				z = position4.z - right.z * 0.1f;
				y2 = num25;
				x2 = num24;
				break;
			}
			default:
			{
				Vector3 position2 = localTransform.position;
				float num13;
				float num14;
				float num15;
				float num16;
				if (count >= 1)
				{
					int num = 0;
					float num2 = 0f;
					float num3 = 0f;
					float num4 = 0f;
					float num5 = 0f;
					Vector3 position3;
					while (true)
					{
						position3 = validChildren[num].position;
						if (num + 1 == count)
						{
							break;
						}
						int num6 = num + 1;
						float num7 = num2 + position3.z;
						float num8 = num3 + position3.x;
						float num9 = num4 + position3.y;
						num5 += (float)Math.Sqrt((position3.z - position2.z) * (position3.z - position2.z) + ((position3.x - position2.x) * (position3.x - position2.x) + (position3.y - position2.y) * (position3.y - position2.y)));
						num4 = num9;
						num3 = num8;
						num2 = num7;
						num = num6;
					}
					float num10 = num2 + position3.z;
					float num11 = num3 + position3.x;
					float num12 = num4 + position3.y;
					num13 = num5 + (float)Math.Sqrt((position3.z - position2.z) * (position3.z - position2.z) + ((position3.x - position2.x) * (position3.x - position2.x) + (position3.y - position2.y) * (position3.y - position2.y)));
					num14 = num12;
					num15 = num11;
					num16 = num10;
				}
				else
				{
					num16 = 0f;
					num15 = 0f;
					num14 = 0f;
					num13 = 0f;
				}
				float num19;
				float num20;
				float num21;
				if ((float)Math.Sqrt((num16 / (float)count - position2.z) * (num16 / (float)count - position2.z) + ((num15 / (float)count - position2.x) * (num15 / (float)count - position2.x) + (num14 / (float)count - position2.y) * (num14 / (float)count - position2.y))) > 1E-05f)
				{
					float num17 = (num15 / (float)count - position2.x) / (float)Math.Sqrt((num16 / (float)count - position2.z) * (num16 / (float)count - position2.z) + ((num15 / (float)count - position2.x) * (num15 / (float)count - position2.x) + (num14 / (float)count - position2.y) * (num14 / (float)count - position2.y)));
					float num18 = (num14 / (float)count - position2.y) / (float)Math.Sqrt((num16 / (float)count - position2.z) * (num16 / (float)count - position2.z) + ((num15 / (float)count - position2.x) * (num15 / (float)count - position2.x) + (num14 / (float)count - position2.y) * (num14 / (float)count - position2.y)));
					num19 = (num16 / (float)count - position2.z) / (float)Math.Sqrt((num16 / (float)count - position2.z) * (num16 / (float)count - position2.z) + ((num15 / (float)count - position2.x) * (num15 / (float)count - position2.x) + (num14 / (float)count - position2.y) * (num14 / (float)count - position2.y)));
					num20 = num18;
					num21 = num17;
				}
				else
				{
					num21 = Vector3.zero.x;
					num20 = Vector3.zero.y;
					num19 = Vector3.zero.z;
				}
				float num22 = position2.x + num13 / (float)count * num21;
				float num23 = position2.y + num13 / (float)count * num20;
				z = position2.z + num13 / (float)count * num19;
				y2 = num23;
				x2 = num22;
				break;
			}
			case 1:
			{
				Vector3 position = validChildren[0].position;
				float x = position.x;
				float y = position.y;
				z = position.z;
				y2 = y;
				x2 = x;
				break;
			}
			}
			return new Vector3
			{
				x = x2,
				y = y2,
				z = z
			};
		}

		public void RemoveAllColliders()
		{
			sphereColliders = new SpringSphereCollider[0];
			capsuleColliders = new SpringCapsuleCollider[0];
			panelColliders = new SpringPanelCollider[0];
		}

		public void UpdateSpring(float deltaTime, Vector3 externalForce)
		{
			Vector3 position = localTransform.position;
			Quaternion localRotation = localTransform.localRotation;
			Transform transform = parentTransform;
			skinAnimationLocalRotation = localRotation;
			Quaternion rotation = transform.rotation;
			float x = initialLocalRotation.x;
			float y = initialLocalRotation.y;
			float z = initialLocalRotation.z;
			float w = initialLocalRotation.w;
			Vector3 vector = boneAxis;
			Vector3 vector2 = new Quaternion
			{
				x = rotation.y * z + (rotation.w * x + rotation.x * w) - rotation.z * y,
				y = rotation.z * x + (rotation.w * y + rotation.y * w) - rotation.x * z,
				z = rotation.x * y + (rotation.w * z + rotation.z * w) - rotation.y * x,
				w = rotation.w * w - rotation.x * x - rotation.y * y - rotation.z * z
			} * vector;
			float num = springLength;
			float x2 = currTipPos.x;
			float y2 = currTipPos.y;
			float num2 = stiffnessForce;
			Vector3 vector3 = currTipPos;
			float x3 = springForce.x;
			float y3 = springForce.y;
			float z2 = currTipPos.z;
			float z3 = springForce.z;
			float num3 = dragForce;
			float x4 = prevTipPos.x;
			float y4 = prevTipPos.y;
			float z4 = prevTipPos.z;
			currTipPos = new Vector3
			{
				x = x2 + ((x3 + (externalForce.x + (position.x + vector2.x * num - x2) * num2)) * (deltaTime * deltaTime * 0.5f) + (x2 - x4) * (1f - num3)),
				y = y2 + ((y3 + (externalForce.y + (position.y + vector2.y * num - y2) * num2)) * (deltaTime * deltaTime * 0.5f) + (y2 - y4) * (1f - num3)),
				z = z2 + (deltaTime * deltaTime * 0.5f * (z3 + (externalForce.z + num2 * (position.z + vector2.z * num - z2))) + (1f - num3) * (z2 - z4))
			};
			prevTipPos = vector3;
			float num6;
			float num7;
			float num8;
			if (!((float)Math.Sqrt((z2 + (deltaTime * deltaTime * 0.5f * (z3 + (externalForce.z + num2 * (position.z + vector2.z * num - z2))) + (1f - num3) * (z2 - z4)) - position.z) * (z2 + (deltaTime * deltaTime * 0.5f * (z3 + (externalForce.z + num2 * (position.z + vector2.z * num - z2))) + (1f - num3) * (z2 - z4)) - position.z) + ((x2 + ((x3 + (externalForce.x + (position.x + vector2.x * num - x2) * num2)) * (deltaTime * deltaTime * 0.5f) + (x2 - x4) * (1f - num3)) - position.x) * (x2 + ((x3 + (externalForce.x + (position.x + vector2.x * num - x2) * num2)) * (deltaTime * deltaTime * 0.5f) + (x2 - x4) * (1f - num3)) - position.x) + (y2 + ((y3 + (externalForce.y + (position.y + vector2.y * num - y2) * num2)) * (deltaTime * deltaTime * 0.5f) + (y2 - y4) * (1f - num3)) - position.y) * (y2 + ((y3 + (externalForce.y + (position.y + vector2.y * num - y2) * num2)) * (deltaTime * deltaTime * 0.5f) + (y2 - y4) * (1f - num3)) - position.y))) <= 0.001f))
			{
				float num4 = (x2 + ((x3 + (externalForce.x + (position.x + vector2.x * num - x2) * num2)) * (deltaTime * deltaTime * 0.5f) + (x2 - x4) * (1f - num3)) - position.x) * (1f / (float)Math.Sqrt((z2 + (deltaTime * deltaTime * 0.5f * (z3 + (externalForce.z + num2 * (position.z + vector2.z * num - z2))) + (1f - num3) * (z2 - z4)) - position.z) * (z2 + (deltaTime * deltaTime * 0.5f * (z3 + (externalForce.z + num2 * (position.z + vector2.z * num - z2))) + (1f - num3) * (z2 - z4)) - position.z) + ((x2 + ((x3 + (externalForce.x + (position.x + vector2.x * num - x2) * num2)) * (deltaTime * deltaTime * 0.5f) + (x2 - x4) * (1f - num3)) - position.x) * (x2 + ((x3 + (externalForce.x + (position.x + vector2.x * num - x2) * num2)) * (deltaTime * deltaTime * 0.5f) + (x2 - x4) * (1f - num3)) - position.x) + (y2 + ((y3 + (externalForce.y + (position.y + vector2.y * num - y2) * num2)) * (deltaTime * deltaTime * 0.5f) + (y2 - y4) * (1f - num3)) - position.y) * (y2 + ((y3 + (externalForce.y + (position.y + vector2.y * num - y2) * num2)) * (deltaTime * deltaTime * 0.5f) + (y2 - y4) * (1f - num3)) - position.y))));
				float num5 = (y2 + ((y3 + (externalForce.y + (position.y + vector2.y * num - y2) * num2)) * (deltaTime * deltaTime * 0.5f) + (y2 - y4) * (1f - num3)) - position.y) * (1f / (float)Math.Sqrt((z2 + (deltaTime * deltaTime * 0.5f * (z3 + (externalForce.z + num2 * (position.z + vector2.z * num - z2))) + (1f - num3) * (z2 - z4)) - position.z) * (z2 + (deltaTime * deltaTime * 0.5f * (z3 + (externalForce.z + num2 * (position.z + vector2.z * num - z2))) + (1f - num3) * (z2 - z4)) - position.z) + ((x2 + ((x3 + (externalForce.x + (position.x + vector2.x * num - x2) * num2)) * (deltaTime * deltaTime * 0.5f) + (x2 - x4) * (1f - num3)) - position.x) * (x2 + ((x3 + (externalForce.x + (position.x + vector2.x * num - x2) * num2)) * (deltaTime * deltaTime * 0.5f) + (x2 - x4) * (1f - num3)) - position.x) + (y2 + ((y3 + (externalForce.y + (position.y + vector2.y * num - y2) * num2)) * (deltaTime * deltaTime * 0.5f) + (y2 - y4) * (1f - num3)) - position.y) * (y2 + ((y3 + (externalForce.y + (position.y + vector2.y * num - y2) * num2)) * (deltaTime * deltaTime * 0.5f) + (y2 - y4) * (1f - num3)) - position.y))));
				num6 = (z2 + (deltaTime * deltaTime * 0.5f * (z3 + (externalForce.z + num2 * (position.z + vector2.z * num - z2))) + (1f - num3) * (z2 - z4)) - position.z) * (1f / (float)Math.Sqrt((z2 + (deltaTime * deltaTime * 0.5f * (z3 + (externalForce.z + num2 * (position.z + vector2.z * num - z2))) + (1f - num3) * (z2 - z4)) - position.z) * (z2 + (deltaTime * deltaTime * 0.5f * (z3 + (externalForce.z + num2 * (position.z + vector2.z * num - z2))) + (1f - num3) * (z2 - z4)) - position.z) + ((x2 + ((x3 + (externalForce.x + (position.x + vector2.x * num - x2) * num2)) * (deltaTime * deltaTime * 0.5f) + (x2 - x4) * (1f - num3)) - position.x) * (x2 + ((x3 + (externalForce.x + (position.x + vector2.x * num - x2) * num2)) * (deltaTime * deltaTime * 0.5f) + (x2 - x4) * (1f - num3)) - position.x) + (y2 + ((y3 + (externalForce.y + (position.y + vector2.y * num - y2) * num2)) * (deltaTime * deltaTime * 0.5f) + (y2 - y4) * (1f - num3)) - position.y) * (y2 + ((y3 + (externalForce.y + (position.y + vector2.y * num - y2) * num2)) * (deltaTime * deltaTime * 0.5f) + (y2 - y4) * (1f - num3)) - position.y))));
				num7 = num5;
				num8 = num4;
			}
			else
			{
				Vector3 vector4 = localTransform.TransformDirection(boneAxis);
				float x5 = vector4.x;
				float y5 = vector4.y;
				num6 = vector4.z;
				num7 = y5;
				num8 = x5;
			}
			float num9 = springLength;
			currTipPos = new Vector3
			{
				x = position.x + num8 * num9,
				y = position.y + num7 * num9,
				z = position.z + num6 * num9
			};
		}

		public void SatisfyConstraintsAndComputeRotation(float deltaTime, float dynamicRatio)
		{
			Vector3 position = localTransform.position;
			SpringManager springManager = manager;
			cachedPosition = position;
			if (springManager.enableLengthLimits)
			{
				Vector3 vector = ApplyLengthLimits(deltaTime);
				springManager = manager;
				currTipPos = vector;
			}
			int num;
			if (springManager.collideWithGround)
			{
				bool flag = CheckForGroundCollision();
				springManager = manager;
				if ((object)springManager == null)
				{
					throw new NullReferenceException();
				}
				num = ((!flag) ? 1 : 0) & 1;
			}
			else
			{
				num = 1;
			}
			if ((num & (springManager.enableCollision ? 1 : 0)) != 0)
			{
				bool flag2 = CheckForCollision();
				springManager = manager;
			}
			if (springManager.enableAngleLimits)
			{
				ApplyAngleLimits(deltaTime);
			}
			float num2 = currTipPos.x;
			float num3;
			float num4;
			if ((uint)(BitConverter.SingleToInt32Bits(num2) & 0x7FFFFFFF) <= 2139095040u)
			{
				num3 = currTipPos.y;
				if ((uint)(BitConverter.SingleToInt32Bits(num3) & 0x7FFFFFFF) <= 2139095040u)
				{
					num4 = currTipPos.z;
					if ((uint)(BitConverter.SingleToInt32Bits(num4) & 0x7FFFFFFF) < 2139095041u)
					{
						goto IL_04e4;
					}
				}
			}
			Quaternion rotation = parentTransform.rotation;
			float x = initialLocalRotation.x;
			float y = initialLocalRotation.y;
			float z = initialLocalRotation.z;
			float w = initialLocalRotation.w;
			float x2 = cachedPosition.x;
			float y2 = cachedPosition.y;
			Vector3 vector2 = boneAxis;
			float z2 = cachedPosition.z;
			Vector3 vector3 = new Quaternion
			{
				x = rotation.y * z + (rotation.w * x + rotation.x * w) - rotation.z * y,
				y = rotation.z * x + (rotation.w * y + rotation.y * w) - rotation.x * z,
				z = rotation.x * y + (rotation.w * z + rotation.z * w) - rotation.y * x,
				w = rotation.w * w - rotation.x * x - rotation.y * y - rotation.z * z
			} * vector2;
			float num5 = springLength;
			currTipPos = new Vector3
			{
				x = x2 + vector3.x * num5,
				y = y2 + vector3.y * num5,
				z = z2 + vector3.z * num5
			};
			prevTipPos = currTipPos;
			float num6 = x2 + vector3.x * num5;
			float num7 = y2 + vector3.y * num5;
			num4 = z2 + vector3.z * num5;
			num3 = num7;
			num2 = num6;
			IL_04e4:
			Quaternion b = ComputeRotation(new Vector3
			{
				x = num2,
				y = num3,
				z = num4
			});
			Quaternion a = skinAnimationLocalRotation;
			Transform transform = localTransform;
			actualLocalRotation = b;
			transform.localRotation = Quaternion.Lerp(a, b, dynamicRatio);
		}

		public void ComputeRotation(float dynamicRatio)
		{
			float num = currTipPos.x;
			float num2;
			float num3;
			if ((uint)(BitConverter.SingleToInt32Bits(num) & 0x7FFFFFFF) <= 2139095040u)
			{
				num2 = currTipPos.y;
				if ((uint)(BitConverter.SingleToInt32Bits(num2) & 0x7FFFFFFF) <= 2139095040u)
				{
					num3 = currTipPos.z;
					if ((uint)(BitConverter.SingleToInt32Bits(num3) & 0x7FFFFFFF) < 2139095041u)
					{
						goto IL_0370;
					}
				}
			}
			Quaternion rotation = parentTransform.rotation;
			Transform transform = localTransform;
			float z = initialLocalRotation.z;
			float w = initialLocalRotation.w;
			float x = initialLocalRotation.x;
			float y = initialLocalRotation.y;
			Vector3 position = transform.position;
			Vector3 vector = boneAxis;
			Vector3 vector2 = new Quaternion
			{
				x = rotation.y * z + (rotation.w * x + rotation.x * w) - rotation.z * y,
				y = rotation.z * x + (rotation.w * y + rotation.y * w) - rotation.x * z,
				z = rotation.x * y + (rotation.w * z + rotation.z * w) - rotation.y * x,
				w = rotation.w * w - rotation.x * x - rotation.y * y - rotation.z * z
			} * vector;
			float num4 = springLength;
			currTipPos = new Vector3
			{
				x = position.x + vector2.x * num4,
				y = position.y + vector2.y * num4,
				z = position.z + vector2.z * num4
			};
			prevTipPos = currTipPos;
			float num5 = position.x + vector2.x * num4;
			float num6 = position.y + vector2.y * num4;
			num3 = position.z + vector2.z * num4;
			num2 = num6;
			num = num5;
			IL_0370:
			Quaternion b = ComputeRotation(new Vector3
			{
				x = num,
				y = num2,
				z = num3
			});
			Quaternion a = skinAnimationLocalRotation;
			Transform transform2 = localTransform;
			actualLocalRotation = b;
			transform2.localRotation = Quaternion.Lerp(a, b, dynamicRatio);
		}

		public Transform GetPivotTransform()
		{
			if (!hasPivotNode)
			{
				if (pivotNode == null)
				{
					Transform transform = parentTransform;
					if ((object)transform == null)
					{
						transform = localTransform;
					}
					pivotNode = transform;
				}
				hasPivotNode = true;
			}
			return pivotNode;
		}

		private static IList<Transform> GetValidChildren(Transform parent)
		{
			int childCount = parent.childCount;
			List<Transform> list = new List<Transform>(childCount);
			if (childCount >= 1)
			{
				int num = 0;
				while (true)
				{
					Transform child = parent.GetChild(num);
					if (child.GetComponent<SpringBonePivot>() == null)
					{
						list.Add(child);
					}
					if (childCount == num + 1)
					{
						break;
					}
					num++;
				}
				return list;
			}
			return list;
		}

		private void ApplyAngleLimits(float deltaTime)
		{
			if ((yAngleLimits.active || zAngleLimits.active) && (hasPivotNode || !(pivotNode == null)))
			{
				float x = currTipPos.x;
				float y = currTipPos.y;
				float z = currTipPos.z;
				float x2 = cachedPosition.x;
				float y2 = cachedPosition.y;
				float z2 = cachedPosition.z;
				Quaternion rotation = GetPivotTransform().rotation;
				QuaternionUtility.Left(rotation, ref angleForward);
				QuaternionUtility.Back(rotation, ref angleBack);
				QuaternionUtility.Down(rotation, ref angleDown);
				AngleLimits angleLimits = yAngleLimits;
				Vector3 vector;
				if (!angleLimits.active)
				{
					vector = new Vector3
					{
						x = x - x2,
						y = y - y2,
						z = z - z2
					};
				}
				else
				{
					Vector3 basisSide = angleDown;
					Vector3 basisUp = angleBack;
					Vector3 basisForward = angleForward;
					float springStrength = angularStiffness;
					vector = new Vector3
					{
						x = x - x2,
						y = y - y2,
						z = z - z2
					};
					bool flag = angleLimits.ConstrainVector(basisSide, basisUp, basisForward, springStrength, deltaTime, ref vector);
				}
				AngleLimits angleLimits2 = zAngleLimits;
				if (angleLimits2.active)
				{
					bool flag2 = angleLimits2.ConstrainVector(angleBack, angleDown, angleForward, angularStiffness, deltaTime, ref vector);
				}
				currTipPos = new Vector3
				{
					x = x2 + vector.x,
					y = y2 + vector.y,
					z = z2 + vector.z
				};
			}
		}

		private bool CheckForCollision()
		{
			Transform transform = localTransform;
			if ((object)transform == null)
			{
				throw new NullReferenceException();
			}
			float x = radius;
			float x2 = currTipPos.x;
			float y = currTipPos.y;
			float z = currTipPos.z;
			Vector3 vector = cachedPosition;
			Vector3 vector2 = transform.TransformDirection(x, 0f, 0f);
			SpringCapsuleCollider[] array = capsuleColliders;
			Vector3 vector3 = new Vector3
			{
				z = 1f
			};
			bool flag = false;
			Vector3 hitNormal = vector3;
			long num = 0L;
			int num2 = 0;
			while (true)
			{
				if (num2 < array.Length)
				{
					SpringCapsuleCollider springCapsuleCollider = array[(nint)num];
					if (springCapsuleCollider.enabled)
					{
						CollisionStatus collisionStatus = springCapsuleCollider.CheckForCollisionAndReact(vector, ref currTipPos, (float)Math.Sqrt(vector2.z * vector2.z + (vector2.x * vector2.x + vector2.y * vector2.y)), ref hitNormal);
						flag = flag || collisionStatus != CollisionStatus.NoCollision;
					}
					array = capsuleColliders;
					if (array == null)
					{
						break;
					}
					num2++;
					num++;
					continue;
				}
				SpringSphereCollider[] array2 = sphereColliders;
				int num3 = 0;
				long num4 = 0L;
				while (true)
				{
					if (num3 < array2.Length)
					{
						SpringSphereCollider springSphereCollider = array2[(nint)num4];
						if (springSphereCollider.enabled)
						{
							CollisionStatus collisionStatus2 = springSphereCollider.CheckForCollisionAndReact(vector, ref currTipPos, (float)Math.Sqrt(vector2.z * vector2.z + (vector2.x * vector2.x + vector2.y * vector2.y)), ref hitNormal);
							flag = flag || collisionStatus2 != CollisionStatus.NoCollision;
						}
						array2 = sphereColliders;
						if (array2 == null)
						{
							break;
						}
						num3++;
						num4++;
						continue;
					}
					SpringPanelCollider[] array3 = panelColliders;
					int num5 = array3.Length;
					if (num5 >= 1)
					{
						long num6 = 0L;
						int num7 = 0;
						while (true)
						{
							SpringPanelCollider springPanelCollider = array3[(nint)num6];
							if (springPanelCollider.enabled)
							{
								CollisionStatus collisionStatus3 = springPanelCollider.CheckForCollisionAndReact(vector, springLength, ref currTipPos, (float)Math.Sqrt(vector2.z * vector2.z + (vector2.x * vector2.x + vector2.y * vector2.y)), ref hitNormal);
								flag = flag || collisionStatus3 != CollisionStatus.NoCollision;
							}
							if (num5 == num7 + 1)
							{
								break;
							}
							array3 = panelColliders;
							if (array3 == null)
							{
								goto end_IL_00c8;
							}
							num6 = (uint)(num7 + 1);
							num7++;
						}
					}
					if (flag)
					{
						SpringManager springManager = manager;
						if ((object)springManager == null)
						{
							throw new NullReferenceException();
						}
						float x3 = prevTipPos.x;
						float y2 = prevTipPos.y;
						float z2 = prevTipPos.z;
						float bounce = springManager.bounce;
						float friction = springManager.friction;
						if ((hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + ((hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction))) > 0.0001f)
						{
							float x4 = currTipPos.x;
							float y3 = currTipPos.y;
							float z3 = currTipPos.z;
							float x5 = currTipPos.x;
							float y4 = currTipPos.y;
							float z4 = currTipPos.z;
							prevTipPos = new Vector3
							{
								x = x5 - (hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)),
								y = y4 - (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)),
								z = z4 - (hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction))
							};
							if (1 == 0)
							{
							}
							float num10;
							float num11;
							float num12;
							if ((float)Math.Sqrt((hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + ((hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)))) > 1E-05f)
							{
								float num8 = (hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) / (float)Math.Sqrt((hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + ((hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction))));
								float num9 = (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) / (float)Math.Sqrt((hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + ((hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction))));
								num10 = (hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) / (float)Math.Sqrt((hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + ((hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction))));
								num11 = num9;
								num12 = num8;
							}
							else
							{
								num12 = Vector3.zero.x;
								num11 = Vector3.zero.y;
								num10 = Vector3.zero.z;
							}
							Vector3 vector4 = default;
							float num13 = num12;
							float num14 = (float)Math.Sqrt((hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + ((hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)))) - (float)Math.Sqrt((x4 - x3) * (x4 - x3) + (y3 - y2) * (y3 - y2) + (z3 - z2) * (z3 - z2));
							float num15 = 0f;
							float num16 = num14;
							uint num17 = (uint)BitConverter.SingleToInt32Bits(num16);
							uint num18 = (uint)BitConverter.SingleToInt32Bits(num15);
							vector4.x = x5 + num13 * ((num16 == num15) ? BitConverter.Int32BitsToSingle((int)(num17 & num18)) : (((num17 & 0x7FFFFFFF) > 2139095040 && (num17 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num17 | 0x400000)) : (((num18 & 0x7FFFFFFF) > 2139095040 && (num18 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num18 | 0x400000)) : (((num17 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num17 | 0x400000)) : (((num18 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num18 | 0x400000)) : ((!(num16 > num15)) ? num15 : num16))))));
							float num19 = num11;
							float num20 = (float)Math.Sqrt((hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + ((hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)))) - (float)Math.Sqrt((x4 - x3) * (x4 - x3) + (y3 - y2) * (y3 - y2) + (z3 - z2) * (z3 - z2));
							float num21 = 0f;
							float num22 = num20;
							uint num23 = (uint)BitConverter.SingleToInt32Bits(num22);
							uint num24 = (uint)BitConverter.SingleToInt32Bits(num21);
							vector4.y = y4 + num19 * ((num22 == num21) ? BitConverter.Int32BitsToSingle((int)(num23 & num24)) : (((num23 & 0x7FFFFFFF) > 2139095040 && (num23 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num23 | 0x400000)) : (((num24 & 0x7FFFFFFF) > 2139095040 && (num24 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num24 | 0x400000)) : (((num23 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num23 | 0x400000)) : (((num24 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num24 | 0x400000)) : ((!(num22 > num21)) ? num21 : num22))))));
							float num25 = (float)Math.Sqrt((hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.z * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + ((hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.x * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) + (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)) * (hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)))) * bounce + (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f) - hitNormal.y * (hitNormal.z * (z - z2 + hitNormal.z * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + (hitNormal.x * (x2 - x3 + hitNormal.x * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f)) + hitNormal.y * (y - y2 + hitNormal.y * (((z - z2) * hitNormal.z + ((x2 - x3) * hitNormal.x + (y - y2) * hitNormal.y)) * -2f))))) * (1f - friction)))) - (float)Math.Sqrt((x4 - x3) * (x4 - x3) + (y3 - y2) * (y3 - y2) + (z3 - z2) * (z3 - z2));
							float num26 = 0f;
							float num27 = num25;
							uint num28 = (uint)BitConverter.SingleToInt32Bits(num27);
							uint num29 = (uint)BitConverter.SingleToInt32Bits(num26);
							vector4.z = z4 + ((num27 == num26) ? BitConverter.Int32BitsToSingle((int)(num28 & num29)) : (((num28 & 0x7FFFFFFF) > 2139095040 && (num28 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num28 | 0x400000)) : (((num29 & 0x7FFFFFFF) > 2139095040 && (num29 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num29 | 0x400000)) : (((num28 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num28 | 0x400000)) : (((num29 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num29 | 0x400000)) : ((!(num27 > num26)) ? num26 : num27)))))) * num10;
							currTipPos = vector4;
						}
						else
						{
							prevTipPos = currTipPos;
						}
					}
					return flag;
				}
				break;
				continue;
				end_IL_00c8:
				break;
			}
			throw new NullReferenceException();
		}

		private bool CheckForGroundCollision()
		{
			float x = currTipPos.x;
			float y = currTipPos.y;
			float z = currTipPos.z;
			float x2 = cachedPosition.x;
			float y2 = cachedPosition.y;
			float z2 = cachedPosition.z;
			Vector3 vector = localTransform.TransformDirection(radius, 0f, 0f);
			float x3 = currTipPos.x;
			float y3 = currTipPos.y;
			float z3 = currTipPos.z;
			if (1 == 0)
			{
			}
			float groundHeight = manager.groundHeight;
			Vector3 localTailPosition = new Vector3
			{
				x = x,
				y = y - groundHeight,
				z = z
			};
			CollisionStatus collisionStatus = SpringPanelCollider.CheckForCollisionWithAlignedPlaneAndReact(new Vector3
			{
				x = x2,
				y = y2 - groundHeight,
				z = z2
			}, (float)Math.Sqrt((x3 - x2) * (x3 - x2) + (y3 - y2) * (y3 - y2) + (z3 - z2) * (z3 - z2)), ref localTailPosition, (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)), SpringPanelCollider.Axis.Y);
			if (collisionStatus != CollisionStatus.NoCollision)
			{
				float num = springLength;
				currTipPos = FixBoneLength(cachedPosition, new Vector3
				{
					x = localTailPosition.x,
					y = groundHeight + localTailPosition.y,
					z = localTailPosition.z
				}, num * 0.5f, num);
				prevTipPos = currTipPos;
			}
			return collisionStatus != CollisionStatus.NoCollision;
		}

		private Vector3 FixBoneLength(Vector3 headPosition, Vector3 tailPosition, float minLength, float maxLength)
		{
			float num3;
			float num4;
			float num5;
			if (!((float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y))) <= 0.001f))
			{
				float num = (tailPosition.x - headPosition.x) * (((((!((float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y))) < minLength)) ? ((float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y)))) : minLength) > maxLength) ? maxLength : ((!((float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y))) < minLength)) ? ((float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y)))) : minLength)) / (float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y))));
				float num2 = (tailPosition.y - headPosition.y) * (((((!((float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y))) < minLength)) ? ((float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y)))) : minLength) > maxLength) ? maxLength : ((!((float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y))) < minLength)) ? ((float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y)))) : minLength)) / (float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y))));
				num3 = (tailPosition.z - headPosition.z) * (((((!((float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y))) < minLength)) ? ((float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y)))) : minLength) > maxLength) ? maxLength : ((!((float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y))) < minLength)) ? ((float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y)))) : minLength)) / (float)Math.Sqrt((tailPosition.z - headPosition.z) * (tailPosition.z - headPosition.z) + ((tailPosition.x - headPosition.x) * (tailPosition.x - headPosition.x) + (tailPosition.y - headPosition.y) * (tailPosition.y - headPosition.y))));
				num4 = num2;
				num5 = num;
			}
			else
			{
				Vector3 vector = localTransform.TransformDirection(boneAxis);
				float num6 = vector.x * minLength;
				float num7 = vector.y * minLength;
				num3 = vector.z * minLength;
				num4 = num7;
				num5 = num6;
			}
			return new Vector3
			{
				x = headPosition.x + num5,
				y = headPosition.y + num4,
				z = headPosition.z + num3
			};
		}

		private void InitializeSpringLengthAndTipPosition()
		{
			Vector3 vector = ComputeChildPosition();
			Vector3 position = localTransform.position;
			Transform[] array = lengthLimitTargets;
			currTipPos = vector;
			prevTipPos.x = vector.x;
			springLength = (float)Math.Sqrt((position.z - vector.z) * (position.z - vector.z) + ((position.x - vector.x) * (position.x - vector.x) + (position.y - vector.y) * (position.y - vector.y)));
			prevTipPos.y = vector.y;
			prevTipPos.z = vector.z;
			int num = array.Length;
			lengthsToLimitTargets = new float[num];
			if (num >= 1)
			{
				long num2 = 0L;
				int num3 = 0;
				while (true)
				{
					Transform transform = lengthLimitTargets[(nint)num2];
					float[] array2 = lengthsToLimitTargets;
					Vector3 position2 = transform.position;
					array2[(nint)num2] = (float)Math.Sqrt((position2.z - vector.z) * (position2.z - vector.z) + ((position2.x - vector.x) * (position2.x - vector.x) + (position2.y - vector.y) * (position2.y - vector.y)));
					if (num == num3 + 1)
					{
						break;
					}
					num2 = (uint)(num3 + 1);
					num3++;
				}
				appliedLengthScale = 1f;
			}
			else
			{
				appliedLengthScale = 1f;
			}
		}

		private Quaternion ComputeRotation(Vector3 tipPosition)
		{
			Vector3 position = localTransform.position;
			Quaternion rotation = parentTransform.rotation;
			float x = initialLocalRotation.x;
			float y = initialLocalRotation.y;
			float z = initialLocalRotation.z;
			float w = initialLocalRotation.w;
			Vector3 vector = Quaternion.Inverse(new Quaternion
			{
				x = rotation.y * z + (rotation.w * x + rotation.x * w) - rotation.z * y,
				y = rotation.z * x + (rotation.w * y + rotation.y * w) - rotation.x * z,
				z = rotation.x * y + (rotation.w * z + rotation.z * w) - rotation.y * x,
				w = rotation.w * w - rotation.x * x - rotation.y * y - rotation.z * z
			}) * new Vector3
			{
				x = tipPosition.x - position.x,
				y = tipPosition.y - position.y,
				z = tipPosition.z - position.z
			};
			Quaternion quaternion = Quaternion.FromToRotation(boneAxis, new Vector3
			{
				x = vector.x / (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)),
				y = vector.y / (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)),
				z = vector.z / (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y))
			});
			float z2 = initialLocalRotation.z;
			float w2 = initialLocalRotation.w;
			float x2 = initialLocalRotation.x;
			float y2 = initialLocalRotation.y;
			return new Quaternion
			{
				x = quaternion.z * y2 + (x2 * quaternion.w + quaternion.x * w2) - quaternion.y * z2,
				y = quaternion.x * z2 + (quaternion.w * y2 + quaternion.y * w2) - x2 * quaternion.z,
				z = x2 * quaternion.y + (quaternion.w * z2 + quaternion.z * w2) - quaternion.x * y2,
				w = quaternion.w * w2 - x2 * quaternion.x - quaternion.y * y2 - quaternion.z * z2
			};
		}

		private Vector3 ApplyLengthLimits(float deltaTime)
		{
			Transform[] array = lengthLimitTargets;
			int num = array.Length;
			float x4;
			float y4;
			float z4;
			if (num != 0)
			{
				float springConstant = SpringConstant;
				movement = default;
				float num7;
				float num8;
				float num9;
				if (num >= 1)
				{
					long num2 = 0L;
					int num3 = 0;
					Vector3 position;
					float x;
					float y;
					float num4;
					float z;
					float x2;
					float y2;
					float z2;
					while (true)
					{
						position = array[(nint)num2].position;
						float[] array2 = lengthsToLimitTargets;
						x = currTipPos.x;
						y = currTipPos.y;
						num4 = array2[(nint)num2];
						z = currTipPos.z;
						x2 = movement.x;
						y2 = movement.y;
						z2 = movement.z;
						movement = new Vector3
						{
							x = x2 - (x - position.x) * (1f / (float)Math.Sqrt((x - position.x) * (x - position.x) + (y - position.y) * (y - position.y) + (z - position.z) * (z - position.z))) * (springConstant * deltaTime * deltaTime * ((float)Math.Sqrt((x - position.x) * (x - position.x) + (y - position.y) * (y - position.y) + (z - position.z) * (z - position.z)) - num4)),
							y = y2 - (y - position.y) * (1f / (float)Math.Sqrt((x - position.x) * (x - position.x) + (y - position.y) * (y - position.y) + (z - position.z) * (z - position.z))) * (springConstant * deltaTime * deltaTime * ((float)Math.Sqrt((x - position.x) * (x - position.x) + (y - position.y) * (y - position.y) + (z - position.z) * (z - position.z)) - num4)),
							z = z2 - (z - position.z) * (1f / (float)Math.Sqrt((x - position.x) * (x - position.x) + (y - position.y) * (y - position.y) + (z - position.z) * (z - position.z))) * (springConstant * deltaTime * deltaTime * ((float)Math.Sqrt((x - position.x) * (x - position.x) + (y - position.y) * (y - position.y) + (z - position.z) * (z - position.z)) - num4))
						};
						if (num == num3 + 1)
						{
							break;
						}
						array = lengthLimitTargets;
						if (array == null)
						{
							throw new NullReferenceException();
						}
						num2 = (uint)(num3 + 1);
						num3++;
					}
					float num5 = x2 - (x - position.x) * (1f / (float)Math.Sqrt((x - position.x) * (x - position.x) + (y - position.y) * (y - position.y) + (z - position.z) * (z - position.z))) * (springConstant * deltaTime * deltaTime * ((float)Math.Sqrt((x - position.x) * (x - position.x) + (y - position.y) * (y - position.y) + (z - position.z) * (z - position.z)) - num4));
					float num6 = y2 - (y - position.y) * (1f / (float)Math.Sqrt((x - position.x) * (x - position.x) + (y - position.y) * (y - position.y) + (z - position.z) * (z - position.z))) * (springConstant * deltaTime * deltaTime * ((float)Math.Sqrt((x - position.x) * (x - position.x) + (y - position.y) * (y - position.y) + (z - position.z) * (z - position.z)) - num4));
					num7 = z2 - (z - position.z) * (1f / (float)Math.Sqrt((x - position.x) * (x - position.x) + (y - position.y) * (y - position.y) + (z - position.z) * (z - position.z))) * (springConstant * deltaTime * deltaTime * ((float)Math.Sqrt((x - position.x) * (x - position.x) + (y - position.y) * (y - position.y) + (z - position.z) * (z - position.z)) - num4));
					num8 = num6;
					num9 = num5;
				}
				else
				{
					num9 = 0f;
					num8 = 0f;
					num7 = 0f;
				}
				float x3 = currTipPos.x;
				float y3 = currTipPos.y;
				float z3 = currTipPos.z;
				x4 = x3 + num9;
				y4 = y3 + num8;
				z4 = z3 + num7;
			}
			else
			{
				x4 = currTipPos.x;
				y4 = currTipPos.y;
				z4 = currTipPos.z;
			}
			return new Vector3
			{
				x = x4,
				y = y4,
				z = z4
			};
		}

		public void SetSpringLengthScale(float scale)
		{
			if (!(localTransform == null))
			{
				if (parentTransform == null)
				{
					Debug.LogWarning("[SpringBone] SetSpringLengthScale: 初期化前のため適用できませんでした。SpringBone=\"" + name + "\"");
					return;
				}
				float num = appliedLengthScale;
				float epsilon = Mathf.Epsilon;
				float epsilon2 = Mathf.Epsilon;
				float num2 = Math.Abs(1f - scale / ((!(num > epsilon)) ? epsilon : num));
				float num3 = Math.Abs(scale / ((!(num > epsilon)) ? epsilon : num));
				float num4 = 1f;
				float num5 = num3;
				uint num6 = (uint)BitConverter.SingleToInt32Bits(num5);
				uint num7 = (uint)BitConverter.SingleToInt32Bits(num4);
				float num13;
				if (((num5 == num4) ? BitConverter.Int32BitsToSingle((int)(num6 & num7)) : (((num6 & 0x7FFFFFFF) > 2139095040 && (num6 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num6 | 0x400000)) : (((num7 & 0x7FFFFFFF) > 2139095040 && (num7 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num7 | 0x400000)) : (((num6 & 0x7FFFFFFF) > 2139095040) ? (((num7 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num6 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num7)) : (((num7 & 0x7FFFFFFF) > 2139095040) ? (((num6 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num7 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num6)) : ((!(num5 > num4)) ? num4 : num5)))))) * 1E-06f > epsilon2 * 8f)
				{
					float num8 = Math.Abs(scale / ((!(num > epsilon)) ? epsilon : num));
					float num9 = 1f;
					float num10 = num8;
					uint num11 = (uint)BitConverter.SingleToInt32Bits(num10);
					uint num12 = (uint)BitConverter.SingleToInt32Bits(num9);
					num13 = ((num10 == num9) ? BitConverter.Int32BitsToSingle((int)(num11 & num12)) : (((num11 & 0x7FFFFFFF) > 2139095040 && (num11 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num11 | 0x400000)) : (((num12 & 0x7FFFFFFF) > 2139095040 && (num12 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num12 | 0x400000)) : (((num11 & 0x7FFFFFFF) > 2139095040) ? (((num12 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num11 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num12)) : (((num12 & 0x7FFFFFFF) > 2139095040) ? (((num11 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num12 | 0x400000)) : BitConverter.Int32BitsToSingle((int)num11)) : ((!(num10 > num9)) ? num9 : num10)))))) * 1E-06f;
				}
				else
				{
					num13 = epsilon2 * 8f;
				}
				if (num2 < num13)
				{
					return;
				}
				float num14 = springLength;
				Transform transform = localTransform;
				appliedLengthScale = scale;
				springLength = scale / ((!(num > epsilon)) ? epsilon : num) * num14;
				Vector3 position = transform.position;
				Quaternion rotation = parentTransform.rotation;
				float x = initialLocalRotation.x;
				float y = initialLocalRotation.y;
				float z = initialLocalRotation.z;
				float w = initialLocalRotation.w;
				Vector3 vector = boneAxis;
				Vector3 vector2 = new Quaternion
				{
					x = rotation.y * z + (rotation.w * x + rotation.x * w) - rotation.z * y,
					y = rotation.z * x + (rotation.w * y + rotation.y * w) - rotation.x * z,
					z = rotation.x * y + (rotation.w * z + rotation.z * w) - rotation.y * x,
					w = rotation.w * w - rotation.x * x - rotation.y * y - rotation.z * z
				} * vector;
				float num15 = springLength;
				float[] array = lengthsToLimitTargets;
				currTipPos = new Vector3
				{
					x = position.x + vector2.x * num15,
					y = position.y + vector2.y * num15,
					z = position.z + vector2.z * num15
				};
				prevTipPos = currTipPos;
				if (array == null)
				{
					return;
				}
				int num16 = array.Length;
				if (num16 < 1)
				{
					return;
				}
				long num17 = 0L;
				while (true)
				{
					float num18 = array[(nint)num17];
					array[(nint)num17] = scale / ((!(num > epsilon)) ? epsilon : num) * num18;
					if (num17 + 1L >= num16)
					{
						break;
					}
					num17++;
				}
			}
			else
			{
				Debug.LogWarning("[SpringBone] SetSpringLengthScale: 初期化前のため適用できませんでした。SpringBone=\"" + name + "\"");
			}
		}

		public SpringBone()
		{
			springForce.x = 0f;
			springForce.y = -0.0001f;
			springForce.z = 0f;
			windInfluence = 1f;
			angularStiffness = 100f;
			yAngleLimits = new AngleLimits();
			zAngleLimits = new AngleLimits();
			boneAxis.z = 0f;
			radius = 0.05f;
			boneAxis.x = -1f;
			boneAxis.y = 0f;
			appliedLengthScale = 1f;
		}
	}
}
