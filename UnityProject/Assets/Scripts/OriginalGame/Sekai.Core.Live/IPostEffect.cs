// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Core.Live/IPostEffect.cs。
using UnityEngine;

namespace Sekai.Core.Live
{
	public interface IPostEffect
	{
		void SetTransitionRange(float transitionRange);

		void SetFocalRegion(float focalRegion);

		void SetAperture(float aperture);

		void SetFocalLength(float focalLength);

		void SetDisableForeBokeh(bool disableForeBokeh);

		void SetBloomIntensity(float intensity);

		void SetBloomScatter(float scatter);

		void SetBloomUseBlend(bool useBlend);

		void SetLightOverlayBrightColor(Color brightColor);

		void SetLightOverlayDarkColor(Color darkColor);

		void SetLightOverlayBrightPosition(Vector2 brightPosition);

		void SetLightOverlayDarkPosition(Vector2 darkPosition);

		void SetIncidentLight(int order, int incidentLightType, Color color, Vector2 position, float length);

		void SetSat(float sat);

		void SetSatAlpha(float satAlpha);

		void SetSaturationModuleSaturation(float saturation);

		void SetDirectionalBlurParamType(int type);

		void SetDirectionalBlurStrength(float blurStrength);

		void SetDirectionalBlurDirection(float blurDirection);

		void SetRadialBlurStrength(float blurStrength);

		void SetRadialBlurCenterPosition(Vector2 center);

		void SetSolarization(float solarization);

		void SetFadeOutBeforeProp(float fadeOutBeforeProp);

		void SetFadeOutBeforePropLerp(float fadeOutBeforePropLerp);

		void SetFadeOut(float fadeOut);

		void SetFadeOutLerp(float fadeOutLerp);

		void SetDistortionIntensity(float value);

		void SetDistortionScale(float value);

		void SetDistortionOffset(float value);

		void SetDistortionUseNoiseTexture(bool value);

		void SetDistortionTexture(Texture value);

		void SetDistortionNoiseTextureScale(Vector2 scale);

		void SetDistortionNoiseUVScrollSpeed(Vector2 speed);

		void SetDistortionTime(float time);

		void SetChromaticAberrationParamType(int type);

		void SetChromaticAberrationOffsetR(Vector2 value);

		void SetChromaticAberrationOffsetG(Vector2 value);

		void SetChromaticAberrationOffsetB(Vector2 value);

		void SetChromaticAberrationSceleRgb(Vector3 scale);

		void SetMainCameraUvScrollOffset(Vector2 offset);

		void SetMainCameraUvScrollWrapMode(MainCameraUvScrollWrapMode wrapMode);

		void SetMainCameraUvScrollApplyToScreenPos(bool enable);

		void SetVignetteColor(Color value);

		void SetVignetteCenterX(float value);

		void SetVignetteCenterY(float value);

		void SetVignetteIntensity(float value);

		void SetVignetteSmoothness(float value);

		void SetVignetteRoundness(float value);
	}
}
