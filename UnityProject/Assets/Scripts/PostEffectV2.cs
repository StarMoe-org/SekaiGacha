// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Graphics/PostEffectV2.cs。
using System;
using Sekai.Core.Live;
using Sekai.Rendering;
using Sekai.Rendering.Components;
using Sekai.Rendering.Components.PostProcessV2;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Sekai.Core.Graphics
{
	[ExecuteAlways]
	public class PostEffectV2 : MonoBehaviour, IPostEffect, ILutEffect
	{
		private class VignetteCache
		{
			public Color color;

			public float centerX;

			public float centerY;

			public float intensity;

			public float smoothness;

			public float roundness;
		}

		private class ScreenDistortionCache
		{
			public float amount;

			public float scale;

			public float offset;

			public bool useNoiseTexture;

			public Vector2 noiseTextureScale;

			public Vector2 noiseUVScrollSpeed;

			public float time;
		}

		private static readonly float FOCUS_DISTANCE = 10f;

		private static readonly float TRANSITION_RANGE = 5f;

		private static readonly float FOCAL_REGION = 2f;

		private static readonly float APERTURE = 32f;

		private static readonly float FOCAL_LENGTH = 0f;

		private static readonly bool DISABLE_FORE_BOKEH = false;

		private static readonly float INTENSITY = 0.05f;

		private static readonly float SCATTER = 2f;

		private static readonly bool NEW_BLOOM_BLEND = false;

		private static readonly Color BRIGHT_COLOR = new Color
		{
			r = 0.5f,
			g = 0.5f,
			b = 0.5f,
			a = 1f
		};

		private static readonly Color DARK_COLOR = new Color
		{
			r = 0.5f,
			g = 0.5f,
			b = 0.5f,
			a = 1f
		};

		private static readonly Vector2 BRIGHT_POSITION = Vector2.zero;

		private static readonly Vector2 DARK_POSITION = Vector2.zero;

		private static readonly int INCIDENT_LIGHT_TYPE = 0;

		private static readonly bool IS_INCIDENT_LIGHT2_USE = false;

		private static readonly bool IS_INCIDENT_LIGHT3_USE = false;

		private static readonly Color INCIDENT_LIGHT_COLOR = new Color
		{
			a = 1f
		};

		private static readonly Vector2 INCIDENT_LIGHT_POSITION = Vector2.zero;

		private static readonly float INCIDENT_LIGHT_LENGTH = 0f;

		private static readonly float SAT = 1f;

		private static readonly float SAT_ALPHA = 0f;

		private static readonly int DIRECTIONAL_BLUR_PARAM_TYPE = 0;

		private static readonly float DIRECTIONAL_BLUR_STRENGTH = 0f;

		private static readonly float DIRECTIONAL_BLUR_DIRECTION = 0f;

		private static readonly float RADIAL_BLUR_STRENGTH = 0f;

		private static readonly Vector2 RADIAL_BLUR_CENTER_POSITION = Vector2.zero;

		private static readonly bool SAT_MODULE_ACTIVE = false;

		private static readonly float SAT_MODULE_SATURATION = 1f;

		private static readonly float SOLARIZATION = 0f;

		private static readonly float FADEOUT_BASE = 0.5f;

		private static readonly int CHROMATIC_ABERRATION_PARAM_TYPE = 0;

		private static readonly Vector2 CHROMATIC_ABERRATION_OFFSET = Vector2.zero;

		private static readonly Vector3 CHROMATIC_ABERRATION_SCALE = Vector3.zero;

		private static readonly Vector2 MAIN_CAMERA_UV_SCROLL_OFFSET;

		private static readonly MainCameraUvScrollWrapMode MAIN_CAMERA_UV_SCROLL_WRAP_MODE;

		private static readonly bool MAIN_CAMERA_UV_SCROLL_APPLY_TO_SCREEN_POS;

		[SerializeField]
		private Transform parameterTransform;

		[SerializeField]
		private RenderingQuality quality;

		private bool enableSekaiDof = true;

		private float focusDistance;

		private float transitionRange;

		private float focalRegion;

		private float aperture;

		private float focalLength;

		private bool disableForeBokeh;

		private float intensity;

		private float scatter;

		private bool newBloomBlend;

		private Color brightColor;

		private Color darkColor;

		private Vector2 brightPosition;

		private Vector2 darkPosition;

		private int incidentLightType;

		private Color incidentLightColor;

		private Vector2 incidentLightPosition;

		private float incidentLightLength;

		private float sat;

		private float satAlpha;

		private SaturationModule saturationModule;

		private int directionalBlurParamType;

		private float directionalBlurStrength;

		private float directionalBlurDirection;

		private Vector2 radialBlurCenterPosition;

		private float solarization;

		private Vector2 mainCameraUvScrollOffset;

		private MainCameraUvScrollWrapMode mainCameraUvScrollWrapMode;

		private bool mainCameraUvScrollApplyToScreenPos;

		private float fadeOut;

		private float fadeOutLerp;

		private float fadeOutBeforeProp;

		private float fadeOutBeforePropLerp;

		private Texture3D frontLut;

		private Texture3D backLut;

		private float frontLutBlend;

		private float backLutBlend;

		private Vector2 frontLutPoint;

		private Vector2 frontNonLutPoint;

		private Vector2 backLutPoint;

		private Vector2 backNonLutPoint;

		private int chromaticAberrationParamType;

		private Vector2 chromaticAberrationOffsetR;

		private Vector2 chromaticAberrationOffsetG;

		private Vector2 chromaticAberrationOffsetB;

		private Vector3 chromaticAberrationScaleRgb;

		private AntialiasingMode antialiasingMode;

		private SekaiVolume volume;

		private readonly VignetteCache vignetteCache;

		private readonly ScreenDistortionCache screenDistortionCache;

		public RenderingQuality Quality
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

		public Camera currentCamera { get; private set; }

		public int CullingMask
		{
			get
			{
				if (currentCamera != null)
				{
					return currentCamera.cullingMask;
				}
				return 65535;
			}
		}

		private void Awake()
		{
			currentCamera = GetComponent<Camera>();
		}

		private void OnDestroy()
		{
			volume?.Dispose();
		}

		public void Setup(PostEffectInfo postEffectInfo = default(PostEffectInfo), RenderingQuality quality = RenderingQuality.High)
		{
			SekaiVolume sekaiVolume = volume;
			this.quality = quality;
			sekaiVolume.SetupVolume(gameObject, "LegacyMV");
			volume.SaturationBlur.saturationBlurType.value = (SaturationBlurVolumeType)postEffectInfo.SaturationBlurType;
		}

		public void Reset()
		{
			float fOCUS_DISTANCE = FOCUS_DISTANCE;
			float tRANSITION_RANGE = TRANSITION_RANGE;
			float fOCAL_REGION = FOCAL_REGION;
			float aPERTURE = APERTURE;
			focusDistance = fOCUS_DISTANCE;
			transitionRange = tRANSITION_RANGE;
			focalRegion = fOCAL_REGION;
			aperture = aPERTURE;
			focalLength = FOCAL_LENGTH;
			float iNTENSITY = INTENSITY;
			float sCATTER = SCATTER;
			intensity = iNTENSITY;
			scatter = sCATTER;
			brightColor = BRIGHT_COLOR;
			darkColor = DARK_COLOR;
			brightPosition = BRIGHT_POSITION;
			darkPosition = DARK_POSITION;
			incidentLightColor = INCIDENT_LIGHT_COLOR;
			incidentLightPosition = INCIDENT_LIGHT_POSITION;
			float iNCIDENT_LIGHT_LENGTH = INCIDENT_LIGHT_LENGTH;
			float sAT = SAT;
			incidentLightLength = iNCIDENT_LIGHT_LENGTH;
			sat = sAT;
			satAlpha = SAT_ALPHA;
			directionalBlurParamType = DIRECTIONAL_BLUR_PARAM_TYPE;
			float dIRECTIONAL_BLUR_STRENGTH = DIRECTIONAL_BLUR_STRENGTH;
			float dIRECTIONAL_BLUR_DIRECTION = DIRECTIONAL_BLUR_DIRECTION;
			directionalBlurStrength = dIRECTIONAL_BLUR_STRENGTH;
			directionalBlurDirection = dIRECTIONAL_BLUR_DIRECTION;
			radialBlurCenterPosition = RADIAL_BLUR_CENTER_POSITION;
			fadeOutBeforePropLerp = (fadeOutBeforeProp = (fadeOutLerp = (fadeOut = FADEOUT_BASE)));
			chromaticAberrationOffsetR = CHROMATIC_ABERRATION_OFFSET;
			chromaticAberrationOffsetG = CHROMATIC_ABERRATION_OFFSET;
			chromaticAberrationOffsetB = CHROMATIC_ABERRATION_OFFSET;
			ResetMainCameraUvScroll();
			if (parameterTransform != null)
			{
				Transform transform = parameterTransform;
				float y = Vector3.forward.y;
				float z = Vector3.forward.z;
				float x = Vector3.forward.x;
				transform.localPosition = new Vector3
				{
					x = x * 0.5f,
					y = y * 0.5f,
					z = z * 0.5f
				};
				Transform transform2 = parameterTransform;
				float num = focusDistance;
				float y2 = Vector3.right.y;
				float z2 = Vector3.right.z;
				float x2 = Vector3.right.x;
				transform2.localScale = new Vector3
				{
					x = num * x2,
					y = num * y2,
					z = num * z2
				};
			}
			if (volume.SekaiDof.IsActive())
			{
				ApplySekaiDoF();
			}
		}

		public void ApplySekaiDoF()
		{
			volume.SekaiDof.focusDistance.value = focusDistance;
			volume.SekaiDof.aperture.value = aperture;
			volume.SekaiDof.focalLength.value = focalLength;
			float value = volume.SekaiDof.focalLength.value;
			float value2 = volume.SekaiDof.focalLength.value;
			float value3 = volume.SekaiDof.aperture.value;
			float value4 = volume.SekaiDof.focusDistance.value;
			Shader.SetGlobalVector(ShaderPropertyID.CoCParams, new Vector4
			{
				x = value4,
				y = value / 1000f * (value2 / value3) / (value4 - value / 1000f)
			});
		}

		private void LateUpdate()
		{
			if (parameterTransform != null)
			{
				Vector3 localPosition = parameterTransform.localPosition;
				currentCamera.fieldOfView = SekaiCameraAspect.CalculateVerticalFov(localPosition.z * 100f);
				focusDistance = parameterTransform.localScale.x;
			}
			RenderingQuality renderingQuality = quality;
			currentCamera.enabled = renderingQuality == RenderingQuality.High || (Time.frameCount & 1) == 0;
			volume.LightOverlay.darkColor.value = darkColor;
			volume.LightOverlay.brightColor.value = brightColor;
			volume.LightOverlay.darkPosition.value = darkPosition;
			volume.LightOverlay.brightPosition.value = brightPosition;
			volume.IncidentLight.incidentLightAddBlend.value = incidentLightType;
			volume.IncidentLight.incidentLightColor.value = incidentLightColor;
			volume.IncidentLight.incidentLightPosition.value = incidentLightPosition;
			volume.IncidentLight.incidentLightLength.value = incidentLightLength;
			volume.SaturationBlur.saturation.value = sat;
			volume.SaturationBlur.alpha.value = satAlpha;
			volume.Saturation.saturation.value = saturationModule.saturation;
			volume.DirectionalBlur.blurType.value = directionalBlurParamType;
			volume.DirectionalBlur.blurStrength.value = directionalBlurStrength;
			volume.DirectionalBlur.blurDirection.value = directionalBlurDirection;
			volume.DirectionalBlur.blurCenterPosition.value = radialBlurCenterPosition;
			volume.Solarisation.solarisation.value = solarization;
			float x = mainCameraUvScrollOffset.x;
			float y = mainCameraUvScrollOffset.y;
			Shader.SetGlobalVector(ShaderPropertyID.MAIN_CAMERA_UV_SCROLL_OFFSET_ID, new Vector4
			{
				x = x,
				y = y
			});
			Shader.SetGlobalInt(ShaderPropertyID.MAIN_CAMERA_UV_SCROLL_WRAP_MODE_ID, (int)mainCameraUvScrollWrapMode);
			Shader.SetGlobalInt(ShaderPropertyID.MAIN_CAMERA_UV_SCROLL_APPLY_TO_SCREEN_POS_ID, mainCameraUvScrollApplyToScreenPos ? 1 : 0);
			volume.FadeOut.fadeOut.value = fadeOut;
			volume.FadeOut.fadeOutLerp.value = fadeOutLerp;
			volume.FadeOutBeforeProp.fadeOutBeforeProp.value = fadeOutBeforeProp;
			volume.FadeOutBeforeProp.fadeOutBeforePropLerp.value = fadeOutBeforePropLerp;
			volume.Lut.frontTex.value = frontLut;
			volume.Lut.frontBlend.value = frontLutBlend;
			volume.Lut.frontPoint.value = frontLutPoint;
			volume.Lut.frontNonPoint.value = frontNonLutPoint;
			volume.Lut.backTex.value = backLut;
			volume.Lut.backBlend.value = backLutBlend;
			volume.Lut.backPoint.value = backLutPoint;
			volume.Lut.backNonPoint.value = backNonLutPoint;
			volume.Bloom.intensity.value = intensity;
			volume.Bloom.scatter.value = scatter;
			volume.Bloom.useNewBlend.value = newBloomBlend;
			volume.Antialiasing.mode.value = antialiasingMode;
			Sekai.Rendering.Components.PostProcessV2.Vignette vignette = volume.Vignette;
			VignetteCache vignetteCache = this.vignetteCache;
			vignette.color.value = vignetteCache.color;
			Sekai.Rendering.Components.PostProcessV2.Vignette vignette2 = volume.Vignette;
			VignetteCache vignetteCache2 = this.vignetteCache;
			Vector2Parameter center = vignette2.center;
			float centerX = vignetteCache2.centerX;
			float centerY = vignetteCache2.centerY;
			center.value = new Vector2
			{
				x = centerX,
				y = centerY
			};
			Sekai.Rendering.Components.PostProcessV2.Vignette vignette3 = volume.Vignette;
			VignetteCache vignetteCache3 = this.vignetteCache;
			vignette3.intensity.value = vignetteCache3.intensity;
			Sekai.Rendering.Components.PostProcessV2.Vignette vignette4 = volume.Vignette;
			VignetteCache vignetteCache4 = this.vignetteCache;
			vignette4.smoothness.value = vignetteCache4.smoothness;
			Sekai.Rendering.Components.PostProcessV2.Vignette vignette5 = volume.Vignette;
			VignetteCache vignetteCache5 = this.vignetteCache;
			vignette5.roundness.value = vignetteCache5.roundness;
			if (volume.ScreenDistortion != null)
			{
				ScreenDistortion screenDistortion = volume.ScreenDistortion;
				ScreenDistortionCache screenDistortionCache = this.screenDistortionCache;
				screenDistortion.IntensityAmount.value = screenDistortionCache.amount;
				ScreenDistortion screenDistortion2 = volume.ScreenDistortion;
				ScreenDistortionCache screenDistortionCache2 = this.screenDistortionCache;
				screenDistortion2.ScaleAmount.value = screenDistortionCache2.scale;
				ScreenDistortion screenDistortion3 = volume.ScreenDistortion;
				ScreenDistortionCache screenDistortionCache3 = this.screenDistortionCache;
				screenDistortion3.OffsetAmount.value = screenDistortionCache3.offset;
				ScreenDistortion screenDistortion4 = volume.ScreenDistortion;
				ScreenDistortionCache screenDistortionCache4 = this.screenDistortionCache;
				screenDistortion4.UseNoise.value = screenDistortionCache4.useNoiseTexture;
				ScreenDistortion screenDistortion5 = volume.ScreenDistortion;
				ScreenDistortionCache screenDistortionCache5 = this.screenDistortionCache;
				screenDistortion5.NoiseScale.value = screenDistortionCache5.noiseTextureScale;
				ScreenDistortion screenDistortion6 = volume.ScreenDistortion;
				ScreenDistortionCache screenDistortionCache6 = this.screenDistortionCache;
				screenDistortion6.NoiseScrollSpeed.value = screenDistortionCache6.noiseUVScrollSpeed;
				ScreenDistortion screenDistortion7 = volume.ScreenDistortion;
				ScreenDistortionCache screenDistortionCache7 = this.screenDistortionCache;
				screenDistortion7.Time.value = screenDistortionCache7.time;
			}
			float value = volume.SekaiDof.focusDistance.value;
			float value2 = volume.SekaiDof.aperture.value;
			float value3 = volume.SekaiDof.focalLength.value;
			volume.SekaiDof.focusDistance.value = focusDistance;
			volume.SekaiDof.aperture.value = aperture;
			volume.SekaiDof.focalLength.value = focalLength;
			volume.SekaiDof.disableForeBokeh.value = disableForeBokeh;
			if (volume.SekaiDof.IsActive())
			{
				float value4 = volume.SekaiDof.focusDistance.value;
				float epsilon = Mathf.Epsilon;
				if (!(Math.Abs(value4 - value) > epsilon))
				{
					float value5 = volume.SekaiDof.aperture.value;
					float epsilon2 = Mathf.Epsilon;
					if (Math.Abs(value5 - value2) > epsilon2)
					{
						ApplySekaiDoF();
					}
					else
					{
						float value6 = volume.SekaiDof.focalLength.value;
						float epsilon3 = Mathf.Epsilon;
						if (Math.Abs(value6 - value3) > epsilon3)
						{
							ApplySekaiDoF();
						}
					}
				}
				else
				{
					ApplySekaiDoF();
				}
			}
			volume.ChromaticAberration.ChromaticAberrationMode.value = chromaticAberrationParamType;
			volume.ChromaticAberration.OffsetR.value = chromaticAberrationOffsetR;
			volume.ChromaticAberration.OffsetG.value = chromaticAberrationOffsetG;
			volume.ChromaticAberration.OffsetB.value = chromaticAberrationOffsetB;
			volume.ChromaticAberration.ScaleR.value = chromaticAberrationScaleRgb.x;
			volume.ChromaticAberration.ScaleG.value = chromaticAberrationScaleRgb.y;
			volume.ChromaticAberration.ScaleB.value = chromaticAberrationScaleRgb.z;
		}

		public void SetTransitionRange(float transitionRange)
		{
			float num4;
			if (!(transitionRange < 0.1f))
			{
				float num = 100f;
				uint num2 = (uint)BitConverter.SingleToInt32Bits(transitionRange);
				uint num3 = (uint)BitConverter.SingleToInt32Bits(num);
				num4 = ((transitionRange == num) ? BitConverter.Int32BitsToSingle((int)(num2 | num3)) : (((num2 & 0x7FFFFFFF) > 2139095040 && (num2 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040 && (num3 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : (((num2 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : ((!(transitionRange < num)) ? num : transitionRange))))));
			}
			else
			{
				num4 = 0.1f;
			}
			this.transitionRange = num4;
		}

		public void SetFocalRegion(float focalRegion)
		{
			float num4;
			if (!(focalRegion < 0f))
			{
				float num = 100f;
				uint num2 = (uint)BitConverter.SingleToInt32Bits(focalRegion);
				uint num3 = (uint)BitConverter.SingleToInt32Bits(num);
				num4 = ((focalRegion == num) ? BitConverter.Int32BitsToSingle((int)(num2 | num3)) : (((num2 & 0x7FFFFFFF) > 2139095040 && (num2 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040 && (num3 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : (((num2 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : ((!(focalRegion < num)) ? num : focalRegion))))));
			}
			else
			{
				num4 = 0f;
			}
			this.focalRegion = num4;
		}

		public void SetEnableSekaiDof(bool enable)
		{
			enableSekaiDof = enable;
		}

		public void SetAperture(float aperture)
		{
			this.aperture = aperture;
		}

		public void SetFocalLength(float focalLength)
		{
			this.focalLength = focalLength;
		}

		public void SetDisableForeBokeh(bool disableForeBokeh)
		{
			this.disableForeBokeh = disableForeBokeh;
		}

		public void SetBloomIntensity(float intensity)
		{
			float num4;
			if (!(intensity < 0f))
			{
				float num = 1f;
				uint num2 = (uint)BitConverter.SingleToInt32Bits(intensity);
				uint num3 = (uint)BitConverter.SingleToInt32Bits(num);
				num4 = ((intensity == num) ? BitConverter.Int32BitsToSingle((int)(num2 | num3)) : (((num2 & 0x7FFFFFFF) > 2139095040 && (num2 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040 && (num3 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : (((num2 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : ((!(intensity < num)) ? num : intensity))))));
			}
			else
			{
				num4 = 0f;
			}
			this.intensity = num4;
		}

		public void SetBloomScatter(float scatter)
		{
			float num4;
			if (!(scatter < 0f))
			{
				float num = 3f;
				uint num2 = (uint)BitConverter.SingleToInt32Bits(scatter);
				uint num3 = (uint)BitConverter.SingleToInt32Bits(num);
				num4 = ((scatter == num) ? BitConverter.Int32BitsToSingle((int)(num2 | num3)) : (((num2 & 0x7FFFFFFF) > 2139095040 && (num2 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040 && (num3 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : (((num2 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : ((!(scatter < num)) ? num : scatter))))));
			}
			else
			{
				num4 = 0f;
			}
			this.scatter = num4;
		}

		public void SetBloomUseBlend(bool useBlend)
		{
			newBloomBlend = useBlend;
		}

		public void SetLightOverlayBrightColor(Color brightColor)
		{
			this.brightColor = brightColor;
		}

		public void SetLightOverlayDarkColor(Color darkColor)
		{
			this.darkColor = darkColor;
		}

		public void SetLightOverlayBrightPosition(Vector2 brightPosition)
		{
			this.brightPosition = brightPosition;
		}

		public void SetLightOverlayDarkPosition(Vector2 darkPosition)
		{
			this.darkPosition = darkPosition;
		}

		public void SetIncidentLight(int order, int incidentLightType, Color color, Vector2 position, float length)
		{
			this.incidentLightType = incidentLightType;
			incidentLightColor = color;
			incidentLightPosition = position;
			incidentLightLength = length;
		}

		public void SetFrontLutTex(Texture3D frontLut)
		{
			this.frontLut = frontLut;
		}

		public void SetBackLutTex(Texture3D backLut)
		{
			this.backLut = backLut;
		}

		public void SetFrontLutBlend(float frontLutBlend)
		{
			this.frontLutBlend = frontLutBlend;
		}

		public void SetBackLutBlend(float backLutBlend)
		{
			this.backLutBlend = backLutBlend;
		}

		public void SetFrontLutPoint(Vector2 frontLutPoint)
		{
			this.frontLutPoint = frontLutPoint;
		}

		public void SetFrontNonLutPoint(Vector2 frontNonLutPoint)
		{
			this.frontNonLutPoint = frontNonLutPoint;
		}

		public void SetBackLutPoint(Vector2 backLutPoint)
		{
			this.backLutPoint = backLutPoint;
		}

		public void SetBackNonLutPoint(Vector2 backNonLutPoint)
		{
			this.backNonLutPoint = backNonLutPoint;
		}

		public void SetSat(float sat)
		{
			float num4;
			if (!(sat < 0f))
			{
				float num = 2f;
				uint num2 = (uint)BitConverter.SingleToInt32Bits(sat);
				uint num3 = (uint)BitConverter.SingleToInt32Bits(num);
				num4 = ((sat == num) ? BitConverter.Int32BitsToSingle((int)(num2 | num3)) : (((num2 & 0x7FFFFFFF) > 2139095040 && (num2 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040 && (num3 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : (((num2 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : ((!(sat < num)) ? num : sat))))));
			}
			else
			{
				num4 = 0f;
			}
			this.sat = num4;
		}

		public void SetSatAlpha(float satAlpha)
		{
			float num4;
			if (!(satAlpha < 0f))
			{
				float num = 1f;
				uint num2 = (uint)BitConverter.SingleToInt32Bits(satAlpha);
				uint num3 = (uint)BitConverter.SingleToInt32Bits(num);
				num4 = ((satAlpha == num) ? BitConverter.Int32BitsToSingle((int)(num2 | num3)) : (((num2 & 0x7FFFFFFF) > 2139095040 && (num2 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040 && (num3 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : (((num2 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : ((!(satAlpha < num)) ? num : satAlpha))))));
			}
			else
			{
				num4 = 0f;
			}
			this.satAlpha = num4;
		}

		public void SetSaturationModuleSaturation(float saturation)
		{
			ref SaturationModule reference = ref saturationModule;
			float saturation2;
			if (!(saturation < 0f))
			{
				float num = 1f;
				uint num2 = (uint)BitConverter.SingleToInt32Bits(saturation);
				uint num3 = (uint)BitConverter.SingleToInt32Bits(num);
				saturation2 = ((saturation == num) ? BitConverter.Int32BitsToSingle((int)(num2 | num3)) : (((num2 & 0x7FFFFFFF) > 2139095040 && (num2 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040 && (num3 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : (((num2 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : ((!(saturation < num)) ? num : saturation))))));
			}
			else
			{
				saturation2 = 0f;
			}
			reference.saturation = saturation2;
		}

		public void SetDirectionalBlurParamType(int type)
		{
			directionalBlurParamType = type;
		}

		public void SetDirectionalBlurStrength(float strength)
		{
			directionalBlurStrength = strength;
		}

		public void SetDirectionalBlurDirection(float direction)
		{
			float num4;
			if (!(direction < 0f))
			{
				float num = 360f;
				uint num2 = (uint)BitConverter.SingleToInt32Bits(direction);
				uint num3 = (uint)BitConverter.SingleToInt32Bits(num);
				num4 = ((direction == num) ? BitConverter.Int32BitsToSingle((int)(num2 | num3)) : (((num2 & 0x7FFFFFFF) > 2139095040 && (num2 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040 && (num3 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : (((num2 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : ((!(direction < num)) ? num : direction))))));
			}
			else
			{
				num4 = 0f;
			}
			directionalBlurDirection = num4;
		}

		public void SetRadialBlurStrength(float strength)
		{
			directionalBlurStrength = strength;
		}

		public void SetRadialBlurCenterPosition(Vector2 centerPosition)
		{
			radialBlurCenterPosition = centerPosition;
		}

		public void SetSolarization(float solarization)
		{
			float num4;
			if (!(solarization < 0f))
			{
				float num = 1f;
				uint num2 = (uint)BitConverter.SingleToInt32Bits(solarization);
				uint num3 = (uint)BitConverter.SingleToInt32Bits(num);
				num4 = ((solarization == num) ? BitConverter.Int32BitsToSingle((int)(num2 | num3)) : (((num2 & 0x7FFFFFFF) > 2139095040 && (num2 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040 && (num3 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : (((num2 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : ((!(solarization < num)) ? num : solarization))))));
			}
			else
			{
				num4 = 0f;
			}
			this.solarization = num4;
		}

		public void SetMainCameraUvScrollOffset(Vector2 offset)
		{
			mainCameraUvScrollOffset = offset;
		}

		public void SetMainCameraUvScrollWrapMode(MainCameraUvScrollWrapMode wrapMode)
		{
			mainCameraUvScrollWrapMode = wrapMode;
		}

		public void SetMainCameraUvScrollApplyToScreenPos(bool enable)
		{
			mainCameraUvScrollApplyToScreenPos = enable;
		}

		private void ResetMainCameraUvScroll()
		{
			mainCameraUvScrollOffset = MAIN_CAMERA_UV_SCROLL_OFFSET;
			mainCameraUvScrollWrapMode = MAIN_CAMERA_UV_SCROLL_WRAP_MODE;
			mainCameraUvScrollApplyToScreenPos = MAIN_CAMERA_UV_SCROLL_APPLY_TO_SCREEN_POS;
			float x = mainCameraUvScrollOffset.x;
			float y = mainCameraUvScrollOffset.y;
			Shader.SetGlobalVector(ShaderPropertyID.MAIN_CAMERA_UV_SCROLL_OFFSET_ID, new Vector4
			{
				x = x,
				y = y
			});
			Shader.SetGlobalInt(ShaderPropertyID.MAIN_CAMERA_UV_SCROLL_WRAP_MODE_ID, (int)mainCameraUvScrollWrapMode);
			Shader.SetGlobalInt(ShaderPropertyID.MAIN_CAMERA_UV_SCROLL_APPLY_TO_SCREEN_POS_ID, mainCameraUvScrollApplyToScreenPos ? 1 : 0);
		}

		public void SetFadeOut(float value)
		{
			float num4;
			if (!(value < 0f))
			{
				float num = 1f;
				uint num2 = (uint)BitConverter.SingleToInt32Bits(value);
				uint num3 = (uint)BitConverter.SingleToInt32Bits(num);
				num4 = ((value == num) ? BitConverter.Int32BitsToSingle((int)(num2 | num3)) : (((num2 & 0x7FFFFFFF) > 2139095040 && (num2 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040 && (num3 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : (((num2 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : ((!(value < num)) ? num : value))))));
			}
			else
			{
				num4 = 0f;
			}
			fadeOut = num4;
		}

		public void SetFadeOutLerp(float value)
		{
			float num4;
			if (!(value < 0f))
			{
				float num = 1f;
				uint num2 = (uint)BitConverter.SingleToInt32Bits(value);
				uint num3 = (uint)BitConverter.SingleToInt32Bits(num);
				num4 = ((value == num) ? BitConverter.Int32BitsToSingle((int)(num2 | num3)) : (((num2 & 0x7FFFFFFF) > 2139095040 && (num2 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040 && (num3 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : (((num2 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : ((!(value < num)) ? num : value))))));
			}
			else
			{
				num4 = 0f;
			}
			fadeOutLerp = num4;
		}

		public void SetFadeOutBeforeProp(float value)
		{
			float num4;
			if (!(value < 0f))
			{
				float num = 1f;
				uint num2 = (uint)BitConverter.SingleToInt32Bits(value);
				uint num3 = (uint)BitConverter.SingleToInt32Bits(num);
				num4 = ((value == num) ? BitConverter.Int32BitsToSingle((int)(num2 | num3)) : (((num2 & 0x7FFFFFFF) > 2139095040 && (num2 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040 && (num3 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : (((num2 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : ((!(value < num)) ? num : value))))));
			}
			else
			{
				num4 = 0f;
			}
			fadeOutBeforeProp = num4;
		}

		public void SetFadeOutBeforePropLerp(float value)
		{
			float num4;
			if (!(value < 0f))
			{
				float num = 1f;
				uint num2 = (uint)BitConverter.SingleToInt32Bits(value);
				uint num3 = (uint)BitConverter.SingleToInt32Bits(num);
				num4 = ((value == num) ? BitConverter.Int32BitsToSingle((int)(num2 | num3)) : (((num2 & 0x7FFFFFFF) > 2139095040 && (num2 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040 && (num3 & 0x400000) == 0) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : (((num2 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num2 | 0x400000)) : (((num3 & 0x7FFFFFFF) > 2139095040) ? BitConverter.Int32BitsToSingle((int)(num3 | 0x400000)) : ((!(value < num)) ? num : value))))));
			}
			else
			{
				num4 = 0f;
			}
			fadeOutBeforePropLerp = num4;
		}

		public void SetVignetteColor(Color value)
		{
			vignetteCache.color = value;
		}

		public void SetVignetteCenterX(float value)
		{
			vignetteCache.centerX = value;
		}

		public void SetVignetteCenterY(float value)
		{
			vignetteCache.centerY = value;
		}

		public void SetVignetteIntensity(float value)
		{
			vignetteCache.intensity = value;
		}

		public void SetVignetteSmoothness(float value)
		{
			vignetteCache.smoothness = value;
		}

		public void SetVignetteRoundness(float value)
		{
			vignetteCache.roundness = value;
		}

		public void SetAntiAliasing(AntialiasingMode mode)
		{
			antialiasingMode = mode;
		}

		public void SetDistortionIntensity(float value)
		{
			screenDistortionCache.amount = value;
		}

		public void SetDistortionScale(float value)
		{
			screenDistortionCache.scale = value;
		}

		public void SetDistortionOffset(float value)
		{
			screenDistortionCache.offset = value;
		}

		public void SetDistortionTexture(Texture texture)
		{
			if (texture != null)
			{
				Shader.SetGlobalTexture(ShaderPropertyID.SCREEN_DISTORTION_NOISE_TEXTURE_ID, texture);
			}
		}

		public void SetDistortionUseNoiseTexture(bool value)
		{
			screenDistortionCache.useNoiseTexture = value;
		}

		public void SetDistortionNoiseTextureScale(Vector2 scale)
		{
			screenDistortionCache.noiseTextureScale = scale;
		}

		public void SetDistortionNoiseUVScrollSpeed(Vector2 speed)
		{
			screenDistortionCache.noiseUVScrollSpeed = speed;
		}

		public void SetDistortionTime(float time)
		{
			screenDistortionCache.time = time;
		}

		public void SetChromaticAberrationParamType(int type)
		{
			chromaticAberrationParamType = type;
		}

		public void SetChromaticAberrationOffsetR(Vector2 offset)
		{
			chromaticAberrationOffsetR = offset;
		}

		public void SetChromaticAberrationOffsetG(Vector2 offset)
		{
			chromaticAberrationOffsetG = offset;
		}

		public void SetChromaticAberrationOffsetB(Vector2 offset)
		{
			chromaticAberrationOffsetB = offset;
		}

		public void SetChromaticAberrationSceleRgb(Vector3 scale)
		{
			chromaticAberrationScaleRgb = scale;
		}

		public PostEffectV2()
		{
			float fOCUS_DISTANCE = FOCUS_DISTANCE;
			float tRANSITION_RANGE = TRANSITION_RANGE;
			float fOCAL_REGION = FOCAL_REGION;
			float aPERTURE = APERTURE;
			focusDistance = fOCUS_DISTANCE;
			transitionRange = tRANSITION_RANGE;
			focalRegion = fOCAL_REGION;
			aperture = aPERTURE;
			focalLength = FOCAL_LENGTH;
			disableForeBokeh = DISABLE_FORE_BOKEH;
			float iNTENSITY = INTENSITY;
			float sCATTER = SCATTER;
			intensity = iNTENSITY;
			scatter = sCATTER;
			newBloomBlend = NEW_BLOOM_BLEND;
			brightColor = BRIGHT_COLOR;
			darkColor = DARK_COLOR;
			brightPosition = BRIGHT_POSITION;
			darkPosition = DARK_POSITION;
			incidentLightType = INCIDENT_LIGHT_TYPE;
			incidentLightColor = INCIDENT_LIGHT_COLOR;
			incidentLightPosition = INCIDENT_LIGHT_POSITION;
			float iNCIDENT_LIGHT_LENGTH = INCIDENT_LIGHT_LENGTH;
			float sAT = SAT;
			incidentLightLength = iNCIDENT_LIGHT_LENGTH;
			sat = sAT;
			satAlpha = SAT_ALPHA;
			bool sAT_MODULE_ACTIVE = SAT_MODULE_ACTIVE;
			saturationModule = new SaturationModule
			{
				active = sAT_MODULE_ACTIVE,
				saturation = 1f
			};
			directionalBlurParamType = DIRECTIONAL_BLUR_PARAM_TYPE;
			float dIRECTIONAL_BLUR_STRENGTH = DIRECTIONAL_BLUR_STRENGTH;
			float dIRECTIONAL_BLUR_DIRECTION = DIRECTIONAL_BLUR_DIRECTION;
			directionalBlurStrength = dIRECTIONAL_BLUR_STRENGTH;
			directionalBlurDirection = dIRECTIONAL_BLUR_DIRECTION;
			radialBlurCenterPosition = RADIAL_BLUR_CENTER_POSITION;
			solarization = SOLARIZATION;
			mainCameraUvScrollOffset = MAIN_CAMERA_UV_SCROLL_OFFSET;
			mainCameraUvScrollWrapMode = MAIN_CAMERA_UV_SCROLL_WRAP_MODE;
			mainCameraUvScrollApplyToScreenPos = MAIN_CAMERA_UV_SCROLL_APPLY_TO_SCREEN_POS;
			fadeOutBeforePropLerp = (fadeOutBeforeProp = (fadeOutLerp = (fadeOut = FADEOUT_BASE)));
			chromaticAberrationParamType = CHROMATIC_ABERRATION_PARAM_TYPE;
			chromaticAberrationOffsetR = CHROMATIC_ABERRATION_OFFSET;
			chromaticAberrationOffsetG = CHROMATIC_ABERRATION_OFFSET;
			chromaticAberrationOffsetB = CHROMATIC_ABERRATION_OFFSET;
			chromaticAberrationScaleRgb = CHROMATIC_ABERRATION_SCALE;
			volume = new SekaiVolume();
			vignetteCache = new VignetteCache();
			screenDistortionCache = new ScreenDistortionCache();
		}

		static PostEffectV2()
		{
			if (1 == 0)
			{
			}
			MAIN_CAMERA_UV_SCROLL_OFFSET = Vector2.zero;
			MAIN_CAMERA_UV_SCROLL_WRAP_MODE = MainCameraUvScrollWrapMode.Clamp;
			MAIN_CAMERA_UV_SCROLL_APPLY_TO_SCREEN_POS = false;
		}
	}
}
