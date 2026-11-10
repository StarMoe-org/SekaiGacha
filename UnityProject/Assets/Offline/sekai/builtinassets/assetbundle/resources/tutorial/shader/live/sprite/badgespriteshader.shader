// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Sprites/Badge"
{
	Properties
	{
		[PerRendererData] _MainTex("Main Map", 2D) = "white" {}
		_HologramMap("Hologram Map", 2D) = "white" {}
		_HologramScale("Hologram Scale", Float) = 1
		_HologramMaskMap("Hologram Mask", 2D) = "black" {}
		_HologramRampMap("Hologram Ramp", 2D) = "white" {}
		_HologramRampScale("Hologram Ramp Scale", Range(0, 100)) = 5
		_NormalMap("Normal Map", 2D) = "white" {}
		_NormalScale("Normal Scale", Float) = 1
		_Metallic("Metallic", Range(0, 1)) = 0
		_Smoothness("Smoothness", Range(0, 1)) = 0
		_HologramMetallic("Hologram Metallic", Range(0, 1)) = 0
		_HologramSmoothness("Hologram Smoothness", Range(0, 1)) = 0
		_HologramAddRatio("Hologram Add Ratio", Range(0, 1)) = 1
		_AmbientColor("Ambient Color", Color) = (0.5, 0.5, 0.5, 1)
		_AmbientSpecularColor("Ambient Specular Color", Color) = (0, 0, 0, 1)
		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip("Use Alpha Clip", Float) = 0
		[HideInspector] _StencilComp("Stencil Comparison", Float) = 8
		[HideInspector] _Stencil("Stencil ID", Float) = 0
		[HideInspector] _StencilOp("Stencil Operation", Float) = 0
		[HideInspector] _StencilWriteMask("Stencil Write Mask", Float) = 255
		[HideInspector] _StencilReadMask("Stencil Read Mask", Float) = 255
		[HideInspector] _ColorMask("Color Mask", Float) = 15
	}
	SubShader
	{
		Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
		LOD 100
		Pass
		{
			Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ColorMask [_ColorMask]
			ZTest [unity_GUIZTestMode]
			ZWrite Off
			Cull Off
			Stencil
			{
				Ref [_Stencil]
				ReadMask [_StencilReadMask]
				WriteMask [_StencilWriteMask]
				Comp [_StencilComp]
				Pass [_StencilOp]
			}
			GLSLPROGRAM
#pragma multi_compile _ UNITY_UI_ALPHACLIP
#pragma multi_compile _ UNITY_UI_CLIP_RECT
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
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
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4                _HologramMap_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HologramMaskMap_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HologramRampMap_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_NormalMap_ST;
	UNITY_UNIFORM float                _HologramScale;
	UNITY_UNIFORM float                _NormalScale;
	UNITY_UNIFORM float                _HologramRampScale;
	UNITY_UNIFORM float                _Metallic;
	UNITY_UNIFORM float                _Smoothness;
	UNITY_UNIFORM float                _HologramMetallic;
	UNITY_UNIFORM float                _HologramSmoothness;
	UNITY_UNIFORM float                _HologramAddRatio;
	UNITY_UNIFORM mediump vec4                _AmbientColor;
	UNITY_UNIFORM mediump vec4                _AmbientSpecularColor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec2 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD6;
out mediump vec4 vs_COLOR0;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_TEXCOORD0.xyz = in_POSITION0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 1.17549435e-38);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = max(u_xlat12, 1.17549435e-38);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlatb12 = unity_WorldTransformParams.w>=0.0;
    u_xlat12 = (u_xlatb12) ? 1.0 : -1.0;
    u_xlat16_3.x = u_xlat12 * in_TANGENT0.w;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    vs_TEXCOORD4.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _HologramMap_ST.xy + _HologramMap_ST.zw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
#if defined(UNITY_UI_CLIP_RECT)
uniform 	vec4 _ClipRect;
#endif
uniform 	vec4 _VirtualBadgeLightDir0;
uniform 	vec4 _VirtualBadgeLightDir1;
uniform 	vec4 _VirtualBadgeLightDir2;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4                _HologramMap_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HologramMaskMap_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HologramRampMap_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_NormalMap_ST;
	UNITY_UNIFORM float                _HologramScale;
	UNITY_UNIFORM float                _NormalScale;
	UNITY_UNIFORM float                _HologramRampScale;
	UNITY_UNIFORM float                _Metallic;
	UNITY_UNIFORM float                _Smoothness;
	UNITY_UNIFORM float                _HologramMetallic;
	UNITY_UNIFORM float                _HologramSmoothness;
	UNITY_UNIFORM float                _HologramAddRatio;
	UNITY_UNIFORM mediump vec4                _AmbientColor;
	UNITY_UNIFORM mediump vec4                _AmbientSpecularColor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _NormalMap;
UNITY_LOCATION(2) uniform mediump sampler2D _HologramMap;
UNITY_LOCATION(3) uniform mediump sampler2D _HologramMaskMap;
UNITY_LOCATION(4) uniform mediump sampler2D _HologramRampMap;
#if defined(UNITY_UI_CLIP_RECT)
in highp vec3 vs_TEXCOORD0;
#endif
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec2 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD6;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
vec4 u_xlat0;
#else
vec3 u_xlat0;
#endif
#else
vec4 u_xlat0;
#endif
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
#if defined(UNITY_UI_CLIP_RECT)
bvec4 u_xlatb1;
#endif
mediump vec4 u_xlat16_2;
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
vec3 u_xlat3;
#else
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
bool u_xlatb3;
#endif
#else
vec3 u_xlat3;
#endif
vec3 u_xlat4;
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
mediump vec3 u_xlat16_4;
#endif
#else
mediump vec3 u_xlat16_4;
#endif
vec3 u_xlat5;
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
vec3 u_xlat8;
#else
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
#endif
#else
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
vec3 u_xlat8;
#endif
mediump vec4 u_xlat16_8;
vec3 u_xlat9;
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
mediump float u_xlat16_10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
vec3 u_xlat13;
mediump vec3 u_xlat16_14;
vec3 u_xlat15;
#else
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
vec3 u_xlat14;
#endif
#else
mediump float u_xlat16_10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
vec3 u_xlat13;
mediump vec3 u_xlat16_14;
vec3 u_xlat15;
#endif
mediump vec3 u_xlat16_15;
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
bool u_xlatb15;
mediump float u_xlat16_17;
mediump vec3 u_xlat16_21;
mediump vec3 u_xlat16_25;
mediump vec2 u_xlat16_32;
float u_xlat45;
float u_xlat46;
mediump float u_xlat16_47;
mediump float u_xlat16_51;
#else
mediump float u_xlat16_18;
vec2 u_xlat19;
mediump vec3 u_xlat16_24;
mediump vec3 u_xlat16_27;
mediump vec2 u_xlat16_34;
float u_xlat48;
bool u_xlatb48;
mediump float u_xlat16_50;
float u_xlat51;
float u_xlat52;
float u_xlat53;
mediump float u_xlat16_56;
#endif
#else
bool u_xlatb15;
mediump float u_xlat16_17;
mediump vec3 u_xlat16_21;
mediump vec3 u_xlat16_25;
mediump vec2 u_xlat16_32;
float u_xlat45;
float u_xlat46;
mediump float u_xlat16_47;
mediump float u_xlat16_51;
#endif
void main()
{
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
    u_xlat0.x = dot(_VirtualBadgeLightDir1.xyz, _VirtualBadgeLightDir1.xyz);
    u_xlat0.x = max(u_xlat0.x, 1.17549435e-38);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat15.xyz = _VirtualBadgeLightDir1.xyz * u_xlat0.xxx + vec3(0.0, 0.0, -1.0);
    u_xlat1.xyz = u_xlat0.xxx * _VirtualBadgeLightDir1.xyz;
    u_xlat0.x = dot(u_xlat15.xyz, u_xlat15.xyz);
    u_xlat0.x = max(u_xlat0.x, 1.17549435e-38);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat15.xyz;
    u_xlat45 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
    u_xlat16_2.x = u_xlat45 * u_xlat45;
    u_xlat45 = max(u_xlat16_2.x, 0.100000001);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD3.xyz;
    u_xlat46 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat46 = inversesqrt(u_xlat46);
    u_xlat3.xyz = vec3(u_xlat46) * vs_TEXCOORD4.xyz;
    u_xlat16_4.xyz = texture(_NormalMap, vs_TEXCOORD5.xy).xyw;
    u_xlat16_2.x = dot(u_xlat16_4.zz, u_xlat16_4.xx);
    u_xlat16_2.y = u_xlat16_4.y + u_xlat16_4.y;
#else
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD5.xy);
    u_xlatb48 = u_xlat16_0.w>=0.5;
    u_xlat1.w = u_xlatb48 ? 1.0 : float(0.0);
    u_xlat16_2.x = u_xlat1.w * vs_COLOR0.w + -0.00100000005;
    u_xlatb48 = u_xlat16_2.x<0.0;
    if(u_xlatb48){discard;}
    u_xlat48 = dot(_VirtualBadgeLightDir1.xyz, _VirtualBadgeLightDir1.xyz);
    u_xlat48 = max(u_xlat48, 1.17549435e-38);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = _VirtualBadgeLightDir1.xyz * vec3(u_xlat48) + vec3(0.0, 0.0, -1.0);
    u_xlat4.xyz = vec3(u_xlat48) * _VirtualBadgeLightDir1.xyz;
    u_xlat48 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat48 = max(u_xlat48, 1.17549435e-38);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * u_xlat3.xyz;
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat48 = clamp(u_xlat48, 0.0, 1.0);
    u_xlat16_2.x = u_xlat48 * u_xlat48;
    u_xlat48 = max(u_xlat16_2.x, 0.100000001);
    u_xlat51 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat4.xyz = vec3(u_xlat51) * vs_TEXCOORD3.xyz;
    u_xlat51 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * vs_TEXCOORD4.xyz;
    u_xlat16_6.xyz = texture(_NormalMap, vs_TEXCOORD5.xy).xyw;
    u_xlat16_2.x = dot(u_xlat16_6.zz, u_xlat16_6.xx);
    u_xlat16_2.y = u_xlat16_6.y + u_xlat16_6.y;
#endif
#else
    u_xlat0.x = dot(_VirtualBadgeLightDir1.xyz, _VirtualBadgeLightDir1.xyz);
    u_xlat0.x = max(u_xlat0.x, 1.17549435e-38);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat15.xyz = _VirtualBadgeLightDir1.xyz * u_xlat0.xxx + vec3(0.0, 0.0, -1.0);
    u_xlat1.xyz = u_xlat0.xxx * _VirtualBadgeLightDir1.xyz;
    u_xlat0.x = dot(u_xlat15.xyz, u_xlat15.xyz);
    u_xlat0.x = max(u_xlat0.x, 1.17549435e-38);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat15.xyz;
    u_xlat45 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
    u_xlat16_2.x = u_xlat45 * u_xlat45;
    u_xlat45 = max(u_xlat16_2.x, 0.100000001);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD3.xyz;
    u_xlat46 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat46 = inversesqrt(u_xlat46);
    u_xlat3.xyz = vec3(u_xlat46) * vs_TEXCOORD4.xyz;
    u_xlat16_4.xyz = texture(_NormalMap, vs_TEXCOORD5.xy).xyw;
    u_xlat16_2.x = dot(u_xlat16_4.zz, u_xlat16_4.xx);
    u_xlat16_2.y = u_xlat16_4.y + u_xlat16_4.y;
#endif
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
    u_xlat16_32.xy = u_xlat16_2.xy * vec2(vec2(_NormalScale, _NormalScale));
#else
    u_xlat16_34.xy = u_xlat16_2.xy * vec2(vec2(_NormalScale, _NormalScale));
#endif
#else
    u_xlat16_32.xy = u_xlat16_2.xy * vec2(vec2(_NormalScale, _NormalScale));
#endif
    u_xlat16_2.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 1.00000002e-16);
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
    u_xlat4.xyz = u_xlat3.xyz * u_xlat16_32.yyy;
    u_xlat4.xyz = u_xlat16_32.xxx * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat46 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat46 = inversesqrt(u_xlat46);
    u_xlat5.xyz = vec3(u_xlat46) * vs_TEXCOORD2.xyz;
    u_xlat4.xyz = u_xlat16_2.xxx * u_xlat5.zxy + u_xlat4.zxy;
    u_xlat0.x = dot(u_xlat4.yzx, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6.xy = (-vec2(_Smoothness, _HologramSmoothness)) + vec2(1.0, 1.0);
    u_xlat16_6.xy = u_xlat16_6.xy * u_xlat16_6.xy;
    u_xlat16_6.xy = max(u_xlat16_6.xy, vec2(0.0078125, 0.0078125));
    u_xlat15.xy = u_xlat16_6.xy * u_xlat16_6.xy + vec2(-1.0, -1.0);
    u_xlat0.x = u_xlat0.x * u_xlat15.x + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat45 * u_xlat0.x;
    u_xlat7.xy = u_xlat16_6.xy * vec2(4.0, 4.0) + vec2(30.0, 30.0);
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat16_21.xy = u_xlat16_6.xy * u_xlat16_6.xy;
    u_xlat16_17 = u_xlat16_6.x * u_xlat16_6.x + 1.0;
    u_xlat16_17 = float(1.0) / u_xlat16_17;
    u_xlat0.x = u_xlat16_21.x / u_xlat0.x;
    u_xlat16_6.x = u_xlat0.x + -6.10351562e-05;
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat0.x = dot(_VirtualBadgeLightDir0.xyz, _VirtualBadgeLightDir0.xyz);
    u_xlat0.x = max(u_xlat0.x, 1.17549435e-38);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat8.xyz = _VirtualBadgeLightDir0.xyz * u_xlat0.xxx + vec3(0.0, 0.0, -1.0);
    u_xlat45 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat45 = max(u_xlat45, 1.17549435e-38);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat8.xyz = vec3(u_xlat45) * u_xlat8.xyz;
    u_xlat45 = dot(u_xlat4.yzx, u_xlat8.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat45 = u_xlat45 * u_xlat15.x + 1.00001001;
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat9.xyz = u_xlat0.xxx * _VirtualBadgeLightDir0.xyz;
    u_xlat46 = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat46 = clamp(u_xlat46, 0.0, 1.0);
    u_xlat16_51 = u_xlat46 * u_xlat46;
    u_xlat46 = max(u_xlat16_51, 0.100000001);
    u_xlat45 = u_xlat45 * u_xlat46;
    u_xlat45 = u_xlat7.x * u_xlat45;
    u_xlat45 = u_xlat16_21.x / u_xlat45;
    u_xlat16_51 = u_xlat45 + -6.10351562e-05;
    u_xlat16_6.w = max(u_xlat16_51, 0.0);
    u_xlat16_6.xw = min(u_xlat16_6.xw, vec2(1000.0, 1000.0));
    u_xlat16_10 = (-_Metallic) * 0.959999979 + 0.959999979;
    u_xlat16_8 = texture(_MainTex, vs_TEXCOORD5.xy);
    u_xlat16_25.xyz = vec3(u_xlat16_10) * u_xlat16_8.xyz;
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    u_xlat16_10 = u_xlat16_10 + _Smoothness;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    u_xlat11.xyz = u_xlat16_6.www * _VirtualBadgeLightDir0.www + u_xlat16_25.xyz;
    u_xlat11.xyz = u_xlat16_6.xxx * _VirtualBadgeLightDir1.www + u_xlat11.xyz;
    u_xlat45 = dot(_VirtualBadgeLightDir2.xyz, _VirtualBadgeLightDir2.xyz);
    u_xlat45 = max(u_xlat45, 1.17549435e-38);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat12.xyz = _VirtualBadgeLightDir2.xyz * vec3(u_xlat45) + vec3(0.0, 0.0, -1.0);
    u_xlat13.xyz = vec3(u_xlat45) * _VirtualBadgeLightDir2.xyz;
    u_xlat45 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat45 = max(u_xlat45, 1.17549435e-38);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat12.xyz = vec3(u_xlat45) * u_xlat12.xyz;
    u_xlat45 = dot(u_xlat13.xyz, u_xlat12.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
    u_xlat46 = dot(u_xlat4.yzx, u_xlat12.xyz);
    u_xlat46 = clamp(u_xlat46, 0.0, 1.0);
    u_xlat46 = u_xlat46 * u_xlat46;
    u_xlat15.x = u_xlat46 * u_xlat15.x + 1.00001001;
    u_xlat15.x = u_xlat15.x * u_xlat15.x;
    u_xlat16_6.x = u_xlat45 * u_xlat45;
    u_xlat45 = max(u_xlat16_6.x, 0.100000001);
    u_xlat15.x = u_xlat45 * u_xlat15.x;
    u_xlat15.x = u_xlat7.x * u_xlat15.x;
    u_xlat15.x = u_xlat16_21.x / u_xlat15.x;
    u_xlat16_6.x = u_xlat15.x + -6.10351562e-05;
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = min(u_xlat16_6.x, 1000.0);
    u_xlat7.xzw = u_xlat16_6.xxx * _VirtualBadgeLightDir2.www + u_xlat11.xyz;
    u_xlat16_11.xyz = texture(_HologramMap, vs_TEXCOORD6.xy).xyw;
    u_xlat16_6.x = dot(u_xlat16_11.zz, u_xlat16_11.xx);
    u_xlat16_6.y = u_xlat16_11.y + u_xlat16_11.y;
    u_xlat16_6.xy = u_xlat16_6.xy + vec2(-1.0, -1.0);
    u_xlat16_14.xy = u_xlat16_6.xy * vec2(_HologramScale);
    u_xlat16_6.x = dot(u_xlat16_6.xy, u_xlat16_6.xy);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_6.x = sqrt(u_xlat16_6.x);
    u_xlat16_6.x = max(u_xlat16_6.x, 1.00000002e-16);
    u_xlat16_21.xz = u_xlat16_2.xx * u_xlat16_14.xy;
    u_xlat16_14.z = u_xlat16_2.x * u_xlat16_6.x;
    u_xlat16_14.xy = u_xlat16_32.xy * u_xlat16_6.xx + u_xlat16_21.xz;
    u_xlat16_2.x = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
#else
    u_xlat6.xyz = u_xlat5.xyz * u_xlat16_34.yyy;
    u_xlat6.xyz = u_xlat16_34.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlat51 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat7.xyz = vec3(u_xlat51) * vs_TEXCOORD2.xyz;
    u_xlat6.xyz = u_xlat16_2.xxx * u_xlat7.zxy + u_xlat6.zxy;
    u_xlat3.x = dot(u_xlat6.yzx, u_xlat3.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat16_8.xy = (-vec2(_Smoothness, _HologramSmoothness)) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat16_8.xy * u_xlat16_8.xy;
    u_xlat16_8.xy = max(u_xlat16_8.xy, vec2(0.0078125, 0.0078125));
    u_xlat19.xy = u_xlat16_8.xy * u_xlat16_8.xy + vec2(-1.0, -1.0);
    u_xlat3.x = u_xlat3.x * u_xlat19.x + 1.00001001;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat48 = u_xlat48 * u_xlat3.x;
    u_xlat3.xw = u_xlat16_8.xy * vec2(4.0, 4.0) + vec2(30.0, 30.0);
    u_xlat48 = u_xlat48 * u_xlat3.x;
    u_xlat16_24.xy = u_xlat16_8.xy * u_xlat16_8.xy;
    u_xlat16_18 = u_xlat16_8.x * u_xlat16_8.x + 1.0;
    u_xlat16_18 = float(1.0) / u_xlat16_18;
    u_xlat48 = u_xlat16_24.x / u_xlat48;
    u_xlat16_8.x = u_xlat48 + -6.10351562e-05;
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat48 = dot(_VirtualBadgeLightDir0.xyz, _VirtualBadgeLightDir0.xyz);
    u_xlat48 = max(u_xlat48, 1.17549435e-38);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat9.xyz = _VirtualBadgeLightDir0.xyz * vec3(u_xlat48) + vec3(0.0, 0.0, -1.0);
    u_xlat52 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat52 = max(u_xlat52, 1.17549435e-38);
    u_xlat52 = inversesqrt(u_xlat52);
    u_xlat9.xyz = vec3(u_xlat52) * u_xlat9.xyz;
    u_xlat52 = dot(u_xlat6.yzx, u_xlat9.xyz);
    u_xlat52 = clamp(u_xlat52, 0.0, 1.0);
    u_xlat52 = u_xlat52 * u_xlat52;
    u_xlat52 = u_xlat52 * u_xlat19.x + 1.00001001;
    u_xlat52 = u_xlat52 * u_xlat52;
    u_xlat10.xyz = vec3(u_xlat48) * _VirtualBadgeLightDir0.xyz;
    u_xlat53 = dot(u_xlat10.xyz, u_xlat9.xyz);
    u_xlat53 = clamp(u_xlat53, 0.0, 1.0);
    u_xlat16_56 = u_xlat53 * u_xlat53;
    u_xlat53 = max(u_xlat16_56, 0.100000001);
    u_xlat52 = u_xlat52 * u_xlat53;
    u_xlat52 = u_xlat3.x * u_xlat52;
    u_xlat52 = u_xlat16_24.x / u_xlat52;
    u_xlat16_56 = u_xlat52 + -6.10351562e-05;
    u_xlat16_8.w = max(u_xlat16_56, 0.0);
    u_xlat16_8.xw = min(u_xlat16_8.xw, vec2(1000.0, 1000.0));
    u_xlat16_11 = (-_Metallic) * 0.959999979 + 0.959999979;
    u_xlat16_27.xyz = u_xlat16_0.xyz * vec3(u_xlat16_11);
    u_xlat16_12.xyz = u_xlat16_0.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_12.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_12.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat16_11 = u_xlat16_11 + _Smoothness;
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat16_13.xyz = (-u_xlat16_12.xyz) + vec3(u_xlat16_11);
    u_xlat0.xyz = u_xlat16_8.www * _VirtualBadgeLightDir0.www + u_xlat16_27.xyz;
    u_xlat0.xyz = u_xlat16_8.xxx * _VirtualBadgeLightDir1.www + u_xlat0.xyz;
    u_xlat52 = dot(_VirtualBadgeLightDir2.xyz, _VirtualBadgeLightDir2.xyz);
    u_xlat52 = max(u_xlat52, 1.17549435e-38);
    u_xlat52 = inversesqrt(u_xlat52);
    u_xlat9.xyz = _VirtualBadgeLightDir2.xyz * vec3(u_xlat52) + vec3(0.0, 0.0, -1.0);
    u_xlat14.xyz = vec3(u_xlat52) * _VirtualBadgeLightDir2.xyz;
    u_xlat52 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat52 = max(u_xlat52, 1.17549435e-38);
    u_xlat52 = inversesqrt(u_xlat52);
    u_xlat9.xyz = vec3(u_xlat52) * u_xlat9.xyz;
    u_xlat52 = dot(u_xlat14.xyz, u_xlat9.xyz);
    u_xlat52 = clamp(u_xlat52, 0.0, 1.0);
    u_xlat53 = dot(u_xlat6.yzx, u_xlat9.xyz);
    u_xlat53 = clamp(u_xlat53, 0.0, 1.0);
    u_xlat53 = u_xlat53 * u_xlat53;
    u_xlat19.x = u_xlat53 * u_xlat19.x + 1.00001001;
    u_xlat19.x = u_xlat19.x * u_xlat19.x;
    u_xlat16_8.x = u_xlat52 * u_xlat52;
    u_xlat52 = max(u_xlat16_8.x, 0.100000001);
    u_xlat19.x = u_xlat19.x * u_xlat52;
    u_xlat3.x = u_xlat3.x * u_xlat19.x;
    u_xlat3.x = u_xlat16_24.x / u_xlat3.x;
    u_xlat16_8.x = u_xlat3.x + -6.10351562e-05;
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_8.x = min(u_xlat16_8.x, 1000.0);
    u_xlat0.xyz = u_xlat16_8.xxx * _VirtualBadgeLightDir2.www + u_xlat0.xyz;
    u_xlat16_9.xyz = texture(_HologramMap, vs_TEXCOORD6.xy).xyw;
    u_xlat16_8.x = dot(u_xlat16_9.zz, u_xlat16_9.xx);
    u_xlat16_8.y = u_xlat16_9.y + u_xlat16_9.y;
    u_xlat16_8.xy = u_xlat16_8.xy + vec2(-1.0, -1.0);
    u_xlat16_15.xy = u_xlat16_8.xy * vec2(_HologramScale);
    u_xlat16_8.x = dot(u_xlat16_8.xy, u_xlat16_8.xy);
    u_xlat16_8.x = min(u_xlat16_8.x, 1.0);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_8.x = sqrt(u_xlat16_8.x);
    u_xlat16_8.x = max(u_xlat16_8.x, 1.00000002e-16);
    u_xlat16_24.xz = u_xlat16_2.xx * u_xlat16_15.xy;
    u_xlat16_15.z = u_xlat16_2.x * u_xlat16_8.x;
    u_xlat16_15.xy = u_xlat16_34.xy * u_xlat16_8.xx + u_xlat16_24.xz;
    u_xlat16_2.x = dot(u_xlat16_15.xyz, u_xlat16_15.xyz);
#endif
#else
    u_xlat4.xyz = u_xlat3.xyz * u_xlat16_32.yyy;
    u_xlat4.xyz = u_xlat16_32.xxx * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat46 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat46 = inversesqrt(u_xlat46);
    u_xlat5.xyz = vec3(u_xlat46) * vs_TEXCOORD2.xyz;
    u_xlat4.xyz = u_xlat16_2.xxx * u_xlat5.zxy + u_xlat4.zxy;
    u_xlat0.x = dot(u_xlat4.yzx, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6.xy = (-vec2(_Smoothness, _HologramSmoothness)) + vec2(1.0, 1.0);
    u_xlat16_6.xy = u_xlat16_6.xy * u_xlat16_6.xy;
    u_xlat16_6.xy = max(u_xlat16_6.xy, vec2(0.0078125, 0.0078125));
    u_xlat15.xy = u_xlat16_6.xy * u_xlat16_6.xy + vec2(-1.0, -1.0);
    u_xlat0.x = u_xlat0.x * u_xlat15.x + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat45 * u_xlat0.x;
    u_xlat7.xy = u_xlat16_6.xy * vec2(4.0, 4.0) + vec2(30.0, 30.0);
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat16_21.xy = u_xlat16_6.xy * u_xlat16_6.xy;
    u_xlat16_17 = u_xlat16_6.x * u_xlat16_6.x + 1.0;
    u_xlat16_17 = float(1.0) / u_xlat16_17;
    u_xlat0.x = u_xlat16_21.x / u_xlat0.x;
    u_xlat16_6.x = u_xlat0.x + -6.10351562e-05;
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat0.x = dot(_VirtualBadgeLightDir0.xyz, _VirtualBadgeLightDir0.xyz);
    u_xlat0.x = max(u_xlat0.x, 1.17549435e-38);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat8.xyz = _VirtualBadgeLightDir0.xyz * u_xlat0.xxx + vec3(0.0, 0.0, -1.0);
    u_xlat45 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat45 = max(u_xlat45, 1.17549435e-38);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat8.xyz = vec3(u_xlat45) * u_xlat8.xyz;
    u_xlat45 = dot(u_xlat4.yzx, u_xlat8.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat45 = u_xlat45 * u_xlat15.x + 1.00001001;
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat9.xyz = u_xlat0.xxx * _VirtualBadgeLightDir0.xyz;
    u_xlat46 = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat46 = clamp(u_xlat46, 0.0, 1.0);
    u_xlat16_51 = u_xlat46 * u_xlat46;
    u_xlat46 = max(u_xlat16_51, 0.100000001);
    u_xlat45 = u_xlat45 * u_xlat46;
    u_xlat45 = u_xlat7.x * u_xlat45;
    u_xlat45 = u_xlat16_21.x / u_xlat45;
    u_xlat16_51 = u_xlat45 + -6.10351562e-05;
    u_xlat16_6.w = max(u_xlat16_51, 0.0);
    u_xlat16_6.xw = min(u_xlat16_6.xw, vec2(1000.0, 1000.0));
    u_xlat16_10 = (-_Metallic) * 0.959999979 + 0.959999979;
    u_xlat16_8 = texture(_MainTex, vs_TEXCOORD5.xy);
    u_xlat16_25.xyz = vec3(u_xlat16_10) * u_xlat16_8.xyz;
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    u_xlat16_10 = u_xlat16_10 + _Smoothness;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    u_xlat11.xyz = u_xlat16_6.www * _VirtualBadgeLightDir0.www + u_xlat16_25.xyz;
    u_xlat11.xyz = u_xlat16_6.xxx * _VirtualBadgeLightDir1.www + u_xlat11.xyz;
    u_xlat45 = dot(_VirtualBadgeLightDir2.xyz, _VirtualBadgeLightDir2.xyz);
    u_xlat45 = max(u_xlat45, 1.17549435e-38);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat12.xyz = _VirtualBadgeLightDir2.xyz * vec3(u_xlat45) + vec3(0.0, 0.0, -1.0);
    u_xlat13.xyz = vec3(u_xlat45) * _VirtualBadgeLightDir2.xyz;
    u_xlat45 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat45 = max(u_xlat45, 1.17549435e-38);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat12.xyz = vec3(u_xlat45) * u_xlat12.xyz;
    u_xlat45 = dot(u_xlat13.xyz, u_xlat12.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
    u_xlat46 = dot(u_xlat4.yzx, u_xlat12.xyz);
    u_xlat46 = clamp(u_xlat46, 0.0, 1.0);
    u_xlat46 = u_xlat46 * u_xlat46;
    u_xlat15.x = u_xlat46 * u_xlat15.x + 1.00001001;
    u_xlat15.x = u_xlat15.x * u_xlat15.x;
    u_xlat16_6.x = u_xlat45 * u_xlat45;
    u_xlat45 = max(u_xlat16_6.x, 0.100000001);
    u_xlat15.x = u_xlat45 * u_xlat15.x;
    u_xlat15.x = u_xlat7.x * u_xlat15.x;
    u_xlat15.x = u_xlat16_21.x / u_xlat15.x;
    u_xlat16_6.x = u_xlat15.x + -6.10351562e-05;
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = min(u_xlat16_6.x, 1000.0);
    u_xlat7.xzw = u_xlat16_6.xxx * _VirtualBadgeLightDir2.www + u_xlat11.xyz;
    u_xlat16_11.xyz = texture(_HologramMap, vs_TEXCOORD6.xy).xyw;
    u_xlat16_6.x = dot(u_xlat16_11.zz, u_xlat16_11.xx);
    u_xlat16_6.y = u_xlat16_11.y + u_xlat16_11.y;
    u_xlat16_6.xy = u_xlat16_6.xy + vec2(-1.0, -1.0);
    u_xlat16_14.xy = u_xlat16_6.xy * vec2(_HologramScale);
    u_xlat16_6.x = dot(u_xlat16_6.xy, u_xlat16_6.xy);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_6.x = sqrt(u_xlat16_6.x);
    u_xlat16_6.x = max(u_xlat16_6.x, 1.00000002e-16);
    u_xlat16_21.xz = u_xlat16_2.xx * u_xlat16_14.xy;
    u_xlat16_14.z = u_xlat16_2.x * u_xlat16_6.x;
    u_xlat16_14.xy = u_xlat16_32.xy * u_xlat16_6.xx + u_xlat16_21.xz;
    u_xlat16_2.x = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
#endif
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_2.zzz;
    u_xlat1.xyz = u_xlat16_2.xxx * u_xlat1.xyz + u_xlat3.xyz;
    u_xlat1.xyz = u_xlat16_2.www * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat3.xyz;
    u_xlatb15 = unity_OrthoParams.w==0.0;
    u_xlat16_14.x = (u_xlatb15) ? u_xlat3.x : hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat16_14.y = (u_xlatb15) ? u_xlat3.y : hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16_14.z = (u_xlatb15) ? u_xlat3.z : hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.xyw = _VirtualBadgeLightDir0.xyz * u_xlat0.xxx + u_xlat16_14.xyz;
    u_xlat46 = dot(u_xlat0.xyw, u_xlat0.xyw);
    u_xlat46 = max(u_xlat46, 1.17549435e-38);
    u_xlat46 = inversesqrt(u_xlat46);
    u_xlat0.xyw = u_xlat0.xyw * vec3(u_xlat46);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyw);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat9.xyz, u_xlat0.xyw);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat15.x = dot(u_xlat4.yzx, u_xlat9.xyz);
    u_xlat4.x = (-u_xlat4.x);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat45 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = u_xlat45 * u_xlat45;
#else
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_15.xyz;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat16_2.zzz;
    u_xlat4.xyz = u_xlat16_2.xxx * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat4.xyz = u_xlat16_2.www * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlatb3 = unity_OrthoParams.w==0.0;
    u_xlat16_15.x = (u_xlatb3) ? u_xlat5.x : hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat16_15.y = (u_xlatb3) ? u_xlat5.y : hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16_15.z = (u_xlatb3) ? u_xlat5.z : hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat5.xyz = _VirtualBadgeLightDir0.xyz * vec3(u_xlat48) + u_xlat16_15.xyz;
    u_xlat48 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat48 = max(u_xlat48, 1.17549435e-38);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat5.xyz = vec3(u_xlat48) * u_xlat5.xyz;
    u_xlat48 = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat48 = clamp(u_xlat48, 0.0, 1.0);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat5.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat19.x = dot(u_xlat6.yzx, u_xlat10.xyz);
    u_xlat6.x = (-u_xlat6.x);
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
    u_xlat4.x = (-u_xlat6.x) + 1.0;
    u_xlat16_2.x = u_xlat4.x * u_xlat4.x;
#endif
#else
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_2.zzz;
    u_xlat1.xyz = u_xlat16_2.xxx * u_xlat1.xyz + u_xlat3.xyz;
    u_xlat1.xyz = u_xlat16_2.www * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat3.xyz;
    u_xlatb15 = unity_OrthoParams.w==0.0;
    u_xlat16_14.x = (u_xlatb15) ? u_xlat3.x : hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat16_14.y = (u_xlatb15) ? u_xlat3.y : hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16_14.z = (u_xlatb15) ? u_xlat3.z : hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.xyw = _VirtualBadgeLightDir0.xyz * u_xlat0.xxx + u_xlat16_14.xyz;
    u_xlat46 = dot(u_xlat0.xyw, u_xlat0.xyw);
    u_xlat46 = max(u_xlat46, 1.17549435e-38);
    u_xlat46 = inversesqrt(u_xlat46);
    u_xlat0.xyw = u_xlat0.xyw * vec3(u_xlat46);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyw);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat9.xyz, u_xlat0.xyw);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat15.x = dot(u_xlat4.yzx, u_xlat9.xyz);
    u_xlat4.x = (-u_xlat4.x);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat45 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = u_xlat45 * u_xlat45;
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
    u_xlat15.x = u_xlat15.x * 0.5 + 0.5;
    u_xlat3.y = u_xlat15.x * _HologramRampScale;
    u_xlat16_32.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat16_32.x, 0.100000001);
    u_xlat15.x = u_xlat1.x * u_xlat1.x;
    u_xlat15.x = u_xlat15.x * u_xlat15.y + 1.00001001;
    u_xlat15.x = u_xlat15.x * u_xlat15.x;
    u_xlat0.x = u_xlat0.x * u_xlat15.x;
    u_xlat0.x = u_xlat7.y * u_xlat0.x;
    u_xlat0.x = u_xlat16_21.y / u_xlat0.x;
    u_xlat16_32.x = u_xlat0.x + -6.10351562e-05;
    u_xlat16_32.x = max(u_xlat16_32.x, 0.0);
    u_xlat16_32.x = min(u_xlat16_32.x, 1000.0);
    u_xlat16_47 = (-_HologramMetallic) * 0.959999979 + 0.959999979;
    u_xlat16_6.x = _HologramMetallic * 0.959999979 + 0.0399999991;
    u_xlat0.x = u_xlat16_32.x * u_xlat16_6.x + u_xlat16_47;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlatb15 = u_xlat16_8.w>=0.5;
    u_xlat16_6.xyz = u_xlat16_8.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat1.w = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    u_xlat0.x = u_xlat0.x * _HologramAddRatio;
    u_xlat15.x = texture(_HologramMaskMap, vs_TEXCOORD5.xy).x;
    u_xlatb15 = u_xlat15.x>=0.5;
    u_xlat0.x = (u_xlatb15) ? 0.0 : u_xlat0.x;
    u_xlat3.x = 0.0;
    u_xlat16_15.xyz = texture(_HologramRampMap, u_xlat3.xy).xyz;
    u_xlat0.xyz = u_xlat16_15.xyz * u_xlat0.xxx + u_xlat7.xzw;
    u_xlat16_14.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_10);
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_14.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = u_xlat16_2.xzw * vec3(u_xlat16_17);
    u_xlat16_2.xyz = u_xlat3.xyz * _AmbientSpecularColor.xyz;
    u_xlat16_2.xyz = _AmbientColor.xyz * u_xlat16_25.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat0.xyz + u_xlat16_2.xyz;
#else
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_13.xyz + u_xlat16_12.xyz;
    u_xlat4.xyz = u_xlat16_2.xzw * vec3(u_xlat16_18);
    u_xlat16_2.xyz = u_xlat4.xyz * _AmbientSpecularColor.xyz;
    u_xlat16_2.xyz = _AmbientColor.xyz * u_xlat16_27.xyz + u_xlat16_2.xyz;
    u_xlat19.x = u_xlat19.x * 0.5 + 0.5;
    u_xlat4.y = u_xlat19.x * _HologramRampScale;
    u_xlat16_50 = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = max(u_xlat16_50, 0.100000001);
    u_xlat48 = u_xlat48 * u_xlat48;
    u_xlat48 = u_xlat48 * u_xlat19.y + 1.00001001;
    u_xlat48 = u_xlat48 * u_xlat48;
    u_xlat48 = u_xlat3.x * u_xlat48;
    u_xlat48 = u_xlat3.w * u_xlat48;
    u_xlat48 = u_xlat16_24.y / u_xlat48;
    u_xlat16_50 = u_xlat48 + -6.10351562e-05;
    u_xlat16_50 = max(u_xlat16_50, 0.0);
    u_xlat16_50 = min(u_xlat16_50, 1000.0);
    u_xlat16_8.x = (-_HologramMetallic) * 0.959999979 + 0.959999979;
    u_xlat16_24.x = _HologramMetallic * 0.959999979 + 0.0399999991;
    u_xlat48 = u_xlat16_50 * u_xlat16_24.x + u_xlat16_8.x;
    u_xlat48 = clamp(u_xlat48, 0.0, 1.0);
    u_xlat48 = u_xlat1.w * u_xlat48;
    u_xlat48 = u_xlat48 * _HologramAddRatio;
    u_xlat3.x = texture(_HologramMaskMap, vs_TEXCOORD5.xy).x;
    u_xlatb3 = u_xlat3.x>=0.5;
    u_xlat48 = (u_xlatb3) ? 0.0 : u_xlat48;
    u_xlat4.x = 0.0;
    u_xlat16_3.xyz = texture(_HologramRampMap, u_xlat4.xy).xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(u_xlat48) + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz + u_xlat0.xyz;
#endif
#else
    u_xlat15.x = u_xlat15.x * 0.5 + 0.5;
    u_xlat3.y = u_xlat15.x * _HologramRampScale;
    u_xlat16_32.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat16_32.x, 0.100000001);
    u_xlat15.x = u_xlat1.x * u_xlat1.x;
    u_xlat15.x = u_xlat15.x * u_xlat15.y + 1.00001001;
    u_xlat15.x = u_xlat15.x * u_xlat15.x;
    u_xlat0.x = u_xlat0.x * u_xlat15.x;
    u_xlat0.x = u_xlat7.y * u_xlat0.x;
    u_xlat0.x = u_xlat16_21.y / u_xlat0.x;
    u_xlat16_32.x = u_xlat0.x + -6.10351562e-05;
    u_xlat16_32.x = max(u_xlat16_32.x, 0.0);
    u_xlat16_32.x = min(u_xlat16_32.x, 1000.0);
    u_xlat16_47 = (-_HologramMetallic) * 0.959999979 + 0.959999979;
    u_xlat16_6.x = _HologramMetallic * 0.959999979 + 0.0399999991;
    u_xlat0.x = u_xlat16_32.x * u_xlat16_6.x + u_xlat16_47;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlatb15 = u_xlat16_8.w>=0.5;
    u_xlat16_6.xyz = u_xlat16_8.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat1.w = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    u_xlat0.x = u_xlat0.x * _HologramAddRatio;
    u_xlat15.x = texture(_HologramMaskMap, vs_TEXCOORD5.xy).x;
    u_xlatb15 = u_xlat15.x>=0.5;
    u_xlat0.x = (u_xlatb15) ? 0.0 : u_xlat0.x;
    u_xlat3.x = 0.0;
    u_xlat16_15.xyz = texture(_HologramRampMap, u_xlat3.xy).xyz;
    u_xlat0.xyz = u_xlat16_15.xyz * u_xlat0.xxx + u_xlat7.xzw;
    u_xlat16_14.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_10);
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_14.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = u_xlat16_2.xzw * vec3(u_xlat16_17);
    u_xlat16_2.xyz = u_xlat3.xyz * _AmbientSpecularColor.xyz;
    u_xlat16_2.xyz = _AmbientColor.xyz * u_xlat16_25.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat0.xyz + u_xlat16_2.xyz;
#endif
    u_xlat16_0 = u_xlat1 * vs_COLOR0;
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD0.xxxy).zw;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat16_2.x = u_xlat16_0.w * u_xlat1.x + -0.00100000005;
    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat1.xxx;
    SV_Target0.w = u_xlat1.x;
    u_xlatb1.x = u_xlat16_2.x<0.0;
    if(u_xlatb1.x){discard;}
#else
    SV_Target0.xyz = u_xlat16_0.www * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
#endif
#else
#if defined(UNITY_UI_CLIP_RECT)
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD0.xxxy).zw;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat1.xxx;
    SV_Target0.w = u_xlat1.x;
#else
    SV_Target0.xyz = u_xlat16_0.www * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
#endif
#endif
    return;
}
#endif
			ENDGLSL
		}
	}
}
