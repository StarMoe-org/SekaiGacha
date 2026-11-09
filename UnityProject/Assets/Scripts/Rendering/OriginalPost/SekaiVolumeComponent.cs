// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/SekaiVolumeComponent.cs，适配独立 URP 工程。
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components
{
	public class SekaiVolumeComponent : VolumeComponent
	{
		protected bool isActive;

		public virtual bool IsActive()
		{
			return isActive;
		}
	}
}
