// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/LegacyDof.cs，适配独立 URP 工程。
using System;
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components
{
	[Serializable]
	[VolumeComponentMenu("Sekai/Legacy/LegacyDof")]
	public class LegacyDof : VolumeComponent
	{
		private BoolParameter enable = new BoolParameter(value: false);

		public void SetActive(bool isActive)
		{
			enable.value = isActive;
		}

		public bool IsActive()
		{
			return enable.value;
		}
	}
}
