// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/LutBehaviour.cs。
using System;
using UnityEngine;
using UnityEngine.Playables;

namespace Sekai.Core.Live
{
	[Serializable]
	public class LutBehaviour : PlayableBehaviour
	{
		public Texture3D texture3D;

		public bool isWholeLut = true;

		public Vector2 lutPosition;

		public Vector2 nonLutPosition;
	}
}
