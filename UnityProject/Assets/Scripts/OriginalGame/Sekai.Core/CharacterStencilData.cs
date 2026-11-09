// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core/CharacterStencilData.cs。
using UnityEngine.Rendering;

namespace Sekai.Core
{
	public struct CharacterStencilData
	{
		public uint StencilRef;

		public uint ReadMask;

		public uint WriteMask;

		public CompareFunction Comp;

		public StencilOp Pass;

		public StencilOp Fail;

		public StencilOp ZFail;
	}
}
