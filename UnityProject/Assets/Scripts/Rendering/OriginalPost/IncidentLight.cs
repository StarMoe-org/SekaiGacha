// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.Components/IncidentLight.cs，适配独立 URP 工程。
using System;
using UnityEngine;
using UnityEngine.Rendering;

namespace Sekai.Rendering.Components
{
	[Serializable]
	[VolumeComponentMenu("Sekai/Legacy/IncidentLight")]
	public class IncidentLight : SekaiVolumeComponent
	{
		public BoolParameter incidentLightUse = new BoolParameter(value: true);

		public IntParameter incidentLightAddBlend = new IntParameter(0);

		public ColorParameter incidentLightColor = new ColorParameter(new Color
		{
			a = 1f
		});

		public Vector2Parameter incidentLightPosition = new Vector2Parameter(Vector2.zero);

		public FloatParameter incidentLightLength = new FloatParameter(0f);

		public override bool IsActive()
		{
			return isActive = IsValidLight();
		}

		public bool IsValidLight()
		{
			if (incidentLightUse.value)
			{
				return incidentLightLength.value > 0f;
			}
			return false;
		}
	}
}
