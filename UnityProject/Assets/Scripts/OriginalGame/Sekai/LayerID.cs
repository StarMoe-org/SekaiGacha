// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai/LayerID.cs。
using UnityEngine;

namespace Sekai
{
	public static class LayerID
	{
		public static readonly int LobbyBG = LayerMask.NameToLayer("LobbyBG");

		public static readonly int LiveMV = LayerMask.NameToLayer("LiveMV");

		public static readonly int MainCamera = LayerMask.NameToLayer("MainCamera");

		public static readonly int SubCamera = LayerMask.NameToLayer("SubCamera");

		public static readonly int EffectOverlay = LayerMask.NameToLayer("EffectOverlay");

		public static readonly int CameraProp = LayerMask.NameToLayer("CameraProp");

		public static readonly int Default = LayerMask.NameToLayer("Default");

		public static int GetMVMainCameraLayerMask()
		{
			int liveMV = LiveMV;
			return (1 << MainCamera) | (1 << liveMV) | (1 << CameraProp);
		}

		public static int GetMVSubCameraLayerMask()
		{
			int liveMV = LiveMV;
			return (1 << SubCamera) | (1 << liveMV);
		}

		public static int GetFittingRoomCameraLayerMask()
		{
			return 1 << LiveMV;
		}

		public static int GetGachaMainCameraLayerMask()
		{
			int liveMV = LiveMV;
			return (1 << MainCamera) | (1 << liveMV) | (1 << CameraProp) | (1 << Default);
		}
	}
}
