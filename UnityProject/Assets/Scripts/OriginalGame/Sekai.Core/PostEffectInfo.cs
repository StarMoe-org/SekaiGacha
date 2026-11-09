// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core/PostEffectInfo.cs。
using System;
using UnityEngine;

namespace Sekai.Core
{
	[Serializable]
	public struct PostEffectInfo
	{
		[HideInInspector]
		[SerializeField]
		private bool enableMeshFlarePara;

		[HideInInspector]
		[SerializeField]
		public SaturationBlurType SaturationBlurType;

		public bool EnableMeshFlarePara => enableMeshFlarePara;

		public PostEffectInfo(bool enableMeshFlarePara, SaturationBlurType saturationBlurType)
		{
			this.enableMeshFlarePara = enableMeshFlarePara;
			SaturationBlurType = saturationBlurType;
		}
	}
}
