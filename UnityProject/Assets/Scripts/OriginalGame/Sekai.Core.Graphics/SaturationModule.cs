// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Graphics/SaturationModule.cs。
using System;
using UnityEngine;

namespace Sekai.Core.Graphics
{
	[Serializable]
	public struct SaturationModule : IModule
	{
		public bool active;

		[Range(0f, 2f)]
		public float saturation;

		public SaturationModule(bool active = false)
		{
			this.active = active;
			saturation = 1f;
		}
	}
}
