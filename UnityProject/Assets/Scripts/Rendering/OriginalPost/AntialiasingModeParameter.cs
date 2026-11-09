// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/AntialiasingModeParameter.cs，适配独立 URP 工程。
using System;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Sekai.Rendering.Components
{
	[Serializable]
	public sealed class AntialiasingModeParameter : VolumeParameter<AntialiasingMode>
	{
		public AntialiasingModeParameter(AntialiasingMode value, bool overrideState = false)
			: base(value, overrideState)
		{
		}
	}
}
