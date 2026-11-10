using System.Collections.Generic;
using Sekai.Rendering;
using UnityEngine;

public class SekaiCharacterReflectionOffSettings : MonoBehaviour
{
	private static List<ISekaiCharacterReflectionOff> currentCharacterReflectionOffs = new List<ISekaiCharacterReflectionOff>();

	private static int memberCount;

	public static List<ISekaiCharacterReflectionOff> CurrentCharacterReflectionOffs => currentCharacterReflectionOffs;

	public static bool isHidingAll { get; private set; }

	public static void Clear()
	{
		isHidingAll = false;
		ClearCharacterReflection();
		ClearMemberNum();
	}

	public static void ClearCharacterReflection()
	{
		currentCharacterReflectionOffs?.Clear();
	}

	public static void SetMemberNum(int num)
	{
		memberCount = num;
	}

	public static void ClearMemberNum()
	{
		memberCount = 0;
	}

	public static void SetIsHidingAll(bool useAnyClip)
	{
		isHidingAll = useAnyClip;
	}

	public static void RegisterCharacterReflectionOff(ISekaiCharacterReflectionOff characterReflectionOff)
	{
		if (characterReflectionOff != null && characterReflectionOff.IsReflectionHiding && !currentCharacterReflectionOffs.Contains(characterReflectionOff))
		{
			currentCharacterReflectionOffs.Add(characterReflectionOff);
		}
	}

	public static void UnregisterCharacterReflectionOff(ISekaiCharacterReflectionOff characterReflectionOff)
	{
		if (characterReflectionOff != null && currentCharacterReflectionOffs.Contains(characterReflectionOff))
		{
			currentCharacterReflectionOffs.Remove(characterReflectionOff);
		}
	}

	public static bool ExistCharacterReflection()
	{
		return currentCharacterReflectionOffs.Count == memberCount;
	}
}
