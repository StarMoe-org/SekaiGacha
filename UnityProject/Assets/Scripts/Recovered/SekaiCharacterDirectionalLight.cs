using UnityEngine;

namespace Sekai {

[ExecuteAlways]
public class SekaiCharacterDirectionalLight : MonoBehaviour
{
	public enum FadeMode
	{
		FadeOut,
		Spread
	}

	private const string GROUP_NAME_CHARACTER_FACE_SHADOW = "■ 顔影";

	[SerializeField]

	private bool useFaceShadowLimiter = true;


	[Range(0f, 1f)]
	[SerializeField]
	private float faceShadowLimitRange;

	private const string GROUP_NAME_CHARACTER_SHADOW_WEIGHT = "■ 影色調整";

	[Range(0f, 1f)]

	[SerializeField]

	private float shadowTexWeight;

	private const string GROUP_NAME_CHARACTER_SHADOW_FADE = "■ 影フェード";

	[SerializeField]

	private bool useShadowFade;

	[SerializeField]

	private FadeMode fade = FadeMode.Spread;

	[Range(0f, 1f)]


	[SerializeField]
	private float shadowWidth;

	private const string GROUP_NAME_CHARACTER_HSVC = "■ 色調";

	[SerializeField]


	private bool useHsvControl;

	[Range(0f, 1f)]
	[SerializeField]

	private float hue;

	[Range(0f, 1f)]
	[SerializeField]

	private float saturation = 0.5f;

	[SerializeField]

	[Range(0f, 1f)]
	private float value = 0.5f;

	[Range(0f, 1f)]

	[SerializeField]

	private float contrast = 0.5f;

	public bool UseFaceShadowLimiter => useFaceShadowLimiter;

	public float FaceShadowLimitRange => faceShadowLimitRange;

	public float ShadowTexWeight => shadowTexWeight;

	public bool UseShadowFade => useShadowFade;

	public FadeMode Fade => fade;

	public float ShadowWidth => shadowWidth;

	public bool UseHsvControl => useHsvControl;

	public float Hue => hue;

	public float Saturation => saturation;

	public float Value => value;

	public float Contrast => contrast;

	public void Initialize()
	{
		useShadowFade = false;
		shadowWidth = 0f;
		useHsvControl = false;
		useFaceShadowLimiter = true;
		faceShadowLimitRange = 0f;
		shadowTexWeight = 1f;
		hue = 0f;
		saturation = 0.5f;
		value = 0.5f;
		contrast = 0.5f;
	}

	public void UpdateDatas()
	{
	}
}

}
