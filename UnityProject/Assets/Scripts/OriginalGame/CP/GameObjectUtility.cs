// 源自恢复工程 Assets/Scripts/Assembly-CSharp/CP/GameObjectUtility.cs。
using System;
using System.Collections.Generic;
using JetBrains.Annotations;
using Sekai;
using Unity.Mathematics;
using UnityEngine;

namespace CP
{
	public static class GameObjectUtility
	{
		public static GameObject Instantiate(GameObject prefab)
		{
			return UnityEngine.Object.Instantiate(prefab);
		}

		public static GameObject Instantiate(GameObject prefab, Transform parent)
		{
			return UnityEngine.Object.Instantiate(prefab, parent);
		}

		public static GameObject Instantiate(GameObject prefab, Vector3 createPosition, Transform parent)
		{
			return UnityEngine.Object.Instantiate(prefab, createPosition, quaternion.identity, parent);
		}

		public static GameObject Instantiate(GameObject prefab, Transform parent, string name)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(prefab, parent);
			gameObject.name = name;
			return gameObject;
		}

		public static T Instantiate<T>(GameObject prefab) where T : MonoBehaviour
		{
			return UnityEngine.Object.Instantiate(prefab).GetComponent<T>();
		}

		public static T Instantiate<T>(GameObject prefab, Transform parent) where T : MonoBehaviour
		{
			return UnityEngine.Object.Instantiate(prefab, parent).GetComponent<T>();
		}

		public static T Instantiate<T>(GameObject prefab, Vector3 createPosition, Transform parent) where T : MonoBehaviour
		{
			return UnityEngine.Object.Instantiate(prefab, createPosition, quaternion.identity, parent).GetComponent<T>();
		}

		public static T Instantiate<T>(GameObject prefab, Transform parent, string name) where T : MonoBehaviour
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(prefab, parent);
			gameObject.name = name;
			return gameObject.GetComponent<T>();
		}

		public static T Instantiate<T>(T prefab, Transform parent) where T : MonoBehaviour
		{
			return Instantiate<T>(prefab.gameObject, parent);
		}

		public static GameObject Instantiate(GameObject prefab, Transform parent, bool isWorldSpace)
		{
			return UnityEngine.Object.Instantiate(prefab, parent, isWorldSpace);
		}

		public static GameObject Instantiate(GameObject prefab, Vector3 parent, Quaternion quaternion)
		{
			return UnityEngine.Object.Instantiate(prefab, parent, quaternion);
		}

		public static void DestroyInTransform(Transform target)
		{
			foreach (Transform item in target)
			{
				UnityEngine.Object.Destroy(item.gameObject);
			}
		}

		public static void Destroy(GameObject gameObject, bool isImmediate = false)
		{
			if (gameObject == null)
			{
				return;
			}
			if (!isImmediate)
			{
				if (!Application.isPlaying)
				{
					UnityEngine.Object.DestroyImmediate(gameObject);
				}
				else
				{
					UnityEngine.Object.Destroy(gameObject);
				}
			}
			else
			{
				UnityEngine.Object.DestroyImmediate(gameObject);
			}
		}

		public static void ChangeLayer(GameObject targetObject, int layerIndex, bool includeChildren)
		{
			targetObject.layer = layerIndex;
			if (includeChildren && targetObject.transform.childCount >= 1)
			{
				ChangeLayerChildren(targetObject.transform, layerIndex);
			}
		}

		public static void ChangeLayerToMainCamera(GameObject targetObject, bool includeChildren)
		{
			ChangeLayer(targetObject, LayerID.MainCamera, includeChildren);
		}

		private static void ChangeLayerChildren(Transform targetTrans, int layerId)
		{
			if (targetTrans.childCount < 1)
			{
				return;
			}
			int num = 0;
			while (true)
			{
				Transform child = targetTrans.GetChild(num);
				child.gameObject.layer = layerId;
				if (child.childCount >= 1)
				{
					ChangeLayerChildren(child, layerId);
				}
				if (num + 1 >= targetTrans.childCount)
				{
					break;
				}
				num++;
			}
		}

		public static void ExecuteProcessRecursion<T>(Transform targetTrans, Action<T> process) where T : UnityEngine.Object
		{
			ExecuteProcessRecursionCore(targetTrans, process);
		}

		private static void ExecuteProcessRecursionCore<T>(Transform targetTrans, Action<T> process) where T : UnityEngine.Object
		{
			T component = targetTrans.GetComponent<T>();
			bool flag = component != null;
			if (process != null && flag)
			{
				process(component);
			}
			if (targetTrans.childCount < 1)
			{
				return;
			}
			int num = 0;
			while (true)
			{
				ExecuteProcessRecursionCore(targetTrans.GetChild(num), process);
				if (num + 1 >= targetTrans.childCount)
				{
					break;
				}
				num++;
			}
		}

		public static string GetHierarchyPath(Transform target)
		{
			string text = target.gameObject.name;
			Transform transform = target;
			while (true)
			{
				transform = transform.parent;
				if (!(transform != null))
				{
					break;
				}
				text = transform.name + "/" + text;
			}
			return text;
		}

		public static List<GameObject> GetAllChildren(GameObject obj)
		{
			List<GameObject> list = new List<GameObject>();
			List<GameObject> allChildren = list;
			GetAllChildren(obj, ref allChildren);
			return list;
		}

		public static void GetAllChildren(GameObject obj, ref List<GameObject> allChildren)
		{
			Transform componentInChildren = obj.GetComponentInChildren<Transform>();
			if (componentInChildren.childCount == 0)
			{
				return;
			}
			foreach (Transform item in componentInChildren)
			{
				allChildren.Add(item.gameObject);
				GetAllChildren(item.gameObject, ref allChildren);
			}
		}

		[ContractAnnotation("obj:null => true; obj:notnull => false")]
		public static bool IsNull<T>(T obj) where T : class
		{
			if (obj != null)
			{
				if (((obj is UnityEngine.Object) ? 1u : 0u) != (byte)0)
				{
					return obj as UnityEngine.Object == null;
				}
				return false;
			}
			return true;
		}
	}
}
