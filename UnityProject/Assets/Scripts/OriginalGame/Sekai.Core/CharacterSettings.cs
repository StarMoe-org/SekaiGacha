// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core/CharacterSettings.cs。
using System;
using UnityEngine;

namespace Sekai.Core
{
	[CreateAssetMenu]
	public class CharacterSettings : ScriptableObject
	{
		[Serializable]
		public class BlendShapeData
		{
			[SerializeField]
			private string deformerName = "BS_eye";

			[SerializeField]
			private string targetShapeName = "eye_close";

			public string DeformerName => deformerName;

			public string TargetShapeName => targetShapeName;

			public BlendShapeData(string deformerName, string targetShapeName)
			{
				this.deformerName = deformerName;
				this.targetShapeName = targetShapeName;
			}
		}

		[SerializeField]
		private BlendShapeData[] leftCloseEyeBlendShapes;

		[SerializeField]
		private BlendShapeData[] rightCloseEyeBlendShapes;

		public BlendShapeData[] LeftCloseEyeBlendShapeNames => leftCloseEyeBlendShapes;

		public BlendShapeData[] RightCloseEyeBlendShapeNames => rightCloseEyeBlendShapes;

		public CharacterSettings()
		{
			BlendShapeData[] array = new BlendShapeData[2];
			BlendShapeData blendShapeData = new BlendShapeData("BS_eye", "eye_close");
			if (blendShapeData == null || blendShapeData is BlendShapeData)
			{
				array[0] = blendShapeData;
				BlendShapeData blendShapeData2 = new BlendShapeData("BS_eye", "eye_wink_L");
				if (blendShapeData2 != null && !(blendShapeData2 is BlendShapeData))
				{
					throw new ArrayTypeMismatchException();
				}
				array[1] = blendShapeData2;
				leftCloseEyeBlendShapes = array;
				BlendShapeData[] array2 = new BlendShapeData[2];
				BlendShapeData blendShapeData3 = new BlendShapeData("BS_eye", "eye_close");
				if (blendShapeData3 != null && !(blendShapeData3 is BlendShapeData))
				{
					throw new ArrayTypeMismatchException();
				}
				array2[0] = blendShapeData3;
				BlendShapeData blendShapeData4 = new BlendShapeData("BS_eye", "eye_wink_R");
				if (blendShapeData4 != null)
				{
					if (!(blendShapeData4 is BlendShapeData))
					{
						throw new ArrayTypeMismatchException();
					}
					array2[1] = blendShapeData4;
					rightCloseEyeBlendShapes = array2;
				}
				else
				{
					array2[1] = blendShapeData4;
					rightCloseEyeBlendShapes = array2;
				}
				return;
			}
			throw new ArrayTypeMismatchException();
		}
	}
}
