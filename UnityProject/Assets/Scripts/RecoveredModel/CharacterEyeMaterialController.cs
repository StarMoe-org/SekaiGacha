// 源自恢复工程 Sekai.Scripts.Live.Character/CharacterEyeMaterialController.cs，仅保留初始化调用链。
using System.Collections.Generic;
using UnityEngine;
using Sekai.Core;
namespace Sekai.Scripts.Live.Character {
public class CharacterEyeMaterialController : MonoBehaviour {
 private class MaterialIndexTable { public int Highlight = -1; public int Base = -1; }
 private static readonly Dictionary<int, CharacterEyeMaterialController> _materialControllers = new Dictionary<int, CharacterEyeMaterialController>();
 private Material _eyeBaseMaterial;
 private SkinnedMeshRenderer skinnedMeshRenderer;
 private MaterialIndexTable materialIndexTable;
public static void Create(CharacterModel characterModel)
		{
			int gameObjectHashCode = characterModel.GameObjectHashCode;
			GameObject face = characterModel.Face;
			if (face != null)
			{
				CharacterEyeMaterialController characterEyeMaterialController = face.GetComponent<CharacterEyeMaterialController>();
				if ((object)characterEyeMaterialController == null)
				{
					characterEyeMaterialController = face.AddComponent<CharacterEyeMaterialController>();
				}
				characterEyeMaterialController.hideFlags = HideFlags.DontSave;
				characterEyeMaterialController.skinnedMeshRenderer = face.GetComponent<SkinnedMeshRenderer>();
				characterEyeMaterialController.CreateMaterialIndexTable();
				if (_materialControllers.ContainsKey(gameObjectHashCode))
				{
					bool flag = _materialControllers[gameObjectHashCode] == null;
				}
				_materialControllers[gameObjectHashCode] = characterEyeMaterialController;
			}
		}
private void CreateMaterialIndexTable()
		{
			materialIndexTable = new MaterialIndexTable();
			Material[] sharedMaterials = skinnedMeshRenderer.sharedMaterials;
			int num = sharedMaterials.Length;
			if (num >= 1)
			{
				long num2 = 0L;
				int num3 = 0;
				while (true)
				{
					string text = sharedMaterials[(nint)num2].name;
					if (text.Contains("_ehl_"))
					{
						materialIndexTable.Highlight = num3;
					}
					if (text.Contains("_eye_"))
					{
						materialIndexTable.Base = num3;
					}
					num = sharedMaterials.Length;
					if (num3 + 1 >= num)
					{
						break;
					}
					num2 = (uint)(num3 + 1);
					num3++;
				}
			}
			int num4 = materialIndexTable.Base;
			if ((uint)num4 >> 31 << 31 == 0 && num4 < num)
			{
				_eyeBaseMaterial = sharedMaterials[num4];
			}
		}
}
}
