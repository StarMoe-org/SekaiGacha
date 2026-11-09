using UnityEngine;

namespace Sekai.Core
{
	[ExecuteInEditMode]
	public class SekaiGlobalSettings : MonoBehaviour
	{
		public enum GraphicsQuality
		{
			High = 500,
			Middle = 300,
			Low = 100
		}

		[SerializeField]
		private Color fogColor = default;

		[SerializeField]
		private float fogStart;

		[SerializeField]
		private float fogEnd;

		[Range(0f, 1f)]
		[HideInInspector]
		[SerializeField]
		private float intensity = 1f;

		[SerializeField]
		private GraphicsQuality quality = GraphicsQuality.Middle;

		public Color FogColor
		{
			get
			{
				return fogColor;
			}
			set
			{
				fogColor = value;
			}
		}

		public float FogStart
		{
			get
			{
				return fogStart;
			}
			set
			{
				fogStart = value;
			}
		}

		public float FogEnd
		{
			get
			{
				return fogEnd;
			}
			set
			{
				fogEnd = value;
			}
		}

		public float Intensity
		{
			get
			{
				return intensity;
			}
			set
			{
				intensity = value;
			}
		}

		public GraphicsQuality Quality
		{
			get
			{
				return quality;
			}
			set
			{
				quality = value;
			}
		}

		private void Update()
		{
			Shader.globalMaximumLOD = (int)quality;
			float num = fogStart;
			float num2 = fogEnd;
			int sEKAI_FOG_FACTOR_ID = ShaderPropertyID.SEKAI_FOG_FACTOR_ID;
			float x;
			float y;
			if (num < num2)
			{
				float num3 = fogStart;
				float num4 = fogEnd;
				x = num4 / (num4 - num3);
				y = 1f / (num4 - num3);
			}
			else
			{
				x = 1f;
				y = 0f;
			}
			Shader.SetGlobalVector(sEKAI_FOG_FACTOR_ID, new Vector4
			{
				x = x,
				y = y
			});
			Shader.SetGlobalColor(ShaderPropertyID.SEKAI_FOG_COLOR_ID, fogColor);
			Shader.SetGlobalFloat(ShaderPropertyID.SEKAI_ALL_LIGHT_INTENSITY_ID, intensity);
		}

		public void ResetFog()
		{
			fogColor = default;
			fogStart = 0f;
			fogEnd = 0f;
		}
	}
}
