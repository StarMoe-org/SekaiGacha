// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Hidden/Sekai/Live/Reflection"
{
	SubShader
	{
		Tags { "IGNOREPROJECTOR"="true" "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
		Pass
		{
			Name "Character-Caster"
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="ReflectionCaster" "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
			Blend [_ReflectionCasterSrcBlend] [_ReflectionCasterDstBlend], [_ReflectionCasterSrcBlend] [_ReflectionCasterDstBlend]
			Cull Front
			Stencil
			{
				Ref 1
				Comp Equal
				Pass [_StencilPassOperation]
			}
			GLSLPROGRAM
#pragma multi_compile _ USE_DITHER_ALPHA
#pragma multi_compile _ _FACE_SHADOW_RANGE_LIMIT
#pragma multi_compile _ _HAIR_SHADOW
#pragma multi_compile _ _LAMBERT
#pragma multi_compile _ _USE_OVERLAY_FLIPBOOK
#ifdef VERTEX
#version 300 es
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _SekaiFogFactor;
#if defined(_USE_OVERLAY_FLIPBOOK)
uniform 	mediump float _FlipBookMaskThreshold_Character;
uniform 	mediump float _FlipBookMaskFallOff_Character;
uniform 	mediump float _FlipBookUpperDotMaskOpacity_Character;
uniform 	mediump float _FlipBookLowerDotMaskOpacity_Character;
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_LODFade;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_WorldTransformParams;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_RenderingLayer;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_LightData;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_LightIndices[2];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SpecCube0_HDR;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SpecCube1_HDR;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube0_BoxMax;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube0_BoxMin;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube0_ProbePosition;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube1_BoxMax;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube1_BoxMin;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube1_ProbePosition;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_LightmapST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHAr;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHAg;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHAb;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHBr;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHBg;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHBb;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHC;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_RendererBounds_Min;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_RendererBounds_Max;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_MatrixPreviousM[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_MatrixPreviousMI[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_MotionVectorsParams;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_FaceShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_LightMapTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineOffset;
	UNITY_UNIFORM float Xhlslcc_UnusedX_SpecularPower;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM mediump float                _HeadNormalBlend;
#else
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HeadNormalBlend;
#endif
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashTransparent;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsLeftEyeClose;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsRightEyeClose;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM mediump vec4                _ReflectionBlendColor;
	UNITY_UNIFORM int                _BlendMode;
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_FaceFront;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterId;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM vec3                _HeadPosition;
#else
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_HeadPosition;
#endif
	UNITY_UNIFORM float Xhlslcc_UnusedX_RangeLimit;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HeadDotDirectionalLightValues;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowTexWeight;
	UNITY_UNIFORM int Xhlslcc_UnusedX_FadeMode;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out mediump float vs_TEXCOORD4;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD3;
#if defined(_USE_OVERLAY_FLIPBOOK)
out mediump float vs_TEXCOORD6;
#endif
#if defined(USE_DITHER_ALPHA)
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
#if defined(_HAIR_SHADOW)
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb0;
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
vec3 u_xlat0;
#else
vec4 u_xlat0;
#endif
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb0;
#endif
#endif
vec4 u_xlat1;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
vec3 u_xlat2;
vec3 u_xlat3;
#if defined(_USE_OVERLAY_FLIPBOOK)
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_9;
float u_xlat15;
#else
float u_xlat4;
float u_xlat12;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
#else
float u_xlat3;
#endif
float u_xlat7;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb7;
float u_xlat10;
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
vec3 u_xlat2;
#if defined(_USE_OVERLAY_FLIPBOOK)
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
float u_xlat12;
#else
float u_xlat3;
float u_xlat9;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
mediump float u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat10;
#else
float u_xlat2;
float u_xlat7;
#endif
#endif
#endif
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat1;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = max(u_xlat15, 1.17549435e-38);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
#else
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = max(u_xlat12, 1.17549435e-38);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
#endif
    vs_NORMAL0.xyz = u_xlat2.xyz;
#else
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = max(u_xlat10, 1.17549435e-38);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#else
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = max(u_xlat7, 1.17549435e-38);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
#endif
    vs_NORMAL0.xyz = u_xlat1.xyz;
#if !defined(_USE_OVERLAY_FLIPBOOK)
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat1;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = max(u_xlat12, 1.17549435e-38);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
#else
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = max(u_xlat9, 1.17549435e-38);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
#endif
    vs_NORMAL0.xyz = u_xlat2.xyz;
#else
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = max(u_xlat10, 1.17549435e-38);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#else
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = max(u_xlat7, 1.17549435e-38);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
#endif
    vs_NORMAL0.xyz = u_xlat1.xyz;
#if !defined(_USE_OVERLAY_FLIPBOOK)
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
#endif
#endif
#endif
    vs_COLOR0 = in_COLOR0;
#if defined(_HAIR_SHADOW)
    vs_TEXCOORD0 = u_xlat1;
#else
    vs_TEXCOORD0 = u_xlat0;
#endif
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat3.xyz = u_xlat0.xyz + (-vec3(_HeadPosition.x, _HeadPosition.y, _HeadPosition.z));
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx + (-u_xlat2.xyz);
    u_xlat0.xyz = vec3(_HeadNormalBlend) * u_xlat0.xyz + u_xlat2.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD2.xyz = vec3(u_xlat15) * u_xlat0.xyz;
#else
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD2.xyz = vec3(u_xlat12) * u_xlat0.xyz;
#endif
    vs_TEXCOORD5 = u_xlat1.z;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat5 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat5;
#else
    u_xlat4 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat4;
#endif
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD4 = u_xlat0.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlatb0 = 0.0>=u_xlat2.y;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * _FlipBookLowerDotMaskOpacity_Character;
    u_xlatb5 = u_xlat2.y>=0.0;
    u_xlat5 = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat16_4 = u_xlat5 * _FlipBookUpperDotMaskOpacity_Character + u_xlat0.x;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat16_4 = abs(u_xlat2.y) * u_xlat16_4 + (-_FlipBookMaskThreshold_Character);
    u_xlat16_9 = _FlipBookMaskFallOff_Character + 0.00100000005;
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_4 = u_xlat16_9 * u_xlat16_4;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat16_9 = u_xlat16_4 * -2.0 + 3.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    vs_TEXCOORD6 = u_xlat16_4 * u_xlat16_9;
#endif
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
#endif
    vs_TEXCOORD5 = u_xlat0.z;
    u_xlat1.x = u_xlat0.z + _ProjectionParams.y;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat7 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat1.x = u_xlat1.x / u_xlat7;
#else
    u_xlat3 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat1.x = u_xlat1.x / u_xlat3;
#endif
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = (-_SekaiFogFactor.y) * u_xlat1.x + _SekaiFogFactor.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    vs_TEXCOORD4 = u_xlat1.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlatb1 = 0.0>=u_xlat1.y;
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat1.x = u_xlat1.x * _FlipBookLowerDotMaskOpacity_Character;
    u_xlatb7 = u_xlat1.y>=0.0;
    u_xlat7 = u_xlatb7 ? 1.0 : float(0.0);
    u_xlat16_2 = u_xlat7 * _FlipBookUpperDotMaskOpacity_Character + u_xlat1.x;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_2 = abs(u_xlat1.y) * u_xlat16_2 + (-_FlipBookMaskThreshold_Character);
    u_xlat16_5 = _FlipBookMaskFallOff_Character + 0.00100000005;
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
    u_xlat16_5 = float(1.0) / u_xlat16_5;
    u_xlat16_2 = u_xlat16_5 * u_xlat16_2;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = u_xlat16_2 * -2.0 + 3.0;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    vs_TEXCOORD6 = u_xlat16_2 * u_xlat16_5;
#endif
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
#endif
#else
#if defined(_HAIR_SHADOW)
    u_xlat1.xyw = u_xlat0.xyz + (-vec3(_HeadPosition.x, _HeadPosition.y, _HeadPosition.z));
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyw, u_xlat1.xyw);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat1.xyw * u_xlat0.xxx + (-u_xlat2.xyz);
    u_xlat0.xyz = vec3(_HeadNormalBlend) * u_xlat0.xyz + u_xlat2.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD2.xyz = vec3(u_xlat12) * u_xlat0.xyz;
#else
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
#endif
    vs_TEXCOORD5 = u_xlat1.z;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat4 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat4;
#else
    u_xlat3 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat3;
#endif
#else
    vs_TEXCOORD5 = u_xlat0.z;
    u_xlat0.x = u_xlat0.z + _ProjectionParams.y;
#if defined(_USE_OVERLAY_FLIPBOOK)
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat3 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat3;
#else
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
#endif
#endif
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD4 = u_xlat0.x;
#if defined(_HAIR_SHADOW)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlatb0 = 0.0>=u_xlat2.y;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * _FlipBookLowerDotMaskOpacity_Character;
    u_xlatb4 = u_xlat2.y>=0.0;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat16_3 = u_xlat4 * _FlipBookUpperDotMaskOpacity_Character + u_xlat0.x;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = abs(u_xlat2.y) * u_xlat16_3 + (-_FlipBookMaskThreshold_Character);
    u_xlat16_7 = _FlipBookMaskFallOff_Character + 0.00100000005;
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
    u_xlat16_7 = float(1.0) / u_xlat16_7;
    u_xlat16_3 = u_xlat16_7 * u_xlat16_3;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_7 = u_xlat16_3 * -2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    vs_TEXCOORD6 = u_xlat16_3 * u_xlat16_7;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlatb0 = 0.0>=u_xlat1.y;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * _FlipBookLowerDotMaskOpacity_Character;
    u_xlatb3 = u_xlat1.y>=0.0;
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat16_2 = u_xlat3 * _FlipBookUpperDotMaskOpacity_Character + u_xlat0.x;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_2 = abs(u_xlat1.y) * u_xlat16_2 + (-_FlipBookMaskThreshold_Character);
    u_xlat16_5 = _FlipBookMaskFallOff_Character + 0.00100000005;
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
    u_xlat16_5 = float(1.0) / u_xlat16_5;
    u_xlat16_2 = u_xlat16_5 * u_xlat16_2;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = u_xlat16_2 * -2.0 + 3.0;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    vs_TEXCOORD6 = u_xlat16_2 * u_xlat16_5;
#endif
#endif
#endif
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec2 _GlobalMipBias;
uniform 	vec4 _ProjectionParams;
#if defined(USE_DITHER_ALPHA)
uniform 	vec4 _ScreenParams;
#endif
uniform 	vec4 _CoCParams;
uniform 	vec4 _SekaiFogColor;
#if defined(USE_DITHER_ALPHA)
uniform 	mediump float _DitherAlpha;
#endif
#if defined(_USE_OVERLAY_FLIPBOOK)
uniform 	vec3 _FlipBookCenterPosition;
uniform 	float _GlobalFlipBookTime;
uniform 	mediump float _FlipBookFrameCountX;
uniform 	mediump float _FlipBookFrameCountY;
uniform 	mediump float _FlipBookFPS;
uniform 	mediump vec4 _FlipBookColor_Character;
uniform 	mediump float _FlipBookOpacity;
uniform 	mediump float _FlipBookFadeRadius;
uniform 	mediump float _FlipBookFadeFallOff;
uniform 	mediump float _FlipBookScale_Character;
uniform 	vec2 _FlipBookUVScroll_Character;
#endif
uniform 	vec4 _SekaiDirectionalLight;
uniform 	mediump vec4 _SekaiShadowColor;
uniform 	mediump float _SekaiShadowThreshold;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_FaceShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_LightMapTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineOffset;
	UNITY_UNIFORM float Xhlslcc_UnusedX_SpecularPower;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM mediump float                _HeadNormalBlend;
#else
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HeadNormalBlend;
#endif
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashTransparent;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsLeftEyeClose;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsRightEyeClose;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM mediump vec4                _ReflectionBlendColor;
	UNITY_UNIFORM int                _BlendMode;
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_FaceFront;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterId;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM vec3                _HeadPosition;
#else
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_HeadPosition;
#endif
	UNITY_UNIFORM float Xhlslcc_UnusedX_RangeLimit;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HeadDotDirectionalLightValues;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowTexWeight;
	UNITY_UNIFORM int Xhlslcc_UnusedX_FadeMode;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if defined(USE_DITHER_ALPHA)
#if defined(_USE_OVERLAY_FLIPBOOK)
UNITY_LOCATION(0) uniform mediump sampler2D _FlipBookTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DitherTex;
UNITY_LOCATION(2) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(3) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(4) uniform mediump sampler2D _ValueTex;
#else
UNITY_LOCATION(0) uniform mediump sampler2D _DitherTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(3) uniform mediump sampler2D _ValueTex;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
UNITY_LOCATION(0) uniform mediump sampler2D _FlipBookTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(3) uniform mediump sampler2D _ValueTex;
#else
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ValueTex;
#endif
#endif
in mediump float vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
#if defined(_USE_OVERLAY_FLIPBOOK)
in highp vec3 vs_TEXCOORD3;
in mediump float vs_TEXCOORD6;
#endif
#if defined(USE_DITHER_ALPHA)
in highp vec4 vs_TEXCOORD7;
#endif
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
#if defined(USE_DITHER_ALPHA)
bool u_xlatb0;
mediump vec4 u_xlat16_1;
#if defined(_USE_OVERLAY_FLIPBOOK)
vec4 u_xlat2;
#else
vec3 u_xlat2;
#endif
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
mediump vec3 u_xlat16_2;
#endif
#endif
bvec3 u_xlatb2;
#else
#if defined(_HAIR_SHADOW)
bool u_xlatb0;
#if defined(_LAMBERT)
#if defined(_USE_OVERLAY_FLIPBOOK)
vec4 u_xlat1;
#else
float u_xlat1;
#endif
mediump vec4 u_xlat16_1;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
#else
vec3 u_xlat1;
#endif
#endif
#else
#if !defined(_LAMBERT)
bool u_xlatb0;
#endif
#if defined(_USE_OVERLAY_FLIPBOOK)
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
#else
vec3 u_xlat1;
#endif
#endif
bvec3 u_xlatb1;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
vec3 u_xlat2;
#endif
#endif
mediump vec4 u_xlat16_2;
#endif
#if defined(_HAIR_SHADOW)
#if !defined(_LAMBERT)
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat3;
#endif
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat3;
#endif
#endif
mediump vec3 u_xlat16_3;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
mediump float u_xlat16_4;
#else
mediump vec4 u_xlat16_4;
#endif
mediump vec3 u_xlat16_5;
#if defined(_LAMBERT)
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat6;
#endif
#endif
#else
#if defined(_LAMBERT)
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
#else
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
#endif
#endif
mediump vec3 u_xlat16_6;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
float u_xlat7;
bool u_xlatb7;
#else
mediump vec3 u_xlat16_8;
#endif
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat9;
#else
float u_xlat9;
#endif
#if defined(_LAMBERT)
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat14;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb16;
#endif
mediump float u_xlat16_17;
mediump float u_xlat16_18;
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat20;
#endif
#else
mediump float u_xlat16_12;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb16;
vec2 u_xlat17;
#endif
mediump float u_xlat16_19;
#endif
float u_xlat21;
#if defined(_LAMBERT)
#if defined(_USE_OVERLAY_FLIPBOOK)
float u_xlat23;
#endif
mediump float u_xlat16_24;
mediump float u_xlat16_25;
#else
bool u_xlatb21;
mediump float u_xlat16_22;
float u_xlat23;
mediump float u_xlat16_23;
mediump float u_xlat16_26;
#endif
#else
#if defined(_LAMBERT)
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_9;
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat10;
#else
float u_xlat10;
#endif
mediump float u_xlat16_14;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb18;
vec2 u_xlat19;
#endif
#else
mediump vec3 u_xlat16_8;
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat9;
#else
float u_xlat9;
#endif
mediump float u_xlat16_12;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb16;
vec2 u_xlat17;
#endif
mediump float u_xlat16_19;
float u_xlat21;
bool u_xlatb21;
#endif
mediump float u_xlat16_22;
#if defined(_LAMBERT)
float u_xlat24;
bool u_xlatb24;
mediump float u_xlat16_25;
float u_xlat26;
mediump float u_xlat16_30;
#else
float u_xlat23;
mediump float u_xlat16_23;
mediump float u_xlat16_26;
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
float u_xlat7;
bool u_xlatb7;
#endif
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat8;
#else
float u_xlat8;
#endif
#if defined(_LAMBERT)
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat14;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb15;
#endif
mediump float u_xlat16_17;
mediump float u_xlat16_18;
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat20;
#endif
#else
mediump vec3 u_xlat16_9;
mediump float u_xlat16_12;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb15;
vec2 u_xlat17;
#endif
mediump float u_xlat16_19;
#endif
float u_xlat21;
#if defined(_LAMBERT)
#if defined(_USE_OVERLAY_FLIPBOOK)
float u_xlat22;
#endif
mediump float u_xlat16_24;
mediump float u_xlat16_25;
#else
bool u_xlatb21;
float u_xlat22;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
mediump float u_xlat16_26;
#endif
#else
#if defined(_LAMBERT)
mediump vec3 u_xlat16_7;
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat9;
#else
float u_xlat9;
#endif
mediump vec3 u_xlat16_10;
mediump float u_xlat16_14;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb17;
vec2 u_xlat19;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat8;
#else
float u_xlat8;
#endif
mediump vec3 u_xlat16_9;
mediump float u_xlat16_12;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb15;
vec2 u_xlat17;
#endif
mediump float u_xlat16_19;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
#endif
mediump float u_xlat16_22;
#if defined(_LAMBERT)
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
#else
mediump float u_xlat16_23;
#endif
mediump float u_xlat16_26;
#if defined(_LAMBERT)
mediump float u_xlat16_30;
#endif
#endif
#endif
void main()
{
#if defined(USE_DITHER_ALPHA)
    u_xlat0.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat16_0.x = texture(_DitherTex, u_xlat0.xy, _GlobalMipBias.x).x;
    u_xlat16_1.x = (-u_xlat16_0.x) + _DitherAlpha;
    u_xlatb0 = u_xlat16_1.x<0.0;
    if(u_xlatb0){discard;}
#endif
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat0.x = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat7 = u_xlat0.x;
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
    u_xlatb7 = _SekaiShadowThreshold>=u_xlat7;
    u_xlat7 = u_xlatb7 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat2.xyz = u_xlat16_1.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat2.xyz = u_xlat16_1.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat2.zxy);
    u_xlat2.xyz = u_xlat2.xyz * vec3(_HueSinAngle);
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat2.xyz;
    u_xlat16_3.x = (-_HueCosAngle) + 1.0;
    u_xlat14 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_1.xyz);
    u_xlat14 = u_xlat14 * 0.57735002;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat16_3.xxx + u_xlat2.xyz;
    u_xlat16_10.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_4 = _Value * 2.0 + -1.0;
    u_xlat16_11 = _Contrast + _Contrast;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(u_xlat16_11) + vec3(u_xlat16_4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_18 = dot(u_xlat16_10.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_10.xyz = u_xlat16_10.xyz + (-vec3(u_xlat16_18));
    u_xlat16_25 = _Saturation + _Saturation;
    u_xlat16_10.xyz = vec3(u_xlat16_25) * u_xlat16_10.xyz + vec3(u_xlat16_18);
    u_xlat16_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_5.xyz = (-u_xlat16_10.xyz) + u_xlat16_2.xyz;
    u_xlat14 = (-u_xlat16_1.x) + u_xlat16_2.x;
    u_xlat16_5.xyz = vec3(u_xlat7) * u_xlat16_5.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * _SekaiShadowColor.xyz + (-u_xlat16_10.xyz);
    u_xlat16_6.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_18 = u_xlat16_6.z * 2.0 + -1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlatb0 = u_xlat0.x>=_SekaiShadowThreshold;
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat16_10.xyz;
    u_xlat0.x = u_xlat0.x * u_xlat14 + u_xlat16_1.x;
    u_xlat16_10.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
    u_xlat16_17 = u_xlat0.x + u_xlat0.x;
    u_xlat16_17 = u_xlat16_17;
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
    u_xlat0.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat16_5.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_5.xyz = u_xlat16_10.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_5.xyz;
#endif
#endif
    u_xlat0.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_10.xyz = vec3(u_xlat16_17) * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat16_10.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_10.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
#else
    u_xlat2.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat16_1.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD2.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat16_3.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_22 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = u_xlat21 + u_xlat16_22;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = u_xlat21>=_SekaiShadowThreshold;
    u_xlat21 = (u_xlatb21) ? 0.0 : 1.0;
    u_xlat16_23 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat23 = u_xlat16_23 + (-u_xlat16_4.x);
    u_xlat21 = u_xlat21 * u_xlat23 + u_xlat16_4.x;
    u_xlat16_22 = u_xlat21 * 2.0 + -1.0;
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
    u_xlat16_5.x = u_xlat21 + u_xlat21;
    u_xlat16_5.x = u_xlat16_5.x;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat16_1.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_1.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
#endif
#else
    u_xlat2.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat16_1.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
#if defined(_LAMBERT)
    u_xlat24 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD2.xyz);
    u_xlat24 = u_xlat24 * 0.5 + 0.5;
#else
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD2.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
#endif
    u_xlat16_3.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
#if defined(_LAMBERT)
    u_xlat16_25 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat24 = u_xlat24 + u_xlat16_25;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlatb24 = u_xlat24>=_SekaiShadowThreshold;
    u_xlat24 = (u_xlatb24) ? 0.0 : 1.0;
    u_xlat16_4.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_5 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat26 = u_xlat16_4.x + (-u_xlat16_5.x);
    u_xlat26 = u_xlat24 * u_xlat26 + u_xlat16_5.x;
    u_xlat16_25 = u_xlat26 * 2.0 + -1.0;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_6.x = u_xlat26 + u_xlat26;
    u_xlat16_6.x = u_xlat16_6.x;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz + u_xlat2.xyz;
#else
    u_xlat16_22 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = u_xlat21 + u_xlat16_22;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = u_xlat21>=_SekaiShadowThreshold;
    u_xlat21 = (u_xlatb21) ? 0.0 : 1.0;
    u_xlat16_23 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat23 = u_xlat16_23 + (-u_xlat16_4.x);
    u_xlat21 = u_xlat21 * u_xlat23 + u_xlat16_4.x;
    u_xlat16_22 = u_xlat21 * 2.0 + -1.0;
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
    u_xlat16_5.x = u_xlat21 + u_xlat21;
    u_xlat16_5.x = u_xlat16_5.x;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz + u_xlat2.xyz;
#endif
    u_xlat16_1.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_1.xyz;
#if defined(_LAMBERT)
    u_xlat16_1.xyz = u_xlat16_6.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
#else
    u_xlat16_1.xyz = u_xlat16_5.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
#endif
    u_xlat0.xyz = u_xlat16_1.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_1.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
#endif
#else
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_10.xyz = vec3(u_xlat16_17) * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat16_10.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_10.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
#else
    u_xlat1.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat16_2.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD2.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat16_3.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_23 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = u_xlat21 + u_xlat16_23;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = u_xlat21>=_SekaiShadowThreshold;
    u_xlat21 = (u_xlatb21) ? 0.0 : 1.0;
    u_xlat16_22 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat22 = u_xlat16_22 + (-u_xlat16_4.x);
    u_xlat21 = u_xlat21 * u_xlat22 + u_xlat16_4.x;
    u_xlat16_23 = u_xlat21 * 2.0 + -1.0;
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_5.x = u_xlat21 + u_xlat21;
    u_xlat16_5.x = u_xlat16_5.x;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
#endif
#else
    u_xlat1.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat16_2.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
#if defined(_LAMBERT)
    u_xlat24 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD2.xyz);
    u_xlat24 = u_xlat24 * 0.5 + 0.5;
#else
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD2.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
#endif
    u_xlat16_3.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
#if defined(_LAMBERT)
    u_xlat16_26 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat24 = u_xlat24 + u_xlat16_26;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlatb24 = u_xlat24>=_SekaiShadowThreshold;
    u_xlat24 = (u_xlatb24) ? 0.0 : 1.0;
    u_xlat16_4.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_5 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat25 = u_xlat16_4.x + (-u_xlat16_5.x);
    u_xlat25 = u_xlat24 * u_xlat25 + u_xlat16_5.x;
    u_xlat16_26 = u_xlat25 * 2.0 + -1.0;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_6.x = u_xlat25 + u_xlat25;
    u_xlat16_6.x = u_xlat16_6.x;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz + u_xlat1.xyz;
#else
    u_xlat16_23 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = u_xlat21 + u_xlat16_23;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = u_xlat21>=_SekaiShadowThreshold;
    u_xlat21 = (u_xlatb21) ? 0.0 : 1.0;
    u_xlat16_22 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat22 = u_xlat16_22 + (-u_xlat16_4.x);
    u_xlat21 = u_xlat21 * u_xlat22 + u_xlat16_4.x;
    u_xlat16_23 = u_xlat21 * 2.0 + -1.0;
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_5.x = u_xlat21 + u_xlat21;
    u_xlat16_5.x = u_xlat16_5.x;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat1.xyz;
#endif
    u_xlat16_2.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_2.xyz;
#if defined(_LAMBERT)
    u_xlat16_2.xyz = u_xlat16_6.xxx * u_xlat16_2.xyz + u_xlat0.xyz;
#else
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + u_xlat0.xyz;
#endif
    u_xlat0.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
#endif
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(_HueSinAngle);
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat0.xyz = u_xlat16_10.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat0.xyz;
    u_xlat21 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_10.xyz);
#else
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat0.xyz;
    u_xlat21 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_1.xyz);
#endif
    u_xlat21 = u_xlat21 * 0.57735002;
#if defined(_LAMBERT)
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_11) + vec3(u_xlat16_4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_24 = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.xyz = (-vec3(u_xlat16_24)) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_25) * u_xlat16_3.xyz + vec3(u_xlat16_24);
    u_xlat16_3.xyz = (-u_xlat2.xyz) + u_xlat16_3.xyz;
    u_xlatb0 = u_xlat16_6.x>=0.5;
    u_xlat16_24 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat2.xyz;
    u_xlat0.xyz = (-u_xlat16_3.xyz) + _SekaiFogColor.xyz;
    u_xlat16_24 = (-vs_TEXCOORD4) + 1.0;
    u_xlat21 = u_xlat16_24 * _SekaiFogColor.w;
    u_xlat16_1.xyz = vec3(u_xlat21) * u_xlat0.xyz + u_xlat16_3.xyz;
    SV_Target2.xyz = u_xlat16_6.yyy * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz * _ReflectionBlendColor.www;
#else
    u_xlat16_1.x = (-_HueCosAngle) + 1.0;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat16_8.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_5.x = _Value * 2.0 + -1.0;
    u_xlat16_12 = _Contrast + _Contrast;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(u_xlat16_12) + u_xlat16_5.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_19 = dot(u_xlat16_8.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-vec3(u_xlat16_19));
    u_xlat16_26 = _Saturation + _Saturation;
    u_xlat16_8.xyz = vec3(u_xlat16_26) * u_xlat16_8.xyz + vec3(u_xlat16_19);
    u_xlat0.xyz = u_xlat16_4.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_4.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_HueSinAngle);
    u_xlat0.xyz = u_xlat16_4.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat0.xyz;
    u_xlat21 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_4.xyz);
    u_xlat21 = u_xlat21 * 0.57735002;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_12) + u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_1.x = dot(u_xlat16_5.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_5.xyz = (-u_xlat16_1.xxx) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz + u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_8.xyz + (-u_xlat16_5.xyz);
    u_xlatb0 = u_xlat16_3.x>=0.5;
    u_xlat16_22 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat0.xyz = (-u_xlat16_1.xyz) + _SekaiFogColor.xyz;
    u_xlat16_22 = (-vs_TEXCOORD4) + 1.0;
    u_xlat21 = u_xlat16_22 * _SekaiFogColor.w;
    u_xlat16_4.xyz = vec3(u_xlat21) * u_xlat0.xyz + u_xlat16_1.xyz;
    SV_Target2.xyz = u_xlat16_3.yyy * u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _ReflectionBlendColor.www;
#endif
#else
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat0.xyz;
#if defined(_LAMBERT)
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_1.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
#else
    u_xlat21 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_1.xyz);
    u_xlat21 = u_xlat21 * 0.57735002;
#endif
    u_xlat16_1.x = (-_HueCosAngle) + 1.0;
#if defined(_LAMBERT)
    u_xlat0.xyz = u_xlat2.xxx * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat16_9.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_6.x = _Value * 2.0 + -1.0;
    u_xlat16_14 = _Contrast + _Contrast;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(u_xlat16_14) + u_xlat16_6.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_22 = dot(u_xlat16_9.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-vec3(u_xlat16_22));
    u_xlat16_30 = _Saturation + _Saturation;
    u_xlat16_9.xyz = vec3(u_xlat16_30) * u_xlat16_9.xyz + vec3(u_xlat16_22);
    u_xlat0.xyz = u_xlat16_5.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_5.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
#else
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat16_8.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_5.x = _Value * 2.0 + -1.0;
    u_xlat16_12 = _Contrast + _Contrast;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(u_xlat16_12) + u_xlat16_5.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_19 = dot(u_xlat16_8.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-vec3(u_xlat16_19));
    u_xlat16_26 = _Saturation + _Saturation;
    u_xlat16_8.xyz = vec3(u_xlat16_26) * u_xlat16_8.xyz + vec3(u_xlat16_19);
    u_xlat0.xyz = u_xlat16_4.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_4.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(_HueSinAngle);
#if defined(_LAMBERT)
    u_xlat0.xyz = u_xlat16_5.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat0.xyz;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_5.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat0.xyz = u_xlat2.xxx * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(u_xlat16_14) + u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_1.x = dot(u_xlat16_6.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_6.xyz = (-u_xlat16_1.xxx) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz + u_xlat16_1.xxx;
    u_xlat0.xyz = u_xlat16_4.xyz * _SekaiShadowColor.xyz + (-u_xlat16_6.xyz);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + u_xlat16_9.xyz;
    u_xlatb24 = u_xlat16_3.x>=0.5;
    u_xlat16_25 = (u_xlatb24) ? 1.0 : 0.0;
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz + u_xlat0.xyz;
#else
    u_xlat0.xyz = u_xlat16_4.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat0.xyz;
    u_xlat21 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_4.xyz);
    u_xlat21 = u_xlat21 * 0.57735002;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_12) + u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_1.x = dot(u_xlat16_5.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_5.xyz = (-u_xlat16_1.xxx) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz + u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_8.xyz + (-u_xlat16_5.xyz);
    u_xlatb0 = u_xlat16_3.x>=0.5;
    u_xlat16_22 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz + u_xlat16_5.xyz;
#endif
    u_xlat0.xyz = (-u_xlat16_1.xyz) + _SekaiFogColor.xyz;
#if defined(_LAMBERT)
    u_xlat16_25 = (-vs_TEXCOORD4) + 1.0;
    u_xlat24 = u_xlat16_25 * _SekaiFogColor.w;
    u_xlat16_5.xyz = vec3(u_xlat24) * u_xlat0.xyz + u_xlat16_1.xyz;
#else
    u_xlat16_22 = (-vs_TEXCOORD4) + 1.0;
    u_xlat21 = u_xlat16_22 * _SekaiFogColor.w;
    u_xlat16_4.xyz = vec3(u_xlat21) * u_xlat0.xyz + u_xlat16_1.xyz;
#endif
    SV_Target2.xyz = u_xlat16_3.yyy * u_xlat16_1.xyz;
#if defined(_LAMBERT)
    u_xlat16_0.xyz = u_xlat16_5.xyz * _ReflectionBlendColor.www;
#else
    u_xlat16_0.xyz = u_xlat16_4.xyz * _ReflectionBlendColor.www;
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat0.xyz = u_xlat16_10.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat0.xyz;
    u_xlat21 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_10.xyz);
#else
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat0.xyz;
    u_xlat21 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
#endif
    u_xlat21 = u_xlat21 * 0.57735002;
#if defined(_LAMBERT)
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_11) + vec3(u_xlat16_4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_24 = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.xyz = (-vec3(u_xlat16_24)) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_25) * u_xlat16_3.xyz + vec3(u_xlat16_24);
    u_xlat16_3.xyz = (-u_xlat2.xyz) + u_xlat16_3.xyz;
    u_xlatb0 = u_xlat16_6.x>=0.5;
    u_xlat16_24 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat2.xyz;
    u_xlat0.xyz = (-u_xlat16_3.xyz) + _SekaiFogColor.xyz;
    u_xlat16_24 = (-vs_TEXCOORD4) + 1.0;
    u_xlat21 = u_xlat16_24 * _SekaiFogColor.w;
    u_xlat16_1.xyz = vec3(u_xlat21) * u_xlat0.xyz + u_xlat16_3.xyz;
    SV_Target2.xyz = u_xlat16_6.yyy * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz * _ReflectionBlendColor.www;
#else
    u_xlat16_2.x = (-_HueCosAngle) + 1.0;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_9.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_5.x = _Value * 2.0 + -1.0;
    u_xlat16_12 = _Contrast + _Contrast;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(u_xlat16_12) + u_xlat16_5.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_19 = dot(u_xlat16_9.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-vec3(u_xlat16_19));
    u_xlat16_26 = _Saturation + _Saturation;
    u_xlat16_9.xyz = vec3(u_xlat16_26) * u_xlat16_9.xyz + vec3(u_xlat16_19);
    u_xlat0.xyz = u_xlat16_4.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_4.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_HueSinAngle);
    u_xlat0.xyz = u_xlat16_4.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat0.xyz;
    u_xlat21 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_4.xyz);
    u_xlat21 = u_xlat21 * 0.57735002;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_12) + u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_2.x = dot(u_xlat16_5.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_5.xyz = (-u_xlat16_2.xxx) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz + u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_9.xyz + (-u_xlat16_5.xyz);
    u_xlatb0 = u_xlat16_3.x>=0.5;
    u_xlat16_23 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat0.xyz = (-u_xlat16_2.xyz) + _SekaiFogColor.xyz;
    u_xlat16_23 = (-vs_TEXCOORD4) + 1.0;
    u_xlat21 = u_xlat16_23 * _SekaiFogColor.w;
    u_xlat16_4.xyz = vec3(u_xlat21) * u_xlat0.xyz + u_xlat16_2.xyz;
    SV_Target2.xyz = u_xlat16_3.yyy * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _ReflectionBlendColor.www;
#endif
#else
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat0.xyz;
#if defined(_LAMBERT)
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
#else
    u_xlat21 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat21 = u_xlat21 * 0.57735002;
#endif
    u_xlat16_2.x = (-_HueCosAngle) + 1.0;
#if defined(_LAMBERT)
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_10.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_6.x = _Value * 2.0 + -1.0;
    u_xlat16_14 = _Contrast + _Contrast;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(u_xlat16_14) + u_xlat16_6.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_22 = dot(u_xlat16_10.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_10.xyz = u_xlat16_10.xyz + (-vec3(u_xlat16_22));
    u_xlat16_30 = _Saturation + _Saturation;
    u_xlat16_10.xyz = vec3(u_xlat16_30) * u_xlat16_10.xyz + vec3(u_xlat16_22);
    u_xlat0.xyz = u_xlat16_5.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_5.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
#else
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_9.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_5.x = _Value * 2.0 + -1.0;
    u_xlat16_12 = _Contrast + _Contrast;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(u_xlat16_12) + u_xlat16_5.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_19 = dot(u_xlat16_9.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-vec3(u_xlat16_19));
    u_xlat16_26 = _Saturation + _Saturation;
    u_xlat16_9.xyz = vec3(u_xlat16_26) * u_xlat16_9.xyz + vec3(u_xlat16_19);
    u_xlat0.xyz = u_xlat16_4.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_4.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(_HueSinAngle);
#if defined(_LAMBERT)
    u_xlat0.xyz = u_xlat16_5.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat0.xyz;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_5.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(u_xlat16_14) + u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_2.x = dot(u_xlat16_6.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_6.xyz = (-u_xlat16_2.xxx) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz + u_xlat16_2.xxx;
    u_xlat0.xyz = u_xlat16_4.xyz * _SekaiShadowColor.xyz + (-u_xlat16_6.xyz);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat16_10.xyz;
    u_xlatb24 = u_xlat16_3.x>=0.5;
    u_xlat16_26 = (u_xlatb24) ? 1.0 : 0.0;
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz + u_xlat0.xyz;
#else
    u_xlat0.xyz = u_xlat16_4.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat0.xyz;
    u_xlat21 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_4.xyz);
    u_xlat21 = u_xlat21 * 0.57735002;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_12) + u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_2.x = dot(u_xlat16_5.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_5.xyz = (-u_xlat16_2.xxx) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz + u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_9.xyz + (-u_xlat16_5.xyz);
    u_xlatb0 = u_xlat16_3.x>=0.5;
    u_xlat16_23 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_5.xyz;
#endif
    u_xlat0.xyz = (-u_xlat16_2.xyz) + _SekaiFogColor.xyz;
#if defined(_LAMBERT)
    u_xlat16_26 = (-vs_TEXCOORD4) + 1.0;
    u_xlat24 = u_xlat16_26 * _SekaiFogColor.w;
    u_xlat16_5.xyz = vec3(u_xlat24) * u_xlat0.xyz + u_xlat16_2.xyz;
#else
    u_xlat16_23 = (-vs_TEXCOORD4) + 1.0;
    u_xlat21 = u_xlat16_23 * _SekaiFogColor.w;
    u_xlat16_4.xyz = vec3(u_xlat21) * u_xlat0.xyz + u_xlat16_2.xyz;
#endif
    SV_Target2.xyz = u_xlat16_3.yyy * u_xlat16_2.xyz;
#if defined(_LAMBERT)
    u_xlat16_0.xyz = u_xlat16_5.xyz * _ReflectionBlendColor.www;
#else
    u_xlat16_0.xyz = u_xlat16_4.xyz * _ReflectionBlendColor.www;
#endif
#endif
#endif
    u_xlat16_0.w = _ReflectionBlendColor.w;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_0 = (_BlendMode != 0) ? u_xlat16_1 : u_xlat16_0;
#else
    u_xlat16_0 = (_BlendMode != 0) ? u_xlat16_4 : u_xlat16_0;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_0 = (_BlendMode != 0) ? u_xlat16_5 : u_xlat16_0;
#else
    u_xlat16_0 = (_BlendMode != 0) ? u_xlat16_4 : u_xlat16_0;
#endif
#endif
#if defined(USE_DITHER_ALPHA)
    u_xlatb2.xyz = equal(ivec4(_BlendMode), ivec4(1, 2, 3, 0)).xyz;
    u_xlat16_0 = (u_xlatb2.x) ? _ReflectionBlendColor : u_xlat16_0;
    u_xlat16_1.xyz = _ReflectionBlendColor.www * _ReflectionBlendColor.xyz;
    u_xlat16_1.w = _ReflectionBlendColor.w;
    u_xlat16_0 = (u_xlatb2.y) ? u_xlat16_1 : u_xlat16_0;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_3.xyz = _ReflectionBlendColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = _ReflectionBlendColor.www * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
#else
    u_xlat16_1.xyz = _ReflectionBlendColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = _ReflectionBlendColor.www * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
#endif
#else
    u_xlat16_1.xyz = _ReflectionBlendColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = _ReflectionBlendColor.www * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
#endif
    u_xlat16_1.w = 0.0;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_0 = (u_xlatb2.z) ? u_xlat16_1 : u_xlat16_0;
    u_xlat2.x = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat9.x = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat2.x = u_xlat2.x / u_xlat9.x;
    u_xlatb16 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb16) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat2.x = u_xlat9.x * u_xlat2.x;
    u_xlat2.x = floor(u_xlat2.x);
    u_xlat9.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat23 = u_xlat9.x * u_xlat2.x;
    u_xlat23 = floor(u_xlat23);
    u_xlat6.x = (-_FlipBookFrameCountX) * u_xlat23 + u_xlat2.x;
    u_xlat2.x = u_xlat23 + 1.0;
    u_xlat6.y = (-u_xlat2.x) + _FlipBookFrameCountY;
    u_xlat2.xw = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat20.xy = vs_TEXCOORD3.xz + (-_FlipBookCenterPosition.xz);
    u_xlat2.xw = u_xlat20.xy * vec2(_FlipBookScale_Character) + (-u_xlat2.xw);
    u_xlat20.x = dot(u_xlat20.xy, u_xlat20.xy);
    u_xlat20.x = sqrt(u_xlat20.x);
    u_xlat20.x = u_xlat20.x + (-_FlipBookFadeRadius);
    u_xlat20.x = u_xlat20.x + (-_FlipBookFadeFallOff);
    u_xlat2.xw = fract(u_xlat2.xw);
    u_xlat2.xw = u_xlat6.xy + u_xlat2.xw;
    u_xlat2.xy = u_xlat9.xy * u_xlat2.xw;
    u_xlat16_1 = texture(_FlipBookTex, u_xlat2.xy);
    u_xlat16_3.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vs_TEXCOORD6);
    u_xlat16_3.xyz = u_xlat16_3.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _FlipBookColor_Character.www;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_FlipBookOpacity);
    u_xlat2.x = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat2.x = u_xlat2.x * u_xlat20.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat9.x = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat9.x;
    u_xlat2.xyz = u_xlat16_3.xyz * u_xlat2.xxx + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat2.xyz;
#else
    SV_Target0 = (u_xlatb2.z) ? u_xlat16_1 : u_xlat16_0;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_0 = (u_xlatb2.z) ? u_xlat16_1 : u_xlat16_0;
    u_xlat2.x = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat9.x = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat2.x = u_xlat2.x / u_xlat9.x;
    u_xlatb16 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb16) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat2.x = u_xlat9.x * u_xlat2.x;
    u_xlat2.x = floor(u_xlat2.x);
    u_xlat9.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat23 = u_xlat9.x * u_xlat2.x;
    u_xlat23 = floor(u_xlat23);
    u_xlat3.x = (-_FlipBookFrameCountX) * u_xlat23 + u_xlat2.x;
    u_xlat2.x = u_xlat23 + 1.0;
    u_xlat3.y = (-u_xlat2.x) + _FlipBookFrameCountY;
    u_xlat2.xw = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat17.xy = vs_TEXCOORD3.xz + (-_FlipBookCenterPosition.xz);
    u_xlat2.xw = u_xlat17.xy * vec2(_FlipBookScale_Character) + (-u_xlat2.xw);
    u_xlat17.x = dot(u_xlat17.xy, u_xlat17.xy);
    u_xlat17.x = sqrt(u_xlat17.x);
    u_xlat17.x = u_xlat17.x + (-_FlipBookFadeRadius);
    u_xlat17.x = u_xlat17.x + (-_FlipBookFadeFallOff);
    u_xlat2.xw = fract(u_xlat2.xw);
    u_xlat2.xw = u_xlat3.xy + u_xlat2.xw;
    u_xlat2.xy = u_xlat9.xy * u_xlat2.xw;
    u_xlat16_1 = texture(_FlipBookTex, u_xlat2.xy);
    u_xlat16_5.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vs_TEXCOORD6);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _FlipBookColor_Character.www;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_FlipBookOpacity);
    u_xlat2.x = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat2.x = u_xlat2.x * u_xlat17.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat9.x = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat9.x;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat2.xxx + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat2.xyz;
#else
    SV_Target0 = (u_xlatb2.z) ? u_xlat16_1 : u_xlat16_0;
#endif
#endif
#else
#if defined(_LAMBERT)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_0 = (u_xlatb2.z) ? u_xlat16_1 : u_xlat16_0;
    u_xlat2.x = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat10.x = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat2.x = u_xlat2.x / u_xlat10.x;
    u_xlatb18 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb18) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = floor(u_xlat2.x);
    u_xlat10.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat26 = u_xlat10.x * u_xlat2.x;
    u_xlat26 = floor(u_xlat26);
    u_xlat3.x = (-_FlipBookFrameCountX) * u_xlat26 + u_xlat2.x;
    u_xlat2.x = u_xlat26 + 1.0;
    u_xlat3.y = (-u_xlat2.x) + _FlipBookFrameCountY;
    u_xlat2.xw = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat19.xy = vs_TEXCOORD3.xz + (-_FlipBookCenterPosition.xz);
    u_xlat2.xw = u_xlat19.xy * vec2(_FlipBookScale_Character) + (-u_xlat2.xw);
    u_xlat19.x = dot(u_xlat19.xy, u_xlat19.xy);
    u_xlat19.x = sqrt(u_xlat19.x);
    u_xlat19.x = u_xlat19.x + (-_FlipBookFadeRadius);
    u_xlat19.x = u_xlat19.x + (-_FlipBookFadeFallOff);
    u_xlat2.xw = fract(u_xlat2.xw);
    u_xlat2.xw = u_xlat3.xy + u_xlat2.xw;
    u_xlat2.xy = u_xlat10.xy * u_xlat2.xw;
    u_xlat16_1 = texture(_FlipBookTex, u_xlat2.xy);
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vs_TEXCOORD6);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _FlipBookColor_Character.www;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_FlipBookOpacity);
    u_xlat2.x = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat2.x = u_xlat2.x * u_xlat19.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat10.x = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat10.x;
    u_xlat2.xyz = u_xlat16_6.xyz * u_xlat2.xxx + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat2.xyz;
#else
    SV_Target0 = (u_xlatb2.z) ? u_xlat16_1 : u_xlat16_0;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_0 = (u_xlatb2.z) ? u_xlat16_1 : u_xlat16_0;
    u_xlat2.x = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat9.x = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat2.x = u_xlat2.x / u_xlat9.x;
    u_xlatb16 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb16) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat2.x = u_xlat9.x * u_xlat2.x;
    u_xlat2.x = floor(u_xlat2.x);
    u_xlat9.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat23 = u_xlat9.x * u_xlat2.x;
    u_xlat23 = floor(u_xlat23);
    u_xlat3.x = (-_FlipBookFrameCountX) * u_xlat23 + u_xlat2.x;
    u_xlat2.x = u_xlat23 + 1.0;
    u_xlat3.y = (-u_xlat2.x) + _FlipBookFrameCountY;
    u_xlat2.xw = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat17.xy = vs_TEXCOORD3.xz + (-_FlipBookCenterPosition.xz);
    u_xlat2.xw = u_xlat17.xy * vec2(_FlipBookScale_Character) + (-u_xlat2.xw);
    u_xlat17.x = dot(u_xlat17.xy, u_xlat17.xy);
    u_xlat17.x = sqrt(u_xlat17.x);
    u_xlat17.x = u_xlat17.x + (-_FlipBookFadeRadius);
    u_xlat17.x = u_xlat17.x + (-_FlipBookFadeFallOff);
    u_xlat2.xw = fract(u_xlat2.xw);
    u_xlat2.xw = u_xlat3.xy + u_xlat2.xw;
    u_xlat2.xy = u_xlat9.xy * u_xlat2.xw;
    u_xlat16_1 = texture(_FlipBookTex, u_xlat2.xy);
    u_xlat16_5.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vs_TEXCOORD6);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _FlipBookColor_Character.www;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_FlipBookOpacity);
    u_xlat2.x = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat2.x = u_xlat2.x * u_xlat17.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat9.x = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat9.x;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat2.xxx + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat2.xyz;
#else
    SV_Target0 = (u_xlatb2.z) ? u_xlat16_1 : u_xlat16_0;
#endif
#endif
#endif
    u_xlat2.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
#if defined(_HAIR_SHADOW)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat9.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9.x = u_xlat9.x + -1.0;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.w;
    u_xlat2.x = u_xlat9.x * u_xlat2.x + _ProjectionParams.w;
#else
    u_xlat9 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9 = u_xlat9 + -1.0;
    u_xlat9 = u_xlat9 * _ProjectionParams.w;
    u_xlat2.x = u_xlat9 * u_xlat2.x + _ProjectionParams.w;
#endif
#else
#if defined(_LAMBERT)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat10.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat10.x = u_xlat10.x + -1.0;
    u_xlat10.x = u_xlat10.x * _ProjectionParams.w;
    u_xlat2.x = u_xlat10.x * u_xlat2.x + _ProjectionParams.w;
#else
    u_xlat10 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat10 = u_xlat10 + -1.0;
    u_xlat10 = u_xlat10 * _ProjectionParams.w;
    u_xlat2.x = u_xlat10 * u_xlat2.x + _ProjectionParams.w;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat9.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9.x = u_xlat9.x + -1.0;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.w;
    u_xlat2.x = u_xlat9.x * u_xlat2.x + _ProjectionParams.w;
#else
    u_xlat9 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9 = u_xlat9 + -1.0;
    u_xlat9 = u_xlat9 * _ProjectionParams.w;
    u_xlat2.x = u_xlat9 * u_xlat2.x + _ProjectionParams.w;
#endif
#endif
#endif
    u_xlat2.x = (-_CoCParams.x) * u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * _CoCParams.y;
#if defined(_HAIR_SHADOW)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat9.x = max(u_xlat2.x, -1.0);
#else
    u_xlat9 = max(u_xlat2.x, -1.0);
#endif
#else
#if defined(_LAMBERT)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat10.x = max(u_xlat2.x, -1.0);
#else
    u_xlat10 = max(u_xlat2.x, -1.0);
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat9.x = max(u_xlat2.x, -1.0);
#else
    u_xlat9 = max(u_xlat2.x, -1.0);
#endif
#endif
#endif
    u_xlat2.x = u_xlat2.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#if defined(_HAIR_SHADOW)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat9.x = min(u_xlat9.x, 0.0);
    u_xlat2.x = u_xlat9.x + u_xlat2.x;
#else
    u_xlat9 = min(u_xlat9, 0.0);
    u_xlat2.x = u_xlat9 + u_xlat2.x;
#endif
#else
#if defined(_LAMBERT)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat10.x = min(u_xlat10.x, 0.0);
    u_xlat2.x = u_xlat10.x + u_xlat2.x;
#else
    u_xlat10 = min(u_xlat10, 0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.x;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat9.x = min(u_xlat9.x, 0.0);
    u_xlat2.x = u_xlat9.x + u_xlat2.x;
#else
    u_xlat9 = min(u_xlat9, 0.0);
    u_xlat2.x = u_xlat9 + u_xlat2.x;
#endif
#endif
#endif
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
    SV_Target1.x = u_xlat2.x;
#else
    u_xlatb1.xyz = equal(ivec4(_BlendMode), ivec4(1, 2, 3, 0)).xyz;
    u_xlat16_0 = (u_xlatb1.x) ? _ReflectionBlendColor : u_xlat16_0;
    u_xlat16_2.xyz = _ReflectionBlendColor.www * _ReflectionBlendColor.xyz;
    u_xlat16_2.w = _ReflectionBlendColor.w;
    u_xlat16_0 = (u_xlatb1.y) ? u_xlat16_2 : u_xlat16_0;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_3.xyz = _ReflectionBlendColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = _ReflectionBlendColor.www * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
#else
    u_xlat16_2.xyz = _ReflectionBlendColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = _ReflectionBlendColor.www * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
#endif
#else
    u_xlat16_2.xyz = _ReflectionBlendColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = _ReflectionBlendColor.www * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
#endif
    u_xlat16_2.w = 0.0;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_0 = (u_xlatb1.z) ? u_xlat16_2 : u_xlat16_0;
    u_xlat1.x = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat8.x = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat1.x = u_xlat1.x / u_xlat8.x;
    u_xlatb15 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat1.x = fract(abs(u_xlat1.x));
    u_xlat1.x = (u_xlatb15) ? u_xlat1.x : (-u_xlat1.x);
    u_xlat1.x = u_xlat8.x * u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat8.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat22 = u_xlat8.x * u_xlat1.x;
    u_xlat22 = floor(u_xlat22);
    u_xlat6.x = (-_FlipBookFrameCountX) * u_xlat22 + u_xlat1.x;
    u_xlat1.x = u_xlat22 + 1.0;
    u_xlat6.y = (-u_xlat1.x) + _FlipBookFrameCountY;
    u_xlat1.xw = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat20.xy = vs_TEXCOORD3.xz + (-_FlipBookCenterPosition.xz);
    u_xlat1.xw = u_xlat20.xy * vec2(_FlipBookScale_Character) + (-u_xlat1.xw);
    u_xlat20.x = dot(u_xlat20.xy, u_xlat20.xy);
    u_xlat20.x = sqrt(u_xlat20.x);
    u_xlat20.x = u_xlat20.x + (-_FlipBookFadeRadius);
    u_xlat20.x = u_xlat20.x + (-_FlipBookFadeFallOff);
    u_xlat1.xw = fract(u_xlat1.xw);
    u_xlat1.xw = u_xlat6.xy + u_xlat1.xw;
    u_xlat1.xy = u_xlat8.xy * u_xlat1.xw;
    u_xlat16_1 = texture(_FlipBookTex, u_xlat1.xy);
    u_xlat16_3.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vs_TEXCOORD6);
    u_xlat16_3.xyz = u_xlat16_3.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _FlipBookColor_Character.www;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_FlipBookOpacity);
    u_xlat1.x = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat1.x = u_xlat1.x * u_xlat20.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat1.xyz = u_xlat16_3.xyz * u_xlat1.xxx + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat8.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat8.x = u_xlat8.x + -1.0;
    u_xlat8.x = u_xlat8.x * _ProjectionParams.w;
    u_xlat1.x = u_xlat8.x * u_xlat1.x + _ProjectionParams.w;
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
    u_xlat8.x = max(u_xlat1.x, -1.0);
    u_xlat1.x = u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = min(u_xlat8.x, 0.0);
    u_xlat1.x = u_xlat8.x + u_xlat1.x;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * 0.5;
    SV_Target1.x = u_xlat1.x;
#else
    SV_Target0 = (u_xlatb1.z) ? u_xlat16_2 : u_xlat16_0;
    u_xlat1 = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat1 = u_xlat1 * 0.5 + 0.5;
    u_xlat1 = (-u_xlat1) + 1.0;
    u_xlat8 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat8 = u_xlat8 + -1.0;
    u_xlat8 = u_xlat8 * _ProjectionParams.w;
    u_xlat1 = u_xlat8 * u_xlat1 + _ProjectionParams.w;
    u_xlat1 = (-_CoCParams.x) * u_xlat1 + 1.0;
    u_xlat1 = u_xlat1 * _CoCParams.y;
    u_xlat8 = max(u_xlat1, -1.0);
    u_xlat1 = u_xlat1;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat8 = min(u_xlat8, 0.0);
    u_xlat1 = u_xlat8 + u_xlat1;
    u_xlat1 = u_xlat1 + 1.0;
    u_xlat1 = u_xlat1 * 0.5;
    SV_Target1.x = u_xlat1;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_0 = (u_xlatb1.z) ? u_xlat16_2 : u_xlat16_0;
    u_xlat1.x = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat8.x = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat1.x = u_xlat1.x / u_xlat8.x;
    u_xlatb15 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat1.x = fract(abs(u_xlat1.x));
    u_xlat1.x = (u_xlatb15) ? u_xlat1.x : (-u_xlat1.x);
    u_xlat1.x = u_xlat8.x * u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat8.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat22 = u_xlat8.x * u_xlat1.x;
    u_xlat22 = floor(u_xlat22);
    u_xlat3.x = (-_FlipBookFrameCountX) * u_xlat22 + u_xlat1.x;
    u_xlat1.x = u_xlat22 + 1.0;
    u_xlat3.y = (-u_xlat1.x) + _FlipBookFrameCountY;
    u_xlat1.xw = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat17.xy = vs_TEXCOORD3.xz + (-_FlipBookCenterPosition.xz);
    u_xlat1.xw = u_xlat17.xy * vec2(_FlipBookScale_Character) + (-u_xlat1.xw);
    u_xlat17.x = dot(u_xlat17.xy, u_xlat17.xy);
    u_xlat17.x = sqrt(u_xlat17.x);
    u_xlat17.x = u_xlat17.x + (-_FlipBookFadeRadius);
    u_xlat17.x = u_xlat17.x + (-_FlipBookFadeFallOff);
    u_xlat1.xw = fract(u_xlat1.xw);
    u_xlat1.xw = u_xlat3.xy + u_xlat1.xw;
    u_xlat1.xy = u_xlat8.xy * u_xlat1.xw;
    u_xlat16_1 = texture(_FlipBookTex, u_xlat1.xy);
    u_xlat16_2.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vs_TEXCOORD6);
    u_xlat16_2.xyz = u_xlat16_2.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _FlipBookColor_Character.www;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_FlipBookOpacity);
    u_xlat1.x = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat1.x = u_xlat1.x * u_xlat17.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat1.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat1.xyz;
#else
    SV_Target0 = (u_xlatb1.z) ? u_xlat16_2 : u_xlat16_0;
#endif
    u_xlat1.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat8.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat8.x = u_xlat8.x + -1.0;
    u_xlat8.x = u_xlat8.x * _ProjectionParams.w;
    u_xlat1.x = u_xlat8.x * u_xlat1.x + _ProjectionParams.w;
#else
    u_xlat8 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat8 = u_xlat8 + -1.0;
    u_xlat8 = u_xlat8 * _ProjectionParams.w;
    u_xlat1.x = u_xlat8 * u_xlat1.x + _ProjectionParams.w;
#endif
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat8.x = max(u_xlat1.x, -1.0);
#else
    u_xlat8 = max(u_xlat1.x, -1.0);
#endif
    u_xlat1.x = u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat8.x = min(u_xlat8.x, 0.0);
    u_xlat1.x = u_xlat8.x + u_xlat1.x;
#else
    u_xlat8 = min(u_xlat8, 0.0);
    u_xlat1.x = u_xlat8 + u_xlat1.x;
#endif
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * 0.5;
    SV_Target1.x = u_xlat1.x;
#endif
#else
#if defined(_LAMBERT)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_0 = (u_xlatb1.z) ? u_xlat16_2 : u_xlat16_0;
    u_xlat1.x = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat9.x = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat1.x = u_xlat1.x / u_xlat9.x;
    u_xlatb17 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat1.x = fract(abs(u_xlat1.x));
    u_xlat1.x = (u_xlatb17) ? u_xlat1.x : (-u_xlat1.x);
    u_xlat1.x = u_xlat9.x * u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat9.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat25 = u_xlat9.x * u_xlat1.x;
    u_xlat25 = floor(u_xlat25);
    u_xlat3.x = (-_FlipBookFrameCountX) * u_xlat25 + u_xlat1.x;
    u_xlat1.x = u_xlat25 + 1.0;
    u_xlat3.y = (-u_xlat1.x) + _FlipBookFrameCountY;
    u_xlat1.xw = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat19.xy = vs_TEXCOORD3.xz + (-_FlipBookCenterPosition.xz);
    u_xlat1.xw = u_xlat19.xy * vec2(_FlipBookScale_Character) + (-u_xlat1.xw);
    u_xlat19.x = dot(u_xlat19.xy, u_xlat19.xy);
    u_xlat19.x = sqrt(u_xlat19.x);
    u_xlat19.x = u_xlat19.x + (-_FlipBookFadeRadius);
    u_xlat19.x = u_xlat19.x + (-_FlipBookFadeFallOff);
    u_xlat1.xw = fract(u_xlat1.xw);
    u_xlat1.xw = u_xlat3.xy + u_xlat1.xw;
    u_xlat1.xy = u_xlat9.xy * u_xlat1.xw;
    u_xlat16_1 = texture(_FlipBookTex, u_xlat1.xy);
    u_xlat16_2.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vs_TEXCOORD6);
    u_xlat16_2.xyz = u_xlat16_2.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _FlipBookColor_Character.www;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_FlipBookOpacity);
    u_xlat1.x = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat1.x = u_xlat1.x * u_xlat19.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat9.x;
    u_xlat1.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat1.xyz;
#else
    SV_Target0 = (u_xlatb1.z) ? u_xlat16_2 : u_xlat16_0;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_0 = (u_xlatb1.z) ? u_xlat16_2 : u_xlat16_0;
    u_xlat1.x = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat8.x = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat1.x = u_xlat1.x / u_xlat8.x;
    u_xlatb15 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat1.x = fract(abs(u_xlat1.x));
    u_xlat1.x = (u_xlatb15) ? u_xlat1.x : (-u_xlat1.x);
    u_xlat1.x = u_xlat8.x * u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat8.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat22 = u_xlat8.x * u_xlat1.x;
    u_xlat22 = floor(u_xlat22);
    u_xlat3.x = (-_FlipBookFrameCountX) * u_xlat22 + u_xlat1.x;
    u_xlat1.x = u_xlat22 + 1.0;
    u_xlat3.y = (-u_xlat1.x) + _FlipBookFrameCountY;
    u_xlat1.xw = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat17.xy = vs_TEXCOORD3.xz + (-_FlipBookCenterPosition.xz);
    u_xlat1.xw = u_xlat17.xy * vec2(_FlipBookScale_Character) + (-u_xlat1.xw);
    u_xlat17.x = dot(u_xlat17.xy, u_xlat17.xy);
    u_xlat17.x = sqrt(u_xlat17.x);
    u_xlat17.x = u_xlat17.x + (-_FlipBookFadeRadius);
    u_xlat17.x = u_xlat17.x + (-_FlipBookFadeFallOff);
    u_xlat1.xw = fract(u_xlat1.xw);
    u_xlat1.xw = u_xlat3.xy + u_xlat1.xw;
    u_xlat1.xy = u_xlat8.xy * u_xlat1.xw;
    u_xlat16_1 = texture(_FlipBookTex, u_xlat1.xy);
    u_xlat16_2.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vs_TEXCOORD6);
    u_xlat16_2.xyz = u_xlat16_2.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _FlipBookColor_Character.www;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_FlipBookOpacity);
    u_xlat1.x = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat1.x = u_xlat1.x * u_xlat17.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat1.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat1.xyz;
#else
    SV_Target0 = (u_xlatb1.z) ? u_xlat16_2 : u_xlat16_0;
#endif
#endif
    u_xlat1.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
#if defined(_LAMBERT)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat9.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9.x = u_xlat9.x + -1.0;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.w;
    u_xlat1.x = u_xlat9.x * u_xlat1.x + _ProjectionParams.w;
#else
    u_xlat9 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9 = u_xlat9 + -1.0;
    u_xlat9 = u_xlat9 * _ProjectionParams.w;
    u_xlat1.x = u_xlat9 * u_xlat1.x + _ProjectionParams.w;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat8.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat8.x = u_xlat8.x + -1.0;
    u_xlat8.x = u_xlat8.x * _ProjectionParams.w;
    u_xlat1.x = u_xlat8.x * u_xlat1.x + _ProjectionParams.w;
#else
    u_xlat8 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat8 = u_xlat8 + -1.0;
    u_xlat8 = u_xlat8 * _ProjectionParams.w;
    u_xlat1.x = u_xlat8 * u_xlat1.x + _ProjectionParams.w;
#endif
#endif
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
#if defined(_LAMBERT)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat9.x = max(u_xlat1.x, -1.0);
#else
    u_xlat9 = max(u_xlat1.x, -1.0);
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat8.x = max(u_xlat1.x, -1.0);
#else
    u_xlat8 = max(u_xlat1.x, -1.0);
#endif
#endif
    u_xlat1.x = u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#if defined(_LAMBERT)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat9.x = min(u_xlat9.x, 0.0);
    u_xlat1.x = u_xlat9.x + u_xlat1.x;
#else
    u_xlat9 = min(u_xlat9, 0.0);
    u_xlat1.x = u_xlat9 + u_xlat1.x;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat8.x = min(u_xlat8.x, 0.0);
    u_xlat1.x = u_xlat8.x + u_xlat1.x;
#else
    u_xlat8 = min(u_xlat8, 0.0);
    u_xlat1.x = u_xlat8 + u_xlat1.x;
#endif
#endif
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * 0.5;
    SV_Target1.x = u_xlat1.x;
#endif
#endif
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "MusicItem-Caster"
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="ReflectionCaster" "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
			Blend [_ReflectionCasterSrcBlend] [_ReflectionCasterDstBlend], [_ReflectionCasterSrcBlend] [_ReflectionCasterDstBlend]
			Cull Front
			Stencil
			{
				Ref 1
				Comp Equal
				Pass [_StencilPassOperation]
			}
			GLSLPROGRAM
#pragma multi_compile _ USE_DITHER_ALPHA
#ifdef VERTEX
#version 300 es
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _SekaiFogFactor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_LODFade;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_WorldTransformParams;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_RenderingLayer;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_LightData;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_LightIndices[2];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SpecCube0_HDR;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SpecCube1_HDR;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube0_BoxMax;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube0_BoxMin;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube0_ProbePosition;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube1_BoxMax;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube1_BoxMin;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube1_ProbePosition;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_LightmapST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHAr;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHAg;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHAb;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHBr;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHBg;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHBb;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHC;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_RendererBounds_Min;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_RendererBounds_Max;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_MatrixPreviousM[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_MatrixPreviousMI[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_MotionVectorsParams;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_FaceShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_LightMapTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineOffset;
	UNITY_UNIFORM float Xhlslcc_UnusedX_SpecularPower;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HeadNormalBlend;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashTransparent;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsLeftEyeClose;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsRightEyeClose;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM mediump vec4                _ReflectionBlendColor;
	UNITY_UNIFORM int                _BlendMode;
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_FaceFront;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterId;
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_HeadPosition;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RangeLimit;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HeadDotDirectionalLightValues;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowTexWeight;
	UNITY_UNIFORM int Xhlslcc_UnusedX_FadeMode;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_NORMAL0;
out mediump float vs_TEXCOORD4;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out highp float vs_TEXCOORD5;
#if defined(USE_DITHER_ALPHA)
out highp vec4 vs_TEXCOORD7;
#endif
vec4 u_xlat0;
vec4 u_xlat1;
#if defined(USE_DITHER_ALPHA)
float u_xlat3;
#else
float u_xlat2;
#endif
float u_xlat7;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = max(u_xlat7, 1.17549435e-38);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_NORMAL0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = u_xlat0.z;
#if defined(USE_DITHER_ALPHA)
    u_xlat1.x = u_xlat0.z + _ProjectionParams.y;
    u_xlat3 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat1.x = u_xlat1.x / u_xlat3;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = (-_SekaiFogFactor.y) * u_xlat1.x + _SekaiFogFactor.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    vs_TEXCOORD4 = u_xlat1.x;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
#else
    u_xlat0.x = u_xlat0.z + _ProjectionParams.y;
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD4 = u_xlat0.x;
#endif
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec2 _GlobalMipBias;
uniform 	vec4 _ProjectionParams;
#if defined(USE_DITHER_ALPHA)
uniform 	vec4 _ScreenParams;
#endif
uniform 	vec4 _CoCParams;
uniform 	vec4 _SekaiFogColor;
#if defined(USE_DITHER_ALPHA)
uniform 	mediump float _DitherAlpha;
#endif
uniform 	vec4 _SekaiDirectionalLight;
uniform 	mediump vec4 _SekaiShadowColor;
uniform 	mediump float _SekaiShadowThreshold;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_FaceShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_LightMapTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineOffset;
	UNITY_UNIFORM float Xhlslcc_UnusedX_SpecularPower;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HeadNormalBlend;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashTransparent;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsLeftEyeClose;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsRightEyeClose;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM mediump vec4                _ReflectionBlendColor;
	UNITY_UNIFORM int                _BlendMode;
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_FaceFront;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterId;
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_HeadPosition;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RangeLimit;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HeadDotDirectionalLightValues;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowTexWeight;
	UNITY_UNIFORM int Xhlslcc_UnusedX_FadeMode;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if defined(USE_DITHER_ALPHA)
UNITY_LOCATION(0) uniform mediump sampler2D _DitherTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(3) uniform mediump sampler2D _ValueTex;
#else
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ValueTex;
#endif
in highp vec3 vs_NORMAL0;
in mediump float vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp float vs_TEXCOORD5;
#if defined(USE_DITHER_ALPHA)
in highp vec4 vs_TEXCOORD7;
#endif
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
#if defined(USE_DITHER_ALPHA)
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
bvec3 u_xlatb2;
#else
vec3 u_xlat1;
bvec3 u_xlatb1;
mediump vec4 u_xlat16_2;
#endif
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
#if defined(USE_DITHER_ALPHA)
mediump vec3 u_xlat16_8;
float u_xlat9;
#else
float u_xlat8;
mediump vec3 u_xlat16_9;
#endif
mediump float u_xlat16_12;
mediump float u_xlat16_19;
float u_xlat21;
bool u_xlatb21;
#if !defined(USE_DITHER_ALPHA)
float u_xlat22;
#endif
mediump float u_xlat16_22;
#if defined(USE_DITHER_ALPHA)
float u_xlat23;
#endif
mediump float u_xlat16_23;
mediump float u_xlat16_26;
void main()
{
#if defined(USE_DITHER_ALPHA)
    u_xlat0.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat16_0.x = texture(_DitherTex, u_xlat0.xy, _GlobalMipBias.x).x;
    u_xlat16_1.x = (-u_xlat16_0.x) + _DitherAlpha;
    u_xlatb0 = u_xlat16_1.x<0.0;
    if(u_xlatb0){discard;}
#endif
    u_xlat0.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat2.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat16_1.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
#else
    u_xlat1.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat16_2.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
#endif
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_NORMAL0.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat16_3.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_22 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = u_xlat21 + u_xlat16_22;
#else
    u_xlat16_23 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = u_xlat21 + u_xlat16_23;
#endif
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = u_xlat21>=_SekaiShadowThreshold;
    u_xlat21 = (u_xlatb21) ? 0.0 : 1.0;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_23 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
#else
    u_xlat16_22 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
#endif
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
#if defined(USE_DITHER_ALPHA)
    u_xlat23 = u_xlat16_23 + (-u_xlat16_4.x);
    u_xlat21 = u_xlat21 * u_xlat23 + u_xlat16_4.x;
    u_xlat16_22 = u_xlat21 * 2.0 + -1.0;
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#else
    u_xlat22 = u_xlat16_22 + (-u_xlat16_4.x);
    u_xlat21 = u_xlat21 * u_xlat22 + u_xlat16_4.x;
    u_xlat16_23 = u_xlat21 * 2.0 + -1.0;
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat21 + u_xlat21;
    u_xlat16_5.x = u_xlat16_5.x;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat16_1.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_1.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
#else
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(_HueSinAngle);
#if defined(USE_DITHER_ALPHA)
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat0.xyz;
    u_xlat21 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_1.xyz);
#else
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat0.xyz;
    u_xlat21 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
#endif
    u_xlat21 = u_xlat21 * 0.57735002;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.x = (-_HueCosAngle) + 1.0;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat16_8.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
#else
    u_xlat16_2.x = (-_HueCosAngle) + 1.0;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_9.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
#endif
    u_xlat16_5.x = _Value * 2.0 + -1.0;
    u_xlat16_12 = _Contrast + _Contrast;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(u_xlat16_12) + u_xlat16_5.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_19 = dot(u_xlat16_8.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-vec3(u_xlat16_19));
#else
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(u_xlat16_12) + u_xlat16_5.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_19 = dot(u_xlat16_9.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-vec3(u_xlat16_19));
#endif
    u_xlat16_26 = _Saturation + _Saturation;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_8.xyz = vec3(u_xlat16_26) * u_xlat16_8.xyz + vec3(u_xlat16_19);
#else
    u_xlat16_9.xyz = vec3(u_xlat16_26) * u_xlat16_9.xyz + vec3(u_xlat16_19);
#endif
    u_xlat0.xyz = u_xlat16_4.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_4.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_HueSinAngle);
    u_xlat0.xyz = u_xlat16_4.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat0.xyz;
    u_xlat21 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_4.xyz);
    u_xlat21 = u_xlat21 * 0.57735002;
#if defined(USE_DITHER_ALPHA)
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_1.xxx + u_xlat0.xyz;
#else
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_2.xxx + u_xlat0.xyz;
#endif
    u_xlat16_6.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_12) + u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz + vec3(0.5, 0.5, 0.5);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.x = dot(u_xlat16_5.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_5.xyz = (-u_xlat16_1.xxx) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz + u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_8.xyz + (-u_xlat16_5.xyz);
#else
    u_xlat16_2.x = dot(u_xlat16_5.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_5.xyz = (-u_xlat16_2.xxx) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz + u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_9.xyz + (-u_xlat16_5.xyz);
#endif
    u_xlatb0 = u_xlat16_3.x>=0.5;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_22 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat0.xyz = (-u_xlat16_1.xyz) + _SekaiFogColor.xyz;
    u_xlat16_22 = (-vs_TEXCOORD4) + 1.0;
    u_xlat21 = u_xlat16_22 * _SekaiFogColor.w;
    u_xlat16_4.xyz = vec3(u_xlat21) * u_xlat0.xyz + u_xlat16_1.xyz;
    SV_Target2.xyz = u_xlat16_3.yyy * u_xlat16_1.xyz;
#else
    u_xlat16_23 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat0.xyz = (-u_xlat16_2.xyz) + _SekaiFogColor.xyz;
    u_xlat16_23 = (-vs_TEXCOORD4) + 1.0;
    u_xlat21 = u_xlat16_23 * _SekaiFogColor.w;
    u_xlat16_4.xyz = vec3(u_xlat21) * u_xlat0.xyz + u_xlat16_2.xyz;
    SV_Target2.xyz = u_xlat16_3.yyy * u_xlat16_2.xyz;
#endif
    u_xlat16_0.xyz = u_xlat16_4.xyz * _ReflectionBlendColor.www;
    u_xlat16_0.w = _ReflectionBlendColor.w;
    u_xlat16_0 = (_BlendMode != 0) ? u_xlat16_4 : u_xlat16_0;
#if defined(USE_DITHER_ALPHA)
    u_xlatb2.xyz = equal(ivec4(_BlendMode), ivec4(1, 2, 3, 0)).xyz;
    u_xlat16_0 = (u_xlatb2.x) ? _ReflectionBlendColor : u_xlat16_0;
    u_xlat16_1.xyz = _ReflectionBlendColor.www * _ReflectionBlendColor.xyz;
    u_xlat16_1.w = _ReflectionBlendColor.w;
    u_xlat16_0 = (u_xlatb2.y) ? u_xlat16_1 : u_xlat16_0;
    u_xlat16_1.xyz = _ReflectionBlendColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = _ReflectionBlendColor.www * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.w = 0.0;
    SV_Target0 = (u_xlatb2.z) ? u_xlat16_1 : u_xlat16_0;
    u_xlat2.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat9 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9 = u_xlat9 + -1.0;
    u_xlat9 = u_xlat9 * _ProjectionParams.w;
    u_xlat2.x = u_xlat9 * u_xlat2.x + _ProjectionParams.w;
    u_xlat2.x = (-_CoCParams.x) * u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * _CoCParams.y;
    u_xlat9 = max(u_xlat2.x, -1.0);
    u_xlat2.x = u_xlat2.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat9 = min(u_xlat9, 0.0);
    u_xlat2.x = u_xlat9 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
    SV_Target1.x = u_xlat2.x;
#else
    u_xlatb1.xyz = equal(ivec4(_BlendMode), ivec4(1, 2, 3, 0)).xyz;
    u_xlat16_0 = (u_xlatb1.x) ? _ReflectionBlendColor : u_xlat16_0;
    u_xlat16_2.xyz = _ReflectionBlendColor.www * _ReflectionBlendColor.xyz;
    u_xlat16_2.w = _ReflectionBlendColor.w;
    u_xlat16_0 = (u_xlatb1.y) ? u_xlat16_2 : u_xlat16_0;
    u_xlat16_2.xyz = _ReflectionBlendColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = _ReflectionBlendColor.www * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.w = 0.0;
    SV_Target0 = (u_xlatb1.z) ? u_xlat16_2 : u_xlat16_0;
    u_xlat1.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat8 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat8 = u_xlat8 + -1.0;
    u_xlat8 = u_xlat8 * _ProjectionParams.w;
    u_xlat1.x = u_xlat8 * u_xlat1.x + _ProjectionParams.w;
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
    u_xlat8 = max(u_xlat1.x, -1.0);
    u_xlat1.x = u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = min(u_xlat8, 0.0);
    u_xlat1.x = u_xlat8 + u_xlat1.x;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * 0.5;
    SV_Target1.x = u_xlat1.x;
#endif
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "LightMap-Caster"
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="ReflectionCaster" "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
			Cull Front
			Stencil
			{
				Ref 1
				Comp Equal
			}
			GLSLPROGRAM
#pragma multi_compile _ _USE_OVERLAY_FLIPBOOK
#ifdef VERTEX
#version 300 es
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _SekaiFogFactor;
#if defined(_USE_OVERLAY_FLIPBOOK)
uniform 	mediump float _FlipBookMaskThreshold_Stage;
uniform 	mediump float _FlipBookMaskFallOff_Stage;
uniform 	mediump float _FlipBookUpperDotMaskOpacity_Stage;
uniform 	mediump float _FlipBookLowerDotMaskOpacity_Stage;
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_ObjectToWorld[4];
#if defined(_USE_OVERLAY_FLIPBOOK)
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_WorldToObject[4];
#else
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_WorldToObject[4];
#endif
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_LODFade;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_WorldTransformParams;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_RenderingLayer;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_LightData;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_LightIndices[2];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SpecCube0_HDR;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SpecCube1_HDR;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube0_BoxMax;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube0_BoxMin;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube0_ProbePosition;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube1_BoxMax;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube1_BoxMin;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube1_ProbePosition;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_LightmapST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHAr;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHAg;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHAb;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHBr;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHBg;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHBb;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHC;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_RendererBounds_Min;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_RendererBounds_Max;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_MatrixPreviousM[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_MatrixPreviousMI[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_MotionVectorsParams;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4                _LightMapTex_ST;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
#if defined(_USE_OVERLAY_FLIPBOOK)
in highp vec3 in_NORMAL0;
#endif
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump float vs_TEXCOORD4;
#if defined(_USE_OVERLAY_FLIPBOOK)
out mediump float vs_TEXCOORD6;
#endif
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
#if defined(_USE_OVERLAY_FLIPBOOK)
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
float u_xlat8;
bool u_xlatb8;
#else
float u_xlat3;
#endif
void main()
{
    u_xlat0 = in_POSITION0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[0];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1] * in_POSITION0.yyyy + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1] * (-in_POSITION0.yyyy) + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0 = u_xlat0;
    u_xlat0.x = u_xlat0.z + _ProjectionParams.y;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * _LightMapTex_ST.xy + _LightMapTex_ST.zw;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat4 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat4;
#else
    u_xlat3 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat3;
#endif
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD4 = u_xlat0.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 1.17549435e-38);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlatb4 = 0.0>=u_xlat0.x;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat4 = u_xlat4 * _FlipBookLowerDotMaskOpacity_Stage;
    u_xlatb8 = u_xlat0.x>=0.0;
    u_xlat8 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat16_3 = u_xlat8 * _FlipBookUpperDotMaskOpacity_Stage + u_xlat4;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = abs(u_xlat0.x) * u_xlat16_3 + (-_FlipBookMaskThreshold_Stage);
    u_xlat16_7 = _FlipBookMaskFallOff_Stage + 0.00100000005;
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
    u_xlat16_7 = float(1.0) / u_xlat16_7;
    u_xlat16_3 = u_xlat16_7 * u_xlat16_3;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_7 = u_xlat16_3 * -2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    vs_TEXCOORD6 = u_xlat16_3 * u_xlat16_7;
#endif
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiLightIntensity;
uniform 	vec4 _SekaiAmbientLightColor;
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
uniform 	vec4 _SekaiFogColor;
#if defined(_USE_OVERLAY_FLIPBOOK)
uniform 	vec3 _FlipBookCenterPosition;
uniform 	float _GlobalFlipBookTime;
uniform 	mediump float _FlipBookFrameCountX;
uniform 	mediump float _FlipBookFrameCountY;
uniform 	mediump float _FlipBookFPS;
uniform 	mediump vec4 _FlipBookColor_Stage;
uniform 	mediump float _FlipBookOpacity;
uniform 	mediump float _FlipBookFadeRadius;
uniform 	mediump float _FlipBookFadeFallOff;
uniform 	mediump float _FlipBookScale_Stage;
uniform 	vec2 _FlipBookUVScroll_Stage;
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _LightMapTex;
#if defined(_USE_OVERLAY_FLIPBOOK)
UNITY_LOCATION(2) uniform mediump sampler2D _FlipBookTex;
#endif
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump float vs_TEXCOORD4;
#if defined(_USE_OVERLAY_FLIPBOOK)
in mediump float vs_TEXCOORD6;
#endif
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec3 u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat6;
vec2 u_xlat7;
float u_xlat11;
bool u_xlatb14;
vec2 u_xlat19;
float u_xlat22;
float u_xlat25;
bool u_xlatb25;
#else
float u_xlat9;
float u_xlat19;
bool u_xlatb19;
#endif
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = texture(_LightMapTex, vs_TEXCOORD2.xy);
    u_xlat16_2 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_1 * u_xlat16_0;
    u_xlatb3.xyz = greaterThanEqual(u_xlat16_2.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_4.x = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb3.y) ? float(1.0) : float(0.0);
    u_xlat16_4.z = (u_xlatb3.z) ? float(1.0) : float(0.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    u_xlat3.xyz = u_xlat16_2.xyz * _SekaiAmbientLightColor.xyz;
    u_xlat16_5.xyz = (-u_xlat16_0.xyz) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat1.xyz = (-_SekaiAmbientLightColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_5.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * _SekaiAmbientLightColor.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz + u_xlat3.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_SekaiLightIntensity, _SekaiLightIntensity, _SekaiLightIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(_SekaiAllLightIntensity);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlatb25 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb25){
#else
    u_xlatb19 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb19){
#endif
        u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat3.xy = u_xlat3.xy * u_xlat3.xy;
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat25 = u_xlat3.y + u_xlat3.x;
        u_xlat25 = u_xlat3.z * u_xlat3.z + u_xlat25;
#else
        u_xlat19 = u_xlat3.y + u_xlat3.x;
        u_xlat19 = u_xlat3.z * u_xlat3.z + u_xlat19;
#endif
        u_xlat3.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat25 = u_xlat25 + (-_SekaiGlobalSpotLightRadiusNear);
#else
        u_xlat19 = u_xlat19 + (-_SekaiGlobalSpotLightRadiusNear);
#endif
        u_xlat3.x = float(1.0) / u_xlat3.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat25 = u_xlat25 * u_xlat3.x;
        u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
        u_xlat3.x = u_xlat25 * -2.0 + 3.0;
        u_xlat25 = u_xlat25 * u_xlat25;
        u_xlat11 = u_xlat25 * u_xlat3.x;
        u_xlat25 = (-u_xlat3.x) * u_xlat25 + 1.0;
        u_xlat3.xyz = u_xlat1.xyz * vec3(u_xlat11);
#else
        u_xlat19 = u_xlat19 * u_xlat3.x;
        u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
        u_xlat3.x = u_xlat19 * -2.0 + 3.0;
        u_xlat19 = u_xlat19 * u_xlat19;
        u_xlat9 = u_xlat19 * u_xlat3.x;
        u_xlat19 = (-u_xlat3.x) * u_xlat19 + 1.0;
        u_xlat3.xyz = u_xlat1.xyz * vec3(u_xlat9);
#endif
        u_xlat3.xyz = u_xlat3.xyz * _SekaiGlobalSpotLightColor.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz + u_xlat3.xyz;
#else
        u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat3.xyz;
#endif
    }
    u_xlat16_2.x = (-vs_TEXCOORD4) + 1.0;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat25 = u_xlat16_2.x * _SekaiFogColor.w;
#else
    u_xlat19 = u_xlat16_2.x * _SekaiFogColor.w;
#endif
    u_xlat3.xyz = (-u_xlat1.xyz) + _SekaiFogColor.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xz + (-_FlipBookCenterPosition.xz);
    u_xlat19.xy = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * vec2(_FlipBookUVScroll_Stage.x, _FlipBookUVScroll_Stage.y);
    u_xlat19.xy = u_xlat3.xy * vec2(vec2(_FlipBookScale_Stage, _FlipBookScale_Stage)) + (-u_xlat19.xy);
    u_xlat19.xy = fract(u_xlat19.xy);
    u_xlat25 = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat6.x = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat25 = u_xlat25 / u_xlat6.x;
    u_xlatb14 = u_xlat25>=(-u_xlat25);
    u_xlat25 = fract(abs(u_xlat25));
    u_xlat25 = (u_xlatb14) ? u_xlat25 : (-u_xlat25);
    u_xlat25 = u_xlat6.x * u_xlat25;
    u_xlat25 = floor(u_xlat25);
    u_xlat6.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat22 = u_xlat25 * u_xlat6.x;
    u_xlat22 = floor(u_xlat22);
    u_xlat7.x = (-_FlipBookFrameCountX) * u_xlat22 + u_xlat25;
    u_xlat25 = u_xlat22 + 1.0;
    u_xlat7.y = (-u_xlat25) + _FlipBookFrameCountY;
    u_xlat19.xy = u_xlat19.xy + u_xlat7.xy;
    u_xlat19.xy = u_xlat6.xy * u_xlat19.xy;
    u_xlat25 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat25 = sqrt(u_xlat25);
    u_xlat16_0 = texture(_FlipBookTex, u_xlat19.xy);
    u_xlat16_2.xyz = u_xlat16_0.www * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vs_TEXCOORD6);
    u_xlat16_2.xyz = u_xlat16_2.xyz * _FlipBookColor_Stage.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _FlipBookColor_Stage.www;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_FlipBookOpacity);
    u_xlat25 = u_xlat25 + (-_FlipBookFadeRadius);
    u_xlat25 = u_xlat25 + (-_FlipBookFadeFallOff);
    u_xlat3.x = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat25 = u_xlat25 * u_xlat3.x;
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat3.x = u_xlat25 * -2.0 + 3.0;
    u_xlat25 = u_xlat25 * u_xlat25;
    u_xlat25 = u_xlat25 * u_xlat3.x;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat25) + u_xlat1.xyz;
#else
    SV_Target0.xyz = vec3(u_xlat19) * u_xlat3.xyz + u_xlat1.xyz;
#endif
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    SV_Target0.w = u_xlat16_2.w;
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "Monitor-Caster"
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="ReflectionCaster" "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
			Cull Front
			Stencil
			{
				Ref 1
				Comp Equal
				Pass [_StencilPassOperation]
			}
			GLSLPROGRAM
#pragma multi_compile _ _MANY_CHARACTER
#ifdef VERTEX
#version 300 es
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _SekaiFogFactor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_LODFade;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_WorldTransformParams;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_RenderingLayer;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_LightData;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_LightIndices[2];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SpecCube0_HDR;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SpecCube1_HDR;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube0_BoxMax;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube0_BoxMin;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube0_ProbePosition;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube1_BoxMax;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube1_BoxMin;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_SpecCube1_ProbePosition;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_LightmapST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHAr;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHAg;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHAb;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHBr;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHBg;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHBb;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_SHC;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_RendererBounds_Min;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_RendererBounds_Max;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_MatrixPreviousM[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_MatrixPreviousMI[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_MotionVectorsParams;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4                _SubTex_ST;
	UNITY_UNIFORM vec4                _BgTex_ST;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Intensity;
	UNITY_UNIFORM mediump float                _Fade;
	UNITY_UNIFORM mediump vec4                _FadeColor;
	UNITY_UNIFORM mediump float                _Brightness;
	UNITY_UNIFORM float                _LocalTime;
	UNITY_UNIFORM mediump vec4                _BaseColor;
	UNITY_UNIFORM vec4                _SheetValue;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out mediump float vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_TEXCOORD0 = u_xlat1;
    u_xlat0.x = _LocalTime * _SheetValue.w;
    u_xlat0.x = u_xlat0.x / _SheetValue.z;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _SheetValue.w;
    u_xlat0.x = u_xlat0.x * _SheetValue.z;
    u_xlat0.x = u_xlat0.x * _SheetValue.w;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _SheetValue.x;
    u_xlat2 = floor(u_xlat0.x);
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat1.x = in_TEXCOORD0.x * _SheetValue.x + u_xlat0.x;
    u_xlat0.x = u_xlat2 * _SheetValue.y;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat1.y = in_TEXCOORD0.y * _SheetValue.y + (-u_xlat0.x);
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    vs_TEXCOORD6 = u_xlat1.z;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
    vs_TEXCOORD3.xy = in_TEXCOORD2.xy * _BgTex_ST.xy + _BgTex_ST.zw;
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD5 = u_xlat0.x;
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiGlowLightIntensity;
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
uniform 	vec4 _SekaiFogColor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4                _SubTex_ST;
	UNITY_UNIFORM vec4                _BgTex_ST;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Intensity;
	UNITY_UNIFORM mediump float                _Fade;
	UNITY_UNIFORM mediump vec4                _FadeColor;
	UNITY_UNIFORM mediump float                _Brightness;
	UNITY_UNIFORM float                _LocalTime;
	UNITY_UNIFORM mediump vec4                _BaseColor;
	UNITY_UNIFORM vec4                _SheetValue;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _SubTex;
#if defined(_MANY_CHARACTER)
UNITY_LOCATION(2) uniform mediump sampler2D _BgTex;
#endif
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
#if defined(_MANY_CHARACTER)
in highp vec2 vs_TEXCOORD3;
#endif
in mediump float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
#if defined(_MANY_CHARACTER)
mediump vec4 u_xlat16_0;
#else
mediump vec3 u_xlat16_0;
#endif
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
#if defined(_MANY_CHARACTER)
mediump vec3 u_xlat16_2;
#else
vec3 u_xlat2;
#endif
mediump vec3 u_xlat16_3;
#if defined(_MANY_CHARACTER)
vec3 u_xlat4;
#endif
float u_xlat5;
float u_xlat12;
bool u_xlatb12;
#if !defined(_MANY_CHARACTER)
float u_xlat13;
#endif
void main()
{
#if defined(_MANY_CHARACTER)
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
#else
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
#endif
    u_xlat16_1.xyz = texture(_SubTex, vs_TEXCOORD2.xy).xyz;
#if defined(_MANY_CHARACTER)
    u_xlat16_2.xyz = texture(_BgTex, vs_TEXCOORD3.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat0.x = vs_TEXCOORD0.z + _ProjectionParams.y;
    u_xlat4.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x * 0.0500000007;
    u_xlat0.x = min(u_xlat0.x, 0.75);
    u_xlat4.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xyz + (-_BaseColor.xyz);
#else
    u_xlat12 = vs_TEXCOORD0.z + _ProjectionParams.y;
    u_xlat13 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat12 = u_xlat12 / u_xlat13;
    u_xlat12 = u_xlat12 * _ProjectionParams.z;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat12 = u_xlat12 * 0.0500000007;
    u_xlat12 = min(u_xlat12, 0.75);
    u_xlat2.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat1.xyz + (-_BaseColor.xyz);
#endif
    u_xlat0.xyz = vec3(_Brightness) * u_xlat0.xyz + _BaseColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SekaiAllLightIntensity);
    u_xlatb12 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb12){
        u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xy = u_xlat1.xy * u_xlat1.xy;
        u_xlat12 = u_xlat1.y + u_xlat1.x;
        u_xlat12 = u_xlat1.z * u_xlat1.z + u_xlat12;
        u_xlat1.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat12 = u_xlat12 + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat1.x = float(1.0) / u_xlat1.x;
        u_xlat12 = u_xlat12 * u_xlat1.x;
        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
        u_xlat1.x = u_xlat12 * -2.0 + 3.0;
        u_xlat12 = u_xlat12 * u_xlat12;
        u_xlat5 = u_xlat12 * u_xlat1.x;
        u_xlat12 = (-u_xlat1.x) * u_xlat12 + 1.0;
        u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat5);
        u_xlat1.xyz = u_xlat1.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz + u_xlat1.xyz;
    }
    u_xlat16_3.x = (-vs_TEXCOORD5) + 1.0;
    u_xlat12 = u_xlat16_3.x * _SekaiFogColor.w;
    u_xlat1.xyz = (-u_xlat0.xyz) + _SekaiFogColor.xyz;
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + _FadeColor.xyz;
    SV_Target0.xyz = vec3(vec3(_Fade, _Fade, _Fade)) * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
	}
}
