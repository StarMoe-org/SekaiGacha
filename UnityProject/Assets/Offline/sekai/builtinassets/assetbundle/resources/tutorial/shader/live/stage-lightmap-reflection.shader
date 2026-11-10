// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Stage/LightMap-Reflection"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_LightMapTex("LightMapTex", 2D) = "white" {}
		[KWEnum(Group1, Standard, _KEY1, Planar Reflection, _KEY2)] _ReflectionMode("ReflectionMode", Float) = 0
		[ShowIf(_ReflectionMode, Equal, 0)] _SubTex("AlphaTex", 2D) = "white" {}
		_Smoothness("Smoothness", Range(0, 1)) = 0
		[ShowIf(_ReflectionMode, Equal, 1)] _NoiseTex("Noise Texture", 2D) = "white" {}
		[ShowIf(_ReflectionMode, Equal, 1)] _DistortionPower("Distortion Power", Range(-0.5, 0.5)) = 0.1
		[ShowIf(_ReflectionMode, Equal, 1)] _DistortionDistance("Distortion Distance", Range(1, 50)) = 5
		[ShowIf(_ReflectionMode, Equal, 1)] _MoveSpeedX("Move Speed X", Range(-1, 1)) = 0
		[ShowIf(_ReflectionMode, Equal, 1)] _MoveSpeedY("Move Speed Y", Range(-1, 1)) = 0
		[ShowIf(_ReflectionMode, Equal, 1)] _NormalNoiseSize("Normal Noise Size", Vector) = (1, 1, 0, 0)
		[ShowIf(_ReflectionMode, Equal, 1)] _NormalPower("Normal Power", Range(0, 2)) = 1
		[ShowIf(_ReflectionMode, Equal, 1)] _Brightness("Brightness", Range(0, 1)) = 0.5
		[ShowIf(_ReflectionMode, Equal, 1)] _LightDir("Light Direction", Vector) = (1, 1, 0, 0)
		[ShowIf(_ReflectionMode, Equal, 1)] [Toggle] _UseSecondaryNormal("Use Secondary Normal Texture", Float) = 0
		[ShowIf(_ReflectionMode, Equal, 1)] _SecondaryNormalTex("Secondary Normal Texture", 2D) = "bump" {}
		[ShowIf(_ReflectionMode, Equal, 1)] [Toggle] _UsePolarUV("Use Polar UV", Float) = 0
		[ShowIf(_ReflectionMode, Equal, 1)] [ShowIf(_UsePolarUV, Equal, 1)] _CenterPos("Center Posiont", Vector) = (0, 0, 0, 0)
		[ShowIf(_ReflectionMode, Equal, 1)] [ShowIf(_UsePolarUV, Equal, 1)] _RadialScale("Radial Scale", Range(0, 50)) = 1
		[ShowIf(_ReflectionMode, Equal, 1)] [ShowIf(_UsePolarUV, Equal, 1)] _RadialSpreadSpeed("Radial Spread Speed", Range(-1, 1)) = 0
		[ShowIf(_ReflectionMode, Equal, 1)] [ShowIf(_UsePolarUV, Equal, 1)] _RotationSpeed("Rotation Speed", Range(-1, 1)) = 0
		[ShowIf(_ReflectionMode, Equal, 1)] [ShowIf(_UsePolarUV, Equal, 1)] _PolarCenterMaskSize("Polar Center Mask Size", Range(0, 10)) = 1
		[ShowIf(_ReflectionMode, Equal, 1)] [ShowIf(_UsePolarUV, Equal, 1)] _PolarCenterMaskFade("Polar Center Mask Fade", Range(0, 1)) = 1
		[ShowIf(_ReflectionMode, Equal, 1)] _WaterSurfaceTime("Water Surface Time", Float) = 0
	}
	SubShader
	{
		Tags { "QUEUE"="Transparent-1" "RenderType"="Transparent" }
		LOD 100
		Pass
		{
			Tags { "QUEUE"="Transparent-1" "RenderType"="Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			Cull Off
			GLSLPROGRAM
#pragma multi_compile _ _USE_OVERLAY_FLIPBOOK
#pragma multi_compile _ _USE_PLANAR_REFLECTION
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
#if defined(_USE_PLANAR_REFLECTION)
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_WorldToObject[4];
#else
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_WorldToObject[4];
#endif
#endif
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_LODFade;
#if defined(_USE_PLANAR_REFLECTION)
	UNITY_UNIFORM mediump vec4                unity_WorldTransformParams;
#else
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXunity_WorldTransformParams;
#endif
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
#if defined(_USE_PLANAR_REFLECTION)
	UNITY_UNIFORM float                _ReflectionMode;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ReflectionTex_ST;
	UNITY_UNIFORM vec4                _NoiseTex_ST;
	UNITY_UNIFORM float                _DistortionPower;
	UNITY_UNIFORM float                _DistortionDistance;
	UNITY_UNIFORM float                _MoveSpeedX;
	UNITY_UNIFORM float                _MoveSpeedY;
	UNITY_UNIFORM vec2                _NormalNoiseSize;
	UNITY_UNIFORM float                _NormalPower;
	UNITY_UNIFORM float                _Brightness;
	UNITY_UNIFORM vec3                _LightDir;
	UNITY_UNIFORM vec4                _SecondaryNormalTex_ST;
	UNITY_UNIFORM float                _UseSecondaryNormal;
	UNITY_UNIFORM float                _UsePolarUV;
	UNITY_UNIFORM vec2                _CenterPos;
	UNITY_UNIFORM float                _RadialScale;
	UNITY_UNIFORM float                _RadialSpreadSpeed;
	UNITY_UNIFORM float                _RotationSpeed;
	UNITY_UNIFORM float                _PolarCenterMaskSize;
	UNITY_UNIFORM float                _PolarCenterMaskFade;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_SubTex_ST;
	UNITY_UNIFORM float                _Smoothness;
#else
	UNITY_UNIFORM float Xhlslcc_UnusedX_ReflectionMode;
	UNITY_UNIFORM vec4                _SubTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_Smoothness;
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
#if defined(_USE_OVERLAY_FLIPBOOK)
#if defined(_USE_PLANAR_REFLECTION)
in highp vec4 in_TANGENT0;
#else
in highp vec2 in_TEXCOORD2;
#endif
in highp vec3 in_NORMAL0;
#else
#if defined(_USE_PLANAR_REFLECTION)
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
#else
in highp vec2 in_TEXCOORD2;
#endif
#endif
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
#if defined(_USE_PLANAR_REFLECTION)
out highp vec3 vs_TEXCOORD4;
#else
out highp vec2 vs_TEXCOORD3;
#endif
out mediump float vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
#if defined(_USE_OVERLAY_FLIPBOOK)
#if !defined(_USE_PLANAR_REFLECTION)
out highp vec3 vs_TEXCOORD4;
#endif
out mediump float vs_TEXCOORD7;
#if defined(_USE_PLANAR_REFLECTION)
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec3 vs_TEXCOORD10;
out highp vec3 vs_TEXCOORD11;
#endif
#else
#if defined(_USE_PLANAR_REFLECTION)
out highp vec3 vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD9;
out highp vec3 vs_TEXCOORD10;
out highp vec3 vs_TEXCOORD11;
#else
out highp vec3 vs_TEXCOORD4;
#endif
#endif
vec4 u_xlat0;
vec4 u_xlat1;
#if defined(_USE_OVERLAY_FLIPBOOK)
#if defined(_USE_PLANAR_REFLECTION)
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat4;
mediump float u_xlat16_6;
float u_xlat12;
bool u_xlatb12;
#else
mediump float u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
#endif
#else
#if defined(_USE_PLANAR_REFLECTION)
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat12;
bool u_xlatb12;
#else
float u_xlat2;
#endif
#endif
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * _LightMapTex_ST.xy + _LightMapTex_ST.zw;
#if !defined(_USE_PLANAR_REFLECTION)
    vs_TEXCOORD6 = u_xlat1.z;
#endif
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
#if defined(_USE_OVERLAY_FLIPBOOK)
#if defined(_USE_PLANAR_REFLECTION)
    vs_TEXCOORD6 = u_xlat1.z;
    u_xlat4 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat4;
#else
    vs_TEXCOORD3.xy = in_TEXCOORD2.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    u_xlat3 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat3;
#endif
#else
#if defined(_USE_PLANAR_REFLECTION)
    vs_TEXCOORD6 = u_xlat1.z;
    u_xlat4 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat4;
#else
    vs_TEXCOORD3.xy = in_TEXCOORD2.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
#endif
#endif
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD5 = u_xlat0.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
#if !defined(_USE_PLANAR_REFLECTION)
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
#endif
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 1.17549435e-38);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlatb12 = 0.0>=u_xlat0.y;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat12 = u_xlat12 * _FlipBookLowerDotMaskOpacity_Stage;
    u_xlatb1 = u_xlat0.y>=0.0;
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat16_2.x = u_xlat1.x * _FlipBookUpperDotMaskOpacity_Stage + u_xlat12;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_2.x = abs(u_xlat0.y) * u_xlat16_2.x + (-_FlipBookMaskThreshold_Stage);
    u_xlat16_6 = _FlipBookMaskFallOff_Stage + 0.00100000005;
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
    u_xlat16_6 = float(1.0) / u_xlat16_6;
    u_xlat16_2.x = u_xlat16_6 * u_xlat16_2.x;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_6 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    vs_TEXCOORD7 = u_xlat16_2.x * u_xlat16_6;
    vs_TEXCOORD8.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD9.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = max(u_xlat12, 1.17549435e-38);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD10.xyz = u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlatb12 = unity_WorldTransformParams.w>=0.0;
    u_xlat12 = (u_xlatb12) ? 1.0 : -1.0;
    u_xlat16_2.x = u_xlat12 * in_TANGENT0.w;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    vs_TEXCOORD11.xyz = u_xlat16_2.xyz;
#else
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 1.17549435e-38);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlatb3 = 0.0>=u_xlat0.x;
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3 = u_xlat3 * _FlipBookLowerDotMaskOpacity_Stage;
    u_xlatb6 = u_xlat0.x>=0.0;
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat16_2 = u_xlat6 * _FlipBookUpperDotMaskOpacity_Stage + u_xlat3;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_2 = abs(u_xlat0.x) * u_xlat16_2 + (-_FlipBookMaskThreshold_Stage);
    u_xlat16_5 = _FlipBookMaskFallOff_Stage + 0.00100000005;
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
    u_xlat16_5 = float(1.0) / u_xlat16_5;
    u_xlat16_2 = u_xlat16_5 * u_xlat16_2;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = u_xlat16_2 * -2.0 + 3.0;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    vs_TEXCOORD7 = u_xlat16_2 * u_xlat16_5;
#endif
#else
#if defined(_USE_PLANAR_REFLECTION)
    vs_TEXCOORD8.xyz = in_NORMAL0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 1.17549435e-38);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = max(u_xlat12, 1.17549435e-38);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD10.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlatb12 = unity_WorldTransformParams.w>=0.0;
    u_xlat12 = (u_xlatb12) ? 1.0 : -1.0;
    u_xlat16_3.x = u_xlat12 * in_TANGENT0.w;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    vs_TEXCOORD11.xyz = u_xlat16_3.xyz;
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
#if defined(_USE_PLANAR_REFLECTION)
uniform 	vec3 _WorldSpaceCameraPos;
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _CoCParams;
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
#if defined(_USE_PLANAR_REFLECTION)
uniform 	float _WaterSurfaceTime;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_LODFade;
	UNITY_UNIFORM mediump vec4                unity_WorldTransformParams;
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
	UNITY_UNIFORM float                _ReflectionMode;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ReflectionTex_ST;
	UNITY_UNIFORM vec4                _NoiseTex_ST;
	UNITY_UNIFORM float                _DistortionPower;
	UNITY_UNIFORM float                _DistortionDistance;
	UNITY_UNIFORM float                _MoveSpeedX;
	UNITY_UNIFORM float                _MoveSpeedY;
	UNITY_UNIFORM vec2                _NormalNoiseSize;
	UNITY_UNIFORM float                _NormalPower;
	UNITY_UNIFORM float                _Brightness;
	UNITY_UNIFORM vec3                _LightDir;
	UNITY_UNIFORM vec4                _SecondaryNormalTex_ST;
	UNITY_UNIFORM float                _UseSecondaryNormal;
	UNITY_UNIFORM float                _UsePolarUV;
	UNITY_UNIFORM vec2                _CenterPos;
	UNITY_UNIFORM float                _RadialScale;
	UNITY_UNIFORM float                _RadialSpreadSpeed;
	UNITY_UNIFORM float                _RotationSpeed;
	UNITY_UNIFORM float                _PolarCenterMaskSize;
	UNITY_UNIFORM float                _PolarCenterMaskFade;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_SubTex_ST;
	UNITY_UNIFORM float                _Smoothness;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _LightMapTex;
#if defined(_USE_OVERLAY_FLIPBOOK)
#if defined(_USE_PLANAR_REFLECTION)
UNITY_LOCATION(2) uniform mediump sampler2D _NoiseTex;
UNITY_LOCATION(3) uniform mediump sampler2D _SecondaryNormalTex;
UNITY_LOCATION(4) uniform mediump sampler2D _ReflectionTex;
UNITY_LOCATION(5) uniform mediump sampler2D _FlipBookTex;
#else
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FlipBookTex;
#endif
#else
#if defined(_USE_PLANAR_REFLECTION)
UNITY_LOCATION(2) uniform mediump sampler2D _NoiseTex;
UNITY_LOCATION(3) uniform mediump sampler2D _SecondaryNormalTex;
UNITY_LOCATION(4) uniform mediump sampler2D _ReflectionTex;
#else
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
#endif
#endif
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
#if defined(_USE_PLANAR_REFLECTION)
in highp vec3 vs_TEXCOORD4;
#else
in highp vec2 vs_TEXCOORD3;
#endif
in mediump float vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
#if defined(_USE_OVERLAY_FLIPBOOK)
#if !defined(_USE_PLANAR_REFLECTION)
in highp vec3 vs_TEXCOORD4;
#endif
in mediump float vs_TEXCOORD7;
#if defined(_USE_PLANAR_REFLECTION)
in highp vec3 vs_TEXCOORD9;
in highp vec3 vs_TEXCOORD10;
in highp vec3 vs_TEXCOORD11;
#endif
#else
#if defined(_USE_PLANAR_REFLECTION)
in highp vec3 vs_TEXCOORD9;
in highp vec3 vs_TEXCOORD10;
in highp vec3 vs_TEXCOORD11;
#else
in highp vec3 vs_TEXCOORD4;
#endif
#endif
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
bvec3 u_xlatb1;
#if defined(_USE_PLANAR_REFLECTION)
vec3 u_xlat2;
#endif
#if defined(_USE_OVERLAY_FLIPBOOK)
mediump vec4 u_xlat16_2;
#else
mediump vec3 u_xlat16_2;
#endif
#if defined(_USE_PLANAR_REFLECTION)
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
#else
mediump vec3 u_xlat16_3;
#endif
mediump vec3 u_xlat16_4;
#if defined(_USE_OVERLAY_FLIPBOOK)
#if defined(_USE_PLANAR_REFLECTION)
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat10;
float u_xlat11;
#else
float u_xlat5;
vec2 u_xlat6;
float u_xlat7;
vec3 u_xlat8;
#endif
vec2 u_xlat12;
#if defined(_USE_PLANAR_REFLECTION)
bool u_xlatb13;
vec2 u_xlat21;
vec2 u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
vec2 u_xlat23;
bool u_xlatb25;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
mediump float u_xlat16_36;
#else
vec2 u_xlat15;
bool u_xlatb19;
mediump float u_xlat16_21;
float u_xlat26;
#endif
#else
#if defined(_USE_PLANAR_REFLECTION)
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat10;
#else
float u_xlat5;
vec3 u_xlat6;
#endif
float u_xlat11;
#if defined(_USE_PLANAR_REFLECTION)
bool u_xlatb13;
vec2 u_xlat22;
mediump float u_xlat16_22;
vec2 u_xlat23;
bool u_xlatb25;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
mediump float u_xlat16_36;
#else
mediump float u_xlat16_15;
#endif
#endif
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = texture(_LightMapTex, vs_TEXCOORD2.xy).xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat2.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat2.z = u_xlat2.y * _ProjectionParams.x;
    u_xlat2.xy = u_xlat2.xz * vec2(0.5, 0.5);
    u_xlat2.z = (-u_xlat2.y);
    u_xlat2.xy = u_xlat2.xz + vec2(0.5, 1.5);
    u_xlat22.xy = u_xlat2.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.xy = (-vs_TEXCOORD4.xz) + (-hlslcc_mtx4x4unity_WorldToObject[3].xz);
    u_xlat23.xy = vs_TEXCOORD4.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat30 = dot(u_xlat23.xy, u_xlat23.xy);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = dFdy(u_xlat30);
    u_xlat30 = float(1.0) / u_xlat30;
    u_xlat31 = u_xlat30 / _DistortionDistance;
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
    u_xlat30 = (-u_xlat30) * 2.0 + 1.0;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat23.xy = vec2(_WaterSurfaceTime) * vec2(_MoveSpeedX, _MoveSpeedY);
    u_xlat22.xy = vec2(_MoveSpeedX, _MoveSpeedY) * vec2(_WaterSurfaceTime) + u_xlat22.xy;
    u_xlat16_22 = texture(_NoiseTex, u_xlat22.xy).x;
    u_xlat23.xy = u_xlat2.xy * _NormalNoiseSize.xy + u_xlat23.xy;
    u_xlat16_4.x = texture(_NoiseTex, u_xlat23.xy).x;
    u_xlat23.xy = u_xlat23.xy + vec2(0.100000001, 0.100000001);
    u_xlat16_4.y = texture(_NoiseTex, u_xlat23.xy).x;
    u_xlat23.xy = vec2(_MoveSpeedX, _MoveSpeedY) * vec2(_WaterSurfaceTime) + vs_TEXCOORD1.xy;
    u_xlat23.xy = u_xlat23.xy * _SecondaryNormalTex_ST.xy + _SecondaryNormalTex_ST.zw;
    u_xlat16_5.xyz = texture(_SecondaryNormalTex, u_xlat23.xy).xyz;
    u_xlat16_4.z = 1.0;
    u_xlat5.xyz = (-u_xlat16_4.xyz) + u_xlat16_5.xyz;
    u_xlat4.xyz = vec3(_UseSecondaryNormal) * u_xlat5.xyz + u_xlat16_4.xyz;
    u_xlat32 = _RadialScale * 0.100000001;
    u_xlat3.xy = u_xlat3.xy + vec2(_CenterPos.x, _CenterPos.y);
    u_xlat23.x = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat23.x = sqrt(u_xlat23.x);
    u_xlat5.x = dot(u_xlat23.xx, vec2(u_xlat32));
    u_xlat32 = min(abs(u_xlat3.y), abs(u_xlat3.x));
    u_xlat33 = max(abs(u_xlat3.y), abs(u_xlat3.x));
    u_xlat33 = float(1.0) / u_xlat33;
    u_xlat32 = u_xlat32 * u_xlat33;
    u_xlat33 = u_xlat32 * u_xlat32;
    u_xlat34 = u_xlat33 * 0.0208350997 + -0.0851330012;
    u_xlat34 = u_xlat33 * u_xlat34 + 0.180141002;
    u_xlat34 = u_xlat33 * u_xlat34 + -0.330299497;
    u_xlat33 = u_xlat33 * u_xlat34 + 0.999866009;
    u_xlat34 = u_xlat32 * u_xlat33;
    u_xlatb25 = abs(u_xlat3.y)<abs(u_xlat3.x);
    u_xlat34 = u_xlat34 * -2.0 + 1.57079637;
    u_xlat34 = u_xlatb25 ? u_xlat34 : float(0.0);
    u_xlat32 = u_xlat32 * u_xlat33 + u_xlat34;
    u_xlatb33 = u_xlat3.y<(-u_xlat3.y);
    u_xlat33 = u_xlatb33 ? -3.14159274 : float(0.0);
    u_xlat32 = u_xlat32 + u_xlat33;
    u_xlat33 = min(u_xlat3.y, u_xlat3.x);
    u_xlat3.x = max(u_xlat3.y, u_xlat3.x);
    u_xlatb13 = u_xlat33<(-u_xlat33);
    u_xlatb3 = u_xlat3.x>=(-u_xlat3.x);
    u_xlatb3 = u_xlatb3 && u_xlatb13;
    u_xlat32 = (u_xlatb3) ? (-u_xlat32) : u_xlat32;
    u_xlat5.y = u_xlat32 * 0.159235656;
    u_xlat3.xy = vec2(_WaterSurfaceTime) * vec2(_RadialSpreadSpeed, _RotationSpeed) + u_xlat5.xy;
    u_xlat16_5.x = texture(_NoiseTex, u_xlat3.xy).x;
    u_xlat32 = (-u_xlat16_22) + u_xlat16_5.x;
    u_xlat22.x = _UsePolarUV * u_xlat32 + u_xlat16_22;
    u_xlat3.xy = u_xlat3.xy + vec2(0.100000001, 0.100000001);
    u_xlat16_5.y = texture(_NoiseTex, u_xlat3.xy).x;
    u_xlat16_5.z = 1.0;
    u_xlat3.xyw = (-u_xlat4.xyz) + u_xlat16_5.xyz;
    u_xlat3.xyw = vec3(vec3(_UsePolarUV, _UsePolarUV, _UsePolarUV)) * u_xlat3.xyw + u_xlat4.xyz;
    u_xlat32 = u_xlat23.x + (-_PolarCenterMaskSize);
    u_xlat23.x = float(1.0) / _PolarCenterMaskFade;
    u_xlat32 = u_xlat32 * u_xlat23.x;
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
    u_xlat23.x = u_xlat32 * -2.0 + 3.0;
    u_xlat32 = u_xlat32 * u_xlat32;
    u_xlat16_6.xyz = u_xlat3.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.x = u_xlat31 * _NormalPower;
    u_xlat32 = u_xlat23.x * u_xlat32 + -1.0;
    u_xlat32 = _UsePolarUV * u_xlat32 + 1.0;
    u_xlat3.x = u_xlat32 * u_xlat3.x;
    u_xlat3.xy = u_xlat3.xx * u_xlat16_6.xy;
    u_xlat3.z = u_xlat16_6.z;
    u_xlat4.x = vs_TEXCOORD10.x;
    u_xlat4.y = vs_TEXCOORD11.x;
    u_xlat4.z = vs_TEXCOORD9.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat5.x = vs_TEXCOORD10.y;
    u_xlat5.y = vs_TEXCOORD11.y;
    u_xlat5.z = vs_TEXCOORD9.y;
    u_xlat4.y = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat5.x = vs_TEXCOORD10.z;
    u_xlat5.y = vs_TEXCOORD11.z;
    u_xlat5.z = vs_TEXCOORD9.z;
    u_xlat4.z = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_6.xyz = u_xlat4.xyz * u_xlat16_6.xxx;
    u_xlat16_36 = u_xlat22.x * 2.0 + -1.0;
    u_xlat31 = u_xlat31 * u_xlat32;
    u_xlat31 = u_xlat31 * u_xlat16_36;
    u_xlat22.x = _ReflectionMode * _DistortionPower;
    u_xlat31 = u_xlat31 * u_xlat22.x;
    u_xlat22.x = u_xlat31 * 0.100000001;
    u_xlat3.x = u_xlat31 * 0.100000001 + u_xlat2.x;
    u_xlat31 = _UsePolarUV * u_xlat22.x + u_xlat2.y;
    u_xlat3.y = (-u_xlat30) * 0.00999999978 + u_xlat31;
    u_xlat16_2.xyz = texture(_ReflectionTex, u_xlat3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlatb1.xyz = greaterThanEqual(u_xlat16_8.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_9.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_9.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_9.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_8.xyz;
    u_xlat1.xyz = u_xlat16_8.xyz * _SekaiAmbientLightColor.xyz;
    u_xlat16_7.xyz = (-u_xlat16_0.xyz) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_7.xyz;
#else
    u_xlat16_21 = texture(_SubTex, vs_TEXCOORD3.xy).w;
    u_xlat16_2.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlatb1.xyz = greaterThanEqual(u_xlat16_3.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_4.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_4.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz * _SekaiAmbientLightColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
#endif
#else
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat2.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat2.z = u_xlat2.y * _ProjectionParams.x;
    u_xlat2.xy = u_xlat2.xz * vec2(0.5, 0.5);
    u_xlat2.z = (-u_xlat2.y);
    u_xlat2.xy = u_xlat2.xz + vec2(0.5, 1.5);
    u_xlat22.xy = u_xlat2.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.xy = (-vs_TEXCOORD4.xz) + (-hlslcc_mtx4x4unity_WorldToObject[3].xz);
    u_xlat23.xy = vs_TEXCOORD4.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat30 = dot(u_xlat23.xy, u_xlat23.xy);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = dFdy(u_xlat30);
    u_xlat30 = float(1.0) / u_xlat30;
    u_xlat31 = u_xlat30 / _DistortionDistance;
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
    u_xlat30 = (-u_xlat30) * 2.0 + 1.0;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat23.xy = vec2(_WaterSurfaceTime) * vec2(_MoveSpeedX, _MoveSpeedY);
    u_xlat22.xy = vec2(_MoveSpeedX, _MoveSpeedY) * vec2(_WaterSurfaceTime) + u_xlat22.xy;
    u_xlat16_22 = texture(_NoiseTex, u_xlat22.xy).x;
    u_xlat23.xy = u_xlat2.xy * _NormalNoiseSize.xy + u_xlat23.xy;
    u_xlat16_4.x = texture(_NoiseTex, u_xlat23.xy).x;
    u_xlat23.xy = u_xlat23.xy + vec2(0.100000001, 0.100000001);
    u_xlat16_4.y = texture(_NoiseTex, u_xlat23.xy).x;
    u_xlat23.xy = vec2(_MoveSpeedX, _MoveSpeedY) * vec2(_WaterSurfaceTime) + vs_TEXCOORD1.xy;
    u_xlat23.xy = u_xlat23.xy * _SecondaryNormalTex_ST.xy + _SecondaryNormalTex_ST.zw;
    u_xlat16_5.xyz = texture(_SecondaryNormalTex, u_xlat23.xy).xyz;
    u_xlat16_4.z = 1.0;
    u_xlat5.xyz = (-u_xlat16_4.xyz) + u_xlat16_5.xyz;
    u_xlat4.xyz = vec3(_UseSecondaryNormal) * u_xlat5.xyz + u_xlat16_4.xyz;
    u_xlat32 = _RadialScale * 0.100000001;
    u_xlat3.xy = u_xlat3.xy + vec2(_CenterPos.x, _CenterPos.y);
    u_xlat23.x = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat23.x = sqrt(u_xlat23.x);
    u_xlat5.x = dot(u_xlat23.xx, vec2(u_xlat32));
    u_xlat32 = min(abs(u_xlat3.y), abs(u_xlat3.x));
    u_xlat33 = max(abs(u_xlat3.y), abs(u_xlat3.x));
    u_xlat33 = float(1.0) / u_xlat33;
    u_xlat32 = u_xlat32 * u_xlat33;
    u_xlat33 = u_xlat32 * u_xlat32;
    u_xlat34 = u_xlat33 * 0.0208350997 + -0.0851330012;
    u_xlat34 = u_xlat33 * u_xlat34 + 0.180141002;
    u_xlat34 = u_xlat33 * u_xlat34 + -0.330299497;
    u_xlat33 = u_xlat33 * u_xlat34 + 0.999866009;
    u_xlat34 = u_xlat32 * u_xlat33;
    u_xlatb25 = abs(u_xlat3.y)<abs(u_xlat3.x);
    u_xlat34 = u_xlat34 * -2.0 + 1.57079637;
    u_xlat34 = u_xlatb25 ? u_xlat34 : float(0.0);
    u_xlat32 = u_xlat32 * u_xlat33 + u_xlat34;
    u_xlatb33 = u_xlat3.y<(-u_xlat3.y);
    u_xlat33 = u_xlatb33 ? -3.14159274 : float(0.0);
    u_xlat32 = u_xlat32 + u_xlat33;
    u_xlat33 = min(u_xlat3.y, u_xlat3.x);
    u_xlat3.x = max(u_xlat3.y, u_xlat3.x);
    u_xlatb13 = u_xlat33<(-u_xlat33);
    u_xlatb3 = u_xlat3.x>=(-u_xlat3.x);
    u_xlatb3 = u_xlatb3 && u_xlatb13;
    u_xlat32 = (u_xlatb3) ? (-u_xlat32) : u_xlat32;
    u_xlat5.y = u_xlat32 * 0.159235656;
    u_xlat3.xy = vec2(_WaterSurfaceTime) * vec2(_RadialSpreadSpeed, _RotationSpeed) + u_xlat5.xy;
    u_xlat16_5.x = texture(_NoiseTex, u_xlat3.xy).x;
    u_xlat32 = (-u_xlat16_22) + u_xlat16_5.x;
    u_xlat22.x = _UsePolarUV * u_xlat32 + u_xlat16_22;
    u_xlat3.xy = u_xlat3.xy + vec2(0.100000001, 0.100000001);
    u_xlat16_5.y = texture(_NoiseTex, u_xlat3.xy).x;
    u_xlat16_5.z = 1.0;
    u_xlat3.xyw = (-u_xlat4.xyz) + u_xlat16_5.xyz;
    u_xlat3.xyw = vec3(vec3(_UsePolarUV, _UsePolarUV, _UsePolarUV)) * u_xlat3.xyw + u_xlat4.xyz;
    u_xlat32 = u_xlat23.x + (-_PolarCenterMaskSize);
    u_xlat23.x = float(1.0) / _PolarCenterMaskFade;
    u_xlat32 = u_xlat32 * u_xlat23.x;
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
    u_xlat23.x = u_xlat32 * -2.0 + 3.0;
    u_xlat32 = u_xlat32 * u_xlat32;
    u_xlat16_6.xyz = u_xlat3.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.x = u_xlat31 * _NormalPower;
    u_xlat32 = u_xlat23.x * u_xlat32 + -1.0;
    u_xlat32 = _UsePolarUV * u_xlat32 + 1.0;
    u_xlat3.x = u_xlat32 * u_xlat3.x;
    u_xlat3.xy = u_xlat3.xx * u_xlat16_6.xy;
    u_xlat3.z = u_xlat16_6.z;
    u_xlat4.x = vs_TEXCOORD10.x;
    u_xlat4.y = vs_TEXCOORD11.x;
    u_xlat4.z = vs_TEXCOORD9.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat5.x = vs_TEXCOORD10.y;
    u_xlat5.y = vs_TEXCOORD11.y;
    u_xlat5.z = vs_TEXCOORD9.y;
    u_xlat4.y = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat5.x = vs_TEXCOORD10.z;
    u_xlat5.y = vs_TEXCOORD11.z;
    u_xlat5.z = vs_TEXCOORD9.z;
    u_xlat4.z = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_6.xyz = u_xlat4.xyz * u_xlat16_6.xxx;
    u_xlat16_36 = u_xlat22.x * 2.0 + -1.0;
    u_xlat31 = u_xlat31 * u_xlat32;
    u_xlat31 = u_xlat31 * u_xlat16_36;
    u_xlat22.x = _ReflectionMode * _DistortionPower;
    u_xlat31 = u_xlat31 * u_xlat22.x;
    u_xlat22.x = u_xlat31 * 0.100000001;
    u_xlat3.x = u_xlat31 * 0.100000001 + u_xlat2.x;
    u_xlat31 = _UsePolarUV * u_xlat22.x + u_xlat2.y;
    u_xlat3.y = (-u_xlat30) * 0.00999999978 + u_xlat31;
    u_xlat16_2.xyz = texture(_ReflectionTex, u_xlat3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlatb1.xyz = greaterThanEqual(u_xlat16_8.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_9.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_9.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_9.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_8.xyz;
    u_xlat1.xyz = u_xlat16_8.xyz * _SekaiAmbientLightColor.xyz;
    u_xlat16_7.xyz = (-u_xlat16_0.xyz) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_7.xyz;
#else
    u_xlat16_15 = texture(_SubTex, vs_TEXCOORD3.xy).w;
    u_xlat16_2.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlatb1.xyz = greaterThanEqual(u_xlat16_3.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_4.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_4.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz * _SekaiAmbientLightColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
#endif
#endif
    u_xlat0.xyz = (-_SekaiAmbientLightColor.xyz) + vec3(1.0, 1.0, 1.0);
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat0.xyz = (-u_xlat16_7.xyz) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_8.xyz) * _SekaiAmbientLightColor.xyz + u_xlat0.xyz;
    u_xlat16_7.xyz = u_xlat16_9.xyz * u_xlat16_7.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * vec3(vec3(_SekaiLightIntensity, _SekaiLightIntensity, _SekaiLightIntensity));
#else
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) * _SekaiAmbientLightColor.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_SekaiLightIntensity, _SekaiLightIntensity, _SekaiLightIntensity));
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SekaiAllLightIntensity);
#if defined(_USE_PLANAR_REFLECTION)
    u_xlatb30 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb30){
#else
    u_xlatb1.x = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb1.x){
#endif
        u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xy = u_xlat1.xy * u_xlat1.xy;
#if defined(_USE_OVERLAY_FLIPBOOK)
#if defined(_USE_PLANAR_REFLECTION)
        u_xlat30 = u_xlat1.y + u_xlat1.x;
        u_xlat30 = u_xlat1.z * u_xlat1.z + u_xlat30;
        u_xlat1.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat30 = u_xlat30 + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat1.x = float(1.0) / u_xlat1.x;
        u_xlat30 = u_xlat30 * u_xlat1.x;
        u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
        u_xlat1.x = u_xlat30 * -2.0 + 3.0;
        u_xlat30 = u_xlat30 * u_xlat30;
        u_xlat11 = u_xlat30 * u_xlat1.x;
        u_xlat30 = (-u_xlat1.x) * u_xlat30 + 1.0;
        u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat11);
        u_xlat1.xyz = u_xlat1.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + u_xlat1.xyz;
#else
        u_xlat1.x = u_xlat1.y + u_xlat1.x;
        u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
        u_xlat8.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat1.x = u_xlat1.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat8.x = float(1.0) / u_xlat8.x;
        u_xlat1.x = u_xlat8.x * u_xlat1.x;
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
        u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
        u_xlat1.x = u_xlat1.x * u_xlat1.x;
        u_xlat15.x = u_xlat1.x * u_xlat8.x;
        u_xlat1.x = (-u_xlat8.x) * u_xlat1.x + 1.0;
        u_xlat8.xyz = u_xlat0.xyz * u_xlat15.xxx;
        u_xlat8.xyz = u_xlat8.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat8.xyz;
#endif
#else
#if defined(_USE_PLANAR_REFLECTION)
        u_xlat30 = u_xlat1.y + u_xlat1.x;
        u_xlat30 = u_xlat1.z * u_xlat1.z + u_xlat30;
        u_xlat1.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat30 = u_xlat30 + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat1.x = float(1.0) / u_xlat1.x;
        u_xlat30 = u_xlat30 * u_xlat1.x;
        u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
        u_xlat1.x = u_xlat30 * -2.0 + 3.0;
        u_xlat30 = u_xlat30 * u_xlat30;
        u_xlat11 = u_xlat30 * u_xlat1.x;
        u_xlat30 = (-u_xlat1.x) * u_xlat30 + 1.0;
        u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat11);
        u_xlat1.xyz = u_xlat1.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + u_xlat1.xyz;
#else
        u_xlat1.x = u_xlat1.y + u_xlat1.x;
        u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
        u_xlat6.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat1.x = u_xlat1.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat6.x = float(1.0) / u_xlat6.x;
        u_xlat1.x = u_xlat6.x * u_xlat1.x;
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
        u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
        u_xlat1.x = u_xlat1.x * u_xlat1.x;
        u_xlat11 = u_xlat1.x * u_xlat6.x;
        u_xlat1.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
        u_xlat6.xyz = u_xlat0.xyz * vec3(u_xlat11);
        u_xlat6.xyz = u_xlat6.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat6.xyz;
#endif
#endif
    }
#if defined(_USE_OVERLAY_FLIPBOOK)
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat16_36 = (-vs_TEXCOORD5) + 1.0;
    u_xlat30 = u_xlat16_36 * _SekaiFogColor.w;
    u_xlat1.xyz = (-u_xlat0.xyz) + _SekaiFogColor.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(_Smoothness) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat16_6.xyz, _LightDir.xyz);
    u_xlat30 = u_xlat30 * 0.5 + _Brightness;
    u_xlat30 = u_xlat30 + 0.5;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat30 = u_xlat30 + -1.0;
    u_xlat30 = _ReflectionMode * u_xlat30 + 1.0;
#else
    u_xlat16_2.x = (-vs_TEXCOORD5) + 1.0;
    u_xlat1.x = u_xlat16_2.x * _SekaiFogColor.w;
    u_xlat8.xyz = (-u_xlat0.xyz) + _SekaiFogColor.xyz;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat8.xyz + u_xlat0.xyz;
#endif
    u_xlat1.xy = vs_TEXCOORD4.xz + (-_FlipBookCenterPosition.xz);
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat21.xy = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * vec2(_FlipBookUVScroll_Stage.x, _FlipBookUVScroll_Stage.y);
    u_xlat21.xy = u_xlat1.xy * vec2(vec2(_FlipBookScale_Stage, _FlipBookScale_Stage)) + (-u_xlat21.xy);
    u_xlat21.xy = fract(u_xlat21.xy);
    u_xlat2.x = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
#else
    u_xlat15.xy = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * vec2(_FlipBookUVScroll_Stage.x, _FlipBookUVScroll_Stage.y);
    u_xlat15.xy = u_xlat1.xy * vec2(vec2(_FlipBookScale_Stage, _FlipBookScale_Stage)) + (-u_xlat15.xy);
    u_xlat15.xy = fract(u_xlat15.xy);
    u_xlat5 = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
#endif
    u_xlat12.x = _FlipBookFrameCountY * _FlipBookFrameCountX;
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat2.x = u_xlat2.x / u_xlat12.x;
    u_xlatb22 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb22) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat2.x = u_xlat12.x * u_xlat2.x;
    u_xlat2.x = floor(u_xlat2.x);
#else
    u_xlat5 = u_xlat5 / u_xlat12.x;
    u_xlatb19 = u_xlat5>=(-u_xlat5);
    u_xlat5 = fract(abs(u_xlat5));
    u_xlat5 = (u_xlatb19) ? u_xlat5 : (-u_xlat5);
    u_xlat5 = u_xlat12.x * u_xlat5;
    u_xlat5 = floor(u_xlat5);
#endif
    u_xlat12.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat32 = u_xlat12.x * u_xlat2.x;
    u_xlat32 = floor(u_xlat32);
    u_xlat3.x = (-_FlipBookFrameCountX) * u_xlat32 + u_xlat2.x;
    u_xlat2.x = u_xlat32 + 1.0;
    u_xlat3.y = (-u_xlat2.x) + _FlipBookFrameCountY;
    u_xlat21.xy = u_xlat21.xy + u_xlat3.xy;
    u_xlat21.xy = u_xlat12.xy * u_xlat21.xy;
#else
    u_xlat26 = u_xlat12.x * u_xlat5;
    u_xlat26 = floor(u_xlat26);
    u_xlat6.x = (-_FlipBookFrameCountX) * u_xlat26 + u_xlat5;
    u_xlat5 = u_xlat26 + 1.0;
    u_xlat6.y = (-u_xlat5) + _FlipBookFrameCountY;
    u_xlat15.xy = u_xlat15.xy + u_xlat6.xy;
    u_xlat15.xy = u_xlat12.xy * u_xlat15.xy;
#endif
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat16_2 = texture(_FlipBookTex, u_xlat21.xy);
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vs_TEXCOORD7);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _FlipBookColor_Stage.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _FlipBookColor_Stage.www;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_FlipBookOpacity);
#else
    u_xlat16_2 = texture(_FlipBookTex, u_xlat15.xy);
    u_xlat16_3.xyz = u_xlat16_2.www * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vs_TEXCOORD7);
    u_xlat16_3.xyz = u_xlat16_3.xyz * _FlipBookColor_Stage.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _FlipBookColor_Stage.www;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_FlipBookOpacity);
#endif
    u_xlat1.x = u_xlat1.x + (-_FlipBookFadeRadius);
    u_xlat1.x = u_xlat1.x + (-_FlipBookFadeFallOff);
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat11 = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat1.x = u_xlat11 * u_xlat1.x;
#else
    u_xlat8.x = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat1.x = u_xlat8.x * u_xlat1.x;
#endif
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat11 = u_xlat1.x * -2.0 + 3.0;
#else
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
#endif
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat1.x = u_xlat1.x * u_xlat11;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat1.xyz;
#else
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat1.xxx + u_xlat0.xyz;
#endif
#else
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat16_36 = (-vs_TEXCOORD5) + 1.0;
    u_xlat30 = u_xlat16_36 * _SekaiFogColor.w;
    u_xlat1.xyz = (-u_xlat0.xyz) + _SekaiFogColor.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(_Smoothness) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat16_6.xyz, _LightDir.xyz);
    u_xlat30 = u_xlat30 * 0.5 + _Brightness;
    u_xlat30 = u_xlat30 + 0.5;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat30 = u_xlat30 + -1.0;
    u_xlat30 = _ReflectionMode * u_xlat30 + 1.0;
    SV_Target0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
#else
    u_xlat16_2.x = (-vs_TEXCOORD5) + 1.0;
    u_xlat1.x = u_xlat16_2.x * _SekaiFogColor.w;
    u_xlat6.xyz = (-u_xlat0.xyz) + _SekaiFogColor.xyz;
    SV_Target0.xyz = u_xlat1.xxx * u_xlat6.xyz + u_xlat0.xyz;
#endif
#endif
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
#if !defined(_USE_PLANAR_REFLECTION)
    SV_Target0.w = u_xlat16_21;
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
#else
#if !defined(_USE_PLANAR_REFLECTION)
    SV_Target0.w = u_xlat16_15;
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
#endif
    u_xlat0.x = vs_TEXCOORD6 / vs_TEXCOORD0.w;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#if defined(_USE_OVERLAY_FLIPBOOK)
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat10 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat10 = u_xlat10 + -1.0;
    u_xlat10 = u_xlat10 * _ProjectionParams.w;
    u_xlat0.x = u_xlat10 * u_xlat0.x + _ProjectionParams.w;
#else
    u_xlat7 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat7 = u_xlat7 + -1.0;
    u_xlat7 = u_xlat7 * _ProjectionParams.w;
    u_xlat0.x = u_xlat7 * u_xlat0.x + _ProjectionParams.w;
#endif
#else
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat10 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat10 = u_xlat10 + -1.0;
    u_xlat10 = u_xlat10 * _ProjectionParams.w;
    u_xlat0.x = u_xlat10 * u_xlat0.x + _ProjectionParams.w;
#else
    u_xlat5 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat5 = u_xlat5 + -1.0;
    u_xlat5 = u_xlat5 * _ProjectionParams.w;
    u_xlat0.x = u_xlat5 * u_xlat0.x + _ProjectionParams.w;
#endif
#endif
    u_xlat0.x = (-_CoCParams.x) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _CoCParams.y;
#if defined(_USE_OVERLAY_FLIPBOOK)
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat10 = u_xlat0.x;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#else
    u_xlat7 = u_xlat0.x;
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
#else
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat10 = u_xlat0.x;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#else
    u_xlat5 = u_xlat0.x;
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
#endif
    u_xlat0.x = max(u_xlat0.x, -1.0);
    u_xlat0.x = min(u_xlat0.x, 0.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat0.x = u_xlat0.x + u_xlat10;
#else
    u_xlat0.x = u_xlat0.x + u_xlat7;
#endif
#else
#if defined(_USE_PLANAR_REFLECTION)
    u_xlat0.x = u_xlat0.x + u_xlat10;
#else
    u_xlat0.x = u_xlat0.x + u_xlat5;
#endif
#endif
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5;
#if defined(_USE_PLANAR_REFLECTION)
    SV_Target0.w = 1.0;
#endif
    SV_Target1.x = u_xlat0.x;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}
#endif
			ENDGLSL
		}
	}
}
