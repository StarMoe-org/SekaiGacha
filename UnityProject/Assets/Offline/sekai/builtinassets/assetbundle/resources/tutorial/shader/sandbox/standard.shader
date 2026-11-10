// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sandbox/Standard"
{
	Properties
	{
		_Color("Color", Color) = (1, 1, 1, 1)
		_MainTex("Albedo", 2D) = "white" {}
		_Cutoff("Alpha Cutoff", Range(0, 1)) = 0.5
		_Glossiness("Smoothness", Range(0, 1)) = 0.5
		_GlossMapScale("Smoothness Scale", Range(0, 1)) = 1
		[Enum(Metallic Alpha,0,Albedo Alpha,1)] _SmoothnessTextureChannel("Smoothness texture channel", Float) = 0
		[Gamma] _Metallic("Metallic", Range(0, 1)) = 0
		_MetallicGlossMap("Metallic", 2D) = "white" {}
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1
		[ToggleOff] _GlossyReflections("Glossy Reflections", Float) = 1
		_BumpScale("Scale", Float) = 1
		[Normal] _BumpMap("Normal Map", 2D) = "bump" {}
		_Parallax("Height Scale", Range(0.005, 0.08)) = 0.02
		_ParallaxMap("Height Map", 2D) = "black" {}
		_OcclusionStrength("Strength", Range(0, 1)) = 1
		_OcclusionMap("Occlusion", 2D) = "white" {}
		_EmissionColor("Color", Color) = (0, 0, 0, 1)
		_EmissionMap("Emission", 2D) = "white" {}
		_DetailMask("Detail Mask", 2D) = "white" {}
		_DetailAlbedoMap("Detail Albedo x2", 2D) = "grey" {}
		_DetailNormalMapScale("Scale", Float) = 1
		[Normal] _DetailNormalMap("Normal Map", 2D) = "bump" {}
		[Enum(UV0,0,UV1,1)] _UVSec("UV Set for secondary textures", Float) = 0
		[HideInInspector] _Mode("__mode", Float) = 0
		[HideInInspector] _SrcBlend("__src", Float) = 1
		[HideInInspector] _DstBlend("__dst", Float) = 0
		[HideInInspector] _ZWrite("__zw", Float) = 1
	}
	SubShader
	{
		Tags { "PerformanceChecks"="False" "RenderType"="Opaque" }
		LOD 300
		Pass
		{
			Name "FORWARD"
			Tags { "LIGHTMODE"="FORWARDBASE" "PerformanceChecks"="False" "RenderType"="Opaque" "SHADOWSUPPORT"="true" }
			Blend [_SrcBlend] [_DstBlend], [_SrcBlend] [_DstBlend]
			ZWrite [_ZWrite]
			GLSLPROGRAM
#pragma multi_compile _ DIRECTIONAL
#pragma multi_compile _ INSTANCING_ON
#pragma multi_compile _ LIGHTPROBE_SH
#pragma multi_compile _ SHADOWS_SCREEN
#pragma multi_compile _ VERTEXLIGHT_ON
#ifdef VERTEX
#version 300 es
#if defined(INSTANCING_ON)
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif
#endif
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
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
#if defined(VERTEXLIGHT_ON)
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
#endif
#endif
#else
#if defined(LIGHTPROBE_SH)
#if defined(VERTEXLIGHT_ON)
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
#endif
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
#endif
#endif
#if defined(SHADOWS_SCREEN)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
#endif
#if !defined(INSTANCING_ON)
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if defined(INSTANCING_ON)
uniform 	int unity_BaseInstanceID;
#endif
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DetailAlbedoMap_ST;
uniform 	mediump float _Metallic;
uniform 	float _Glossiness;
uniform 	mediump float _UVSec;
#if defined(INSTANCING_ON)
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
#else
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
#endif
#else
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type                unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if defined(LIGHTPROBE_SH)
struct unity_Builtins2Array_Type {
	mediump vec4 unity_SHArArray;
	mediump vec4 unity_SHAgArray;
	mediump vec4 unity_SHAbArray;
	mediump vec4 unity_SHBrArray;
	mediump vec4 unity_SHBgArray;
	mediump vec4 unity_SHBbArray;
	mediump vec4 unity_SHCArray;
};
#if defined(SHADOWS_SCREEN)
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw2 {
#endif
#else
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw2 {
#endif
#endif
	UNITY_UNIFORM unity_Builtins2Array_Type                unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#endif
#endif
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
#if defined(SHADOWS_SCREEN)
out highp vec4 vs_TEXCOORD3;
#endif
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
vec4 u_xlat0;
#else
vec3 u_xlat0;
#endif
#else
vec3 u_xlat0;
#endif
int u_xlati0;
#else
vec4 u_xlat0;
#if !defined(SHADOWS_SCREEN)
bool u_xlatb0;
#endif
#endif
vec4 u_xlat1;
#if defined(INSTANCING_ON)
vec4 u_xlat2;
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
vec4 u_xlat3;
#if defined(VERTEXLIGHT_ON)
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
#else
mediump vec3 u_xlat16_4;
#endif
mediump vec4 u_xlat16_5;
#if defined(VERTEXLIGHT_ON)
vec4 u_xlat6;
#endif
mediump vec3 u_xlat16_6;
#if defined(VERTEXLIGHT_ON)
vec4 u_xlat7;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat10;
int u_xlati10;
vec2 u_xlat20;
bool u_xlatb20;
#else
float u_xlat7;
int u_xlati7;
vec2 u_xlat14;
bool u_xlatb14;
#endif
#else
#if defined(VERTEXLIGHT_ON)
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
#else
mediump vec3 u_xlat16_3;
#endif
mediump vec4 u_xlat16_4;
#if defined(VERTEXLIGHT_ON)
vec4 u_xlat5;
#endif
mediump vec3 u_xlat16_5;
#if defined(VERTEXLIGHT_ON)
vec4 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
float u_xlat9;
int u_xlati9;
vec2 u_xlat18;
bool u_xlatb18;
#else
float u_xlat6;
int u_xlati6;
vec2 u_xlat12;
bool u_xlatb12;
#endif
#endif
#else
#if defined(SHADOWS_SCREEN)
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
#else
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
#endif
#endif
#else
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
#if defined(VERTEXLIGHT_ON)
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat31;
float u_xlat32;
#else
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat22;
float u_xlat23;
#endif
#else
#if defined(VERTEXLIGHT_ON)
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat27;
float u_xlat28;
#else
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat18;
float u_xlat19;
#endif
#endif
#else
#if defined(SHADOWS_SCREEN)
bool u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
float u_xlat14;
#else
mediump float u_xlat16_2;
float u_xlat9;
float u_xlat10;
#endif
#endif
#endif
void main()
{
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
#if defined(VERTEXLIGHT_ON)
    u_xlati10 = int(u_xlati0 << (3 & int(0x1F)));
#else
    u_xlati7 = int(u_xlati0 << (3 & int(0x1F)));
#endif
#else
#if defined(VERTEXLIGHT_ON)
    u_xlati9 = int(u_xlati0 << (3 & int(0x1F)));
#else
    u_xlati6 = int(u_xlati0 << (3 & int(0x1F)));
#endif
#endif
    u_xlati0 = u_xlati0 * 7;
#if defined(SHADOWS_SCREEN)
#if defined(VERTEXLIGHT_ON)
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati10 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati10 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati10 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati10 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = unity_Builtins0Array[u_xlati10 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
#else
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati7 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati7 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati7 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati7 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = unity_Builtins0Array[u_xlati7 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
#endif
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
#if defined(VERTEXLIGHT_ON)
    u_xlatb20 = _UVSec==0.0;
    u_xlat20.xy = (bool(u_xlatb20)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat20.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#else
    u_xlatb14 = _UVSec==0.0;
    u_xlat14.xy = (bool(u_xlatb14)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat14.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#endif
#else
#if defined(VERTEXLIGHT_ON)
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
#else
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
#endif
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
#if defined(VERTEXLIGHT_ON)
    u_xlatb18 = _UVSec==0.0;
    u_xlat18.xy = (bool(u_xlatb18)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat18.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#else
    u_xlatb12 = _UVSec==0.0;
    u_xlat12.xy = (bool(u_xlatb12)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat12.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#endif
#endif
#else
    u_xlati0 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
#if defined(SHADOWS_SCREEN)
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlatb5 = _UVSec==0.0;
    u_xlat5.xy = (bool(u_xlatb5)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat5.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#else
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlatb4 = _UVSec==0.0;
    u_xlat4.xy = (bool(u_xlatb4)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat4.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#endif
#endif
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
#if defined(SHADOWS_SCREEN)
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlatb1 = _UVSec==0.0;
    u_xlat1.xy = (bool(u_xlatb1)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat1.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#else
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlatb0 = _UVSec==0.0;
    u_xlat0.xy = (bool(u_xlatb0)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat0.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#endif
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
#if defined(VERTEXLIGHT_ON)
    u_xlat16_4 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat20.x = (-u_xlat16_4) + _Glossiness;
    u_xlat2.w = u_xlat20.x + 1.0;
#else
    u_xlat16_4.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat14.x = (-u_xlat16_4.x) + _Glossiness;
    u_xlat2.w = u_xlat14.x + 1.0;
#endif
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#if defined(VERTEXLIGHT_ON)
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati10 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati10 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati10 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati10 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat5.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat20.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20.x = inversesqrt(u_xlat20.x);
    u_xlat2.xyz = u_xlat20.xxx * u_xlat5.xyz;
#else
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati7 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati7 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati7 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati7 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat2.xyz = u_xlat14.xxx * u_xlat3.xyz;
#endif
    vs_TEXCOORD1 = u_xlat2;
#if defined(VERTEXLIGHT_ON)
    u_xlat5.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati10 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat5.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati10 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati10 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat10 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat4.xyz = vec3(u_xlat10) * u_xlat5.xyz;
    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
    u_xlat16_5 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_7.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBrArray, u_xlat16_5);
    u_xlat16_7.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBgArray, u_xlat16_5);
    u_xlat16_7.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBbArray, u_xlat16_5);
    u_xlat16_6.xyz = unity_Builtins2Array[u_xlati0 / 7].unity_SHCArray.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHArArray, u_xlat4);
    u_xlat16_7.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAgArray, u_xlat4);
    u_xlat16_7.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAbArray, u_xlat4);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_6.xyz);
#else
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati7 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati7 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati7 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat7 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat3.xyz = vec3(u_xlat7) * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBrArray, u_xlat16_5);
    u_xlat16_6.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBgArray, u_xlat16_5);
    u_xlat16_6.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBbArray, u_xlat16_5);
    u_xlat16_4.xyz = unity_Builtins2Array[u_xlati0 / 7].unity_SHCArray.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHArArray, u_xlat3);
    u_xlat16_5.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAgArray, u_xlat3);
    u_xlat16_5.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAbArray, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_4.xyz);
#endif
#else
#if defined(VERTEXLIGHT_ON)
    u_xlat16_3 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat18.x = (-u_xlat16_3) + _Glossiness;
    u_xlat1.w = u_xlat18.x + 1.0;
#else
    u_xlat16_3.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat12.x = (-u_xlat16_3.x) + _Glossiness;
    u_xlat1.w = u_xlat12.x + 1.0;
#endif
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#if defined(VERTEXLIGHT_ON)
    u_xlat2.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat4.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18.x = inversesqrt(u_xlat18.x);
    u_xlat1.xyz = u_xlat18.xxx * u_xlat4.xyz;
#else
    u_xlat2.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz;
#endif
    vs_TEXCOORD1 = u_xlat1;
#if defined(VERTEXLIGHT_ON)
    u_xlat4.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat3.xyz = vec3(u_xlat9) * u_xlat4.xyz;
    u_xlat16_5.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_5.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_5.x);
    u_xlat16_4 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBrArray, u_xlat16_4);
    u_xlat16_6.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBgArray, u_xlat16_4);
    u_xlat16_6.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBbArray, u_xlat16_4);
    u_xlat16_5.xyz = unity_Builtins2Array[u_xlati0 / 7].unity_SHCArray.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat3.w = 1.0;
    u_xlat16_6.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHArArray, u_xlat3);
    u_xlat16_6.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAgArray, u_xlat3);
    u_xlat16_6.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAbArray, u_xlat3);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_5.xyz);
#else
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBrArray, u_xlat16_4);
    u_xlat16_5.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBgArray, u_xlat16_4);
    u_xlat16_5.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBbArray, u_xlat16_4);
    u_xlat16_3.xyz = unity_Builtins2Array[u_xlati0 / 7].unity_SHCArray.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHArArray, u_xlat2);
    u_xlat16_4.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAgArray, u_xlat2);
    u_xlat16_4.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAbArray, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
#endif
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
#if defined(SHADOWS_SCREEN)
#if defined(VERTEXLIGHT_ON)
    u_xlat5 = (-u_xlat3.xxxx) + unity_4LightPosX0;
    u_xlat6 = (-u_xlat3.yyyy) + unity_4LightPosY0;
    u_xlat3 = (-u_xlat3.zzzz) + unity_4LightPosZ0;
    u_xlat7 = u_xlat4.yyyy * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat5 * u_xlat5 + u_xlat6;
    u_xlat5 = u_xlat5 * u_xlat4.xxxx + u_xlat7;
    u_xlat5 = u_xlat3 * u_xlat4.zzzz + u_xlat5;
    u_xlat3 = u_xlat3 * u_xlat3 + u_xlat6;
    u_xlat3 = max(u_xlat3, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat6 = inversesqrt(u_xlat3);
    u_xlat3 = u_xlat3 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat3 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat3;
    u_xlat5 = u_xlat5 * u_xlat6;
    u_xlat5 = max(u_xlat5, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat3 = u_xlat3 * u_xlat5;
    u_xlat8.xyz = u_xlat3.yyy * unity_LightColor[1].xyz;
    u_xlat8.xyz = unity_LightColor[0].xyz * u_xlat3.xxx + u_xlat8.xyz;
    u_xlat3.xyz = unity_LightColor[2].xyz * u_xlat3.zzz + u_xlat8.xyz;
    u_xlat3.xyz = unity_LightColor[3].xyz * u_xlat3.www + u_xlat3.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz + u_xlat3.xyz;
#else
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
#endif
#else
#if defined(VERTEXLIGHT_ON)
    u_xlat4 = (-u_xlat2.xxxx) + unity_4LightPosX0;
    u_xlat5 = (-u_xlat2.yyyy) + unity_4LightPosY0;
    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
    u_xlat6 = u_xlat3.yyyy * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat4 * u_xlat4 + u_xlat5;
    u_xlat4 = u_xlat4 * u_xlat3.xxxx + u_xlat6;
    u_xlat4 = u_xlat2 * u_xlat3.zzzz + u_xlat4;
    u_xlat2 = u_xlat2 * u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat5 = inversesqrt(u_xlat2);
    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
    u_xlat4 = u_xlat4 * u_xlat5;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat7.xyz = u_xlat2.yyy * unity_LightColor[1].xyz;
    u_xlat7.xyz = unity_LightColor[0].xyz * u_xlat2.xxx + u_xlat7.xyz;
    u_xlat2.xyz = unity_LightColor[2].xyz * u_xlat2.zzz + u_xlat7.xyz;
    u_xlat2.xyz = unity_LightColor[3].xyz * u_xlat2.www + u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz + u_xlat2.xyz;
#else
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
#endif
#endif
    vs_TEXCOORD2.w = 0.0;
#if defined(SHADOWS_SCREEN)
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat1.wwww + u_xlat0;
#if defined(VERTEXLIGHT_ON)
    u_xlat16_9 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    vs_TEXCOORD4.yzw = u_xlat4.xyz * (-vec3(u_xlat16_9)) + u_xlat2.xyz;
    u_xlat16_9 = dot(u_xlat4.xyz, (-u_xlat2.xyz));
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat16_9 = (-u_xlat16_9) + 1.0;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    vs_TEXCOORD5.w = u_xlat16_9 * u_xlat16_9;
#else
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    vs_TEXCOORD4.yzw = u_xlat3.xyz * (-u_xlat16_4.xxx) + u_xlat2.xyz;
    u_xlat16_4.x = dot(u_xlat3.xyz, (-u_xlat2.xyz));
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    vs_TEXCOORD5.w = u_xlat16_4.x * u_xlat16_4.x;
#endif
#else
#if defined(VERTEXLIGHT_ON)
    u_xlat16_8 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    vs_TEXCOORD4.yzw = u_xlat3.xyz * (-vec3(u_xlat16_8)) + u_xlat1.xyz;
    u_xlat16_8 = dot(u_xlat3.xyz, (-u_xlat1.xyz));
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    vs_TEXCOORD5.w = u_xlat16_8 * u_xlat16_8;
#else
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    vs_TEXCOORD4.yzw = u_xlat2.xyz * (-u_xlat16_3.xxx) + u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, (-u_xlat1.xyz));
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    vs_TEXCOORD5.w = u_xlat16_3.x * u_xlat16_3.x;
#endif
#endif
#else
#if defined(SHADOWS_SCREEN)
    u_xlat16_4 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat5.x = (-u_xlat16_4) + _Glossiness;
    u_xlat2.w = u_xlat5.x + 1.0;
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
    u_xlat5.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat2.xyz = u_xlat5.xyz * u_xlat3.xxx;
    vs_TEXCOORD1 = u_xlat2;
#else
    u_xlat16_3 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat4.x = (-u_xlat16_3) + _Glossiness;
    u_xlat1.w = u_xlat4.x + 1.0;
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat1.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD1 = u_xlat1;
#endif
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
#if defined(SHADOWS_SCREEN)
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat3 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat1.zzzz + u_xlat3;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat1.wwww + u_xlat3;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
#else
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
#endif
    u_xlat0.x = inversesqrt(u_xlat0.x);
#if defined(SHADOWS_SCREEN)
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_4 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_4 = u_xlat16_4 + u_xlat16_4;
    vs_TEXCOORD4.yzw = u_xlat0.xyz * (-vec3(u_xlat16_4)) + u_xlat2.xyz;
    u_xlat16_4 = dot(u_xlat0.xyz, (-u_xlat2.xyz));
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#else
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD4.yzw = u_xlat0.xyz * (-vec3(u_xlat16_3)) + u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat0.xyz, (-u_xlat1.xyz));
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
#if defined(SHADOWS_SCREEN)
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    vs_TEXCOORD5.w = u_xlat16_4 * u_xlat16_4;
#else
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    vs_TEXCOORD5.w = u_xlat16_3 * u_xlat16_3;
#endif
#endif
#else
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
    u_xlat16_3.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat1.x = (-u_xlat16_3.x) + _Glossiness;
    u_xlat1.w = u_xlat1.x + 1.0;
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
#if defined(VERTEXLIGHT_ON)
    u_xlat4.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat32 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat1.xyz = vec3(u_xlat32) * u_xlat4.xyz;
#else
    u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat1.xyz = vec3(u_xlat23) * u_xlat2.xyz;
#endif
    vs_TEXCOORD1 = u_xlat1;
#if defined(VERTEXLIGHT_ON)
    u_xlat3 = (-u_xlat2.yyyy) + unity_4LightPosY0;
    u_xlat4 = u_xlat3 * u_xlat3;
    u_xlat5 = (-u_xlat2.xxxx) + unity_4LightPosX0;
    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat5 * u_xlat5 + u_xlat4;
    u_xlat4 = u_xlat2 * u_xlat2 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat6 = u_xlat4 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat6 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat6;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat31 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat3 = u_xlat3 * u_xlat7.yyyy;
    u_xlat3 = u_xlat5 * u_xlat7.xxxx + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat7.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat2 = u_xlat6 * u_xlat2;
    u_xlat4.xyz = u_xlat2.yyy * unity_LightColor[1].xyz;
    u_xlat4.xyz = unity_LightColor[0].xyz * u_xlat2.xxx + u_xlat4.xyz;
    u_xlat2.xyz = unity_LightColor[2].xyz * u_xlat2.zzz + u_xlat4.xyz;
    u_xlat2.xyz = unity_LightColor[3].xyz * u_xlat2.www + u_xlat2.xyz;
    u_xlat16_8.x = u_xlat7.y * u_xlat7.y;
    u_xlat16_8.x = u_xlat7.x * u_xlat7.x + (-u_xlat16_8.x);
    u_xlat16_3 = u_xlat7.yzzx * u_xlat7.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_8.xyz = unity_SHC.xyz * u_xlat16_8.xxx + u_xlat16_9.xyz;
    u_xlat7.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat7);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat7);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat7);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.xyz = log2(u_xlat16_8.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD2.xyz = u_xlat2.xyz + u_xlat4.xyz;
#else
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat6.xyz = log2(u_xlat16_3.xyz);
    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat6.xyz = exp2(u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD2.xyz = u_xlat6.xyz;
#endif
#else
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.x = (-u_xlat16_2.x) + _Glossiness;
    u_xlat0.w = u_xlat0.x + 1.0;
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
#if defined(VERTEXLIGHT_ON)
    u_xlat3.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat0.xyz = vec3(u_xlat28) * u_xlat3.xyz;
#else
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz;
#endif
    vs_TEXCOORD1 = u_xlat0;
#if defined(VERTEXLIGHT_ON)
    u_xlat2 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat4 + u_xlat3;
    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat3 = max(u_xlat3, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat5 = u_xlat3 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat3 = inversesqrt(u_xlat3);
    u_xlat5 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat5;
    u_xlat6.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat6.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat6.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat6.xyz;
    u_xlat2 = u_xlat2 * u_xlat6.yyyy;
    u_xlat2 = u_xlat4 * u_xlat6.xxxx + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat6.zzzz + u_xlat2;
    u_xlat1 = u_xlat3 * u_xlat1;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat5 * u_xlat1;
    u_xlat3.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat3.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat16_7.x = u_xlat6.y * u_xlat6.y;
    u_xlat16_7.x = u_xlat6.x * u_xlat6.x + (-u_xlat16_7.x);
    u_xlat16_2 = u_xlat6.yzzx * u_xlat6.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_7.xyz = unity_SHC.xyz * u_xlat16_7.xxx + u_xlat16_8.xyz;
    u_xlat6.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat6);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat6);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat6);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.xyz = log2(u_xlat16_7.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat3.xyz = exp2(u_xlat3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD2.xyz = u_xlat1.xyz + u_xlat3.xyz;
#else
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat5.xyz = log2(u_xlat16_2.xyz);
    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat5.xyz = exp2(u_xlat5.xyz);
    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD2.xyz = u_xlat5.xyz;
#endif
#endif
    vs_TEXCOORD2.w = 0.0;
#if defined(SHADOWS_SCREEN)
#if defined(VERTEXLIGHT_ON)
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat2 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat2;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat2;
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat7.xyz);
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    vs_TEXCOORD4.yzw = u_xlat7.xyz * (-u_xlat16_8.xxx) + u_xlat1.xyz;
    u_xlat16_8.x = dot(u_xlat7.xyz, (-u_xlat1.xyz));
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat7.xyz;
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
    vs_TEXCOORD5.w = u_xlat16_8.x * u_xlat16_8.x;
#else
    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat3 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat3;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat3;
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    vs_TEXCOORD4.yzw = u_xlat2.xyz * (-u_xlat16_4.xxx) + u_xlat1.xyz;
    u_xlat16_4.x = dot(u_xlat2.xyz, (-u_xlat1.xyz));
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    vs_TEXCOORD5.w = u_xlat16_4.x * u_xlat16_4.x;
#endif
#else
#if defined(VERTEXLIGHT_ON)
    u_xlat16_7.x = dot(u_xlat0.xyz, u_xlat6.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    vs_TEXCOORD4.yzw = u_xlat6.xyz * (-u_xlat16_7.xxx) + u_xlat0.xyz;
    u_xlat16_7.x = dot(u_xlat6.xyz, (-u_xlat0.xyz));
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    vs_TEXCOORD5.w = u_xlat16_7.x * u_xlat16_7.x;
#else
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    vs_TEXCOORD4.yzw = u_xlat1.xyz * (-u_xlat16_2.xxx) + u_xlat0.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, (-u_xlat0.xyz));
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    vs_TEXCOORD5.w = u_xlat16_2.x * u_xlat16_2.x;
#endif
#endif
#else
#if defined(SHADOWS_SCREEN)
    u_xlat16_3 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat1.x = (-u_xlat16_3) + _Glossiness;
    u_xlat1.w = u_xlat1.x + 1.0;
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD1 = u_xlat1;
#else
    u_xlat16_2 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.x = (-u_xlat16_2) + _Glossiness;
    u_xlat0.w = u_xlat0.x + 1.0;
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD1 = u_xlat0;
#endif
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
#if defined(SHADOWS_SCREEN)
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat2 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat2;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD4.yzw = u_xlat0.xyz * (-vec3(u_xlat16_3)) + u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat0.xyz, (-u_xlat1.xyz));
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    vs_TEXCOORD5.w = u_xlat16_3 * u_xlat16_3;
#else
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2 = u_xlat16_2 + u_xlat16_2;
    vs_TEXCOORD4.yzw = u_xlat1.xyz * (-vec3(u_xlat16_2)) + u_xlat0.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, (-u_xlat0.xyz));
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    vs_TEXCOORD5.w = u_xlat16_2 * u_xlat16_2;
#endif
#endif
#endif
    vs_TEXCOORD4.x = 0.0;
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
#if !defined(SHADOWS_SCREEN)
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif
#endif
#endif
#endif
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
#if defined(SHADOWS_SCREEN)
uniform 	vec4 _LightShadowData;
#endif
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	float _Glossiness;
uniform 	mediump float _OcclusionStrength;
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
#if !defined(SHADOWS_SCREEN)
struct unity_Builtins2Array_Type {
	mediump vec4 unity_SHArArray;
	mediump vec4 unity_SHAgArray;
	mediump vec4 unity_SHAbArray;
	mediump vec4 unity_SHBrArray;
	mediump vec4 unity_SHBgArray;
	mediump vec4 unity_SHBbArray;
	mediump vec4 unity_SHCArray;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw2 {
#endif
	UNITY_UNIFORM unity_Builtins2Array_Type                unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#endif
#endif
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _OcclusionMap;
UNITY_LOCATION(2) uniform highp sampler2D unity_NHxRoughness;
UNITY_LOCATION(3) uniform mediump samplerCube unity_SpecCube0;
#if defined(SHADOWS_SCREEN)
UNITY_LOCATION(4) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(5) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
#endif
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
#if defined(LIGHTPROBE_SH)
in mediump vec4 vs_TEXCOORD2;
#endif
#if defined(SHADOWS_SCREEN)
in highp vec4 vs_TEXCOORD3;
#endif
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
#else
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
#endif
#else
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
#endif
mediump vec3 u_xlat16_3;
#if defined(LIGHTPROBE_SH)
#if !defined(SHADOWS_SCREEN)
vec3 u_xlat4;
#endif
#endif
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
#if !defined(LIGHTPROBE_SH)
vec3 u_xlat6;
#endif
mediump vec3 u_xlat16_6;
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
float u_xlat7;
#endif
mediump float u_xlat16_7;
#if defined(SHADOWS_SCREEN)
mediump float u_xlat16_22;
#else
mediump float u_xlat16_23;
#endif
#else
mediump float u_xlat16_20;
#endif
void main()
{
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
    vec3 txVec0 = vec3(vs_TEXCOORD3.xy,vs_TEXCOORD3.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat7 = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat7 + _LightShadowData.x;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
#endif
#endif
    u_xlat0.xz = (-vec2(_Glossiness)) + vec2(1.0, 1.0);
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
    u_xlat16_22 = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_22 = u_xlat0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_22 * 6.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, vs_TEXCOORD4.yzw, u_xlat16_22);
    u_xlat16_22 = u_xlat16_2.w + -1.0;
    u_xlat16_22 = unity_SpecCube0_HDR.w * u_xlat16_22 + 1.0;
    u_xlat16_22 = u_xlat16_22 * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
#else
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_1 = textureLod(unity_SpecCube0, vs_TEXCOORD4.yzw, u_xlat16_1.x);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
#endif
#else
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_1 = textureLod(unity_SpecCube0, vs_TEXCOORD4.yzw, u_xlat16_1.x);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
#endif
    u_xlat16_0 = texture(_OcclusionMap, vs_TEXCOORD0.xy).y;
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
    u_xlat16_22 = (-_OcclusionStrength) + 1.0;
    u_xlat16_22 = u_xlat16_0 * _OcclusionStrength + u_xlat16_22;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * vs_TEXCOORD2.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat2.xyz = u_xlat16_2.xyz * _Color.xyz;
#else
    u_xlat16_23 = (-_OcclusionStrength) + 1.0;
    u_xlat16_23 = u_xlat16_0 * _OcclusionStrength + u_xlat16_23;
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_23) * vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat4.xyz = u_xlat16_4.xyz * _Color.xyz;
#endif
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) + vs_TEXCOORD1.www;
    u_xlat16_6.xyz = vs_TEXCOORD5.www * u_xlat16_6.xyz + u_xlat16_5.xyz;
#if defined(SHADOWS_SCREEN)
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_6.xyz;
    u_xlat16_22 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_22) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat16_22 = dot(vs_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
    u_xlat16_22 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_7 = u_xlat16_22 * u_xlat16_22;
#else
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat16_23 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_23) * u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_3.xyz = _LightColor0.xyz * unity_Builtins2Array[0].unity_SHCArray.www;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_23 = dot(vs_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
    u_xlat16_23 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_23;
#endif
    u_xlat0.y = u_xlat16_7;
#if defined(SHADOWS_SCREEN)
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * u_xlat16_1.xyz + u_xlat16_3.xyz;
#else
    u_xlat4.x = texture(unity_NHxRoughness, u_xlat0.yz).x;
    u_xlat4.x = u_xlat4.x * 16.0;
    u_xlat16_6.xyz = u_xlat4.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_3.xyz + u_xlat16_2.xyz;
#endif
#else
    u_xlat16_20 = (-_OcclusionStrength) + 1.0;
    u_xlat16_20 = u_xlat16_0 * _OcclusionStrength + u_xlat16_20;
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat16_20 = dot(vs_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
    u_xlat16_20 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_6.x = u_xlat16_20 * u_xlat16_20;
    u_xlat0.y = u_xlat16_6.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = _Color.xyz * u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = u_xlat6.xyz * vec3(u_xlat16_20) + u_xlat16_4.xyz;
#if defined(SHADOWS_SCREEN)
    vec3 txVec0 = vec3(vs_TEXCOORD3.xy,vs_TEXCOORD3.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat6.x = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat6.x + _LightShadowData.x;
    u_xlat16_5.xyz = u_xlat0.xxx * _LightColor0.xyz;
#endif
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#if defined(SHADOWS_SCREEN)
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz;
#else
    u_xlat16_5.xyz = u_xlat0.xxx * _LightColor0.xyz;
#endif
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + vs_TEXCOORD1.www;
    u_xlat16_3.xyz = vs_TEXCOORD5.www * u_xlat16_5.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
#endif
#else
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
    u_xlat16_22 = (-_OcclusionStrength) + 1.0;
    u_xlat16_22 = u_xlat16_0 * _OcclusionStrength + u_xlat16_22;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * vs_TEXCOORD2.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat2.xyz = u_xlat16_2.xyz * _Color.xyz;
#else
    u_xlat16_23 = (-_OcclusionStrength) + 1.0;
    u_xlat16_23 = u_xlat16_0 * _OcclusionStrength + u_xlat16_23;
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_23) * vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat4.xyz = u_xlat16_4.xyz * _Color.xyz;
#endif
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) + vs_TEXCOORD1.www;
    u_xlat16_6.xyz = vs_TEXCOORD5.www * u_xlat16_6.xyz + u_xlat16_5.xyz;
#if defined(SHADOWS_SCREEN)
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_6.xyz;
    u_xlat16_22 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_22) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat16_22 = dot(vs_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
    u_xlat16_22 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_7 = u_xlat16_22 * u_xlat16_22;
#else
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat16_23 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_23) * u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_23 = dot(vs_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
    u_xlat16_23 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_23;
#endif
    u_xlat0.y = u_xlat16_7;
#if defined(SHADOWS_SCREEN)
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * u_xlat16_1.xyz + u_xlat16_3.xyz;
#else
    u_xlat4.x = texture(unity_NHxRoughness, u_xlat0.yz).x;
    u_xlat4.x = u_xlat4.x * 16.0;
    u_xlat16_6.xyz = u_xlat4.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_3.xyz + u_xlat16_2.xyz;
#endif
#else
    u_xlat16_20 = (-_OcclusionStrength) + 1.0;
    u_xlat16_20 = u_xlat16_0 * _OcclusionStrength + u_xlat16_20;
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat16_20 = dot(vs_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
    u_xlat16_20 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_6.x = u_xlat16_20 * u_xlat16_20;
    u_xlat0.y = u_xlat16_6.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = _Color.xyz * u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = u_xlat6.xyz * vec3(u_xlat16_20) + u_xlat16_4.xyz;
#if defined(SHADOWS_SCREEN)
    vec3 txVec0 = vec3(vs_TEXCOORD3.xy,vs_TEXCOORD3.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat6.x = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat6.x + _LightShadowData.x;
    u_xlat16_5.xyz = u_xlat0.xxx * _LightColor0.xyz;
#endif
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#if defined(SHADOWS_SCREEN)
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz;
#else
    u_xlat16_5.xyz = u_xlat0.xxx * _LightColor0.xyz;
#endif
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + vs_TEXCOORD1.www;
    u_xlat16_3.xyz = vs_TEXCOORD5.www * u_xlat16_5.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
#endif
#endif
    SV_Target0.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "FORWARD_DELTA"
			Tags { "LIGHTMODE"="FORWARDADD" "PerformanceChecks"="False" "RenderType"="Opaque" "SHADOWSUPPORT"="true" }
			Blend [_SrcBlend] One, [_SrcBlend] One
			ZWrite Off
			GLSLPROGRAM
#pragma multi_compile _ SHADOWS_CUBE SPOT DIRECTIONAL DIRECTIONAL_COOKIE
#pragma multi_compile _ POINT POINT_COOKIE SHADOWS_DEPTH SHADOWS_SCREEN
#pragma multi_compile _ SHADOWS_SOFT
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
uniform 	vec3 _WorldSpaceCameraPos;
#if defined(SHADOWS_CUBE)
uniform 	vec4 _WorldSpaceLightPos0;
#else
#if defined(SPOT)
uniform 	vec4 _WorldSpaceLightPos0;
#else
#if defined(DIRECTIONAL)
uniform 	mediump vec4 _WorldSpaceLightPos0;
#else
#if defined(DIRECTIONAL_COOKIE)
uniform 	mediump vec4 _WorldSpaceLightPos0;
#else
uniform 	vec4 _WorldSpaceLightPos0;
#endif
#endif
#endif
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DetailAlbedoMap_ST;
uniform 	mediump float _UVSec;
#if defined(SHADOWS_CUBE)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
#else
#if defined(SPOT)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
#else
#if !defined(DIRECTIONAL)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
#endif
#endif
#endif
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
#if defined(SHADOWS_CUBE)
out highp vec3 vs_TEXCOORD5;
#else
#if defined(SPOT)
out highp vec4 vs_TEXCOORD5;
#else
#if !defined(DIRECTIONAL)
#if defined(DIRECTIONAL_COOKIE)
out highp vec2 vs_TEXCOORD5;
#else
out highp vec3 vs_TEXCOORD5;
#endif
#endif
#endif
#endif
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
#if !defined(SHADOWS_CUBE)
#if !defined(SPOT)
#if defined(DIRECTIONAL)
bool u_xlatb0;
#endif
#endif
#endif
vec4 u_xlat1;
#if defined(SHADOWS_CUBE)
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat16;
#else
#if defined(SPOT)
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat16;
#else
#if defined(DIRECTIONAL)
mediump float u_xlat16_2;
float u_xlat9;
#else
bool u_xlatb1;
vec4 u_xlat2;
#if defined(DIRECTIONAL_COOKIE)
mediump float u_xlat16_3;
float u_xlat13;
#else
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat16;
#endif
#endif
#endif
#endif
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
#if defined(SHADOWS_CUBE)
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlatb1 = _UVSec==0.0;
    u_xlat1.xy = (bool(u_xlatb1)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat1.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#else
#if defined(SPOT)
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlatb1 = _UVSec==0.0;
    u_xlat1.xy = (bool(u_xlatb1)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat1.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#else
#if defined(DIRECTIONAL)
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlatb0 = _UVSec==0.0;
    u_xlat0.xy = (bool(u_xlatb0)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat0.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#else
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlatb1 = _UVSec==0.0;
    u_xlat1.xy = (bool(u_xlatb1)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat1.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#endif
#endif
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#if defined(SHADOWS_CUBE)
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
    u_xlat16_4 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4 = u_xlat16_4 + u_xlat16_4;
    vs_TEXCOORD2.yzw = u_xlat3.xyz * (-vec3(u_xlat16_4)) + u_xlat2.xyz;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD2.x = 0.0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
#else
#if defined(SPOT)
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
    u_xlat16_4 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4 = u_xlat16_4 + u_xlat16_4;
    vs_TEXCOORD2.yzw = u_xlat3.xyz * (-vec3(u_xlat16_4)) + u_xlat2.xyz;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD2.x = 0.0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
#else
#if defined(DIRECTIONAL)
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2 = u_xlat16_2 + u_xlat16_2;
    vs_TEXCOORD2.yzw = u_xlat1.xyz * (-vec3(u_xlat16_2)) + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.x = 0.0;
#else
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
#if !defined(DIRECTIONAL_COOKIE)
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
    u_xlat16_4 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4 = u_xlat16_4 + u_xlat16_4;
    vs_TEXCOORD2.yzw = u_xlat3.xyz * (-vec3(u_xlat16_4)) + u_xlat2.xyz;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD2.x = 0.0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
#endif
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
#if defined(DIRECTIONAL_COOKIE)
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD2.yzw = u_xlat2.xyz * (-vec3(u_xlat16_3)) + u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.x = 0.0;
    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
    vs_TEXCOORD5.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
#else
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
#endif
#endif
#endif
#endif
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
#if !defined(SHADOWS_CUBE)
#if defined(SPOT)
#if defined(SHADOWS_DEPTH)
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#endif
#else
#if defined(DIRECTIONAL)
#if defined(SHADOWS_SCREEN)
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#endif
#else
#if defined(DIRECTIONAL_COOKIE)
#if defined(SHADOWS_SCREEN)
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#endif
#endif
#endif
#endif
#endif
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
#if defined(SHADOWS_CUBE)
uniform 	vec4 _LightPositionRange;
uniform 	vec4 _LightProjectionParams;
uniform 	vec4 _LightShadowData;
#else
#if defined(SPOT)
#if defined(SHADOWS_DEPTH)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 _LightShadowData;
#endif
#else
#if defined(DIRECTIONAL)
#if defined(SHADOWS_SCREEN)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 _LightShadowData;
#endif
#else
#if defined(DIRECTIONAL_COOKIE)
#if defined(SHADOWS_SCREEN)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 _LightShadowData;
#endif
#endif
#endif
#endif
#endif
uniform 	mediump vec4 _LightColor0;
#if !defined(SHADOWS_CUBE)
#if defined(SPOT)
#if defined(SHADOWS_DEPTH)
#if defined(SHADOWS_SOFT)
uniform 	vec4 _ShadowOffsets[4];
#endif
#endif
#endif
#endif
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	float _Glossiness;
#if defined(SHADOWS_CUBE)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
#else
#if defined(SPOT)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
#else
#if !defined(DIRECTIONAL)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
#endif
#endif
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D unity_NHxRoughness;
#if defined(SHADOWS_CUBE)
#if defined(POINT)
UNITY_LOCATION(2) uniform highp sampler2D _LightTexture0;
UNITY_LOCATION(3) uniform highp samplerCube _ShadowMapTexture;
UNITY_LOCATION(4) uniform highp samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
#else
UNITY_LOCATION(2) uniform highp sampler2D _LightTextureB0;
UNITY_LOCATION(3) uniform highp samplerCube _LightTexture0;
UNITY_LOCATION(4) uniform highp samplerCube _ShadowMapTexture;
UNITY_LOCATION(5) uniform highp samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
#endif
#else
#if defined(SPOT)
UNITY_LOCATION(2) uniform highp sampler2D _LightTexture0;
UNITY_LOCATION(3) uniform highp sampler2D _LightTextureB0;
#if defined(SHADOWS_DEPTH)
UNITY_LOCATION(4) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(5) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
#endif
#else
#if defined(DIRECTIONAL)
#if defined(SHADOWS_SCREEN)
UNITY_LOCATION(2) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(3) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
#endif
#else
#if defined(DIRECTIONAL_COOKIE)
UNITY_LOCATION(2) uniform highp sampler2D _LightTexture0;
#if defined(SHADOWS_SCREEN)
UNITY_LOCATION(3) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(4) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
#endif
#else
#if defined(POINT)
UNITY_LOCATION(2) uniform highp sampler2D _LightTexture0;
#else
UNITY_LOCATION(2) uniform highp sampler2D _LightTextureB0;
UNITY_LOCATION(3) uniform highp samplerCube _LightTexture0;
#endif
#endif
#endif
#endif
#endif
in highp vec4 vs_TEXCOORD0;
#if defined(SHADOWS_CUBE)
in highp vec3 vs_TEXCOORD1;
#else
#if defined(SPOT)
in highp vec3 vs_TEXCOORD1;
#else
#if defined(DIRECTIONAL)
#if defined(SHADOWS_SCREEN)
in highp vec3 vs_TEXCOORD1;
#endif
#else
in highp vec3 vs_TEXCOORD1;
#endif
#endif
#endif
in mediump vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
#if defined(SHADOWS_CUBE)
vec3 u_xlat0;
#if defined(POINT)
#if defined(SHADOWS_SOFT)
vec4 u_xlat1;
vec3 u_xlat2;
#else
mediump float u_xlat16_1;
vec2 u_xlat2;
mediump float u_xlat16_2;
#endif
#else
#if defined(SHADOWS_SOFT)
vec4 u_xlat1;
vec3 u_xlat2;
#else
float u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
#endif
#endif
mediump float u_xlat16_3;
#if defined(POINT)
#if defined(SHADOWS_SOFT)
vec2 u_xlat4;
mediump float u_xlat16_4;
#else
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
#endif
#else
#if defined(SHADOWS_SOFT)
vec2 u_xlat4;
#endif
mediump float u_xlat16_4;
#if !defined(SHADOWS_SOFT)
vec3 u_xlat5;
#endif
#endif
mediump vec3 u_xlat16_5;
#if defined(POINT)
#if defined(SHADOWS_SOFT)
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_9;
float u_xlat18;
mediump float u_xlat16_23;
#else
float u_xlat12;
#endif
#else
#if defined(SHADOWS_SOFT)
vec3 u_xlat6;
vec3 u_xlat7;
#endif
mediump vec3 u_xlat16_7;
#if defined(SHADOWS_SOFT)
mediump vec3 u_xlat16_9;
float u_xlat12;
float u_xlat18;
mediump float u_xlat16_23;
#else
float u_xlat10;
float u_xlat15;
#endif
#endif
#else
#if defined(SPOT)
vec4 u_xlat0;
#if defined(SHADOWS_DEPTH)
#if defined(SHADOWS_SOFT)
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
#else
vec2 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
#endif
mediump float u_xlat16_3;
#if defined(SHADOWS_SOFT)
vec2 u_xlat4;
#endif
#else
mediump float u_xlat16_0;
vec2 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
#endif
mediump float u_xlat16_4;
#if defined(SHADOWS_DEPTH)
#if !defined(SHADOWS_SOFT)
vec3 u_xlat5;
#endif
mediump vec3 u_xlat16_5;
#if defined(SHADOWS_SOFT)
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
bool u_xlatb12;
float u_xlat18;
mediump float u_xlat16_23;
#else
mediump vec3 u_xlat16_7;
float u_xlat15;
#endif
#else
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
float u_xlat11;
mediump float u_xlat16_18;
#endif
#else
vec2 u_xlat0;
mediump float u_xlat16_0;
#if defined(DIRECTIONAL)
#if defined(SHADOWS_SCREEN)
vec3 u_xlat1;
#else
float u_xlat1;
#endif
#else
#if defined(DIRECTIONAL_COOKIE)
#if defined(SHADOWS_SCREEN)
vec3 u_xlat1;
#else
vec2 u_xlat1;
#endif
#else
vec3 u_xlat1;
#endif
#endif
mediump vec3 u_xlat16_2;
#if defined(DIRECTIONAL)
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_11;
#else
#if defined(DIRECTIONAL_COOKIE)
#if defined(SHADOWS_SCREEN)
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_15;
#else
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_11;
#endif
#else
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
#if !defined(POINT)
float u_xlat10;
#endif
mediump float u_xlat16_11;
#endif
#endif
#endif
#endif
void main()
{
#if defined(SHADOWS_CUBE)
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-_LightPositionRange.xyz);
#if defined(POINT)
#if defined(SHADOWS_SOFT)
    u_xlat18 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat18 = max(abs(u_xlat0.z), u_xlat18);
    u_xlat18 = u_xlat18 + (-_LightProjectionParams.z);
    u_xlat18 = max(u_xlat18, 9.99999975e-06);
    u_xlat18 = u_xlat18 * _LightProjectionParams.w;
    u_xlat18 = _LightProjectionParams.y / u_xlat18;
    u_xlat18 = u_xlat18 + (-_LightProjectionParams.x);
    u_xlat1.xyz = u_xlat0.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
    vec4 txVec0 = vec4(u_xlat1.xyz,u_xlat18);
    u_xlat1.x = texture(hlslcc_zcmp_ShadowMapTexture, txVec0);
    u_xlat2.xyz = u_xlat0.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
    vec4 txVec1 = vec4(u_xlat2.xyz,u_xlat18);
    u_xlat1.y = texture(hlslcc_zcmp_ShadowMapTexture, txVec1);
    u_xlat2.xyz = u_xlat0.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
    u_xlat0.xyz = u_xlat0.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
    vec4 txVec2 = vec4(u_xlat0.xyz,u_xlat18);
    u_xlat1.w = texture(hlslcc_zcmp_ShadowMapTexture, txVec2);
    vec4 txVec3 = vec4(u_xlat2.xyz,u_xlat18);
    u_xlat1.z = texture(hlslcc_zcmp_ShadowMapTexture, txVec3);
    u_xlat0.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat6.x = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat6.x + _LightShadowData.x;
    u_xlat6.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.x = texture(_LightTexture0, u_xlat6.xx).x;
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat16_3 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat16_9.x = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_9.x = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat16_4 = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat4.x = u_xlat16_4;
    u_xlat4.y = (-_Glossiness) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xy).x;
    u_xlat1.x = u_xlat0.x * 16.0;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_9.xyz = _Color.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat7.xyz = u_xlat16_7.xyz * _Color.xyz;
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_5.xyz = u_xlat1.xxx * u_xlat16_5.xyz;
    u_xlat16_23 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = u_xlat7.xyz * vec3(u_xlat16_23) + u_xlat16_5.xyz;
#else
    u_xlat12 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat12 = max(abs(u_xlat0.z), u_xlat12);
    u_xlat12 = u_xlat12 + (-_LightProjectionParams.z);
    u_xlat12 = max(u_xlat12, 9.99999975e-06);
    u_xlat12 = u_xlat12 * _LightProjectionParams.w;
    u_xlat12 = _LightProjectionParams.y / u_xlat12;
    u_xlat12 = u_xlat12 + (-_LightProjectionParams.x);
    vec4 txVec0 = vec4(u_xlat0.xyz,u_xlat12);
    u_xlat0.x = texture(hlslcc_zcmp_ShadowMapTexture, txVec0);
    u_xlat4.x = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat4.x + _LightShadowData.x;
    u_xlat4.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat4.x = texture(_LightTexture0, u_xlat4.xx).x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat16_1 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_1 = u_xlat0.x * u_xlat16_1;
    u_xlat16_5.x = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_2 = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat2.x = u_xlat16_2;
    u_xlat2.y = (-_Glossiness) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat2.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_3 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = u_xlat4.xyz * vec3(u_xlat16_3) + u_xlat16_5.xyz;
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
#if defined(SHADOWS_SOFT)
    SV_Target0.xyz = vec3(u_xlat16_3) * u_xlat16_5.xyz;
#else
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz;
#endif
#else
#if defined(SHADOWS_SOFT)
    u_xlat18 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat18 = max(abs(u_xlat0.z), u_xlat18);
    u_xlat18 = u_xlat18 + (-_LightProjectionParams.z);
    u_xlat18 = max(u_xlat18, 9.99999975e-06);
    u_xlat18 = u_xlat18 * _LightProjectionParams.w;
    u_xlat18 = _LightProjectionParams.y / u_xlat18;
    u_xlat18 = u_xlat18 + (-_LightProjectionParams.x);
    u_xlat1.xyz = u_xlat0.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
    vec4 txVec0 = vec4(u_xlat1.xyz,u_xlat18);
    u_xlat1.x = texture(hlslcc_zcmp_ShadowMapTexture, txVec0);
    u_xlat2.xyz = u_xlat0.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
    vec4 txVec1 = vec4(u_xlat2.xyz,u_xlat18);
    u_xlat1.y = texture(hlslcc_zcmp_ShadowMapTexture, txVec1);
    u_xlat2.xyz = u_xlat0.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
    u_xlat0.xyz = u_xlat0.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
    vec4 txVec2 = vec4(u_xlat0.xyz,u_xlat18);
    u_xlat1.w = texture(hlslcc_zcmp_ShadowMapTexture, txVec2);
    vec4 txVec3 = vec4(u_xlat2.xyz,u_xlat18);
    u_xlat1.z = texture(hlslcc_zcmp_ShadowMapTexture, txVec3);
    u_xlat0.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat6.x = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat6.x + _LightShadowData.x;
    u_xlat6.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.x = texture(_LightTexture0, u_xlat6.xyz).w;
    u_xlat12 = texture(_LightTextureB0, u_xlat1.xx).x;
    u_xlat6.x = u_xlat6.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat16_3 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat16_9.x = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_9.x = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat16_4 = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat4.x = u_xlat16_4;
    u_xlat4.y = (-_Glossiness) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xy).x;
    u_xlat1.x = u_xlat0.x * 16.0;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_9.xyz = _Color.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat7.xyz = u_xlat16_7.xyz * _Color.xyz;
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_5.xyz = u_xlat1.xxx * u_xlat16_5.xyz;
    u_xlat16_23 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = u_xlat7.xyz * vec3(u_xlat16_23) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    SV_Target0.xyz = vec3(u_xlat16_3) * u_xlat16_5.xyz;
#else
    u_xlat15 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat15 = max(abs(u_xlat0.z), u_xlat15);
    u_xlat15 = u_xlat15 + (-_LightProjectionParams.z);
    u_xlat15 = max(u_xlat15, 9.99999975e-06);
    u_xlat15 = u_xlat15 * _LightProjectionParams.w;
    u_xlat15 = _LightProjectionParams.y / u_xlat15;
    u_xlat15 = u_xlat15 + (-_LightProjectionParams.x);
    vec4 txVec0 = vec4(u_xlat0.xyz,u_xlat15);
    u_xlat0.x = texture(hlslcc_zcmp_ShadowMapTexture, txVec0);
    u_xlat5.x = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + _LightShadowData.x;
    u_xlat5.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat1 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.x = texture(_LightTexture0, u_xlat5.xyz).w;
    u_xlat10 = texture(_LightTextureB0, vec2(u_xlat1)).x;
    u_xlat5.x = u_xlat5.x * u_xlat10;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat16_2 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_2 = u_xlat0.x * u_xlat16_2;
    u_xlat16_7.x = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_3 = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat3.x = u_xlat16_3;
    u_xlat3.y = (-_Glossiness) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat3.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = _Color.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat5.xyz = u_xlat16_5.xyz * _Color.xyz;
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz;
    u_xlat16_4 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat16_4) + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _LightColor0.xyz;
    SV_Target0.xyz = vec3(u_xlat16_2) * u_xlat16_7.xyz;
#endif
#endif
#else
#if defined(SPOT)
#if defined(SHADOWS_DEPTH)
#if !defined(SHADOWS_SOFT)
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat15 = texture(_LightTexture0, u_xlat1.xy).w;
    u_xlatb1 = 0.0<u_xlat0.z;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).x;
    u_xlat16_2 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2 = u_xlat15 * u_xlat16_2;
    u_xlat16_2 = u_xlat0.x * u_xlat16_2;
#endif
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToShadow[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToShadow[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToShadow[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
#if defined(SHADOWS_SOFT)
    u_xlat1.xyz = u_xlat0.xyz + _ShadowOffsets[0].xyz;
    vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
    u_xlat1.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat2.xyz = u_xlat0.xyz + _ShadowOffsets[1].xyz;
    vec3 txVec1 = vec3(u_xlat2.xy,u_xlat2.z);
    u_xlat1.y = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat2.xyz = u_xlat0.xyz + _ShadowOffsets[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + _ShadowOffsets[3].xyz;
    vec3 txVec2 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat1.w = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat2.xy,u_xlat2.z);
    u_xlat1.z = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat0.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat6.x = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat6.x + _LightShadowData.x;
    u_xlat1 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat6.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat6.x = texture(_LightTexture0, u_xlat6.xy).w;
    u_xlatb12 = 0.0<u_xlat1.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = texture(_LightTextureB0, vec2(u_xlat18)).x;
    u_xlat16_3 = (u_xlatb12) ? 1.0 : 0.0;
    u_xlat16_3 = u_xlat6.x * u_xlat16_3;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat16_9.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
    u_xlat16_3 = u_xlat16_9.x * u_xlat16_3;
    u_xlat16_9.x = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_9.x = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat16_4 = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat4.x = u_xlat16_4;
    u_xlat4.y = (-_Glossiness) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xy).x;
#else
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.x = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + _LightShadowData.x;
    u_xlat16_2 = u_xlat0.x * u_xlat16_2;
    u_xlat16_7.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_2 = u_xlat16_7.x * u_xlat16_2;
    u_xlat16_7.x = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_3 = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat3.x = u_xlat16_3;
    u_xlat3.y = (-_Glossiness) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat3.xy).x;
#endif
    u_xlat0.x = u_xlat0.x * 16.0;
#if defined(SHADOWS_SOFT)
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_9.xyz = _Color.xyz * u_xlat16_1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_23 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = u_xlat1.xyz * vec3(u_xlat16_23) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    SV_Target0.xyz = vec3(u_xlat16_3) * u_xlat16_5.xyz;
#else
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = _Color.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat5.xyz = u_xlat16_5.xyz * _Color.xyz;
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz;
    u_xlat16_4 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat16_4) + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _LightColor0.xyz;
    SV_Target0.xyz = vec3(u_xlat16_2) * u_xlat16_7.xyz;
#endif
#else
    u_xlat16_0 = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat0.x = u_xlat16_0;
    u_xlat0.y = (-_Glossiness) + 1.0;
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = _Color.xyz * u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_18 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.xyz = u_xlat6.xyz * vec3(u_xlat16_18) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _LightColor0.xyz;
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.x = texture(_LightTexture0, u_xlat1.xy).w;
    u_xlatb6 = 0.0<u_xlat0.z;
    u_xlat11 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = texture(_LightTextureB0, vec2(u_xlat11)).x;
    u_xlat16_18 = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_18 = u_xlat1.x * u_xlat16_18;
    u_xlat16_18 = u_xlat11 * u_xlat16_18;
    u_xlat16_4 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat16_18 = u_xlat16_18 * u_xlat16_4;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz;
#endif
#else
    u_xlat16_0 = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat0.x = u_xlat16_0;
    u_xlat0.y = (-_Glossiness) + 1.0;
#if defined(DIRECTIONAL)
#if defined(SHADOWS_SCREEN)
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat1.x = u_xlat1.x * 16.0;
#else
    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat1 = u_xlat1 * 16.0;
#endif
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = _Color.xyz * u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
#if defined(SHADOWS_SCREEN)
    u_xlat16_2.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
#else
    u_xlat16_2.xyz = vec3(u_xlat1) * u_xlat16_2.xyz;
#endif
    u_xlat16_11 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(u_xlat16_11) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
#if defined(SHADOWS_SCREEN)
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
    u_xlat1.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat4.x = (-_LightShadowData.x) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat4.x + _LightShadowData.x;
#endif
    u_xlat16_11 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#if defined(SHADOWS_SCREEN)
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
#endif
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
#else
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat1.x = u_xlat1.x * 16.0;
#if defined(DIRECTIONAL_COOKIE)
#if defined(SHADOWS_SCREEN)
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = _Color.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat5.xyz = u_xlat16_5.xyz * _Color.xyz;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat16_15) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _LightColor0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
    u_xlat1.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.x = (-_LightShadowData.x) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat5.x + _LightShadowData.x;
    u_xlat5.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat5.xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat5.xy;
    u_xlat5.xy = u_xlat5.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat5.x = texture(_LightTexture0, u_xlat5.xy).w;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat16_15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
    u_xlat16_15 = u_xlat1.x * u_xlat16_15;
    SV_Target0.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
#else
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = _Color.xyz * u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat16_11 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(u_xlat16_11) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat1.x = texture(_LightTexture0, u_xlat1.xy).w;
    u_xlat16_11 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
#endif
#else
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = _Color.xyz * u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat16_11 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(u_xlat16_11) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
#if defined(POINT)
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = texture(_LightTexture0, u_xlat1.xx).x;
#else
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = texture(_LightTexture0, u_xlat1.xyz).w;
    u_xlat4.x = texture(_LightTextureB0, vec2(u_xlat10)).x;
    u_xlat1.x = u_xlat1.x * u_xlat4.x;
#endif
    u_xlat16_11 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
#endif
#endif
#endif
#endif
    SV_Target0.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "DEFERRED"
			Tags { "LIGHTMODE"="DEFERRED" "PerformanceChecks"="False" "RenderType"="Opaque" }
			GLSLPROGRAM
#pragma multi_compile _ INSTANCING_ON
#pragma multi_compile _ LIGHTPROBE_SH
#pragma multi_compile _ UNITY_HDR_ON
#ifdef VERTEX
#version 300 es
#if defined(INSTANCING_ON)
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif
#endif
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
#if !defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if defined(INSTANCING_ON)
uniform 	int unity_BaseInstanceID;
#endif
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DetailAlbedoMap_ST;
uniform 	mediump float _UVSec;
#if defined(INSTANCING_ON)
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if defined(LIGHTPROBE_SH)
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
#else
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type                unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if defined(LIGHTPROBE_SH)
struct unity_Builtins2Array_Type {
	mediump vec4 unity_SHArArray;
	mediump vec4 unity_SHAgArray;
	mediump vec4 unity_SHAbArray;
	mediump vec4 unity_SHBrArray;
	mediump vec4 unity_SHBgArray;
	mediump vec4 unity_SHBbArray;
	mediump vec4 unity_SHCArray;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw2 {
#endif
	UNITY_UNIFORM unity_Builtins2Array_Type                unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#endif
#endif
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
#if defined(INSTANCING_ON)
flat out highp uint vs_SV_InstanceID0;
#if !defined(LIGHTPROBE_SH)
float u_xlat0;
#endif
int u_xlati0;
#else
vec4 u_xlat0;
#if defined(LIGHTPROBE_SH)
mediump vec4 u_xlat16_0;
#endif
bool u_xlatb0;
#endif
vec4 u_xlat1;
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
mediump vec4 u_xlat16_1;
#endif
vec4 u_xlat2;
#if defined(LIGHTPROBE_SH)
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
int u_xlati5;
vec2 u_xlat10;
bool u_xlatb10;
#else
vec3 u_xlat3;
bool u_xlatb3;
#endif
#else
#if defined(LIGHTPROBE_SH)
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
#else
float u_xlat6;
#endif
#endif
void main()
{
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
#if defined(LIGHTPROBE_SH)
    u_xlati5 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlati0 = u_xlati0 * 7;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
#else
    u_xlati0 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
#endif
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
#if defined(LIGHTPROBE_SH)
    u_xlatb10 = _UVSec==0.0;
    u_xlat10.xy = (bool(u_xlatb10)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat10.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#else
    u_xlatb3 = _UVSec==0.0;
    u_xlat3.xy = (bool(u_xlatb3)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#endif
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlatb0 = _UVSec==0.0;
    u_xlat0.xy = (bool(u_xlatb0)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat0.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
#else
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    vs_TEXCOORD1.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
#endif
#else
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
#endif
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
#else
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD4.xyz = vec3(u_xlat0) * u_xlat1.xyz;
#endif
#else
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
#if defined(LIGHTPROBE_SH)
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
#else
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
#endif
#endif
    vs_TEXCOORD4.w = 0.0;
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
    u_xlat16_3 = u_xlat5.y * u_xlat5.y;
    u_xlat16_3 = u_xlat5.x * u_xlat5.x + (-u_xlat16_3);
    u_xlat16_1 = u_xlat5.yzzx * u_xlat5.xyzz;
    u_xlat16_4.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBrArray, u_xlat16_1);
    u_xlat16_4.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBgArray, u_xlat16_1);
    u_xlat16_4.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBbArray, u_xlat16_1);
    vs_TEXCOORD5.xyz = unity_Builtins2Array[u_xlati0 / 7].unity_SHCArray.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD5.w = 0.0;
#else
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
#endif
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
#else
#if defined(LIGHTPROBE_SH)
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5.w = 0.0;
#else
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
#endif
#endif
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif
#endif
#endif
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
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
uniform 	int unity_BaseInstanceID;
#endif
#else
#if defined(LIGHTPROBE_SH)
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
#endif
#endif
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	float _Glossiness;
uniform 	mediump float _OcclusionStrength;
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
struct unity_Builtins2Array_Type {
	mediump vec4 unity_SHArArray;
	mediump vec4 unity_SHAgArray;
	mediump vec4 unity_SHAbArray;
	mediump vec4 unity_SHBrArray;
	mediump vec4 unity_SHBgArray;
	mediump vec4 unity_SHBbArray;
	mediump vec4 unity_SHCArray;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw2 {
#endif
	UNITY_UNIFORM unity_Builtins2Array_Type                unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#endif
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _OcclusionMap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
in mediump vec4 vs_TEXCOORD5;
flat in highp uint vs_SV_InstanceID0;
#endif
#else
#if defined(LIGHTPROBE_SH)
in mediump vec4 vs_TEXCOORD5;
#endif
#endif
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
#if defined(LIGHTPROBE_SH)
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
#else
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
#endif
mediump float u_xlat16_1;
vec3 u_xlat2;
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
mediump vec3 u_xlat16_2;
int u_xlati2;
vec3 u_xlat3;
#endif
#else
#if defined(LIGHTPROBE_SH)
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
#endif
#endif
mediump vec3 u_xlat16_4;
#if defined(LIGHTPROBE_SH)
mediump vec3 u_xlat16_6;
#endif
void main()
{
    u_xlat16_0.x = texture(_OcclusionMap, vs_TEXCOORD0.xy).y;
    u_xlat16_1 = (-_OcclusionStrength) + 1.0;
#if defined(LIGHTPROBE_SH)
    u_xlat16_0.w = u_xlat16_0.x * _OcclusionStrength + u_xlat16_1;
#else
    SV_Target0.w = u_xlat16_0.x * _OcclusionStrength + u_xlat16_1;
#endif
    u_xlat16_1 = (-_Metallic) * 0.779083729 + 0.779083729;
#if defined(LIGHTPROBE_SH)
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    SV_Target1.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_0.xyz = vec3(u_xlat16_1) * u_xlat3.xyz;
    SV_Target0 = u_xlat16_0;
#else
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_4.xyz = _Color.xyz * u_xlat16_0.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    SV_Target1.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat2.xyz;
#endif
    SV_Target1.w = _Glossiness;
#if defined(LIGHTPROBE_SH)
    u_xlat2.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat1.xyz = u_xlat2.xxx * vs_TEXCOORD4.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.xyz = u_xlat2.xyz;
#else
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.xyz = u_xlat0.xyz;
#endif
    SV_Target2.w = 1.0;
#if defined(INSTANCING_ON)
#if defined(LIGHTPROBE_SH)
    u_xlati2 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 * 7;
    u_xlat1.w = 1.0;
    u_xlat16_4.x = dot(unity_Builtins2Array[u_xlati2 / 7].unity_SHArArray, u_xlat1);
    u_xlat16_4.y = dot(unity_Builtins2Array[u_xlati2 / 7].unity_SHAgArray, u_xlat1);
    u_xlat16_4.z = dot(unity_Builtins2Array[u_xlati2 / 7].unity_SHAbArray, u_xlat1);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.xyz = log2(u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = u_xlat16_0.www * u_xlat2.xyz;
#if defined(UNITY_HDR_ON)
    SV_Target3.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
#else
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_4.xyz));
#endif
    SV_Target3.w = 1.0;
#else
#if defined(UNITY_HDR_ON)
    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
#else
    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
#endif
#endif
#else
#if defined(LIGHTPROBE_SH)
    u_xlat1.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.xyz = log2(u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = u_xlat16_0.www * u_xlat2.xyz;
#if defined(UNITY_HDR_ON)
    SV_Target3.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
#else
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_4.xyz));
#endif
    SV_Target3.w = 1.0;
#else
#if defined(UNITY_HDR_ON)
    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
#else
    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
#endif
#endif
#endif
    return;
}
#endif
			ENDGLSL
		}
	}
	SubShader
	{
		Tags { "PerformanceChecks"="False" "RenderType"="Opaque" }
		LOD 150
		Pass
		{
			Name "FORWARD"
			Tags { "LIGHTMODE"="FORWARDBASE" "PerformanceChecks"="False" "RenderType"="Opaque" "SHADOWSUPPORT"="true" }
			Blend [_SrcBlend] [_DstBlend], [_SrcBlend] [_DstBlend]
			ZWrite [_ZWrite]
			GLSLPROGRAM
#pragma multi_compile _ DIRECTIONAL
#pragma multi_compile _ LIGHTPROBE_SH
#pragma multi_compile _ SHADOWS_SCREEN
#pragma multi_compile _ VERTEXLIGHT_ON
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
uniform 	vec3 _WorldSpaceCameraPos;
#if defined(LIGHTPROBE_SH)
#if defined(VERTEXLIGHT_ON)
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
#endif
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
#endif
#if defined(SHADOWS_SCREEN)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DetailAlbedoMap_ST;
uniform 	mediump float _Metallic;
uniform 	float _Glossiness;
uniform 	mediump float _UVSec;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
#if defined(SHADOWS_SCREEN)
out highp vec4 vs_TEXCOORD3;
#endif
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
#if !defined(SHADOWS_SCREEN)
bool u_xlatb0;
#endif
vec4 u_xlat1;
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
#if defined(VERTEXLIGHT_ON)
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat31;
float u_xlat32;
#else
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat22;
float u_xlat23;
#endif
#else
#if defined(VERTEXLIGHT_ON)
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat27;
float u_xlat28;
#else
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat18;
float u_xlat19;
#endif
#endif
#else
#if defined(SHADOWS_SCREEN)
bool u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
float u_xlat14;
#else
mediump float u_xlat16_2;
float u_xlat9;
float u_xlat10;
#endif
#endif
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
#if defined(SHADOWS_SCREEN)
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlatb1 = _UVSec==0.0;
    u_xlat1.xy = (bool(u_xlatb1)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat1.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#else
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlatb0 = _UVSec==0.0;
    u_xlat0.xy = (bool(u_xlatb0)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat0.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
    u_xlat16_3.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat1.x = (-u_xlat16_3.x) + _Glossiness;
    u_xlat1.w = u_xlat1.x + 1.0;
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
#if defined(VERTEXLIGHT_ON)
    u_xlat4.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat32 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat1.xyz = vec3(u_xlat32) * u_xlat4.xyz;
#else
    u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat1.xyz = vec3(u_xlat23) * u_xlat2.xyz;
#endif
    vs_TEXCOORD1 = u_xlat1;
#if defined(VERTEXLIGHT_ON)
    u_xlat3 = (-u_xlat2.yyyy) + unity_4LightPosY0;
    u_xlat4 = u_xlat3 * u_xlat3;
    u_xlat5 = (-u_xlat2.xxxx) + unity_4LightPosX0;
    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat5 * u_xlat5 + u_xlat4;
    u_xlat4 = u_xlat2 * u_xlat2 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat6 = u_xlat4 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat6 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat6;
    u_xlat7.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat7.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat7.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat31 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz;
    u_xlat3 = u_xlat3 * u_xlat7.yyyy;
    u_xlat3 = u_xlat5 * u_xlat7.xxxx + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat7.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat2 = u_xlat6 * u_xlat2;
    u_xlat4.xyz = u_xlat2.yyy * unity_LightColor[1].xyz;
    u_xlat4.xyz = unity_LightColor[0].xyz * u_xlat2.xxx + u_xlat4.xyz;
    u_xlat2.xyz = unity_LightColor[2].xyz * u_xlat2.zzz + u_xlat4.xyz;
    u_xlat2.xyz = unity_LightColor[3].xyz * u_xlat2.www + u_xlat2.xyz;
    u_xlat16_8.x = u_xlat7.y * u_xlat7.y;
    u_xlat16_8.x = u_xlat7.x * u_xlat7.x + (-u_xlat16_8.x);
    u_xlat16_3 = u_xlat7.yzzx * u_xlat7.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_8.xyz = unity_SHC.xyz * u_xlat16_8.xxx + u_xlat16_9.xyz;
    u_xlat7.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat7);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat7);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat7);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.xyz = log2(u_xlat16_8.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD2.xyz = u_xlat2.xyz + u_xlat4.xyz;
#else
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat6.xyz = log2(u_xlat16_3.xyz);
    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat6.xyz = exp2(u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD2.xyz = u_xlat6.xyz;
#endif
#else
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.x = (-u_xlat16_2.x) + _Glossiness;
    u_xlat0.w = u_xlat0.x + 1.0;
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
#if defined(VERTEXLIGHT_ON)
    u_xlat3.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat0.xyz = vec3(u_xlat28) * u_xlat3.xyz;
#else
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz;
#endif
    vs_TEXCOORD1 = u_xlat0;
#if defined(VERTEXLIGHT_ON)
    u_xlat2 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat4 + u_xlat3;
    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat3 = max(u_xlat3, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat5 = u_xlat3 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat3 = inversesqrt(u_xlat3);
    u_xlat5 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat5;
    u_xlat6.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat6.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat6.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat6.xyz;
    u_xlat2 = u_xlat2 * u_xlat6.yyyy;
    u_xlat2 = u_xlat4 * u_xlat6.xxxx + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat6.zzzz + u_xlat2;
    u_xlat1 = u_xlat3 * u_xlat1;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat5 * u_xlat1;
    u_xlat3.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat3.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat16_7.x = u_xlat6.y * u_xlat6.y;
    u_xlat16_7.x = u_xlat6.x * u_xlat6.x + (-u_xlat16_7.x);
    u_xlat16_2 = u_xlat6.yzzx * u_xlat6.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_7.xyz = unity_SHC.xyz * u_xlat16_7.xxx + u_xlat16_8.xyz;
    u_xlat6.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat6);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat6);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat6);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.xyz = log2(u_xlat16_7.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat3.xyz = exp2(u_xlat3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD2.xyz = u_xlat1.xyz + u_xlat3.xyz;
#else
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat5.xyz = log2(u_xlat16_2.xyz);
    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat5.xyz = exp2(u_xlat5.xyz);
    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD2.xyz = u_xlat5.xyz;
#endif
#endif
    vs_TEXCOORD2.w = 0.0;
#if defined(SHADOWS_SCREEN)
#if defined(VERTEXLIGHT_ON)
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat2 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat2;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat2;
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat7.xyz);
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    vs_TEXCOORD4.yzw = u_xlat7.xyz * (-u_xlat16_8.xxx) + u_xlat1.xyz;
    u_xlat16_8.x = dot(u_xlat7.xyz, (-u_xlat1.xyz));
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat7.xyz;
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
    vs_TEXCOORD5.w = u_xlat16_8.x * u_xlat16_8.x;
#else
    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat3 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat3;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat3;
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    vs_TEXCOORD4.yzw = u_xlat2.xyz * (-u_xlat16_4.xxx) + u_xlat1.xyz;
    u_xlat16_4.x = dot(u_xlat2.xyz, (-u_xlat1.xyz));
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    vs_TEXCOORD5.w = u_xlat16_4.x * u_xlat16_4.x;
#endif
#else
#if defined(VERTEXLIGHT_ON)
    u_xlat16_7.x = dot(u_xlat0.xyz, u_xlat6.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    vs_TEXCOORD4.yzw = u_xlat6.xyz * (-u_xlat16_7.xxx) + u_xlat0.xyz;
    u_xlat16_7.x = dot(u_xlat6.xyz, (-u_xlat0.xyz));
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    vs_TEXCOORD5.w = u_xlat16_7.x * u_xlat16_7.x;
#else
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    vs_TEXCOORD4.yzw = u_xlat1.xyz * (-u_xlat16_2.xxx) + u_xlat0.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, (-u_xlat0.xyz));
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    vs_TEXCOORD5.w = u_xlat16_2.x * u_xlat16_2.x;
#endif
#endif
#else
#if defined(SHADOWS_SCREEN)
    u_xlat16_3 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat1.x = (-u_xlat16_3) + _Glossiness;
    u_xlat1.w = u_xlat1.x + 1.0;
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD1 = u_xlat1;
#else
    u_xlat16_2 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.x = (-u_xlat16_2) + _Glossiness;
    u_xlat0.w = u_xlat0.x + 1.0;
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD1 = u_xlat0;
#endif
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
#if defined(SHADOWS_SCREEN)
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat2 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat2;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD4.yzw = u_xlat0.xyz * (-vec3(u_xlat16_3)) + u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat0.xyz, (-u_xlat1.xyz));
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    vs_TEXCOORD5.w = u_xlat16_3 * u_xlat16_3;
#else
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2 = u_xlat16_2 + u_xlat16_2;
    vs_TEXCOORD4.yzw = u_xlat1.xyz * (-vec3(u_xlat16_2)) + u_xlat0.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, (-u_xlat0.xyz));
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    vs_TEXCOORD5.w = u_xlat16_2 * u_xlat16_2;
#endif
#endif
    vs_TEXCOORD4.x = 0.0;
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
#if defined(SHADOWS_SCREEN)
uniform 	vec4 _LightShadowData;
#endif
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	float _Glossiness;
#if defined(SHADOWS_SCREEN)
uniform 	mediump float _OcclusionStrength;
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _OcclusionMap;
UNITY_LOCATION(2) uniform highp sampler2D unity_NHxRoughness;
UNITY_LOCATION(3) uniform mediump samplerCube unity_SpecCube0;
#if defined(SHADOWS_SCREEN)
UNITY_LOCATION(4) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(5) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
#endif
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
#if defined(LIGHTPROBE_SH)
in mediump vec4 vs_TEXCOORD2;
#endif
#if defined(SHADOWS_SCREEN)
in highp vec4 vs_TEXCOORD3;
#endif
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
#else
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
#endif
#else
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
#endif
mediump vec3 u_xlat16_3;
#if defined(LIGHTPROBE_SH)
#if !defined(SHADOWS_SCREEN)
vec3 u_xlat4;
#endif
#endif
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
#if !defined(LIGHTPROBE_SH)
vec3 u_xlat6;
#endif
mediump vec3 u_xlat16_6;
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
float u_xlat7;
#endif
mediump float u_xlat16_7;
#if defined(SHADOWS_SCREEN)
mediump float u_xlat16_22;
#else
mediump float u_xlat16_23;
#endif
#else
mediump float u_xlat16_20;
#endif
void main()
{
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
    vec3 txVec0 = vec3(vs_TEXCOORD3.xy,vs_TEXCOORD3.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat7 = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat7 + _LightShadowData.x;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
#endif
#endif
    u_xlat0.xz = (-vec2(_Glossiness)) + vec2(1.0, 1.0);
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
    u_xlat16_22 = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_22 = u_xlat0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_22 * 6.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, vs_TEXCOORD4.yzw, u_xlat16_22);
    u_xlat16_22 = u_xlat16_2.w + -1.0;
    u_xlat16_22 = unity_SpecCube0_HDR.w * u_xlat16_22 + 1.0;
    u_xlat16_22 = u_xlat16_22 * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
#else
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_1 = textureLod(unity_SpecCube0, vs_TEXCOORD4.yzw, u_xlat16_1.x);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
#endif
#else
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_1 = textureLod(unity_SpecCube0, vs_TEXCOORD4.yzw, u_xlat16_1.x);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
#endif
    u_xlat16_0 = texture(_OcclusionMap, vs_TEXCOORD0.xy).y;
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
    u_xlat16_22 = (-_OcclusionStrength) + 1.0;
    u_xlat16_22 = u_xlat16_0 * _OcclusionStrength + u_xlat16_22;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * vs_TEXCOORD2.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat2.xyz = u_xlat16_2.xyz * _Color.xyz;
#else
    u_xlat16_2.xyz = vec3(u_xlat16_0) * u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_0) * vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat4.xyz = u_xlat16_4.xyz * _Color.xyz;
#endif
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) + vs_TEXCOORD1.www;
    u_xlat16_6.xyz = vs_TEXCOORD5.www * u_xlat16_6.xyz + u_xlat16_5.xyz;
#if defined(SHADOWS_SCREEN)
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_6.xyz;
    u_xlat16_22 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_22) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat16_22 = dot(vs_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
    u_xlat16_22 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_7 = u_xlat16_22 * u_xlat16_22;
#else
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat16_23 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_23) * u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_23 = dot(vs_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
    u_xlat16_23 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_23;
#endif
    u_xlat0.y = u_xlat16_7;
#else
#if defined(SHADOWS_SCREEN)
    u_xlat16_20 = (-_OcclusionStrength) + 1.0;
    u_xlat16_20 = u_xlat16_0 * _OcclusionStrength + u_xlat16_20;
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
#else
    u_xlat16_2.xyz = vec3(u_xlat16_0) * u_xlat16_2.xyz;
#endif
    u_xlat16_20 = dot(vs_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
    u_xlat16_20 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_6.x = u_xlat16_20 * u_xlat16_20;
    u_xlat0.y = u_xlat16_6.x;
#endif
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * u_xlat16_1.xyz + u_xlat16_3.xyz;
#else
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz + u_xlat16_2.xyz;
#endif
#else
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = _Color.xyz * u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = u_xlat6.xyz * vec3(u_xlat16_20) + u_xlat16_4.xyz;
#if defined(SHADOWS_SCREEN)
    vec3 txVec0 = vec3(vs_TEXCOORD3.xy,vs_TEXCOORD3.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat6.x = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat6.x + _LightShadowData.x;
    u_xlat16_5.xyz = u_xlat0.xxx * _LightColor0.xyz;
#endif
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#if defined(SHADOWS_SCREEN)
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz;
#else
    u_xlat16_5.xyz = u_xlat0.xxx * _LightColor0.xyz;
#endif
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + vs_TEXCOORD1.www;
    u_xlat16_3.xyz = vs_TEXCOORD5.www * u_xlat16_5.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
#endif
    SV_Target0.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "FORWARD_DELTA"
			Tags { "LIGHTMODE"="FORWARDADD" "PerformanceChecks"="False" "RenderType"="Opaque" "SHADOWSUPPORT"="true" }
			Blend [_SrcBlend] One, [_SrcBlend] One
			ZWrite Off
			GLSLPROGRAM
#pragma multi_compile _ DIRECTIONAL DIRECTIONAL_COOKIE POINT POINT_COOKIE SPOT
#pragma multi_compile _ SHADOWS_CUBE SHADOWS_SCREEN SHADOWS_DEPTH
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
uniform 	vec3 _WorldSpaceCameraPos;
#if defined(DIRECTIONAL)
uniform 	mediump vec4 _WorldSpaceLightPos0;
#else
#if defined(DIRECTIONAL_COOKIE)
uniform 	mediump vec4 _WorldSpaceLightPos0;
#else
uniform 	vec4 _WorldSpaceLightPos0;
#endif
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DetailAlbedoMap_ST;
uniform 	mediump float _UVSec;
#if !defined(DIRECTIONAL)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
#endif
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
#if !defined(DIRECTIONAL)
#if defined(DIRECTIONAL_COOKIE)
out highp vec2 vs_TEXCOORD5;
#else
#if defined(POINT)
out highp vec3 vs_TEXCOORD5;
#else
#if defined(POINT_COOKIE)
out highp vec3 vs_TEXCOORD5;
#else
out highp vec4 vs_TEXCOORD5;
#endif
#endif
#endif
#endif
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
#if defined(DIRECTIONAL)
bool u_xlatb0;
#endif
vec4 u_xlat1;
#if defined(DIRECTIONAL)
mediump float u_xlat16_2;
float u_xlat9;
#else
bool u_xlatb1;
vec4 u_xlat2;
#if defined(DIRECTIONAL_COOKIE)
mediump float u_xlat16_3;
float u_xlat13;
#else
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat16;
#endif
#endif
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
#if defined(DIRECTIONAL)
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlatb0 = _UVSec==0.0;
    u_xlat0.xy = (bool(u_xlatb0)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat0.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#else
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlatb1 = _UVSec==0.0;
    u_xlat1.xy = (bool(u_xlatb1)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat1.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#if defined(DIRECTIONAL)
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2 = u_xlat16_2 + u_xlat16_2;
    vs_TEXCOORD2.yzw = u_xlat1.xyz * (-vec3(u_xlat16_2)) + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.x = 0.0;
#else
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
#if !defined(DIRECTIONAL_COOKIE)
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
    u_xlat16_4 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4 = u_xlat16_4 + u_xlat16_4;
    vs_TEXCOORD2.yzw = u_xlat3.xyz * (-vec3(u_xlat16_4)) + u_xlat2.xyz;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD2.x = 0.0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
#endif
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
#if defined(DIRECTIONAL_COOKIE)
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD2.yzw = u_xlat2.xyz * (-vec3(u_xlat16_3)) + u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.x = 0.0;
    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
    vs_TEXCOORD5.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
#else
#if defined(POINT)
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
#else
#if defined(POINT_COOKIE)
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
#else
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
#endif
#endif
#endif
#endif
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
#if defined(DIRECTIONAL)
#if defined(SHADOWS_SCREEN)
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#endif
#else
#if defined(DIRECTIONAL_COOKIE)
#if defined(SHADOWS_SCREEN)
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#endif
#else
#if !defined(POINT)
#if !defined(POINT_COOKIE)
#if defined(SHADOWS_DEPTH)
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#endif
#endif
#endif
#endif
#endif
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
#if defined(DIRECTIONAL)
#if defined(SHADOWS_SCREEN)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 _LightShadowData;
#endif
#else
#if defined(DIRECTIONAL_COOKIE)
#if defined(SHADOWS_SCREEN)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 _LightShadowData;
#endif
#else
#if defined(POINT)
#if defined(SHADOWS_CUBE)
uniform 	vec4 _LightPositionRange;
uniform 	vec4 _LightProjectionParams;
uniform 	vec4 _LightShadowData;
#endif
#else
#if defined(POINT_COOKIE)
#if defined(SHADOWS_CUBE)
uniform 	vec4 _LightPositionRange;
uniform 	vec4 _LightProjectionParams;
uniform 	vec4 _LightShadowData;
#endif
#else
#if defined(SHADOWS_DEPTH)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 _LightShadowData;
#endif
#endif
#endif
#endif
#endif
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	float _Glossiness;
#if !defined(DIRECTIONAL)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D unity_NHxRoughness;
#if defined(DIRECTIONAL)
#if defined(SHADOWS_SCREEN)
UNITY_LOCATION(2) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(3) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
#endif
#else
#if defined(DIRECTIONAL_COOKIE)
UNITY_LOCATION(2) uniform highp sampler2D _LightTexture0;
#if defined(SHADOWS_SCREEN)
UNITY_LOCATION(3) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(4) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
#endif
#else
#if defined(POINT)
UNITY_LOCATION(2) uniform highp sampler2D _LightTexture0;
#if defined(SHADOWS_CUBE)
UNITY_LOCATION(3) uniform highp samplerCube _ShadowMapTexture;
UNITY_LOCATION(4) uniform highp samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
#endif
#else
#if defined(POINT_COOKIE)
UNITY_LOCATION(2) uniform highp sampler2D _LightTextureB0;
UNITY_LOCATION(3) uniform highp samplerCube _LightTexture0;
#if defined(SHADOWS_CUBE)
UNITY_LOCATION(4) uniform highp samplerCube _ShadowMapTexture;
UNITY_LOCATION(5) uniform highp samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
#endif
#else
UNITY_LOCATION(2) uniform highp sampler2D _LightTexture0;
UNITY_LOCATION(3) uniform highp sampler2D _LightTextureB0;
#if defined(SHADOWS_DEPTH)
UNITY_LOCATION(4) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(5) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
#endif
#endif
#endif
#endif
#endif
in highp vec4 vs_TEXCOORD0;
#if defined(DIRECTIONAL)
#if defined(SHADOWS_SCREEN)
in highp vec3 vs_TEXCOORD1;
#endif
#else
in highp vec3 vs_TEXCOORD1;
#endif
in mediump vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
#if defined(DIRECTIONAL)
vec2 u_xlat0;
mediump float u_xlat16_0;
#if defined(SHADOWS_SCREEN)
vec3 u_xlat1;
#else
float u_xlat1;
#endif
mediump vec3 u_xlat16_2;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_11;
#else
#if defined(DIRECTIONAL_COOKIE)
vec2 u_xlat0;
mediump float u_xlat16_0;
#if defined(SHADOWS_SCREEN)
vec3 u_xlat1;
#else
vec2 u_xlat1;
#endif
mediump vec3 u_xlat16_2;
#if defined(SHADOWS_SCREEN)
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_15;
#else
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_11;
#endif
#else
#if defined(POINT)
#if defined(SHADOWS_CUBE)
vec3 u_xlat0;
mediump float u_xlat16_1;
vec2 u_xlat2;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
#else
vec2 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
#endif
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
#if defined(SHADOWS_CUBE)
mediump vec3 u_xlat16_5;
float u_xlat12;
#else
mediump float u_xlat16_11;
#endif
#else
#if defined(POINT_COOKIE)
#if defined(SHADOWS_CUBE)
vec3 u_xlat0;
float u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_7;
#else
vec2 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
#endif
float u_xlat10;
#if defined(SHADOWS_CUBE)
float u_xlat15;
#else
mediump float u_xlat16_11;
#endif
#else
vec4 u_xlat0;
#if !defined(SHADOWS_DEPTH)
mediump float u_xlat16_0;
#endif
vec2 u_xlat1;
#if defined(SHADOWS_DEPTH)
bool u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
#else
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
#endif
mediump float u_xlat16_4;
#if defined(SHADOWS_DEPTH)
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_7;
float u_xlat15;
#else
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
float u_xlat11;
mediump float u_xlat16_18;
#endif
#endif
#endif
#endif
#endif
void main()
{
#if defined(DIRECTIONAL)
    u_xlat16_0 = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat0.x = u_xlat16_0;
    u_xlat0.y = (-_Glossiness) + 1.0;
#if defined(SHADOWS_SCREEN)
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat1.x = u_xlat1.x * 16.0;
#else
    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat1 = u_xlat1 * 16.0;
#endif
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = _Color.xyz * u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
#if defined(SHADOWS_SCREEN)
    u_xlat16_2.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
#else
    u_xlat16_2.xyz = vec3(u_xlat1) * u_xlat16_2.xyz;
#endif
    u_xlat16_11 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(u_xlat16_11) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
#if defined(SHADOWS_SCREEN)
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
    u_xlat1.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat4.x = (-_LightShadowData.x) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat4.x + _LightShadowData.x;
#endif
    u_xlat16_11 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#if defined(SHADOWS_SCREEN)
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
#endif
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
#else
#if defined(DIRECTIONAL_COOKIE)
    u_xlat16_0 = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat0.x = u_xlat16_0;
    u_xlat0.y = (-_Glossiness) + 1.0;
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat1.x = u_xlat1.x * 16.0;
#if defined(SHADOWS_SCREEN)
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = _Color.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat5.xyz = u_xlat16_5.xyz * _Color.xyz;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat16_15) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _LightColor0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
    u_xlat1.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.x = (-_LightShadowData.x) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat5.x + _LightShadowData.x;
    u_xlat5.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat5.xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat5.xy;
    u_xlat5.xy = u_xlat5.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat5.x = texture(_LightTexture0, u_xlat5.xy).w;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat16_15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
    u_xlat16_15 = u_xlat1.x * u_xlat16_15;
    SV_Target0.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
#else
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = _Color.xyz * u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat16_11 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(u_xlat16_11) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat1.x = texture(_LightTexture0, u_xlat1.xy).w;
    u_xlat16_11 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
#endif
#else
#if defined(POINT)
#if defined(SHADOWS_CUBE)
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-_LightPositionRange.xyz);
    u_xlat12 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat12 = max(abs(u_xlat0.z), u_xlat12);
    u_xlat12 = u_xlat12 + (-_LightProjectionParams.z);
    u_xlat12 = max(u_xlat12, 9.99999975e-06);
    u_xlat12 = u_xlat12 * _LightProjectionParams.w;
    u_xlat12 = _LightProjectionParams.y / u_xlat12;
    u_xlat12 = u_xlat12 + (-_LightProjectionParams.x);
    vec4 txVec0 = vec4(u_xlat0.xyz,u_xlat12);
    u_xlat0.x = texture(hlslcc_zcmp_ShadowMapTexture, txVec0);
    u_xlat4.x = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat4.x + _LightShadowData.x;
    u_xlat4.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat4.x = texture(_LightTexture0, u_xlat4.xx).x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat16_1 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_1 = u_xlat0.x * u_xlat16_1;
    u_xlat16_5.x = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_2 = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat2.x = u_xlat16_2;
    u_xlat2.y = (-_Glossiness) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat2.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
#else
    u_xlat16_0 = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat0.x = u_xlat16_0;
    u_xlat0.y = (-_Glossiness) + 1.0;
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat1.x = u_xlat1.x * 16.0;
#endif
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#if defined(SHADOWS_CUBE)
    u_xlat16_5.xyz = _Color.xyz * u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
#else
    u_xlat16_2.xyz = _Color.xyz * u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
#endif
    u_xlat4.xyz = u_xlat16_4.xyz * _Color.xyz;
#if defined(SHADOWS_CUBE)
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_3 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = u_xlat4.xyz * vec3(u_xlat16_3) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz;
#else
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat16_11 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(u_xlat16_11) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = texture(_LightTexture0, u_xlat1.xx).x;
    u_xlat16_11 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
#endif
#else
#if defined(POINT_COOKIE)
#if defined(SHADOWS_CUBE)
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-_LightPositionRange.xyz);
    u_xlat15 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat15 = max(abs(u_xlat0.z), u_xlat15);
    u_xlat15 = u_xlat15 + (-_LightProjectionParams.z);
    u_xlat15 = max(u_xlat15, 9.99999975e-06);
    u_xlat15 = u_xlat15 * _LightProjectionParams.w;
    u_xlat15 = _LightProjectionParams.y / u_xlat15;
    u_xlat15 = u_xlat15 + (-_LightProjectionParams.x);
    vec4 txVec0 = vec4(u_xlat0.xyz,u_xlat15);
    u_xlat0.x = texture(hlslcc_zcmp_ShadowMapTexture, txVec0);
    u_xlat5.x = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + _LightShadowData.x;
    u_xlat5.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat1 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.x = texture(_LightTexture0, u_xlat5.xyz).w;
    u_xlat10 = texture(_LightTextureB0, vec2(u_xlat1)).x;
    u_xlat5.x = u_xlat5.x * u_xlat10;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat16_2 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_2 = u_xlat0.x * u_xlat16_2;
    u_xlat16_7.x = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_3 = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat3.x = u_xlat16_3;
    u_xlat3.y = (-_Glossiness) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat3.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = _Color.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat5.xyz = u_xlat16_5.xyz * _Color.xyz;
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz;
    u_xlat16_4 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat16_4) + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _LightColor0.xyz;
    SV_Target0.xyz = vec3(u_xlat16_2) * u_xlat16_7.xyz;
#else
    u_xlat16_0 = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat0.x = u_xlat16_0;
    u_xlat0.y = (-_Glossiness) + 1.0;
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = _Color.xyz * u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat16_11 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(u_xlat16_11) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = texture(_LightTexture0, u_xlat1.xyz).w;
    u_xlat4.x = texture(_LightTextureB0, vec2(u_xlat10)).x;
    u_xlat1.x = u_xlat1.x * u_xlat4.x;
    u_xlat16_11 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
#endif
#else
#if !defined(SHADOWS_DEPTH)
    u_xlat16_0 = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat0.x = u_xlat16_0;
    u_xlat0.y = (-_Glossiness) + 1.0;
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = _Color.xyz * u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_18 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.xyz = u_xlat6.xyz * vec3(u_xlat16_18) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _LightColor0.xyz;
#endif
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
#if defined(SHADOWS_DEPTH)
    u_xlat15 = texture(_LightTexture0, u_xlat1.xy).w;
    u_xlatb1 = 0.0<u_xlat0.z;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).x;
    u_xlat16_2 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2 = u_xlat15 * u_xlat16_2;
    u_xlat16_2 = u_xlat0.x * u_xlat16_2;
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToShadow[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToShadow[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToShadow[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.x = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + _LightShadowData.x;
    u_xlat16_2 = u_xlat0.x * u_xlat16_2;
    u_xlat16_7.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_2 = u_xlat16_7.x * u_xlat16_2;
    u_xlat16_7.x = dot(vs_TEXCOORD2.yzw, vs_TEXCOORD3.xyz);
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_3 = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat3.x = u_xlat16_3;
    u_xlat3.y = (-_Glossiness) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat3.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = _Color.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat5.xyz = u_xlat16_5.xyz * _Color.xyz;
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz;
    u_xlat16_4 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat16_4) + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _LightColor0.xyz;
    SV_Target0.xyz = vec3(u_xlat16_2) * u_xlat16_7.xyz;
#else
    u_xlat1.x = texture(_LightTexture0, u_xlat1.xy).w;
    u_xlatb6 = 0.0<u_xlat0.z;
    u_xlat11 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = texture(_LightTextureB0, vec2(u_xlat11)).x;
    u_xlat16_18 = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_18 = u_xlat1.x * u_xlat16_18;
    u_xlat16_18 = u_xlat11 * u_xlat16_18;
    u_xlat16_4 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat16_18 = u_xlat16_18 * u_xlat16_4;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz;
#endif
#endif
#endif
#endif
#endif
    SV_Target0.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
	}
	Fallback "VertexLit"
}
