// 源自恢复工程 ThirdParty.SpringBone/UTJ.GameObjectExtensions/GameObjectUtil.cs。
using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace UTJ.GameObjectExtensions
{
	public static class GameObjectUtil
	{
		public enum SearchOptions
		{
			None,
			IgnoreNamespace
		}

		public static IEnumerable<T> FindComponentsOfType<T>() where T : Component
		{
			GameObject[] rootGameObjects = SceneManager.GetActiveScene().GetRootGameObjects();
			List<T> list = new List<T>();
			if (rootGameObjects.Length >= 1)
			{
				long num = 0L;
				int num2 = 0;
				while (true)
				{
					list.AddRange(rootGameObjects[(nint)num].GetComponentsInChildren<T>(includeInactive: true));
					if (num2 + 1 >= rootGameObjects.Length)
					{
						break;
					}
					num = (uint)(num2 + 1);
					num2++;
				}
				return list;
			}
			return list;
		}

		public static IEnumerable<GameObject> GetAllGameObjects()
		{
			return from item in FindComponentsOfType<Transform>()
				select item.gameObject;
		}

		public static Dictionary<string, T> BuildNameToComponentMap<T>(this GameObject rootObject, bool includeInactive) where T : Component
		{
			T[] componentsInChildren = rootObject.GetComponentsInChildren<T>(includeInactive);
			if (componentsInChildren == null)
			{
				throw new NullReferenceException();
			}
			Dictionary<string, T> dictionary = new Dictionary<string, T>(componentsInChildren.Length);
			if (componentsInChildren.Length >= 1)
			{
				long num = 0L;
				int num2 = 0;
				while (true)
				{
					T value = componentsInChildren[(nint)num];
					dictionary[value.name] = value;
					if (num2 + 1 >= componentsInChildren.Length)
					{
						break;
					}
					num++;
					num2++;
				}
				return dictionary;
			}
			return dictionary;
		}

		public static IEnumerable<Transform> GetAllBones(this GameObject rootObject)
		{
			SkinnedMeshRenderer[] componentsInChildren = rootObject.GetComponentsInChildren<SkinnedMeshRenderer>(includeInactive: true);
			HashSet<Transform> hashSet = new HashSet<Transform>();
			if (componentsInChildren.Length >= 1)
			{
				long num = 0L;
				int num2 = 0;
				while (true)
				{
					Transform[] bones = componentsInChildren[(nint)num].bones;
					int num3 = bones.Length;
					if (num3 >= 1)
					{
						long num4 = 0L;
						uint num5 = (uint)num3;
						while (true)
						{
							if ((uint)num4 >= num5)
							{
								throw new IndexOutOfRangeException();
							}
							if (hashSet == null)
							{
								throw new NullReferenceException();
							}
							bool flag = hashSet.Add(bones[(nint)num4]);
							int num6 = bones.Length;
							if (num4 + 1L >= num6)
							{
								break;
							}
							num4++;
							num5 = (uint)num6;
						}
					}
					if (num2 + 1 >= componentsInChildren.Length)
					{
						break;
					}
					num = (uint)(num2 + 1);
					num2++;
				}
				return hashSet;
			}
			return hashSet;
		}

		public static Transform FindChildByName(this GameObject inRoot, string inName, SearchOptions searchOptions = SearchOptions.IgnoreNamespace)
		{
			return inRoot.FindChildComponentByName<Transform>(inName, searchOptions);
		}

		public static T FindChildComponentByName<T>(this GameObject inRoot, string inName, SearchOptions searchOptions = SearchOptions.IgnoreNamespace) where T : Component
		{
			string text = inName.ToLowerInvariant();
			if (searchOptions == SearchOptions.IgnoreNamespace)
			{
				text = RemoveNamespaceFromName(text);
			}
			T[] componentsInChildren = inRoot.GetComponentsInChildren<T>();
			int num = componentsInChildren.Length;
			T result;
			if (num >= 1)
			{
				if (num == 0)
				{
					throw new IndexOutOfRangeException();
				}
				long num2 = 0L;
				int num3 = 0;
				while (true)
				{
					result = componentsInChildren[(nint)num2];
					string text2 = result.gameObject.name.ToLowerInvariant();
					if (searchOptions == SearchOptions.IgnoreNamespace)
					{
						text2 = RemoveNamespaceFromName(text2);
					}
					if (text2 == text)
					{
						break;
					}
					if (num + -1 == num3)
					{
						result = null;
						break;
					}
					if ((uint)(num3 + 1) >= (uint)componentsInChildren.Length)
					{
						throw new IndexOutOfRangeException();
					}
					num2 = (uint)(num3 + 1);
					num3++;
				}
			}
			else
			{
				result = null;
			}
			return result;
		}

		public static T[] FindChildComponentsByName<T>(this GameObject inRoot, string[] inNames, SearchOptions searchOptions = SearchOptions.IgnoreNamespace) where T : Component
		{
			T[] componentsInChildren = inRoot.GetComponentsInChildren<T>();
			List<T> list = new List<T>();
			int num = componentsInChildren.Length;
			if (num >= 1)
			{
				long num2 = 0L;
				int num3 = 0;
				while (true)
				{
					T item = componentsInChildren[(nint)num2];
					string childName = item.gameObject.name.ToLowerInvariant();
					if (searchOptions == SearchOptions.IgnoreNamespace)
					{
						childName = RemoveNamespaceFromName(childName);
						if (Array.Exists(inNames, (string searchName) => RemoveNamespaceFromName(searchName.ToLowerInvariant()) == childName))
						{
							list.Add(item);
						}
					}
					else if (Array.Exists(inNames, (string searchName) => searchName.ToLowerInvariant() == childName))
					{
						list.Add(item);
					}
					if (num == num3 + 1)
					{
						break;
					}
					num2 = (uint)(num3 + 1);
					num3++;
				}
				return list.ToArray();
			}
			return list.ToArray();
		}

		public static string RemoveNamespaceFromName(string inName)
		{
			string[] array = inName.Split(new char[1] { ':' }, StringSplitOptions.None);
			int num = array.Length;
			if (num != 0)
			{
				if (num == 0)
				{
					throw new IndexOutOfRangeException();
				}
				return array[num + -1];
			}
			return "";
		}

		public static int GetTransformDepth(Transform inObject)
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

		public static string GetUniqueName(string desiredName)
		{
			IEnumerable<string> source = from item in FindComponentsOfType<Transform>()
				select item.name;
			string text;
			if (source.Contains(desiredName))
			{
				int num = 1;
				while (true)
				{
					text = desiredName + "_" + num;
					if (!source.Contains(text))
					{
						break;
					}
					if (num + 1 < 10001)
					{
						num++;
						continue;
					}
					Debug.LogError("Too many similar names exist: " + desiredName);
					break;
				}
			}
			else
			{
				text = desiredName;
			}
			return text;
		}
	}
}
