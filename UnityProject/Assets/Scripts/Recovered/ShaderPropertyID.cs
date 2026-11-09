// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai/ShaderPropertyID.cs。
using UnityEngine;

namespace Sekai
{
	public static class ShaderPropertyID
	{
		public static class CharacterDebug
		{
			public static readonly int EyelashPositionOffset = Shader.PropertyToID("_EyelashPositionOffset");
		}

		internal static class CharacterModelShaderPropertyId
		{
			public static readonly int CharacterId = Shader.PropertyToID("_CharacterId");

			public static readonly int FaceFront = Shader.PropertyToID("_FaceFront");

			public static readonly int LocalFlipBookOpacity = Shader.PropertyToID("_LocalFlipBookOpacity");

			public static readonly int DefaultSkinColor = Shader.PropertyToID("_DefaultSkinColor");

			public static readonly int Shadow1SkinColor = Shader.PropertyToID("_Shadow1SkinColor");

			public static readonly int Shadow2SkinColor = Shader.PropertyToID("_Shadow2SkinColor");

			public static readonly int AdditionalAmbientColor = Shader.PropertyToID("_PartsAmbientColor");

			public static readonly int Stencil = Shader.PropertyToID("_Stencil");

			public static readonly int ReadMask = Shader.PropertyToID("_ReadMask");

			public static readonly int WriteMask = Shader.PropertyToID("_WriteMask");

			public static readonly int StencilComp = Shader.PropertyToID("_StencilComp");

			public static readonly int StencilOp = Shader.PropertyToID("_StencilOp");

			public static readonly int StencilFail = Shader.PropertyToID("_StencilFail");

			public static readonly int StencilZFail = Shader.PropertyToID("_StencilZFail");

			public static readonly int EyelashStencil = Shader.PropertyToID("_EyelashStencil");

			public static readonly int EyelashReadMask = Shader.PropertyToID("_EyelashReadMask");

			public static readonly int EyelashWriteMask = Shader.PropertyToID("_EyelashWriteMask");

			public static readonly int EyelashStencilComp = Shader.PropertyToID("_EyelashStencilComp");

			public static readonly int EyelashStencilOp = Shader.PropertyToID("_EyelashStencilOp");

			public static readonly int EyelashStencilFail = Shader.PropertyToID("_EyelashStencilFail");

			public static readonly int EyelashStencilZFail = Shader.PropertyToID("_EyelashStencilZFail");

			public static readonly int SekaiCharacterHeadDotDirectionalLight = Shader.PropertyToID("_HeadDotDirectionalLightValues");

			public static readonly int RangeLimit = Shader.PropertyToID("_RangeLimit");

			public static readonly int ShadowTexWeight = Shader.PropertyToID("_ShadowTexWeight");

			public static readonly int ShadowWidth = Shader.PropertyToID("_ShadowWidth");

			public static readonly int FadeMode = Shader.PropertyToID("_FadeMode");

			public static readonly int GlobalEyeTime = Shader.PropertyToID("_SekaiGlobalEyeTime");

			public static readonly int HueSinAngle = Shader.PropertyToID("_HueSinAngle");

			public static readonly int HueCosAngle = Shader.PropertyToID("_HueCosAngle");

			public static readonly int Saturation = Shader.PropertyToID("_Saturation");

			public static readonly int Value = Shader.PropertyToID("_Value");

			public static readonly int Contrast = Shader.PropertyToID("_Contrast");

			public static readonly int OutlineOffset = Shader.PropertyToID("_OutlineOffset");

			public static readonly int UseOutlineSecondNormal = Shader.PropertyToID("_UseOutlineSecondNormal");
		}

		internal static class CharacterWaterEye
		{
			public static readonly int DistortionTex = Shader.PropertyToID("_DistortionTex");

			public static readonly int DistortionTexTilingX = Shader.PropertyToID("_DistortionTexTilingX");

			public static readonly int DistortionTexTilingY = Shader.PropertyToID("_DistortionTexTilingY");

			public static readonly int DistortionScrollSpeed = Shader.PropertyToID("_DistortionScrollSpeed");

			public static readonly int DistortionScrollX = Shader.PropertyToID("_DistortionScrollX");

			public static readonly int DistortionScrollY = Shader.PropertyToID("_DistortionScrollY");

			public static readonly int DistortionFPS = Shader.PropertyToID("_DistortionFPS");

			public static readonly int DistortionIntensity = Shader.PropertyToID("_DistortionIntensity");

			public static readonly int DistortionIntensityX = Shader.PropertyToID("_DistortionIntensityX");

			public static readonly int DistortionIntensityY = Shader.PropertyToID("_DistortionIntensityY");

			public static readonly int DistortionOffsetX = Shader.PropertyToID("_DistortionOffsetX");

			public static readonly int DistortionOffsetY = Shader.PropertyToID("_DistortionOffsetY");
		}

		internal static class EyeFlipbook
		{
			public static readonly int EyeFlipbookEnabled = Shader.PropertyToID("_EyeFlipbookEnabled");

			public static readonly int EyeFlipbookTex = Shader.PropertyToID("_EyeFlipbookTex");

			public static readonly int SheetValue = Shader.PropertyToID("_SheetValue");

			public static readonly int EyeFlipbookCurrentFrame = Shader.PropertyToID("_EyeFlipbookCurrentFrame");

			public static readonly int EyeFlipbookOffsetX = Shader.PropertyToID("_EyeFlipbookOffsetX");

			public static readonly int EyeFlipbookOffsetY = Shader.PropertyToID("_EyeFlipbookOffsetY");
		}

		public static class MysekaiCharacter
		{
			public static readonly int DitherAlpha = Shader.PropertyToID("_DitherAlpha");
		}

		public static readonly int ALPHA_ID = Shader.PropertyToID("_Alpha");

		public static readonly int AMOUNT_ID = Shader.PropertyToID("_Amount");

		public static readonly int ANIMATION_KEY_ID = Shader.PropertyToID("_AnimationKey");

		public static readonly int ANIM_TEX_ID = Shader.PropertyToID("_AnimTex");

		public static readonly int BLACK_ID = Shader.PropertyToID("_Black");

		public static readonly int BLEND_ID = Shader.PropertyToID("_Blend");

		public static readonly int BLOOM_SAT_ID = Shader.PropertyToID("_BloomSat");

		public static readonly int BLUR_SIZE_ID = Shader.PropertyToID("_BlurSize");

		public static readonly int BORDER_ID = Shader.PropertyToID("_Border");

		public static readonly int BRIGHTNESS_ID = Shader.PropertyToID("_Brightness");

		public static readonly int BRIGHTNESS_TEX_ID = Shader.PropertyToID("_BrightnessTex");

		public static readonly int BLOOM_BLENDMODE_TEX_ID = Shader.PropertyToID("_BloomBlendMode");

		public static readonly int PROP_TEX_ID = Shader.PropertyToID("_PropTex");

		public static readonly int BASE_COLOR_ID = Shader.PropertyToID("_BaseColor");

		public static readonly int BRIGHT_COLOR_ID = Shader.PropertyToID("_BrightColor");

		public static readonly int CHARACTER_ID = Shader.PropertyToID("_CharacterId");

		public static readonly int COLOR_ID = Shader.PropertyToID("_Color");

		public static readonly int COLOR_ARRAY_ID = Shader.PropertyToID("_ColorArray");

		public static readonly int CONTENT_SIZE_ID = Shader.PropertyToID("_ContentSize");

		public static readonly int CULL_ID = Shader.PropertyToID("_Cull");

		public static readonly int DARK_COLOR_ID = Shader.PropertyToID("_DarkColor");

		public static readonly int DARK_POSITION_ID = Shader.PropertyToID("_DarkPosition");

		public static readonly int DEPTH_TEXTURE_ID = Shader.PropertyToID("_DepthTexture");

		public static readonly int DIRECTIONAL_SHADOW_SRC_BLEND_ID = Shader.PropertyToID("_DirectionalShadowSrcBlend");

		public static readonly int DISTANCE_ID = Shader.PropertyToID("_Distance");

		public static readonly int DST_BLEND_ID = Shader.PropertyToID("_DstBlend");

		public static readonly int ELAPSED_TIME_ID = Shader.PropertyToID("_ElapsedTime");

		public static readonly int FADE_OUT_ID = Shader.PropertyToID("_FadeOut");

		public static readonly int FOCAL_REGION_ID = Shader.PropertyToID("_FocalRegion");

		public static readonly int FOG_COLOR_ID = Shader.PropertyToID("_FogColor");

		public static readonly int FOG_FACTOR_ID = Shader.PropertyToID("_FogFactor");

		public static readonly int INCIDENT_LIGHT_COLOR_ID = Shader.PropertyToID("_IncidentLightColor");

		public static readonly int INCIDENT_LIGHT_VECTOR_ID = Shader.PropertyToID("_IncidentLightVector");

		public static readonly int INFLUENCE_ID = Shader.PropertyToID("_Influence");

		public static readonly int INTENSITY_ID = Shader.PropertyToID("_Intensity");

		public static readonly int LIGHT_VECTOR_ID = Shader.PropertyToID("_LightVector");

		public static readonly int LINE_ID = Shader.PropertyToID("_Line");

		public static readonly int PERFORMANCE_ELAPSED_TIME_ID = Shader.PropertyToID("_PerformanceElapsedTime");

		public static readonly int LOCAL_TIME_ID = Shader.PropertyToID("_LocalTime");

		public static readonly int MAIN_TEX_ID = Shader.PropertyToID("_MainTex");

		public static readonly int MAIN_TEX_ST_ID = Shader.PropertyToID("_MainTex_ST");

		public static readonly int MASK_TEX_ID = Shader.PropertyToID("_MaskTex");

		public static readonly int DITHER_TEX_ID = Shader.PropertyToID("_DitherTex");

		public static readonly int DITHER_USE_ID = Shader.PropertyToID("_UseDither");

		public static readonly int DITHER_ALPHA_ID = Shader.PropertyToID("_DitherAlpha");

		public static readonly int MONOCHROME_ID = Shader.PropertyToID("_Monochhrome");

		public static readonly int OFFSET_X_ID = Shader.PropertyToID("_OffsetX");

		public static readonly int OFFSET_Y_ID = Shader.PropertyToID("_OffsetY");

		public static readonly int PENLIGHT_BOUNDS_ID = Shader.PropertyToID("_Bounds");

		public static readonly int PENLIGHT_PATTERN_THRESHOLD_ID = Shader.PropertyToID("_PatternThreshold");

		public static readonly int PENLIGHT_PATTERN_FADE_ID = Shader.PropertyToID("_PatternFade");

		public static readonly int PENLIGHT_PATTERN_FADE_PRESET_ID = Shader.PropertyToID("_PatternFadePreset");

		public static readonly int PENLIGHT_PATTERN_ANIMATION_ID = Shader.PropertyToID("_PatternAnimation");

		public static readonly int PENLIGHT_PATTERN_ANIMATION_OFFSET_ID = Shader.PropertyToID("_PatternAnimationOffset");

		public static readonly int PENLIGHT_PATTERN_COLOR_OFFSET_ID = Shader.PropertyToID("_PatternColorOffset");

		public static readonly int PENLIGHT_PATTERN_ANIMATION_UV_ROTATION_ID = Shader.PropertyToID("_PatternAnimationUVRotation");

		public static readonly int PENLIGHT_PATTERN_COLOR_UV_ROTAION_ID = Shader.PropertyToID("_PatternColorUVRotation");

		public static readonly int PENLIGHT_PATTERN_MASK_THRESHOLD_ID = Shader.PropertyToID("_PatternMaskThreshold");

		public static readonly int SAMPLING_DISTANCE_ID = Shader.PropertyToID("_SamplingDistance");

		public static readonly int SATURATION_ID = Shader.PropertyToID("_Saturation");

		public static readonly int SOLARISATION_ID = Shader.PropertyToID("_Solarisation");

		public static readonly int MAIN_CAMERA_UV_SCROLL_OFFSET_ID = Shader.PropertyToID("_MainCameraUvScrollOffset");

		public static readonly int MAIN_CAMERA_UV_SCROLL_WRAP_MODE_ID = Shader.PropertyToID("_MainCameraUvScrollWrapMode");

		public static readonly int MAIN_CAMERA_UV_SCROLL_APPLY_TO_SCREEN_POS_ID = Shader.PropertyToID("_MainCameraUvScrollApplyToScreenPos");

		public static readonly int SAT_ALPHA_ID = Shader.PropertyToID("_SatAlpha");

		public static readonly int SAT_ID = Shader.PropertyToID("_Sat");

		public static readonly int SAT_TEX_ID = Shader.PropertyToID("_SatTex");

		public static readonly int SCALE_ID = Shader.PropertyToID("_Scale");

		public static readonly int SCATTER_ID = Shader.PropertyToID("_Scatter");

		public static readonly int SCATTER_WEIGHT_ID = Shader.PropertyToID("_ScatterWeight");

		public static readonly int SEKAI_ALL_LIGHT_INTENSITY_ID = Shader.PropertyToID("_SekaiAllLightIntensity");

		public static readonly int SEKAI_AMBIENT_LIGHT_COLOR_ID = Shader.PropertyToID("_SekaiAmbientLightColor");

		public static readonly int SEKAI_CHARACTER_AMBIENT_LIGHT_COLOR_ARRAY_ID = Shader.PropertyToID("_SekaiCharacterAmbientLightColorArray");

		public static readonly int SEKAI_CHARACTER_AMBIENT_LIGHT_INTENSITY_ARRAY_ID = Shader.PropertyToID("_SekaiCharacterAmbientLightIntensityArray");

		public static readonly int SEKAI_DIRECTIONAL_LIGHT_ID = Shader.PropertyToID("_SekaiDirectionalLight");

		public static readonly int SEKAI_FOG_COLOR_ID = Shader.PropertyToID("_SekaiFogColor");

		public static readonly int SEKAI_FOG_FACTOR_ID = Shader.PropertyToID("_SekaiFogFactor");

		public static readonly int SEKAI_GLOW_LIGHT_INTENSITY_ID = Shader.PropertyToID("_SekaiGlowLightIntensity");

		public static readonly int SEKAI_LIGHT_INTENSITY_ID = Shader.PropertyToID("_SekaiLightIntensity");

		public static readonly int SEKAI_RIM_LIGHT_ARRAY_ID = Shader.PropertyToID("_SekaiRimLightArray");

		public static readonly int SEKAI_RIM_LIGHT_COLOR_ARRAY_ID = Shader.PropertyToID("_SekaiRimLightColorArray");

		public static readonly int SEKAI_GLOBAL_SPOT_LIGHT_POS_ID = Shader.PropertyToID("_SekaiGlobalSpotLightPos");

		public static readonly int SEKAI_GLOBAL_SPOT_LIGHT_COLOR_ID = Shader.PropertyToID("_SekaiGlobalSpotLightColor");

		public static readonly int SEKAI_GLOBAL_SPOT_LIGHT_RADIUS_NEAR_ID = Shader.PropertyToID("_SekaiGlobalSpotLightRadiusNear");

		public static readonly int SEKAI_GLOBAL_SPOT_LIGHT_RADIUS_FAR_ID = Shader.PropertyToID("_SekaiGlobalSpotLightRadiusFar");

		public static readonly int SEKAI_MONITOR_OBJECT_POSITION_ARRAY_ID = Shader.PropertyToID("_MonitorObjectPositionArray");

		public static readonly int SEKAI_MONITOR_ACCESSORY_POSITION_ARRAY_ID = Shader.PropertyToID("_MonitorAccessoryPositionArray");

		public static readonly int IS_ACCESSORY_ID = Shader.PropertyToID("_IsAccessory");

		public static readonly int SHADOW_TEX_ID = Shader.PropertyToID("_ShadowTex");

		public static readonly int SHEET_VALUE_ID = Shader.PropertyToID("_SheetValue");

		public static readonly int SHINE_ID = Shader.PropertyToID("_Shine");

		public static readonly int SOFT_MASK_RECT_ID = Shader.PropertyToID("_SoftMaskRect");

		public static readonly int SOFT_MASK_TEX_ID = Shader.PropertyToID("_SoftMaskTex");

		public static readonly int SOFT_MASK_TRANS_ID = Shader.PropertyToID("_SoftMaskTrans");

		public static readonly int SRC_BLEND_ID = Shader.PropertyToID("_SrcBlend");

		public static readonly int SUB_COLOR_ID = Shader.PropertyToID("_SubColor");

		public static readonly int BLEND_MODE_ID = Shader.PropertyToID("_BlendMode");

		public static readonly int SUB_TEX_ID = Shader.PropertyToID("_SubTex");

		public static readonly int SCREEN_DISTORTION_NOISE_TEXTURE_ID = Shader.PropertyToID("_ScreenDistortionNoiseTexture");

		public static readonly int SWING_OFFEST_ID = Shader.PropertyToID("_SwingOffset");

		public static readonly int TAP_EFFECT_PROJECTION_MATRIX_ID = Shader.PropertyToID("_TapEffectProjectionMatrix");

		public static readonly int TAP_EFFECT_VIEW_MATRIX_ID = Shader.PropertyToID("_TapEffectViewMatrix");

		public static readonly int TONE_RATIO_ID = Shader.PropertyToID("_ToneRatio");

		public static readonly int TRANSITION_RANGE_ID = Shader.PropertyToID("_TransitionRange");

		public static readonly int USE_PENLIGHT_PATTERN_MASK_ID = Shader.PropertyToID("_UsePatternMask");

		public static readonly int POLAR_PATTERN_COLOR_ID = Shader.PropertyToID("_PolarPatternColor");

		public static readonly int POLAR_PATTERN_ANIMATION_ID = Shader.PropertyToID("_PolarPatternAnimation");

		public static readonly int CUTIN_TRANSITION_COLOR_ID = Shader.PropertyToID("_CutInTransitionColor");

		public static readonly int CUTIN_TRANSITION_ID = Shader.PropertyToID("_CutInTransition");

		public static readonly int VALUE_ID = Shader.PropertyToID("_Value");

		public static readonly int VALUE_TEX_ID = Shader.PropertyToID("_ValueTex");

		public static readonly int VECTOR_ID = Shader.PropertyToID("_Vector");

		public static readonly int VIEW_THRESHOLD_ID = Shader.PropertyToID("_ViewThreshold");

		public static readonly int CONSOLIDATION_RATE_Y = Shader.PropertyToID("_ConsolidationRateY");

		public static readonly int WEIGHT_ID = Shader.PropertyToID("_Weight");

		public static readonly int WORLD_SPACE_LIGHT_POS_0_ID = Shader.PropertyToID("_WorldSpaceLightPos0");

		public static readonly int Z_WRITE_ID = Shader.PropertyToID("_ZWrite");

		public static readonly int Z_TEST_ID = Shader.PropertyToID("_ZTest");

		public static readonly int SCROLL_SPEED_ID = Shader.PropertyToID("_ScrollSpeed");

		public static readonly int LEFT_PENLIGHT_COLOR_ID = Shader.PropertyToID("_LeftPenlightColor");

		public static readonly int RIGHT_PENLIGHT_COLOR_ID = Shader.PropertyToID("_RightPenlightColor");

		public static readonly int LEFT_PENLIGHT_ACTIVE_ID = Shader.PropertyToID("_LeftPenlightActive");

		public static readonly int RIGHT_PENLIGHT_ACTIVE_ID = Shader.PropertyToID("_RightPenlightActive");

		public static readonly int LEFT_PENLIGHT_POS_ID = Shader.PropertyToID("_LeftPenlightParam");

		public static readonly int RIGHT_PENLIGHT_POS_ID = Shader.PropertyToID("_RightPenlightParam");

		public static readonly int ENABLE_PENLIGHT_LIGHTING_ID = Shader.PropertyToID("_EnablePenlightLighting");

		public static readonly int SKIN_TEX_ID = Shader.PropertyToID("_SkinTex");

		public static readonly int ACCESSORY_TEX_ID = Shader.PropertyToID("_AccessoryTex");

		public static readonly int PENLIGHT_BODY_TEX_ID = Shader.PropertyToID("_PenlightBodyTex");

		public static readonly int PENLIGHT_LIGHT_TEX_ID = Shader.PropertyToID("_PenlightLightTex");

		public static readonly int SKIN_COLOR_ID = Shader.PropertyToID("_SkinColor");

		public static readonly int POWER_ID = Shader.PropertyToID("_Power");

		public static readonly int RIM_COLOR_ID = Shader.PropertyToID("_RimColor");

		public static readonly int TEXTURE_ANIMATION_VALUE_ID = Shader.PropertyToID("_Value");

		public static readonly int EMISSION_ID = Shader.PropertyToID("_Emission");

		public static readonly int EMISSION_COLOR_ID = Shader.PropertyToID("_EmissionColor");

		public static readonly int CLIP_THRESHOLD_ID = Shader.PropertyToID("_ClipThreshold");

		public static readonly int CURRENT_START_FRAME_ID = Shader.PropertyToID("_CurrentStartFrame");

		public static readonly int CURRENT_FRAME_ID = Shader.PropertyToID("_CurrentFrame");

		public static readonly int CURRENT_START_TIME_ID = Shader.PropertyToID("_CurrentStartTime");

		public static readonly int PREV_START_FRAME_ID = Shader.PropertyToID("_PrevStartFrame");

		public static readonly int PREV_FRAME_ID = Shader.PropertyToID("_PrevFrame");

		public static readonly int PREV_START_TIME_ID = Shader.PropertyToID("_PrevStartTime");

		public static readonly int FADE_TIME_ID = Shader.PropertyToID("_FadeTime");

		public static readonly int SPEED_ID = Shader.PropertyToID("_Speed");

		public static readonly int MOB_AVATAR_CURRENT_TIME_ID = Shader.PropertyToID("_MobAvatarCurrentTime");

		public static readonly int Y_AXIS_ID = Shader.PropertyToID("_YAxis");

		public static readonly int CoCParams = Shader.PropertyToID("_CoCParams");

		public static readonly int VIRTUAL_BADGE_LIGHT_DIR0_ID = Shader.PropertyToID("_VirtualBadgeLightDir0");

		public static readonly int VIRTUAL_BADGE_LIGHT_DIR1_ID = Shader.PropertyToID("_VirtualBadgeLightDir1");

		public static readonly int VIRTUAL_BADGE_LIGHT_DIR2_ID = Shader.PropertyToID("_VirtualBadgeLightDir2");

		public static readonly int FADE_ID = Shader.PropertyToID("_Fade");

		public static readonly int FADE_COLOR_ID = Shader.PropertyToID("_FadeColor");

		public static readonly int FILTER_TEX_ID = Shader.PropertyToID("_FilterTex");

		public static readonly int FRONT_TEX_ID = Shader.PropertyToID("_FrontTex");

		public static readonly int BACK_TEX_ID = Shader.PropertyToID("_BackTex");

		public static readonly int RAMP_TEXTURE_ID = Shader.PropertyToID("_RampTexture");

		public static readonly int USE_RAMP_ID = Shader.PropertyToID("_UseRamp");

		public static readonly int MESH_FLARE_PARA_TEX_ID = Shader.PropertyToID("_MeshFlareParaMainTex");

		public static readonly int MESH_FLARE_PARA_BLEND_SRC_ID = Shader.PropertyToID("_MeshFlareParaBlendSrc");

		public static readonly int MESH_FLARE_PARA_BLEND_DST_ID = Shader.PropertyToID("_MeshFlareParaBlendDst");

		public static readonly int MESH_FLARE_PARA_COLOR_ID = Shader.PropertyToID("_MeshFlareParaColor");

		public static readonly int MESH_FLARE_PARA_ZTEST_ID = Shader.PropertyToID("_MeshFlareParaZTest");

		public static readonly int USE_SPECULAR = Shader.PropertyToID("_USE_SPECULAR");
	}
}
