using UnityEngine;

namespace Sekai {

[ExecuteInEditMode]
public class SekaiAmbientLight : MonoBehaviour
{
	[SerializeField]
	private Color ambientColor = new Color(1f, 1f, 1f, 1f);

	[Range(0f, 1f)]
	[SerializeField]
	private float intensity = 1f;

	[HideInInspector]
	[SerializeField]
	[Range(0f, 1f)]
	private float glowIntensity = 1f;

	public Color AmbientColor
	{
		get
		{
			return ambientColor;
		}
		set
		{
			ambientColor = value;
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

	public float GlowIntensity
	{
		get
		{
			return glowIntensity;
		}
		set
		{
			glowIntensity = value;
		}
	}

	public void Reset()
	{
		intensity = 1f;
		glowIntensity = 1f;
		ambientColor = new Color(0.5f, 0.5f, 0.5f, 1f);
	}

	private void Update()
	{
		Shader.SetGlobalColor(Shader.PropertyToID("_SekaiAmbientLightColor"), ambientColor);
		Shader.SetGlobalFloat(value: intensity, nameID: Shader.PropertyToID("_SekaiLightIntensity"));
		Shader.SetGlobalFloat(value: glowIntensity, nameID: Shader.PropertyToID("_SekaiGlowLightIntensity"));
	}
}

}
