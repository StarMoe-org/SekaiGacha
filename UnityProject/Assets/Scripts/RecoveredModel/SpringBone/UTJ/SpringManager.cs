// 源自恢复工程 ThirdParty.SpringBone/UTJ/SpringManager.cs。
using System;
using System.Collections.Generic;
using System.Linq;
using UTJ.GameObjectExtensions;
using UnityEngine;

namespace UTJ
{
	public class SpringManager : MonoBehaviour
	{
		[Header("Properties")]
		public bool automaticUpdates = true;

		public bool isPaused;

		public int simulationFrameRate = 60;

		[Range(0f, 1f)]
		public float dynamicRatio = 0.5f;

		public Vector3 gravity;

		[Range(0f, 1f)]
		public float bounce;

		[Range(0f, 1f)]
		public float friction = 1f;

		[Header("Constraints")]
		public bool enableAngleLimits = true;

		public bool enableCollision = true;

		public bool enableLengthLimits = true;

		[Header("Ground Collision")]
		public bool collideWithGround = true;

		public float groundHeight;

		[Header("Bones")]
		public SpringBone[] springBones;

		private float slowMotionScale = 1f;

		private SpringSphereCollider[] cachedSpringSphereColliders;

		private SpringCapsuleCollider[] cachedSpringCapsuleColliders;

		private SpringPanelCollider[] cachedSpringPanelColliders;

		private bool isSumOfForcesOnBone;

		private bool[] boneIsAnimatedStates;

		private ForceProvider[] forceProviders;

		public bool[] BoneIsAnimatedStates => boneIsAnimatedStates;

		public float SlowMotionScale => slowMotionScale;

		public void SetSumOfForcesOnBone(bool active)
		{
			isSumOfForcesOnBone = active;
		}

		public void CleanUpBoneColliders()
		{
			SpringBone[] array = springBones;
			if (array.Length < 1)
			{
				return;
			}
			long num = 0L;
			int num2 = 0;
			while (true)
			{
				SpringBone springBone = array[(nint)num];
				springBone.sphereColliders = springBone.sphereColliders.Where((SpringSphereCollider collider) => collider != null).ToArray();
				springBone.capsuleColliders = springBone.capsuleColliders.Where((SpringCapsuleCollider collider) => collider != null).ToArray();
				springBone.panelColliders = springBone.panelColliders.Where((SpringPanelCollider collider) => collider != null).ToArray();
				if (num2 + 1 >= array.Length)
				{
					break;
				}
				num = (uint)(num2 + 1);
				num2++;
			}
		}

		public void FindSpringBones(bool includeInactive = false)
		{
			var list = (from bone in GetComponentsInChildren<SpringBone>(includeInactive)
				select new
				{
					bone = bone,
					depth = GetObjectDepth(bone.transform)
				}).ToList();
			list.Sort((a, b) => a.depth.CompareTo(b.depth));
			springBones = list.Select(item => item.bone).ToArray();
			SetupCollider();
		}

		public void UpdateBoneIsAnimatedStates(IList<string> animatedBoneNames)
		{
			bool[] array = boneIsAnimatedStates;
			SpringBone[] array2 = springBones;
			if (array == null || array.Length != array2.Length)
			{
				boneIsAnimatedStates = new bool[array2.Length];
				array2 = springBones;
			}
			int num = array2.Length;
			if (num < 1)
			{
				return;
			}
			long num2 = 0L;
			int num3 = 0;
			while (true)
			{
				SpringBone springBone = springBones[(nint)num2];
				boneIsAnimatedStates[(nint)num2] = animatedBoneNames.Contains(springBone.name);
				if (num3 + 1 == num)
				{
					break;
				}
				num2 = (uint)(num3 + 1);
				num3++;
			}
		}

		public void UpdateDynamics()
		{
			SpringBone[] array = springBones;
			bool flag = isPaused;
			int num = array.Length;
			if (flag)
			{
				if (num < 1)
				{
					return;
				}
				long num2 = 0L;
				int num3 = 0;
				while (true)
				{
					SpringBone springBone = array[(nint)num2];
					if (springBone.enabled)
					{
						springBone.ComputeRotation((!boneIsAnimatedStates[(nint)num2]) ? 1f : dynamicRatio);
					}
					if (num + -1 == num3)
					{
						return;
					}
					array = springBones;
					if (array == null)
					{
						break;
					}
					num2 = (uint)(num3 + 1);
					num3++;
				}
				throw new NullReferenceException();
			}
			float deltaTime = CalcTimeStep();
			PreUpdateCollider();
			if (!isSumOfForcesOnBone || num < 1)
			{
				return;
			}
			long num4 = 0L;
			int num5 = 0;
			while (true)
			{
				SpringBone springBone2 = springBones[(nint)num4];
				if (springBone2.enabled)
				{
					springBone2.UpdateSpring(deltaTime, GetSumOfForcesOnBone(springBone2));
					springBone2.SatisfyConstraintsAndComputeRotation(deltaTime, (!boneIsAnimatedStates[(nint)num4]) ? 1f : dynamicRatio);
				}
				if (num == num5 + 1)
				{
					break;
				}
				num4 = (uint)(num5 + 1);
				num5++;
			}
		}

		public void SetSlowMotionScale(float slowMotionScale)
		{
			this.slowMotionScale = slowMotionScale;
		}

		private float CalcTimeStep()
		{
			int num = simulationFrameRate;
			float num2 = ((num <= 0) ? Time.deltaTime : (1f / (float)num));
			if (!slowMotionScale.Equals(1f))
			{
				num2 *= slowMotionScale;
			}
			return num2;
		}

		public void SetupCollider()
		{
			HashSet<SpringSphereCollider> hashSet = new HashSet<SpringSphereCollider>();
			HashSet<SpringCapsuleCollider> hashSet2 = new HashSet<SpringCapsuleCollider>();
			HashSet<SpringPanelCollider> hashSet3 = new HashSet<SpringPanelCollider>();
			SpringBone[] array = springBones;
			int num = 0;
			long num2 = 0L;
			while (num < array.Length)
			{
				SpringBone springBone = array[(nint)num2];
				if (springBone == null)
				{
					return;
				}
				SpringSphereCollider[] sphereColliders = springBone.sphereColliders;
				if (sphereColliders != null)
				{
					hashSet.UnionWith(sphereColliders);
				}
				SpringCapsuleCollider[] capsuleColliders = springBone.capsuleColliders;
				if (capsuleColliders != null)
				{
					hashSet2.UnionWith(capsuleColliders);
				}
				SpringPanelCollider[] panelColliders = springBone.panelColliders;
				if (panelColliders != null)
				{
					hashSet3.UnionWith(panelColliders);
				}
				array = springBones;
				if (array == null)
				{
					throw new NullReferenceException();
				}
				num++;
				num2++;
			}
			cachedSpringSphereColliders = hashSet.ToArray();
			cachedSpringCapsuleColliders = hashSet2.ToArray();
			cachedSpringPanelColliders = hashSet3.ToArray();
		}

		private static int GetObjectDepth(Transform inObject)
		{
			Transform transform = inObject;
			int num = 0;
			while (transform != null)
			{
				transform = transform.parent;
				num++;
			}
			return num;
		}

		private Vector3 GetSumOfForcesOnBone(SpringBone springBone)
		{
			ForceProvider[] array = forceProviders;
			int num = array.Length;
			float num2 = gravity.y;
			float num3 = gravity.z;
			float num4 = gravity.x;
			if (num >= 1)
			{
				long num5 = 0L;
				int num6 = 0;
				while (true)
				{
					ForceProvider forceProvider = array[(nint)num5];
					if (forceProvider.isActiveAndEnabled)
					{
						Vector3 forceOnBone = forceProvider.GetForceOnBone(springBone);
						float num7 = num4 + forceOnBone.x;
						float num8 = num2 + forceOnBone.y;
						num3 += forceOnBone.z;
						num2 = num8;
						num4 = num7;
					}
					if (num == num6 + 1)
					{
						return new Vector3
						{
							x = num4,
							y = num2,
							z = num3
						};
					}
					array = forceProviders;
					if (array == null)
					{
						break;
					}
					num5 = (uint)(num6 + 1);
					num6++;
				}
				throw new NullReferenceException();
			}
			return new Vector3
			{
				x = num4,
				y = num2,
				z = num3
			};
		}

		private void Awake()
		{
			FindSpringBones(includeInactive: true);
			SpringBone[] array = springBones;
			int num = array.Length;
			if (num >= 1)
			{
				long num2 = 0L;
				int num3 = 0;
				while (true)
				{
					array[(nint)num2].Initialize(this);
					if (num == num3 + 1)
					{
						break;
					}
					array = springBones;
					if (array == null)
					{
						throw new NullReferenceException();
					}
					num2 = (uint)(num3 + 1);
					num3++;
				}
			}
			bool[] array2 = boneIsAnimatedStates;
			if (array2 != null)
			{
				if (array2.Length != num)
				{
					boneIsAnimatedStates = new bool[num];
				}
			}
			else
			{
				boneIsAnimatedStates = new bool[num];
			}
		}

		private void Start()
		{
			forceProviders = GameObjectUtil.FindComponentsOfType<ForceProvider>().ToArray();
		}

		private void PreUpdateCollider()
		{
			SpringSphereCollider[] array = cachedSpringSphereColliders;
			int num = 0;
			long num2 = 0L;
			while (true)
			{
				if (num < array.Length)
				{
					array[(nint)num2].PreUpdate();
					array = cachedSpringSphereColliders;
					if (array == null)
					{
						break;
					}
					num++;
					num2++;
					continue;
				}
				SpringCapsuleCollider[] array2 = cachedSpringCapsuleColliders;
				int num3 = 0;
				long num4 = 0L;
				while (true)
				{
					if (num3 < array2.Length)
					{
						array2[(nint)num4].PreUpdate();
						array2 = cachedSpringCapsuleColliders;
						if (array2 == null)
						{
							break;
						}
						num3++;
						num4++;
						continue;
					}
					SpringPanelCollider[] array3 = cachedSpringPanelColliders;
					int num5 = 0;
					long num6 = 0L;
					while (true)
					{
						if (num5 >= array3.Length)
						{
							return;
						}
						array3[(nint)num6].PreUpdate();
						array3 = cachedSpringPanelColliders;
						if (array3 == null)
						{
							break;
						}
						num5++;
						num6++;
					}
					throw new NullReferenceException();
				}
				break;
			}
			throw new NullReferenceException();
		}

		public void UpdateForceProviders()
		{
			forceProviders = GameObjectUtil.FindComponentsOfType<ForceProvider>().ToArray();
		}

		private void LateUpdate()
		{
			if (automaticUpdates)
			{
				UpdateDynamics();
			}
		}

		public SpringManager()
		{
			gravity.x = 0f;
			gravity.y = -10f;
			gravity.z = 0f;
			isSumOfForcesOnBone = true;
		}
	}
}
