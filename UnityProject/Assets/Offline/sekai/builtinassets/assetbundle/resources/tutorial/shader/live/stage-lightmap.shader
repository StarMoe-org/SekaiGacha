// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Stage/LightMap"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_LightMapTex("LightMapTex", 2D) = "white" {}
		_RotateTheta("UV Rotate Theta", Range(-180, 180)) = 0
		_RotateOffset("UV Rotate Offset", Float) = 0
		[Main(Group_Specular, _, on, off)] _groupSpecular("スペキュラ", Float) = 1
		[SubToggle(Group_Specular, _ENABLE_SPECULAR)] _USE_SPECULAR("スペキュラを使う？", Float) = 0
		[ShowIf(_USE_SPECULAR, Equal, 1)] [Sub(Group_Specular)] _NormalMapTex("ノーマルマップテクスチャ", 2D) = "bump" {}
		[ShowIf(_USE_SPECULAR, Equal, 1)] [Sub(Group_Specular)] _NormalMapSize("ノーマルマップUVタイル", Range(1, 100)) = 20
		[ShowIf(_USE_SPECULAR, Equal, 1)] [Sub(Group_Specular)] _NormalPower("ノーマルマップ強度", Range(1, 10)) = 1
		[ShowIf(_USE_SPECULAR, Equal, 1)] [Sub(Group_Specular)] _Smoothness("ハイライトの鋭さ(smoothness)", Range(1, 128)) = 10
		[Space] [ShowIf(_USE_SPECULAR, Equal, 1)] [Sub(Group_Specular)] _Intensity("スペキュラ強度", Range(0, 10)) = 1
		[ShowIf(_USE_SPECULAR, Equal, 1)] [Sub(Group_Specular)] _LightColor("スペキュラカラー", Color) = (1, 1, 1, 1)
		[ShowIf(_USE_SPECULAR, Equal, 1)] [Sub(Group_Specular)] _LightPosition("スペキュラライト位置(wは不使用)", Vector) = (0, 0, 0, 0)
		[ShowIf(_USE_SPECULAR, Equal, 1)] [Sub(Group_Specular)] _LightRotation("スペキュラライト回転(wは不使用)", Vector) = (0, 0, 0, 0)
		[ShowIf(_USE_SPECULAR, Equal, 1)] [Sub(Group_Specular)] _SpecularMaskTex("スペキュラマスク(α)", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
		LOD 100
		Pass
		{
			Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
			GLSLPROGRAM
#pragma multi_compile _ _ENABLE_SPECULAR
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
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_ObjectToWorld[4];
#if defined(_ENABLE_SPECULAR)
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_WorldToObject[4];
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_WorldToObject[4];
#else
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_WorldToObject[4];
#endif
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
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4                _LightMapTex_ST;
#if defined(_ENABLE_SPECULAR)
	UNITY_UNIFORM vec4                _NormalMapTex_ST;
	UNITY_UNIFORM vec4                _SpecularMaskTex_ST;
#else
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_NormalMapTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_SpecularMaskTex_ST;
#endif
	UNITY_UNIFORM float                _RotateTheta;
	UNITY_UNIFORM float                _RotateOffset;
#if defined(_ENABLE_SPECULAR)
	UNITY_UNIFORM float                _NormalMapSize;
	UNITY_UNIFORM float                _NormalPower;
	UNITY_UNIFORM float                _Smoothness;
	UNITY_UNIFORM float                _Intensity;
	UNITY_UNIFORM mediump vec4                _LightColor;
	UNITY_UNIFORM vec4                _LightPosition;
	UNITY_UNIFORM vec4                _LightRotation;
#else
	UNITY_UNIFORM float Xhlslcc_UnusedX_NormalMapSize;
	UNITY_UNIFORM float Xhlslcc_UnusedX_NormalPower;
	UNITY_UNIFORM float Xhlslcc_UnusedX_Smoothness;
	UNITY_UNIFORM float Xhlslcc_UnusedX_Intensity;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_LightColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_LightPosition;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_LightRotation;
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
#if defined(_ENABLE_SPECULAR)
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD2;
in highp vec2 in_TEXCOORD3;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
in highp vec3 in_NORMAL0;
#endif
#endif
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump float vs_TEXCOORD4;
out highp float vs_TEXCOORD5;
#if defined(_USE_OVERLAY_FLIPBOOK)
out mediump float vs_TEXCOORD6;
#endif
#if defined(_ENABLE_SPECULAR)
out highp vec3 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
#endif
vec4 u_xlat0;
vec4 u_xlat1;
#if defined(_ENABLE_SPECULAR)
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
float u_xlat9;
bool u_xlatb9;
#else
vec3 u_xlat2;
float u_xlat6;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
mediump float u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
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
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * _LightMapTex_ST.xy + _LightMapTex_ST.zw;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
    vs_TEXCOORD5 = u_xlat1.z;
#if defined(_ENABLE_SPECULAR)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat3;
#else
    u_xlat2.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2.x;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
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
#if defined(_ENABLE_SPECULAR)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 1.17549435e-38);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlatb9 = 0.0>=u_xlat0.y;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat9 = u_xlat9 * _FlipBookLowerDotMaskOpacity_Stage;
    u_xlatb1 = u_xlat0.y>=0.0;
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat16_2 = u_xlat1.x * _FlipBookUpperDotMaskOpacity_Stage + u_xlat9;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_2 = abs(u_xlat0.y) * u_xlat16_2 + (-_FlipBookMaskThreshold_Stage);
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    u_xlat16_5 = _FlipBookMaskFallOff_Stage + 0.00100000005;
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
    u_xlat16_5 = float(1.0) / u_xlat16_5;
    u_xlat16_2 = u_xlat16_5 * u_xlat16_2;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = u_xlat16_2 * -2.0 + 3.0;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    vs_TEXCOORD6 = u_xlat16_2 * u_xlat16_5;
#else
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = max(u_xlat0.x, 1.17549435e-38);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat2.xyz;
#endif
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 1.17549435e-38);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD8.xyz = vec3(u_xlat9) * u_xlat0.xyz;
#else
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = max(u_xlat6, 1.17549435e-38);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD8.xyz = vec3(u_xlat6) * u_xlat0.xyz;
#endif
    vs_TEXCOORD8.w = in_TANGENT0.w;
    vs_TEXCOORD9.xy = in_TEXCOORD2.xy * _SpecularMaskTex_ST.xy + _SpecularMaskTex_ST.zw;
    vs_TEXCOORD9.zw = in_TEXCOORD3.xy * _NormalMapTex_ST.xy + _NormalMapTex_ST.zw;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
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
    vs_TEXCOORD6 = u_xlat16_2 * u_xlat16_5;
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
#if defined(_ENABLE_SPECULAR)
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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4                _LightMapTex_ST;
#if defined(_ENABLE_SPECULAR)
	UNITY_UNIFORM vec4                _NormalMapTex_ST;
	UNITY_UNIFORM vec4                _SpecularMaskTex_ST;
#else
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_NormalMapTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_SpecularMaskTex_ST;
#endif
	UNITY_UNIFORM float                _RotateTheta;
	UNITY_UNIFORM float                _RotateOffset;
#if defined(_ENABLE_SPECULAR)
	UNITY_UNIFORM float                _NormalMapSize;
	UNITY_UNIFORM float                _NormalPower;
	UNITY_UNIFORM float                _Smoothness;
	UNITY_UNIFORM float                _Intensity;
	UNITY_UNIFORM mediump vec4                _LightColor;
	UNITY_UNIFORM vec4                _LightPosition;
	UNITY_UNIFORM vec4                _LightRotation;
#else
	UNITY_UNIFORM float Xhlslcc_UnusedX_NormalMapSize;
	UNITY_UNIFORM float Xhlslcc_UnusedX_NormalPower;
	UNITY_UNIFORM float Xhlslcc_UnusedX_Smoothness;
	UNITY_UNIFORM float Xhlslcc_UnusedX_Intensity;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_LightColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_LightPosition;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_LightRotation;
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _LightMapTex;
#if defined(_ENABLE_SPECULAR)
UNITY_LOCATION(2) uniform mediump sampler2D _NormalMapTex;
UNITY_LOCATION(3) uniform mediump sampler2D _SpecularMaskTex;
#if defined(_USE_OVERLAY_FLIPBOOK)
UNITY_LOCATION(4) uniform mediump sampler2D _FlipBookTex;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
UNITY_LOCATION(2) uniform mediump sampler2D _FlipBookTex;
#endif
#endif
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump float vs_TEXCOORD4;
in highp float vs_TEXCOORD5;
#if defined(_USE_OVERLAY_FLIPBOOK)
in mediump float vs_TEXCOORD6;
#endif
#if defined(_ENABLE_SPECULAR)
in highp vec3 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
#endif
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
#if defined(_USE_OVERLAY_FLIPBOOK)
mediump vec4 u_xlat16_2;
#else
mediump vec3 u_xlat16_2;
#endif
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bvec3 u_xlatb4;
mediump vec3 u_xlat16_5;
#if defined(_ENABLE_SPECULAR)
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
float u_xlat11;
float u_xlat15;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb17;
vec2 u_xlat26;
float u_xlat28;
#else
float u_xlat26;
#endif
float u_xlat33;
mediump float u_xlat16_33;
bool u_xlatb33;
float u_xlat37;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat6;
vec2 u_xlat7;
float u_xlat8;
float u_xlat12;
bool u_xlatb14;
vec2 u_xlat20;
float u_xlat22;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
#else
float u_xlat6;
float u_xlat10;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
#endif
#endif
void main()
{
    u_xlat0.x = _RotateTheta * 0.0174532942;
    u_xlat16_1.x = sin(u_xlat0.x);
    u_xlat16_2.x = cos(u_xlat0.x);
    u_xlat16_3.x = (-u_xlat16_1.x);
    u_xlat0.xy = vs_TEXCOORD1.xy + (-vec2(vec2(_RotateOffset, _RotateOffset)));
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat16_3.z = u_xlat16_1.x;
    u_xlat4.x = dot(u_xlat0.xy, u_xlat16_3.yz);
    u_xlat4.y = dot(u_xlat0.xy, u_xlat16_3.xy);
    u_xlat0.xy = u_xlat4.xy + vec2(vec2(_RotateOffset, _RotateOffset));
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = texture(_LightMapTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat0 = u_xlat0 * u_xlat16_1;
#if defined(_ENABLE_SPECULAR)
    u_xlat1.w = u_xlat0.w + u_xlat0.w;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat25 = u_xlat0.w + u_xlat0.w;
#else
    u_xlat19 = u_xlat0.w + u_xlat0.w;
#endif
#endif
    u_xlatb4.xyz = greaterThanEqual(u_xlat0.xyzx, vec4(0.25, 0.25, 0.25, 0.0)).xyz;
    u_xlat16_2.x = (u_xlatb4.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb4.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb4.z) ? float(1.0) : float(0.0);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(4.0, 4.0, 4.0);
    u_xlat4.xyz = u_xlat16_3.xyz * _SekaiAmbientLightColor.xyz;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat0.xyz = (-_SekaiAmbientLightColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * _SekaiAmbientLightColor.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_SekaiLightIntensity, _SekaiLightIntensity, _SekaiLightIntensity));
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SekaiAllLightIntensity);
#if defined(_ENABLE_SPECULAR)
    u_xlatb33 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb33){
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlatb24 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb24){
#else
    u_xlatb18 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb18){
#endif
#endif
        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat4.xy = u_xlat4.xy * u_xlat4.xy;
#if defined(_ENABLE_SPECULAR)
        u_xlat33 = u_xlat4.y + u_xlat4.x;
        u_xlat33 = u_xlat4.z * u_xlat4.z + u_xlat33;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat24 = u_xlat4.y + u_xlat4.x;
        u_xlat24 = u_xlat4.z * u_xlat4.z + u_xlat24;
#else
        u_xlat18 = u_xlat4.y + u_xlat4.x;
        u_xlat18 = u_xlat4.z * u_xlat4.z + u_xlat18;
#endif
#endif
        u_xlat4.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#if defined(_ENABLE_SPECULAR)
        u_xlat33 = u_xlat33 + (-_SekaiGlobalSpotLightRadiusNear);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat24 = u_xlat24 + (-_SekaiGlobalSpotLightRadiusNear);
#else
        u_xlat18 = u_xlat18 + (-_SekaiGlobalSpotLightRadiusNear);
#endif
#endif
        u_xlat4.x = float(1.0) / u_xlat4.x;
#if defined(_ENABLE_SPECULAR)
        u_xlat33 = u_xlat33 * u_xlat4.x;
        u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
        u_xlat4.x = u_xlat33 * -2.0 + 3.0;
        u_xlat33 = u_xlat33 * u_xlat33;
        u_xlat15 = u_xlat33 * u_xlat4.x;
        u_xlat33 = (-u_xlat4.x) * u_xlat33 + 1.0;
        u_xlat4.xyz = u_xlat0.xyz * vec3(u_xlat15);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat24 = u_xlat24 * u_xlat4.x;
        u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
        u_xlat4.x = u_xlat24 * -2.0 + 3.0;
        u_xlat24 = u_xlat24 * u_xlat24;
        u_xlat12 = u_xlat24 * u_xlat4.x;
        u_xlat24 = (-u_xlat4.x) * u_xlat24 + 1.0;
        u_xlat4.xyz = u_xlat0.xyz * vec3(u_xlat12);
#else
        u_xlat18 = u_xlat18 * u_xlat4.x;
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
        u_xlat4.x = u_xlat18 * -2.0 + 3.0;
        u_xlat18 = u_xlat18 * u_xlat18;
        u_xlat10 = u_xlat18 * u_xlat4.x;
        u_xlat18 = (-u_xlat4.x) * u_xlat18 + 1.0;
        u_xlat4.xyz = u_xlat0.xyz * vec3(u_xlat10);
#endif
#endif
        u_xlat4.xyz = u_xlat4.xyz * _SekaiGlobalSpotLightColor.xyz;
#if defined(_ENABLE_SPECULAR)
        u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + u_xlat4.xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + u_xlat4.xyz;
#else
        u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat4.xyz;
#endif
#endif
    }
    u_xlat16_2.x = (-vs_TEXCOORD4) + 1.0;
#if defined(_ENABLE_SPECULAR)
    u_xlat33 = u_xlat16_2.x * _SekaiFogColor.w;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat24 = u_xlat16_2.x * _SekaiFogColor.w;
#else
    u_xlat18 = u_xlat16_2.x * _SekaiFogColor.w;
#endif
#endif
    u_xlat4.xyz = (-u_xlat0.xyz) + _SekaiFogColor.xyz;
#if defined(_ENABLE_SPECULAR)
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _LightPosition.xyz;
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat37 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * vs_TEXCOORD7.xyz;
    u_xlat37 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat7.xyz = vec3(u_xlat37) * vs_TEXCOORD8.yzx;
    u_xlat8.xyz = u_xlat6.zxy * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat6.yzx * u_xlat7.yzx + (-u_xlat8.xyz);
    u_xlat8.xyz = u_xlat8.xyz * vs_TEXCOORD8.www;
    u_xlat37 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat8.xyz;
    u_xlat9.xy = vs_TEXCOORD9.zw * vec2(vec2(_NormalMapSize, _NormalMapSize));
    u_xlat16_9.xyz = texture(_NormalMapTex, u_xlat9.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_9.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_NormalPower, _NormalPower));
    u_xlat9.x = u_xlat7.z;
    u_xlat9.y = u_xlat8.x;
    u_xlat9.z = u_xlat6.x;
    u_xlat9.x = dot(u_xlat16_2.xyz, u_xlat9.xyz);
    u_xlat10.x = u_xlat7.x;
    u_xlat10.y = u_xlat8.y;
    u_xlat10.z = u_xlat6.y;
    u_xlat9.y = dot(u_xlat16_2.xyz, u_xlat10.xyz);
    u_xlat6.x = u_xlat7.y;
    u_xlat6.y = u_xlat8.z;
    u_xlat9.z = dot(u_xlat16_2.xyz, u_xlat6.xyz);
    u_xlat16_2.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat9.xyz;
    u_xlat6.xyz = _LightRotation.xyz * vec3(0.0174532924, 0.0174532924, 0.0174532924);
    u_xlat7.x = cos(u_xlat6.x);
    u_xlat6.x = sin(u_xlat6.x);
    u_xlat6.xw = u_xlat4.zy * u_xlat6.xx;
    u_xlat15 = u_xlat4.y * u_xlat7.x + (-u_xlat6.x);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat26.x = u_xlat4.z * u_xlat7.x + u_xlat6.w;
#else
    u_xlat26 = u_xlat4.z * u_xlat7.x + u_xlat6.w;
#endif
    u_xlat7.x = cos(u_xlat6.y);
    u_xlat6.x = sin(u_xlat6.y);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat37 = u_xlat26.x * u_xlat6.x;
#else
    u_xlat37 = u_xlat26 * u_xlat6.x;
#endif
    u_xlat37 = u_xlat4.x * u_xlat7.x + u_xlat37;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat26.x = u_xlat26.x * u_xlat7.x;
    u_xlat7.z = (-u_xlat4.x) * u_xlat6.x + u_xlat26.x;
#else
    u_xlat26 = u_xlat26 * u_xlat7.x;
    u_xlat7.z = (-u_xlat4.x) * u_xlat6.x + u_xlat26;
#endif
    u_xlat4.x = sin(u_xlat6.z);
    u_xlat6.x = cos(u_xlat6.z);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat26.x = u_xlat4.x * u_xlat15;
    u_xlat7.x = u_xlat37 * u_xlat6.x + (-u_xlat26.x);
#else
    u_xlat26 = u_xlat4.x * u_xlat15;
    u_xlat7.x = u_xlat37 * u_xlat6.x + (-u_xlat26);
#endif
    u_xlat15 = u_xlat15 * u_xlat6.x;
    u_xlat7.y = u_xlat37 * u_xlat4.x + u_xlat15;
    u_xlat4.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat7.xyz;
    u_xlat37 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat37 = u_xlat37 * 0.5 + 0.5;
    u_xlat1 = u_xlat1 * vec4(u_xlat37);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat4.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Smoothness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Intensity, _Intensity, _Intensity));
    u_xlat16_33 = texture(_SpecularMaskTex, vs_TEXCOORD9.xy).w;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_33) + u_xlat1.xyz;
    u_xlat4.xy = vs_TEXCOORD3.xz + (-_FlipBookCenterPosition.xz);
    u_xlat26.xy = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * vec2(_FlipBookUVScroll_Stage.x, _FlipBookUVScroll_Stage.y);
    u_xlat26.xy = u_xlat4.xy * vec2(vec2(_FlipBookScale_Stage, _FlipBookScale_Stage)) + (-u_xlat26.xy);
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat33 = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat6.x = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat33 = u_xlat33 / u_xlat6.x;
    u_xlatb17 = u_xlat33>=(-u_xlat33);
    u_xlat33 = fract(abs(u_xlat33));
    u_xlat33 = (u_xlatb17) ? u_xlat33 : (-u_xlat33);
    u_xlat33 = u_xlat6.x * u_xlat33;
    u_xlat33 = floor(u_xlat33);
    u_xlat6.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat28 = u_xlat33 * u_xlat6.x;
    u_xlat28 = floor(u_xlat28);
    u_xlat7.x = (-_FlipBookFrameCountX) * u_xlat28 + u_xlat33;
    u_xlat33 = u_xlat28 + 1.0;
    u_xlat7.y = (-u_xlat33) + _FlipBookFrameCountY;
    u_xlat26.xy = u_xlat26.xy + u_xlat7.xy;
    u_xlat26.xy = u_xlat6.xy * u_xlat26.xy;
    u_xlat33 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat16_2 = texture(_FlipBookTex, u_xlat26.xy);
    u_xlat16_3.xyz = u_xlat16_2.www * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vs_TEXCOORD6);
    u_xlat16_3.xyz = u_xlat16_3.xyz * _FlipBookColor_Stage.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _FlipBookColor_Stage.www;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_FlipBookOpacity);
    u_xlat33 = u_xlat33 + (-_FlipBookFadeRadius);
    u_xlat33 = u_xlat33 + (-_FlipBookFadeFallOff);
    u_xlat4.x = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat33 = u_xlat33 * u_xlat4.x;
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat4.x = u_xlat33 * -2.0 + 3.0;
    u_xlat33 = u_xlat33 * u_xlat33;
    u_xlat33 = u_xlat33 * u_xlat4.x;
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(u_xlat33) + u_xlat0.xyz;
#else
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat16_33) + u_xlat1.xyz;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat4.xyz + u_xlat0.xyz;
    u_xlat4.xy = vs_TEXCOORD3.xz + (-_FlipBookCenterPosition.xz);
    u_xlat20.xy = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * vec2(_FlipBookUVScroll_Stage.x, _FlipBookUVScroll_Stage.y);
    u_xlat20.xy = u_xlat4.xy * vec2(vec2(_FlipBookScale_Stage, _FlipBookScale_Stage)) + (-u_xlat20.xy);
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat24 = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat6.x = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat24 = u_xlat24 / u_xlat6.x;
    u_xlatb14 = u_xlat24>=(-u_xlat24);
    u_xlat24 = fract(abs(u_xlat24));
    u_xlat24 = (u_xlatb14) ? u_xlat24 : (-u_xlat24);
    u_xlat24 = u_xlat6.x * u_xlat24;
    u_xlat24 = floor(u_xlat24);
    u_xlat6.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat22 = u_xlat24 * u_xlat6.x;
    u_xlat22 = floor(u_xlat22);
    u_xlat7.x = (-_FlipBookFrameCountX) * u_xlat22 + u_xlat24;
    u_xlat24 = u_xlat22 + 1.0;
    u_xlat7.y = (-u_xlat24) + _FlipBookFrameCountY;
    u_xlat20.xy = u_xlat20.xy + u_xlat7.xy;
    u_xlat20.xy = u_xlat6.xy * u_xlat20.xy;
    u_xlat24 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat16_2 = texture(_FlipBookTex, u_xlat20.xy);
    u_xlat16_3.xyz = u_xlat16_2.www * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vs_TEXCOORD6);
    u_xlat16_3.xyz = u_xlat16_3.xyz * _FlipBookColor_Stage.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _FlipBookColor_Stage.www;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_FlipBookOpacity);
    u_xlat24 = u_xlat24 + (-_FlipBookFadeRadius);
    u_xlat24 = u_xlat24 + (-_FlipBookFadeFallOff);
    u_xlat4.x = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat24 = u_xlat24 * u_xlat4.x;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat4.x = u_xlat24 * -2.0 + 3.0;
    u_xlat24 = u_xlat24 * u_xlat24;
    u_xlat24 = u_xlat24 * u_xlat4.x;
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(u_xlat24) + u_xlat0.xyz;
#else
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat0.xyz;
#endif
#endif
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
#if defined(_ENABLE_SPECULAR)
    u_xlat1.w = u_xlat1.w;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat1.w = u_xlat25;
#else
    u_xlat1.w = u_xlat19;
#endif
#endif
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#if defined(_ENABLE_SPECULAR)
    u_xlat11 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat11 = u_xlat11 + -1.0;
    u_xlat11 = u_xlat11 * _ProjectionParams.w;
    u_xlat0.x = u_xlat11 * u_xlat0.x + _ProjectionParams.w;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat8 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat8 = u_xlat8 + -1.0;
    u_xlat8 = u_xlat8 * _ProjectionParams.w;
    u_xlat0.x = u_xlat8 * u_xlat0.x + _ProjectionParams.w;
#else
    u_xlat6 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat6 = u_xlat6 + -1.0;
    u_xlat6 = u_xlat6 * _ProjectionParams.w;
    u_xlat0.x = u_xlat6 * u_xlat0.x + _ProjectionParams.w;
#endif
#endif
    u_xlat0.x = (-_CoCParams.x) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _CoCParams.y;
#if defined(_ENABLE_SPECULAR)
    u_xlat11 = u_xlat0.x;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat8 = u_xlat0.x;
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#else
    u_xlat6 = u_xlat0.x;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
#endif
    u_xlat0.x = max(u_xlat0.x, -1.0);
    u_xlat0.x = min(u_xlat0.x, 0.0);
#if defined(_ENABLE_SPECULAR)
    u_xlat0.x = u_xlat0.x + u_xlat11;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat0.x = u_xlat0.x + u_xlat8;
#else
    u_xlat0.x = u_xlat0.x + u_xlat6;
#endif
#endif
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5;
    SV_Target0 = u_xlat1;
    SV_Target1.x = u_xlat0.x;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}
#endif
			ENDGLSL
		}
		UsePass "Hidden/Sekai/Live/Reflection/LightMap-Caster"
	}
}
