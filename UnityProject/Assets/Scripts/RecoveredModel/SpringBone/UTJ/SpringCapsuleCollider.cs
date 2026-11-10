// 源自恢复工程 ThirdParty.SpringBone/UTJ/SpringCapsuleCollider.cs。
using System;
using UnityEngine;

namespace UTJ
{
	public class SpringCapsuleCollider : MonoBehaviour
	{
		public float radius = 0.075f;

		public float height = 0.3f;

		public Renderer linkedRenderer;

		private Matrix4x4 cachedWorldToLocalMatrix;

		private Matrix4x4 cachedLocalToWorldMatrix;

		private Matrix4x4 cachedLocalToWorldMatrixDirection;

		private Transform cachedTransform;

		private Vector3 cachedLossyScale;

		public void PreUpdate()
		{
			cachedTransform = base.transform;
			Matrix4x4 worldToLocalMatrix = cachedTransform.worldToLocalMatrix;
			Transform transform = cachedTransform;
			cachedWorldToLocalMatrix = worldToLocalMatrix;
			Matrix4x4 localToWorldMatrix = transform.localToWorldMatrix;
			Transform transform2 = cachedTransform;
			cachedLocalToWorldMatrix = localToWorldMatrix;
			cachedLossyScale = transform2.lossyScale;
			cachedLocalToWorldMatrixDirection = cachedLocalToWorldMatrix;
			cachedLocalToWorldMatrixDirection.m30 = 0f;
			cachedLocalToWorldMatrixDirection.m31 = 0f;
			cachedLocalToWorldMatrixDirection.m32 = 0f;
			cachedLocalToWorldMatrixDirection = cachedLocalToWorldMatrixDirection.inverse.transpose;
		}

		public SpringBone.CollisionStatus CheckForCollisionAndReact(Vector3 moverHeadPosition, ref Vector3 moverPosition, float moverRadius, ref Vector3 hitNormal)
		{
			if (!(linkedRenderer != null) || linkedRenderer.enabled)
			{
				if (radius <= 0.0001f)
				{
					return SpringBone.CollisionStatus.NoCollision;
				}
				Vector3 vector = cachedWorldToLocalMatrix.MultiplyPoint3x4(moverHeadPosition);
				Vector3 point = moverPosition;
				Vector3 vector2 = cachedWorldToLocalMatrix.MultiplyPoint3x4(point);
				float x = cachedLossyScale.x;
				float num = height;
				if (!(vector2.y <= 0f) && !(vector2.y >= num))
				{
					return CheckForCylinderCollisionAndReact(vector, ref moverPosition, moverRadius, vector2, ref hitNormal);
				}
				float num2 = radius;
				if (vector2.x * vector2.x + (vector2.y - ((!(vector2.y >= num)) ? 0f : num)) * (vector2.y - ((!(vector2.y >= num)) ? 0f : num)) + vector2.z * vector2.z >= (num2 + moverRadius) * (num2 + moverRadius))
				{
					return SpringBone.CollisionStatus.NoCollision;
				}
				if (!(vector.x * vector.x + (vector.y - ((!(vector2.y >= num)) ? 0f : num)) * (vector.y - ((!(vector2.y >= num)) ? 0f : num)) + vector.z * vector.z <= x * (num2 * (x * num2))))
				{
					Circle3 intersection = default;
					if (SpringSphereCollider.ComputeIntersection(vector, (float)Math.Sqrt((vector2.z - vector.z) * (vector2.z - vector.z) + ((vector2.x - vector.x) * (vector2.x - vector.x) + (vector2.y - vector.y) * (vector2.y - vector.y))), new Vector3
					{
						y = ((!(vector2.y >= num)) ? 0f : num)
					}, num2 + moverRadius, ref intersection))
					{
						Vector3 point2 = SpringSphereCollider.ComputeNewTailPosition(intersection, vector2);
						moverPosition = cachedLocalToWorldMatrix.MultiplyPoint3x4(point2);
						float z;
						float y;
						float x2;
						if ((float)Math.Sqrt(point2.z * point2.z + (point2.x * point2.x + (point2.y - ((!(vector2.y >= num)) ? 0f : num)) * (point2.y - ((!(vector2.y >= num)) ? 0f : num)))) > 1E-05f)
						{
							float num3 = point2.x / (float)Math.Sqrt(point2.z * point2.z + (point2.x * point2.x + (point2.y - ((!(vector2.y >= num)) ? 0f : num)) * (point2.y - ((!(vector2.y >= num)) ? 0f : num))));
							float num4 = (point2.y - ((!(vector2.y >= num)) ? 0f : num)) / (float)Math.Sqrt(point2.z * point2.z + (point2.x * point2.x + (point2.y - ((!(vector2.y >= num)) ? 0f : num)) * (point2.y - ((!(vector2.y >= num)) ? 0f : num))));
							z = point2.z / (float)Math.Sqrt(point2.z * point2.z + (point2.x * point2.x + (point2.y - ((!(vector2.y >= num)) ? 0f : num)) * (point2.y - ((!(vector2.y >= num)) ? 0f : num))));
							y = num4;
							x2 = num3;
						}
						else
						{
							x2 = Vector3.zero.x;
							y = Vector3.zero.y;
							z = Vector3.zero.z;
						}
						hitNormal = cachedLocalToWorldMatrixDirection.MultiplyVector(new Vector3
						{
							x = x2,
							y = y,
							z = z
						});
						float x3 = hitNormal.x;
						float y2 = hitNormal.y;
						float z2 = hitNormal.z;
						float x4 = hitNormal.x;
						float y3 = hitNormal.y;
						float z3 = hitNormal.z;
						hitNormal = new Vector3
						{
							x = x4 / (float)Math.Sqrt(x3 * x3 + y2 * y2 + z2 * z2),
							y = y3 / (float)Math.Sqrt(x3 * x3 + y2 * y2 + z2 * z2),
							z = z3 / (float)Math.Sqrt(x3 * x3 + y2 * y2 + z2 * z2)
						};
					}
					return SpringBone.CollisionStatus.TailCollision;
				}
				float num7;
				float num8;
				float num9;
				if ((float)Math.Sqrt(vector2.x * vector2.x + (vector2.y - ((!(vector2.y >= num)) ? 0f : num)) * (vector2.y - ((!(vector2.y >= num)) ? 0f : num)) + vector2.z * vector2.z) > 1E-05f)
				{
					float num5 = vector2.x / (float)Math.Sqrt(vector2.x * vector2.x + (vector2.y - ((!(vector2.y >= num)) ? 0f : num)) * (vector2.y - ((!(vector2.y >= num)) ? 0f : num)) + vector2.z * vector2.z);
					float num6 = (vector2.y - ((!(vector2.y >= num)) ? 0f : num)) / (float)Math.Sqrt(vector2.x * vector2.x + (vector2.y - ((!(vector2.y >= num)) ? 0f : num)) * (vector2.y - ((!(vector2.y >= num)) ? 0f : num)) + vector2.z * vector2.z);
					num7 = vector2.z / (float)Math.Sqrt(vector2.x * vector2.x + (vector2.y - ((!(vector2.y >= num)) ? 0f : num)) * (vector2.y - ((!(vector2.y >= num)) ? 0f : num)) + vector2.z * vector2.z);
					num8 = num6;
					num9 = num5;
				}
				else
				{
					num9 = Vector3.zero.x;
					num8 = Vector3.zero.y;
					num7 = Vector3.zero.z;
				}
				moverPosition = cachedLocalToWorldMatrix.MultiplyPoint3x4(new Vector3
				{
					x = (num2 + moverRadius) * num9 + 0f,
					y = ((!(vector2.y >= num)) ? 0f : num) + (num2 + moverRadius) * num8,
					z = (num2 + moverRadius) * num7 + 0f
				});
				hitNormal = cachedLocalToWorldMatrixDirection.MultiplyVector(new Vector3
				{
					x = num9,
					y = num8,
					z = num7
				});
				float x5 = hitNormal.x;
				float y4 = hitNormal.y;
				float z4 = hitNormal.z;
				float x6 = hitNormal.x;
				float y5 = hitNormal.y;
				float z5 = hitNormal.z;
				hitNormal = new Vector3
				{
					x = x6 / (float)Math.Sqrt(x5 * x5 + y4 * y4 + z4 * z4),
					y = y5 / (float)Math.Sqrt(x5 * x5 + y4 * y4 + z4 * z4),
					z = z5 / (float)Math.Sqrt(x5 * x5 + y4 * y4 + z4 * z4)
				};
				return SpringBone.CollisionStatus.HeadIsEmbedded;
			}
			return SpringBone.CollisionStatus.NoCollision;
		}

		private SpringBone.CollisionStatus CheckForCylinderCollisionAndReact(Vector3 localHeadPosition, ref Vector3 worldMoverPosition, float localMoverRadius, Vector3 localSpherePosition, ref Vector3 hitNormal)
		{
			float num = radius;
			if (!(localSpherePosition.x * localSpherePosition.x + localSpherePosition.z * localSpherePosition.z <= (num + localMoverRadius) * (num + localMoverRadius)))
			{
				return SpringBone.CollisionStatus.NoCollision;
			}
			float num3;
			float num4;
			if ((float)Math.Sqrt(localSpherePosition.x * localSpherePosition.x + localSpherePosition.z * localSpherePosition.z) > 1E-05f)
			{
				float num2 = localSpherePosition.x / (float)Math.Sqrt(localSpherePosition.x * localSpherePosition.x + localSpherePosition.z * localSpherePosition.z);
				num3 = localSpherePosition.z / (float)Math.Sqrt(localSpherePosition.x * localSpherePosition.x + localSpherePosition.z * localSpherePosition.z);
				num4 = num2;
			}
			else
			{
				num4 = Vector2.zero.x;
				num3 = Vector2.zero.y;
			}
			worldMoverPosition = cachedLocalToWorldMatrix.MultiplyPoint3x4(new Vector3
			{
				x = (num + localMoverRadius) * num4,
				y = localSpherePosition.y,
				z = (num + localMoverRadius) * num3
			});
			hitNormal = cachedLocalToWorldMatrixDirection.MultiplyVector(new Vector3
			{
				x = num4,
				z = num3
			});
			float x = hitNormal.x;
			float y = hitNormal.y;
			float z = hitNormal.z;
			float x2 = hitNormal.x;
			float y2 = hitNormal.y;
			float z2 = hitNormal.z;
			hitNormal = new Vector3
			{
				x = x2 / (float)Math.Sqrt(x * x + y * y + z * z),
				y = y2 / (float)Math.Sqrt(x * x + y * y + z * z),
				z = z2 / (float)Math.Sqrt(x * x + y * y + z * z)
			};
			float x3 = cachedLossyScale.x;
			float num5 = radius;
			return (localHeadPosition.x * localHeadPosition.x + localHeadPosition.z * localHeadPosition.z <= x3 * (num5 * (x3 * num5))) ? SpringBone.CollisionStatus.HeadIsEmbedded : SpringBone.CollisionStatus.TailCollision;
		}
	}
}
