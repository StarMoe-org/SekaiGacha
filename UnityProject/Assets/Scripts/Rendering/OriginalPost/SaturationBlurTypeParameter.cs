// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/SaturationBlurTypeParameter.cs，适配独立 URP 工程。
using System;
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components
{
	[Serializable]
	public sealed class SaturationBlurTypeParameter : VolumeParameter<SaturationBlurVolumeType>
	{
		public override SaturationBlurVolumeType value
		{
			get
			{
				return m_Value;
			}
			set
			{
				m_Value = value;
			}
		}

		public SaturationBlurTypeParameter(SaturationBlurVolumeType value, bool overrideStage = false)
			: base(value, overrideStage)
		{
		}
	}
}
