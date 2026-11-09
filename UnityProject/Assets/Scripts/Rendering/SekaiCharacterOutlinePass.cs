using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Sekai.Rendering {

public class SekaiCharacterOutlinePass : ScriptableRenderPass
{
	internal static class PropertyId
	{
		public static readonly int OutlineWidthId = Shader.PropertyToID("_SekaiOutlineWidth");

		public static readonly int OutlineFactorId = Shader.PropertyToID("_SekaiOutlineFactor");
	}

	[Serializable]
	public class OutlineSettings
	{
		[Header("幅（最小）")]
		[SerializeField]
		public float outlineWidthMin;

		[SerializeField]
		[Header("幅（最大）")]
		public float outlineWidthMax;

		[SerializeField]
		[Header("変化距離（最小）")]
		public float outlineDistanceNear;

		[Header("変化距離（最小）")]
		[SerializeField]
		public float outlineDistanceFar;

		[SerializeField]
		[Header("FOV補正カーブ")]
		public AnimationCurve fovCurve;
	}

	private OutlineSettings m_Settings;

	private string m_ProfilerTag;

	public void Setup(OutlineSettings settings)
	{
		m_Settings = settings;
	}

	public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
	{
		UpdateOutline(renderingData.cameraData.camera);
	}

	private void UpdateOutline(Camera camera)
	{
		float fieldOfView = camera.fieldOfView;
		OutlineSettings settings = m_Settings;
		AnimationCurve fovCurve = settings.fovCurve;
		OutlineSettings outlineSettings;
		float num2;
		if (fovCurve != null)
		{
			float num = fovCurve.Evaluate(fieldOfView);
			OutlineSettings settings2 = m_Settings;
			if (settings2 == null)
			{
				throw new NullReferenceException();
			}
			outlineSettings = settings2;
			num2 = num;
		}
		else
		{
			outlineSettings = settings;
			num2 = fieldOfView;
		}
		float outlineWidthMin = outlineSettings.outlineWidthMin;
		float outlineWidthMax = outlineSettings.outlineWidthMax;
		float outlineDistanceNear = outlineSettings.outlineDistanceNear;
		float outlineDistanceFar = outlineSettings.outlineDistanceFar;
		Shader.SetGlobalVector(PropertyId.OutlineWidthId, new Vector4(outlineWidthMin * 0.01f, outlineWidthMax * 0.01f, 0f, 0f));
		Shader.SetGlobalVector(PropertyId.OutlineFactorId, new Vector4(outlineDistanceNear, 1f / (outlineDistanceFar - outlineDistanceNear), fieldOfView / num2, 0f));
	}
}

}
