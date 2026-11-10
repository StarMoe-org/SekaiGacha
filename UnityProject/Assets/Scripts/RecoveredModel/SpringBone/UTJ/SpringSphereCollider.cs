// 源自恢复工程 ThirdParty.SpringBone/UTJ/SpringSphereCollider.cs。
using System;
using UnityEngine;

namespace UTJ
{
	public class SpringSphereCollider : MonoBehaviour
	{
		private static readonly Vector3 DefaultSphereLocalOrigin = default;

		public float radius = 0.1f;

		public Renderer linkedRenderer;

		private static Circle3 intersection;

		private Matrix4x4 cachedWorldToLocalMatrix;

		private Matrix4x4 cachedLocalToWorldMatrix;

		private Matrix4x4 cachedWorldToLocalMatrixDirection;

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
			cachedWorldToLocalMatrixDirection = cachedWorldToLocalMatrix;
			cachedWorldToLocalMatrixDirection.m30 = 0f;
			cachedWorldToLocalMatrixDirection.m31 = 0f;
			cachedWorldToLocalMatrixDirection.m32 = 0f;
			cachedWorldToLocalMatrixDirection = cachedWorldToLocalMatrixDirection.inverse.transpose;
			cachedLocalToWorldMatrixDirection = cachedLocalToWorldMatrix;
			cachedLocalToWorldMatrixDirection.m30 = 0f;
			cachedLocalToWorldMatrixDirection.m31 = 0f;
			cachedLocalToWorldMatrixDirection.m32 = 0f;
			cachedLocalToWorldMatrixDirection = cachedLocalToWorldMatrixDirection.inverse.transpose;
		}

		public SpringBone.CollisionStatus CheckForCollisionAndReact(Vector3 headPosition, ref Vector3 tailPosition, float tailRadius, ref Vector3 hitNormal)
		{
			Vector3 localHeadPosition = cachedWorldToLocalMatrix.MultiplyPoint3x4(headPosition);
			Vector3 point = tailPosition;
			Vector3 localTailPosition = cachedWorldToLocalMatrix.MultiplyPoint3x4(point);
			Vector3 vector = cachedWorldToLocalMatrixDirection.MultiplyVector(new Vector3
			{
				x = tailRadius
			});
			float x = cachedLossyScale.x;
			float num = radius;
			SpringBone.CollisionStatus collisionStatus = CheckForCollisionAndReact(sphereLocalOrigin: DefaultSphereLocalOrigin, localHeadPosition: localHeadPosition, localTailPosition: ref localTailPosition, localTailRadius: (float)Math.Sqrt(vector.z / (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)) * tailRadius * (vector.z / (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)) * tailRadius) + (vector.x / (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)) * tailRadius * (vector.x / (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)) * tailRadius) + vector.y / (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)) * tailRadius * (vector.y / (float)Math.Sqrt(vector.z * vector.z + (vector.x * vector.x + vector.y * vector.y)) * tailRadius))), sphereRadius: x * num);
			if (collisionStatus != SpringBone.CollisionStatus.NoCollision)
			{
				tailPosition = cachedLocalToWorldMatrix.MultiplyPoint3x4(localTailPosition);
				Vector3 vector2 = cachedLocalToWorldMatrixDirection.MultiplyVector(new Vector3
				{
					x = localTailPosition.x / (float)Math.Sqrt(localTailPosition.x * localTailPosition.x + localTailPosition.y * localTailPosition.y + localTailPosition.z * localTailPosition.z),
					y = localTailPosition.y / (float)Math.Sqrt(localTailPosition.x * localTailPosition.x + localTailPosition.y * localTailPosition.y + localTailPosition.z * localTailPosition.z),
					z = localTailPosition.z / (float)Math.Sqrt(localTailPosition.x * localTailPosition.x + localTailPosition.y * localTailPosition.y + localTailPosition.z * localTailPosition.z)
				});
				hitNormal = new Vector3
				{
					x = vector2.x / (float)Math.Sqrt(vector2.z * vector2.z + (vector2.x * vector2.x + vector2.y * vector2.y)),
					y = vector2.y / (float)Math.Sqrt(vector2.z * vector2.z + (vector2.x * vector2.x + vector2.y * vector2.y)),
					z = vector2.z / (float)Math.Sqrt(vector2.z * vector2.z + (vector2.x * vector2.x + vector2.y * vector2.y))
				};
			}
			return collisionStatus;
		}

		public static SpringBone.CollisionStatus CheckForCollisionAndReact(Vector3 localHeadPosition, ref Vector3 localTailPosition, float localTailRadius, Vector3 sphereLocalOrigin, float sphereRadius)
		{
        float combinedRadius = localTailRadius + sphereRadius;
        Vector3 delta = localTailPosition - sphereLocalOrigin;
        if (delta.sqrMagnitude >= combinedRadius * combinedRadius) return SpringBone.CollisionStatus.NoCollision;
        if ((localHeadPosition - sphereLocalOrigin).sqrMagnitude <= sphereRadius * sphereRadius)
        {
            localTailPosition = sphereLocalOrigin + combinedRadius * (delta / delta.magnitude);
            return SpringBone.CollisionStatus.HeadIsEmbedded;
        }
        if (ComputeIntersection(localHeadPosition, (localTailPosition - localHeadPosition).magnitude, sphereLocalOrigin, combinedRadius, ref intersection))
            localTailPosition = ComputeNewTailPosition(intersection, localTailPosition);
        return SpringBone.CollisionStatus.TailCollision;
    }

		public static bool ComputeIntersection(Vector3 originA, float radiusA, Vector3 originB, float radiusB, ref Circle3 intersection)
		{
			if (!((float)Math.Sqrt((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y))) <= 0f))
			{
				intersection = new Circle3
				{
					origin =
					{
						x = originA.x + (radiusA * radiusA + ((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y)) - radiusB * radiusB)) * (0.5f / (float)Math.Sqrt((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y)))) * ((originB.x - originA.x) * (1f / (float)Math.Sqrt((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y))))),
						y = originA.y + (radiusA * radiusA + ((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y)) - radiusB * radiusB)) * (0.5f / (float)Math.Sqrt((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y)))) * ((originB.y - originA.y) * (1f / (float)Math.Sqrt((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y))))),
						z = originA.z + (radiusA * radiusA + ((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y)) - radiusB * radiusB)) * (0.5f / (float)Math.Sqrt((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y)))) * ((originB.z - originA.z) * (1f / (float)Math.Sqrt((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y)))))
					},
					upVector =
					{
						x = (originB.x - originA.x) * (1f / (float)Math.Sqrt((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y)))),
						y = (originB.y - originA.y) * (1f / (float)Math.Sqrt((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y)))),
						z = (originB.z - originA.z) * (1f / (float)Math.Sqrt((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y))))
					},
					radius = 0.5f / (float)Math.Sqrt((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y))) * (float)Math.Sqrt(radiusA * radiusA * (((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y))) * 4f) - (radiusA * radiusA + ((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y)) - radiusB * radiusB)) * (radiusA * radiusA + ((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y)) - radiusB * radiusB)))
				};
			}
			return !((float)Math.Sqrt((originB.z - originA.z) * (originB.z - originA.z) + ((originB.x - originA.x) * (originB.x - originA.x) + (originB.y - originA.y) * (originB.y - originA.y))) <= 0f);
		}

		public static Vector3 ComputeNewTailPosition(Circle3 intersection, Vector3 tailPosition)
		{
			return new Vector3
			{
				x = intersection.origin.x + (tailPosition.x - (intersection.origin.x + intersection.upVector.x * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) / (float)Math.Sqrt((tailPosition.z - (intersection.origin.z + intersection.upVector.z * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) * (tailPosition.z - (intersection.origin.z + intersection.upVector.z * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) + ((tailPosition.x - (intersection.origin.x + intersection.upVector.x * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) * (tailPosition.x - (intersection.origin.x + intersection.upVector.x * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) + (tailPosition.y - (intersection.origin.y + intersection.upVector.y * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) * (tailPosition.y - (intersection.origin.y + intersection.upVector.y * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))))) * intersection.radius,
				y = intersection.origin.y + (tailPosition.y - (intersection.origin.y + intersection.upVector.y * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) / (float)Math.Sqrt((tailPosition.z - (intersection.origin.z + intersection.upVector.z * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) * (tailPosition.z - (intersection.origin.z + intersection.upVector.z * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) + ((tailPosition.x - (intersection.origin.x + intersection.upVector.x * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) * (tailPosition.x - (intersection.origin.x + intersection.upVector.x * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) + (tailPosition.y - (intersection.origin.y + intersection.upVector.y * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) * (tailPosition.y - (intersection.origin.y + intersection.upVector.y * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))))) * intersection.radius,
				z = intersection.origin.z + (tailPosition.z - (intersection.origin.z + intersection.upVector.z * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) / (float)Math.Sqrt((tailPosition.z - (intersection.origin.z + intersection.upVector.z * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) * (tailPosition.z - (intersection.origin.z + intersection.upVector.z * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) + ((tailPosition.x - (intersection.origin.x + intersection.upVector.x * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) * (tailPosition.x - (intersection.origin.x + intersection.upVector.x * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) + (tailPosition.y - (intersection.origin.y + intersection.upVector.y * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))) * (tailPosition.y - (intersection.origin.y + intersection.upVector.y * ((tailPosition.z - intersection.origin.z) * intersection.upVector.z + ((tailPosition.x - intersection.origin.x) * intersection.upVector.x + (tailPosition.y - intersection.origin.y) * intersection.upVector.y)))))) * intersection.radius
			};
		}
	}
}
