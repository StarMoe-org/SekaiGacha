// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sandbox/Particles/StandardSurface"
{
	Properties
	{
		_MainTex("Albedo", 2D) = "white" {}
		_Color("Color", Color) = (1, 1, 1, 1)
		_Cutoff("Alpha Cutoff", Range(0, 1)) = 0.5
		_MetallicGlossMap("Metallic", 2D) = "white" {}
		[Gamma] _Metallic("Metallic", Range(0, 1)) = 0
		_Glossiness("Smoothness", Range(0, 1)) = 0.5
		_BumpScale("Scale", Float) = 1
		_BumpMap("Normal Map", 2D) = "bump" {}
		_EmissionColor("Color", Color) = (0, 0, 0, 1)
		_EmissionMap("Emission", 2D) = "white" {}
		_DistortionStrength("Strength", Float) = 1
		_DistortionBlend("Blend", Range(0, 1)) = 0.5
		_SoftParticlesNearFadeDistance("Soft Particles Near Fade", Float) = 0
		_SoftParticlesFarFadeDistance("Soft Particles Far Fade", Float) = 1
		_CameraNearFadeDistance("Camera Near Fade", Float) = 1
		_CameraFarFadeDistance("Camera Far Fade", Float) = 2
		[HideInInspector] _Mode("__mode", Float) = 0
		[HideInInspector] _FlipbookMode("__flipbookmode", Float) = 0
		[HideInInspector] _LightingEnabled("__lightingenabled", Float) = 1
		[HideInInspector] _DistortionEnabled("__distortionenabled", Float) = 0
		[HideInInspector] _EmissionEnabled("__emissionenabled", Float) = 0
		[HideInInspector] _BlendOp("__blendop", Float) = 0
		[HideInInspector] _SrcBlend("__src", Float) = 1
		[HideInInspector] _DstBlend("__dst", Float) = 0
		[HideInInspector] _ZWrite("__zw", Float) = 1
		[HideInInspector] _Cull("__cull", Float) = 2
		[HideInInspector] _SoftParticlesEnabled("__softparticlesenabled", Float) = 0
		[HideInInspector] _CameraFadingEnabled("__camerafadingenabled", Float) = 0
		[HideInInspector] _SoftParticleFadeParams("__softparticlefadeparams", Vector) = (0, 0, 0, 0)
		[HideInInspector] _CameraFadeParams("__camerafadeparams", Vector) = (0, 0, 0, 0)
		[HideInInspector] _DistortionStrengthScaled("__distortionstrengthscaled", Float) = 0
	}
	SubShader
	{
		Tags { "IGNOREPROJECTOR"="true" "PerformanceChecks"="False" "PreviewType"="Plane" "RenderType"="Opaque" }
		GrabPass { "_GrabTexture" }
		Pass
		{
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="FORWARDBASE" "PerformanceChecks"="False" "PreviewType"="Plane" "RenderType"="Opaque" "SHADOWSUPPORT"="true" }
			Blend [_SrcBlend] [_DstBlend], [_SrcBlend] [_DstBlend]
			BlendOp [_BlendOp], [_BlendOp]
			ZWrite [_ZWrite]
			Cull [_Cull]
			GLSLPROGRAM
#pragma multi_compile _ DIRECTIONAL
#pragma multi_compile _ LIGHTPROBE_SH
#pragma multi_compile _ SHADOWS_SCREEN
#pragma multi_compile _ SOFTPARTICLES_ON
#pragma multi_compile _ VERTEXLIGHT_ON
#pragma multi_compile _ INSTANCING_ON PROCEDURAL_INSTANCING_ON
#ifdef VERTEX
#version 310 es
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
#if defined(SOFTPARTICLES_ON)
uniform 	vec4 _ProjectionParams;
#endif
#if defined(VERTEXLIGHT_ON)
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
#endif
#if defined(LIGHTPROBE_SH)
#if !defined(INSTANCING_ON)
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
#if !defined(PROCEDURAL_INSTANCING_ON)
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
#endif
#endif
#else
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
#if !defined(INSTANCING_ON)
#if !defined(PROCEDURAL_INSTANCING_ON)
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
#endif
#endif
#endif
#if defined(SOFTPARTICLES_ON)
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if defined(INSTANCING_ON)
uniform 	int unity_BaseInstanceID;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
#endif
#endif
uniform 	vec4 _MainTex_ST;
#if defined(LIGHTPROBE_SH)
#if defined(INSTANCING_ON)
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type                unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
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
#else
#if defined(PROCEDURAL_INSTANCING_ON)
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};
layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
#endif
#endif
#else
#if defined(INSTANCING_ON)
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type                unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#else
#if defined(PROCEDURAL_INSTANCING_ON)
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};
layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
#endif
#endif
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
#if defined(LIGHTPROBE_SH)
#if defined(SOFTPARTICLES_ON)
#if defined(VERTEXLIGHT_ON)
#if defined(INSTANCING_ON)
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) out highp vec3 vs_TEXCOORD0;
layout(location = 1) out highp vec3 vs_TEXCOORD1;
layout(location = 2) out mediump vec4 vs_COLOR0;
layout(location = 3) out highp vec2 vs_TEXCOORD2;
layout(location = 5) out highp vec4 vs_TEXCOORD3;
layout(location = 4) out mediump vec3 vs_TEXCOORD4;
layout(location = 6) out highp vec4 vs_TEXCOORD6;
layout(location = 7) flat out highp uint vs_SV_InstanceID0;
#else
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
#endif
#endif
vec4 u_xlat0;
#if defined(INSTANCING_ON)
int u_xlati0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
mediump vec4 u_xlat16_0;
#endif
#endif
#else
#if defined(INSTANCING_ON)
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
int u_xlati0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) out highp vec3 vs_TEXCOORD0;
layout(location = 1) out highp vec3 vs_TEXCOORD1;
layout(location = 2) out mediump vec4 vs_COLOR0;
layout(location = 3) out highp vec2 vs_TEXCOORD2;
layout(location = 5) out highp vec4 vs_TEXCOORD3;
layout(location = 4) out mediump vec3 vs_TEXCOORD4;
layout(location = 6) out highp vec4 vs_TEXCOORD6;
layout(location = 7) flat out highp uint vs_SV_InstanceID0;
#else
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
#endif
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
#endif
#endif
vec4 u_xlat1;
#if defined(VERTEXLIGHT_ON)
#if !defined(INSTANCING_ON)
#if defined(PROCEDURAL_INSTANCING_ON)
int u_xlati1;
#endif
#endif
#else
#if defined(INSTANCING_ON)
mediump vec4 u_xlat16_1;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
int u_xlati1;
#endif
#endif
#endif
vec4 u_xlat2;
#if defined(VERTEXLIGHT_ON)
#if defined(INSTANCING_ON)
mediump vec4 u_xlat16_2;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
uvec2 u_xlatu2;
bool u_xlatb2;
#else
mediump vec4 u_xlat16_2;
#endif
#endif
vec4 u_xlat3;
#if defined(INSTANCING_ON)
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
int u_xlati6;
float u_xlat19;
#else
vec4 u_xlat4;
#if defined(PROCEDURAL_INSTANCING_ON)
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
#else
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
#endif
float u_xlat21;
#if defined(PROCEDURAL_INSTANCING_ON)
float u_xlat31;
uint u_xlatu31;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#endif
#endif
#else
#if defined(INSTANCING_ON)
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
int u_xlati5;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
float u_xlat19;
float u_xlat28;
uint u_xlatu28;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#else
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
#endif
#endif
#endif
#else
#if defined(VERTEXLIGHT_ON)
#if defined(INSTANCING_ON)
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) out highp vec3 vs_TEXCOORD0;
layout(location = 1) out highp vec3 vs_TEXCOORD1;
layout(location = 2) out mediump vec4 vs_COLOR0;
layout(location = 3) out highp vec2 vs_TEXCOORD2;
layout(location = 4) out mediump vec3 vs_TEXCOORD3;
layout(location = 5) out highp vec4 vs_TEXCOORD5;
layout(location = 6) flat out highp uint vs_SV_InstanceID0;
#else
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
#endif
#endif
vec4 u_xlat0;
#if defined(INSTANCING_ON)
int u_xlati0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
mediump vec4 u_xlat16_0;
#endif
#endif
vec4 u_xlat1;
#if !defined(INSTANCING_ON)
#if defined(PROCEDURAL_INSTANCING_ON)
int u_xlati1;
#else
mediump vec4 u_xlat16_1;
#endif
#endif
vec4 u_xlat2;
#if defined(INSTANCING_ON)
mediump vec4 u_xlat16_2;
#endif
vec4 u_xlat3;
#if defined(INSTANCING_ON)
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
int u_xlati6;
#else
vec4 u_xlat4;
#if defined(PROCEDURAL_INSTANCING_ON)
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
uvec2 u_xlatu11;
#else
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
#endif
float u_xlat21;
#if defined(PROCEDURAL_INSTANCING_ON)
float u_xlat30;
uint u_xlatu30;
bool u_xlatb30;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#endif
#endif
#else
#if defined(INSTANCING_ON)
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
int u_xlati5;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) out highp vec3 vs_TEXCOORD0;
layout(location = 1) out highp vec3 vs_TEXCOORD1;
layout(location = 2) out mediump vec4 vs_COLOR0;
layout(location = 3) out highp vec2 vs_TEXCOORD2;
layout(location = 4) out mediump vec3 vs_TEXCOORD3;
layout(location = 5) out highp vec4 vs_TEXCOORD5;
layout(location = 6) flat out highp uint vs_SV_InstanceID0;
#else
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
#endif
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
#if defined(PROCEDURAL_INSTANCING_ON)
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
uvec2 u_xlatu10;
float u_xlat19;
float u_xlat27;
uint u_xlatu27;
bool u_xlatb27;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#else
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
#endif
#endif
#endif
#endif
#else
#if defined(SOFTPARTICLES_ON)
#if defined(VERTEXLIGHT_ON)
#if defined(INSTANCING_ON)
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) out highp vec3 vs_TEXCOORD0;
layout(location = 1) out highp vec3 vs_TEXCOORD1;
layout(location = 2) out mediump vec4 vs_COLOR0;
layout(location = 3) out highp vec2 vs_TEXCOORD2;
layout(location = 5) out highp vec4 vs_TEXCOORD3;
layout(location = 4) out mediump vec3 vs_TEXCOORD4;
layout(location = 6) out highp vec4 vs_TEXCOORD6;
layout(location = 7) flat out highp uint vs_SV_InstanceID0;
#else
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
#endif
#endif
vec4 u_xlat0;
#if defined(INSTANCING_ON)
int u_xlati0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
mediump vec4 u_xlat16_0;
#endif
#endif
#else
#if defined(INSTANCING_ON)
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) out highp vec3 vs_TEXCOORD0;
layout(location = 1) out highp vec3 vs_TEXCOORD1;
layout(location = 2) out mediump vec4 vs_COLOR0;
layout(location = 3) out highp vec2 vs_TEXCOORD2;
layout(location = 5) out highp vec4 vs_TEXCOORD3;
layout(location = 4) out mediump vec3 vs_TEXCOORD4;
layout(location = 6) out highp vec4 vs_TEXCOORD6;
layout(location = 7) flat out highp uint vs_SV_InstanceID0;
#else
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
#endif
vec4 u_xlat0;
#endif
mediump vec4 u_xlat16_0;
#if defined(INSTANCING_ON)
int u_xlati0;
#endif
#endif
vec4 u_xlat1;
#if defined(VERTEXLIGHT_ON)
#if defined(INSTANCING_ON)
mediump vec4 u_xlat16_1;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
int u_xlati1;
#endif
#endif
#else
#if !defined(INSTANCING_ON)
#if defined(PROCEDURAL_INSTANCING_ON)
int u_xlati1;
#endif
#endif
#endif
vec4 u_xlat2;
#if defined(VERTEXLIGHT_ON)
#if !defined(INSTANCING_ON)
#if defined(PROCEDURAL_INSTANCING_ON)
uvec2 u_xlatu2;
bool u_xlatb2;
#else
mediump vec4 u_xlat16_2;
#endif
#endif
vec4 u_xlat3;
vec4 u_xlat4;
#if defined(INSTANCING_ON)
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
#else
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
#endif
float u_xlat21;
#if defined(PROCEDURAL_INSTANCING_ON)
float u_xlat31;
uint u_xlatu31;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#endif
#endif
#else
#if defined(INSTANCING_ON)
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
float u_xlat19;
float u_xlat28;
uint u_xlatu28;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#else
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
#endif
#endif
#endif
#else
#if defined(VERTEXLIGHT_ON)
#if defined(INSTANCING_ON)
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) out highp vec3 vs_TEXCOORD0;
layout(location = 1) out highp vec3 vs_TEXCOORD1;
layout(location = 2) out mediump vec4 vs_COLOR0;
layout(location = 3) out highp vec2 vs_TEXCOORD2;
layout(location = 4) out mediump vec3 vs_TEXCOORD3;
layout(location = 5) out highp vec4 vs_TEXCOORD5;
layout(location = 6) flat out highp uint vs_SV_InstanceID0;
#else
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
#endif
#endif
vec4 u_xlat0;
#if defined(INSTANCING_ON)
int u_xlati0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
mediump vec4 u_xlat16_0;
#endif
#endif
vec4 u_xlat1;
#if defined(INSTANCING_ON)
mediump vec4 u_xlat16_1;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
int u_xlati1;
#else
mediump vec4 u_xlat16_1;
#endif
#endif
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
#if defined(INSTANCING_ON)
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
uvec2 u_xlatu11;
#else
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
#endif
float u_xlat21;
#if defined(PROCEDURAL_INSTANCING_ON)
float u_xlat30;
uint u_xlatu30;
bool u_xlatb30;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#endif
#endif
#else
#if defined(INSTANCING_ON)
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) out highp vec3 vs_TEXCOORD0;
layout(location = 1) out highp vec3 vs_TEXCOORD1;
layout(location = 2) out mediump vec4 vs_COLOR0;
layout(location = 3) out highp vec2 vs_TEXCOORD2;
layout(location = 4) out mediump vec3 vs_TEXCOORD3;
layout(location = 5) out highp vec4 vs_TEXCOORD5;
layout(location = 6) flat out highp uint vs_SV_InstanceID0;
#else
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
#endif
vec4 u_xlat0;
#endif
mediump vec4 u_xlat16_0;
#if defined(INSTANCING_ON)
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
uvec2 u_xlatu10;
float u_xlat19;
float u_xlat27;
uint u_xlatu27;
bool u_xlatb27;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#else
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
#endif
#endif
#endif
#endif
#endif
void main()
{
#if defined(LIGHTPROBE_SH)
#if defined(SOFTPARTICLES_ON)
#if defined(VERTEXLIGHT_ON)
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlati0 = u_xlati0 * 7;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat3.xyz;
    vs_TEXCOORD0.xyz = u_xlat6.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat19 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat19 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat19;
    u_xlat19 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat19;
    u_xlat19 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat19;
    vs_TEXCOORD3.z = (-u_xlat19);
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat2.zzz + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixVP[3].xyw * u_xlat2.www + u_xlat2.xyz;
    u_xlat3.xz = u_xlat2.xz * vec2(0.5, 0.5);
    u_xlat19 = u_xlat2.y * _ProjectionParams.x;
    vs_TEXCOORD3.w = u_xlat2.z;
    u_xlat3.w = u_xlat19 * 0.5;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat16_4.x = u_xlat6.y * u_xlat6.y;
    u_xlat16_4.x = u_xlat6.x * u_xlat6.x + (-u_xlat16_4.x);
    u_xlat16_2 = u_xlat6.yzzx * u_xlat6.xyzz;
    u_xlat16_5.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBrArray, u_xlat16_2);
    u_xlat16_5.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBgArray, u_xlat16_2);
    u_xlat16_5.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBbArray, u_xlat16_2);
    u_xlat16_4.xyz = unity_Builtins2Array[u_xlati0 / 7].unity_SHCArray.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
    u_xlat2 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat6.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat5 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat5 * u_xlat6.xxxx + u_xlat3;
    u_xlat0 = u_xlat1 * u_xlat6.zzzz + u_xlat3;
    u_xlat2 = u_xlat5 * u_xlat5 + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat1 * u_xlat0;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_4.xyz;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat3.w = u_xlat2.y;
    u_xlat11.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat11.y;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]));
    u_xlat3.z = u_xlat4.x;
    u_xlat5.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.x = u_xlat5.z;
    u_xlat21 = dot(u_xlat3, u_xlat0);
    u_xlat6.y = dot(u_xlat3, in_POSITION0);
    u_xlat7 = vec4(u_xlat21) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.w = u_xlat2.x;
    u_xlat5.z = u_xlat4.y;
    u_xlat4.x = u_xlat5.y;
    u_xlat4.y = u_xlat11.x;
    u_xlat5.y = u_xlat11.z;
    u_xlat11.x = dot(u_xlat4, u_xlat0);
    u_xlat6.x = dot(u_xlat4, in_POSITION0);
    u_xlat7 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat11.xxxx + u_xlat7;
    u_xlat5.w = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5, u_xlat0);
    u_xlat6.z = dot(u_xlat5, in_POSITION0);
    u_xlat7 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat7;
    gl_Position = u_xlat7 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat10.xyz = u_xlat4.yzx * u_xlat5.zxy;
    u_xlat10.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat10.xyz);
    u_xlat2.xyz = u_xlat3.zxy * u_xlat5.yzx;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat5.zxy + (-u_xlat2.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat31 = float(1.0) / float(u_xlat31);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat31);
    u_xlat5.y = dot(in_NORMAL0.xyz, u_xlat10.xyz);
    u_xlat10.xyz = u_xlat3.yzx * u_xlat4.zxy;
    u_xlat10.xyz = u_xlat4.yzx * u_xlat3.zxy + (-u_xlat10.xyz);
    u_xlat10.xyz = vec3(u_xlat31) * u_xlat10.xyz;
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat5.x = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, u_xlat10.xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat5.xyz;
    vs_TEXCOORD0.xyz = u_xlat10.xyz;
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat3 = (-u_xlat6.xxxx) + unity_4LightPosX0;
    u_xlat4 = (-u_xlat6.yyyy) + unity_4LightPosY0;
    u_xlat5 = (-u_xlat6.zzzz) + unity_4LightPosZ0;
    u_xlat6 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat6 = vec4(unity_ParticleUseMeshColors) * u_xlat6 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu31 = uint(floatBitsToUint(u_xlat2.w)) & 255u;
    u_xlat7.x = float(u_xlatu31);
    u_xlatu2.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu31 = uint(floatBitsToUint(u_xlat2.w)) >> (24u & uint(0x1F));
    u_xlat7.w = float(u_xlatu31);
    u_xlat7.yz = vec2(u_xlatu2.xy);
    u_xlat2 = u_xlat6 * u_xlat7;
    u_xlat2 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    vs_COLOR0 = u_xlat2;
    u_xlat31 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat31 = floor(u_xlat31);
    u_xlat1.x = (-u_xlat31) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat2.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat1.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat2.y = (-u_xlat31) * unity_ParticleUVShiftData.w + u_xlat1.x;
    u_xlat1.xw = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat2.xy;
    u_xlatb2 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xw = (bool(u_xlatb2)) ? u_xlat1.xw : in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat1.xw * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat21 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.xyz = vec3(u_xlat21) * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat11.xxx + u_xlat2.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat11.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat1.x;
    u_xlat11.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat11.xyz = u_xlat11.xyz + hlslcc_mtx4x4unity_MatrixVP[3].xyw;
    u_xlat0.x = u_xlat1.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat11.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat0.x * 0.5;
    u_xlat2.xz = u_xlat11.xz * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat11.z;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = u_xlat10.yyyy * u_xlat4;
    u_xlat2 = u_xlat4 * u_xlat4;
    u_xlat2 = u_xlat3 * u_xlat3 + u_xlat2;
    u_xlat1 = u_xlat3 * u_xlat10.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat10.zzzz + u_xlat1;
    u_xlat2 = u_xlat5 * u_xlat5 + u_xlat2;
    u_xlat2 = max(u_xlat2, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat2);
    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat21;
    vs_TEXCOORD3.z = (-u_xlat21);
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat1.zzz + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[3].xyw * u_xlat1.www + u_xlat1.xyz;
    u_xlat3.xz = u_xlat1.xz * vec2(0.5, 0.5);
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD3.w = u_xlat1.z;
    u_xlat3.w = u_xlat21 * 0.5;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat2.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat4;
    u_xlat1 = u_xlat0 * u_xlat2.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
#endif
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_8.x = u_xlat10.y * u_xlat10.y;
    u_xlat16_8.x = u_xlat10.x * u_xlat10.x + (-u_xlat16_8.x);
    u_xlat16_0 = u_xlat10.yzzx * u_xlat10.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_8.xyz = unity_SHC.xyz * u_xlat16_8.xxx + u_xlat16_9.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_8.xyz;
#else
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_5.xyz;
#endif
#endif
#else
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlati0 = u_xlati0 * 7;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat5.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat1.x;
    vs_TEXCOORD3.z = (-u_xlat1.x);
    u_xlat1.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat2.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[3].xyw * u_xlat2.www + u_xlat1.xyz;
    u_xlat2.xz = u_xlat1.xz * vec2(0.5, 0.5);
    u_xlat1.x = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD3.w = u_xlat1.z;
    u_xlat2.w = u_xlat1.x * 0.5;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat3.w = u_xlat2.y;
    u_xlat10.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat10.y;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]));
    u_xlat3.z = u_xlat4.x;
    u_xlat5.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.x = u_xlat5.z;
    u_xlat19 = dot(u_xlat3, u_xlat0);
    vs_TEXCOORD1.y = dot(u_xlat3, in_POSITION0);
    u_xlat6 = vec4(u_xlat19) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.w = u_xlat2.x;
    u_xlat5.z = u_xlat4.y;
    u_xlat4.x = u_xlat5.y;
    u_xlat4.y = u_xlat10.x;
    u_xlat5.y = u_xlat10.z;
    u_xlat10.x = dot(u_xlat4, u_xlat0);
    vs_TEXCOORD1.x = dot(u_xlat4, in_POSITION0);
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat6;
    u_xlat5.w = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5, u_xlat0);
    vs_TEXCOORD1.z = dot(u_xlat5, in_POSITION0);
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat6;
    gl_Position = u_xlat6 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat9.xyz = u_xlat4.yzx * u_xlat5.zxy;
    u_xlat9.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat9.xyz);
    u_xlat2.xyz = u_xlat3.zxy * u_xlat5.yzx;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat5.zxy + (-u_xlat2.xyz);
    u_xlat28 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat28 = float(1.0) / float(u_xlat28);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat28);
    u_xlat5.y = dot(in_NORMAL0.xyz, u_xlat9.xyz);
    u_xlat9.xyz = u_xlat3.yzx * u_xlat4.zxy;
    u_xlat9.xyz = u_xlat4.yzx * u_xlat3.zxy + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat28) * u_xlat9.xyz;
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat5.x = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, u_xlat9.xyz);
    u_xlat9.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * u_xlat5.xyz;
    vs_TEXCOORD0.xyz = u_xlat9.xyz;
    u_xlat3 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = vec4(unity_ParticleUseMeshColors) * u_xlat3 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu28 = uint(floatBitsToUint(u_xlat2.w)) & 255u;
    u_xlat4.x = float(u_xlatu28);
    u_xlatu2.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu28 = uint(floatBitsToUint(u_xlat2.w)) >> (24u & uint(0x1F));
    u_xlat4.w = float(u_xlatu28);
    u_xlat4.yz = vec2(u_xlatu2.xy);
    u_xlat2 = u_xlat3 * u_xlat4;
    u_xlat2 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    vs_COLOR0 = u_xlat2;
    u_xlat28 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat28 = floor(u_xlat28);
    u_xlat1.x = (-u_xlat28) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat2.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat1.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat2.y = (-u_xlat28) * unity_ParticleUVShiftData.w + u_xlat1.x;
    u_xlat1.xw = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat2.xy;
    u_xlatb2 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xw = (bool(u_xlatb2)) ? u_xlat1.xw : in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat1.xw * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat19 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.xyz = vec3(u_xlat19) * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat10.xxx + u_xlat2.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat10.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat1.x;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat10.xyz = u_xlat10.xyz + hlslcc_mtx4x4unity_MatrixVP[3].xyw;
    u_xlat0.x = u_xlat1.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat10.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat0.x * 0.5;
    u_xlat2.xz = u_xlat10.xz * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat10.z;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD3.z = (-u_xlat15);
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[3].xyw * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xz = u_xlat1.xz * vec2(0.5, 0.5);
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD3.w = u_xlat1.z;
    u_xlat2.w = u_xlat15 * 0.5;
#endif
#endif
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
#if defined(INSTANCING_ON)
    u_xlat16_3 = u_xlat5.y * u_xlat5.y;
    u_xlat16_3 = u_xlat5.x * u_xlat5.x + (-u_xlat16_3);
    u_xlat16_1 = u_xlat5.yzzx * u_xlat5.xyzz;
    u_xlat16_4.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBrArray, u_xlat16_1);
    u_xlat16_4.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBgArray, u_xlat16_1);
    u_xlat16_4.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBbArray, u_xlat16_1);
    vs_TEXCOORD4.xyz = unity_Builtins2Array[u_xlati0 / 7].unity_SHCArray.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat16_7 = u_xlat9.y * u_xlat9.y;
    u_xlat16_7 = u_xlat9.x * u_xlat9.x + (-u_xlat16_7);
    u_xlat16_0 = u_xlat9.yzzx * u_xlat9.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_7) + u_xlat16_8.xyz;
#else
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
#endif
#endif
#endif
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
#else
#if defined(VERTEXLIGHT_ON)
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlati0 = u_xlati0 * 7;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat6.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_4.x = u_xlat6.y * u_xlat6.y;
    u_xlat16_4.x = u_xlat6.x * u_xlat6.x + (-u_xlat16_4.x);
    u_xlat16_2 = u_xlat6.yzzx * u_xlat6.xyzz;
    u_xlat16_5.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBrArray, u_xlat16_2);
    u_xlat16_5.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBgArray, u_xlat16_2);
    u_xlat16_5.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBbArray, u_xlat16_2);
    u_xlat16_4.xyz = unity_Builtins2Array[u_xlati0 / 7].unity_SHCArray.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
    u_xlat2 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat6.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat5 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat5 * u_xlat6.xxxx + u_xlat3;
    u_xlat0 = u_xlat1 * u_xlat6.zzzz + u_xlat3;
    u_xlat2 = u_xlat5 * u_xlat5 + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat1 * u_xlat0;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_4.xyz;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat3.w = u_xlat2.y;
    u_xlat11.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat11.y;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]));
    u_xlat3.z = u_xlat4.x;
    u_xlat5.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.x = u_xlat5.z;
    u_xlat21 = dot(u_xlat3, u_xlat0);
    u_xlat6.y = dot(u_xlat3, in_POSITION0);
    u_xlat7 = vec4(u_xlat21) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.w = u_xlat2.x;
    u_xlat5.z = u_xlat4.y;
    u_xlat4.x = u_xlat5.y;
    u_xlat4.y = u_xlat11.x;
    u_xlat5.y = u_xlat11.z;
    u_xlat11.x = dot(u_xlat4, u_xlat0);
    u_xlat6.x = dot(u_xlat4, in_POSITION0);
    u_xlat7 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat11.xxxx + u_xlat7;
    u_xlat5.w = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5, u_xlat0);
    u_xlat6.z = dot(u_xlat5, in_POSITION0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat7;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.xyz = u_xlat4.yzx * u_xlat5.zxy;
    u_xlat0.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat0.xyz);
    u_xlat11.xyz = u_xlat3.zxy * u_xlat5.yzx;
    u_xlat11.xyz = u_xlat3.yzx * u_xlat5.zxy + (-u_xlat11.xyz);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat11.xyz);
    u_xlat30 = float(1.0) / float(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat3.yzx * u_xlat4.zxy;
    u_xlat2.xyz = u_xlat4.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat11.xyz = vec3(u_xlat30) * u_xlat11.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat11.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat3 = (-u_xlat6.xxxx) + unity_4LightPosX0;
    u_xlat4 = (-u_xlat6.yyyy) + unity_4LightPosY0;
    u_xlat5 = (-u_xlat6.zzzz) + unity_4LightPosZ0;
    u_xlat6 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat6 = vec4(unity_ParticleUseMeshColors) * u_xlat6 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu30 = uint(floatBitsToUint(u_xlat2.w)) & 255u;
    u_xlat7.x = float(u_xlatu30);
    u_xlatu11.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu30 = uint(floatBitsToUint(u_xlat2.w)) >> (24u & uint(0x1F));
    u_xlat7.w = float(u_xlatu30);
    u_xlat7.yz = vec2(u_xlatu11.xy);
    u_xlat2 = u_xlat6 * u_xlat7;
    u_xlat2 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    vs_COLOR0 = u_xlat2;
    u_xlat30 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat30 = floor(u_xlat30);
    u_xlat1.x = (-u_xlat30) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat21 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat30) * unity_ParticleUVShiftData.w + u_xlat21;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb30 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb30)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * u_xlat4;
    u_xlat2 = u_xlat4 * u_xlat4;
    u_xlat2 = u_xlat3 * u_xlat3 + u_xlat2;
    u_xlat1 = u_xlat3 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat5 * u_xlat5 + u_xlat2;
    u_xlat2 = max(u_xlat2, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat2);
    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_8.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_8.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_8.x);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_8.xyz = unity_SHC.xyz * u_xlat16_8.xxx + u_xlat16_9.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_8.xyz;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
#endif
#endif
#else
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlati0 = u_xlati0 * 7;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat5.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3 = u_xlat5.y * u_xlat5.y;
    u_xlat16_3 = u_xlat5.x * u_xlat5.x + (-u_xlat16_3);
    u_xlat16_1 = u_xlat5.yzzx * u_xlat5.xyzz;
    u_xlat16_4.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBrArray, u_xlat16_1);
    u_xlat16_4.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBgArray, u_xlat16_1);
    u_xlat16_4.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBbArray, u_xlat16_1);
    vs_TEXCOORD3.xyz = unity_Builtins2Array[u_xlati0 / 7].unity_SHCArray.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat3.w = u_xlat2.y;
    u_xlat10.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat10.y;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]));
    u_xlat3.z = u_xlat4.x;
    u_xlat5.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.x = u_xlat5.z;
    u_xlat19 = dot(u_xlat3, u_xlat0);
    vs_TEXCOORD1.y = dot(u_xlat3, in_POSITION0);
    u_xlat6 = vec4(u_xlat19) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.w = u_xlat2.x;
    u_xlat5.z = u_xlat4.y;
    u_xlat4.x = u_xlat5.y;
    u_xlat4.y = u_xlat10.x;
    u_xlat5.y = u_xlat10.z;
    u_xlat10.x = dot(u_xlat4, u_xlat0);
    vs_TEXCOORD1.x = dot(u_xlat4, in_POSITION0);
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat6;
    u_xlat5.w = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5, u_xlat0);
    vs_TEXCOORD1.z = dot(u_xlat5, in_POSITION0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat6;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.xyz = u_xlat4.yzx * u_xlat5.zxy;
    u_xlat0.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat0.xyz);
    u_xlat10.xyz = u_xlat3.zxy * u_xlat5.yzx;
    u_xlat10.xyz = u_xlat3.yzx * u_xlat5.zxy + (-u_xlat10.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat10.xyz);
    u_xlat27 = float(1.0) / float(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat3.yzx * u_xlat4.zxy;
    u_xlat2.xyz = u_xlat4.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat10.xyz = vec3(u_xlat27) * u_xlat10.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat10.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat3 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = vec4(unity_ParticleUseMeshColors) * u_xlat3 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu27 = uint(floatBitsToUint(u_xlat2.w)) & 255u;
    u_xlat4.x = float(u_xlatu27);
    u_xlatu10.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu27 = uint(floatBitsToUint(u_xlat2.w)) >> (24u & uint(0x1F));
    u_xlat4.w = float(u_xlatu27);
    u_xlat4.yz = vec2(u_xlatu10.xy);
    u_xlat2 = u_xlat3 * u_xlat4;
    u_xlat2 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    vs_COLOR0 = u_xlat2;
    u_xlat27 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.x = (-u_xlat27) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat19 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat27) * unity_ParticleUVShiftData.w + u_xlat19;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb27 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb27)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_7 = u_xlat0.y * u_xlat0.y;
    u_xlat16_7 = u_xlat0.x * u_xlat0.x + (-u_xlat16_7);
#else
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
#endif
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_7) + u_xlat16_8.xyz;
#else
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
#endif
#endif
#endif
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
#endif
#else
#if defined(SOFTPARTICLES_ON)
#if defined(VERTEXLIGHT_ON)
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat2.zzz + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixVP[3].xyw * u_xlat2.www + u_xlat2.xyz;
    u_xlat3.xz = u_xlat2.xz * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    vs_TEXCOORD3.w = u_xlat2.z;
    u_xlat3.w = u_xlat0.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat2 = (-u_xlat7.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat7.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat7.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat3.w = u_xlat2.y;
    u_xlat11.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat11.y;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]));
    u_xlat3.z = u_xlat4.x;
    u_xlat5.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.x = u_xlat5.z;
    u_xlat21 = dot(u_xlat3, u_xlat0);
    u_xlat6.y = dot(u_xlat3, in_POSITION0);
    u_xlat7 = vec4(u_xlat21) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.w = u_xlat2.x;
    u_xlat5.z = u_xlat4.y;
    u_xlat4.x = u_xlat5.y;
    u_xlat4.y = u_xlat11.x;
    u_xlat5.y = u_xlat11.z;
    u_xlat11.x = dot(u_xlat4, u_xlat0);
    u_xlat6.x = dot(u_xlat4, in_POSITION0);
    u_xlat7 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat11.xxxx + u_xlat7;
    u_xlat5.w = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5, u_xlat0);
    u_xlat6.z = dot(u_xlat5, in_POSITION0);
    u_xlat7 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat7;
    gl_Position = u_xlat7 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat10.xyz = u_xlat4.yzx * u_xlat5.zxy;
    u_xlat10.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat10.xyz);
    u_xlat2.xyz = u_xlat3.zxy * u_xlat5.yzx;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat5.zxy + (-u_xlat2.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat31 = float(1.0) / float(u_xlat31);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat31);
    u_xlat5.y = dot(in_NORMAL0.xyz, u_xlat10.xyz);
    u_xlat10.xyz = u_xlat3.yzx * u_xlat4.zxy;
    u_xlat10.xyz = u_xlat4.yzx * u_xlat3.zxy + (-u_xlat10.xyz);
    u_xlat10.xyz = vec3(u_xlat31) * u_xlat10.xyz;
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat5.x = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, u_xlat10.xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat5.xyz;
    vs_TEXCOORD0.xyz = u_xlat10.xyz;
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat3 = (-u_xlat6.xxxx) + unity_4LightPosX0;
    u_xlat4 = (-u_xlat6.yyyy) + unity_4LightPosY0;
    u_xlat5 = (-u_xlat6.zzzz) + unity_4LightPosZ0;
    u_xlat6 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat6 = vec4(unity_ParticleUseMeshColors) * u_xlat6 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu31 = uint(floatBitsToUint(u_xlat2.w)) & 255u;
    u_xlat7.x = float(u_xlatu31);
    u_xlatu2.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu31 = uint(floatBitsToUint(u_xlat2.w)) >> (24u & uint(0x1F));
    u_xlat7.w = float(u_xlatu31);
    u_xlat7.yz = vec2(u_xlatu2.xy);
    u_xlat2 = u_xlat6 * u_xlat7;
    u_xlat2 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    vs_COLOR0 = u_xlat2;
    u_xlat31 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat31 = floor(u_xlat31);
    u_xlat1.x = (-u_xlat31) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat2.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat1.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat2.y = (-u_xlat31) * unity_ParticleUVShiftData.w + u_xlat1.x;
    u_xlat1.xw = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat2.xy;
    u_xlatb2 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xw = (bool(u_xlatb2)) ? u_xlat1.xw : in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat1.xw * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat21 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.xyz = vec3(u_xlat21) * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat11.xxx + u_xlat2.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat11.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat1.x;
    u_xlat11.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat11.xyz = u_xlat11.xyz + hlslcc_mtx4x4unity_MatrixVP[3].xyw;
    u_xlat0.x = u_xlat1.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat11.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat0.x * 0.5;
    u_xlat2.xz = u_xlat11.xz * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat11.z;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = u_xlat10.yyyy * u_xlat4;
    u_xlat2 = u_xlat4 * u_xlat4;
    u_xlat2 = u_xlat3 * u_xlat3 + u_xlat2;
    u_xlat1 = u_xlat3 * u_xlat10.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat10.zzzz + u_xlat1;
    u_xlat2 = u_xlat5 * u_xlat5 + u_xlat2;
    u_xlat2 = max(u_xlat2, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat2);
    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat21;
    vs_TEXCOORD3.z = (-u_xlat21);
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat1.zzz + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[3].xyw * u_xlat1.www + u_xlat1.xyz;
    u_xlat3.xz = u_xlat1.xz * vec2(0.5, 0.5);
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD3.w = u_xlat1.z;
    u_xlat3.w = u_xlat21 * 0.5;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat2.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat4;
    u_xlat1 = u_xlat0 * u_xlat2.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
#endif
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_8.x = u_xlat10.y * u_xlat10.y;
    u_xlat16_8.x = u_xlat10.x * u_xlat10.x + (-u_xlat16_8.x);
    u_xlat16_0 = u_xlat10.yzzx * u_xlat10.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_8.xyz = unity_SHC.xyz * u_xlat16_8.xxx + u_xlat16_9.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_8.xyz;
#else
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_5.xyz;
#endif
#endif
#else
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat15 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat15;
    vs_TEXCOORD3.z = (-u_xlat15);
    u_xlat1.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat2.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[3].xyw * u_xlat2.www + u_xlat1.xyz;
    u_xlat2.xz = u_xlat1.xz * vec2(0.5, 0.5);
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD3.w = u_xlat1.z;
    u_xlat2.w = u_xlat15 * 0.5;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat3.w = u_xlat2.y;
    u_xlat10.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat10.y;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]));
    u_xlat3.z = u_xlat4.x;
    u_xlat5.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.x = u_xlat5.z;
    u_xlat19 = dot(u_xlat3, u_xlat0);
    vs_TEXCOORD1.y = dot(u_xlat3, in_POSITION0);
    u_xlat6 = vec4(u_xlat19) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.w = u_xlat2.x;
    u_xlat5.z = u_xlat4.y;
    u_xlat4.x = u_xlat5.y;
    u_xlat4.y = u_xlat10.x;
    u_xlat5.y = u_xlat10.z;
    u_xlat10.x = dot(u_xlat4, u_xlat0);
    vs_TEXCOORD1.x = dot(u_xlat4, in_POSITION0);
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat6;
    u_xlat5.w = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5, u_xlat0);
    vs_TEXCOORD1.z = dot(u_xlat5, in_POSITION0);
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat6;
    gl_Position = u_xlat6 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat9.xyz = u_xlat4.yzx * u_xlat5.zxy;
    u_xlat9.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat9.xyz);
    u_xlat2.xyz = u_xlat3.zxy * u_xlat5.yzx;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat5.zxy + (-u_xlat2.xyz);
    u_xlat28 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat28 = float(1.0) / float(u_xlat28);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat28);
    u_xlat5.y = dot(in_NORMAL0.xyz, u_xlat9.xyz);
    u_xlat9.xyz = u_xlat3.yzx * u_xlat4.zxy;
    u_xlat9.xyz = u_xlat4.yzx * u_xlat3.zxy + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat28) * u_xlat9.xyz;
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat5.x = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, u_xlat9.xyz);
    u_xlat9.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * u_xlat5.xyz;
    vs_TEXCOORD0.xyz = u_xlat9.xyz;
    u_xlat3 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = vec4(unity_ParticleUseMeshColors) * u_xlat3 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu28 = uint(floatBitsToUint(u_xlat2.w)) & 255u;
    u_xlat4.x = float(u_xlatu28);
    u_xlatu2.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu28 = uint(floatBitsToUint(u_xlat2.w)) >> (24u & uint(0x1F));
    u_xlat4.w = float(u_xlatu28);
    u_xlat4.yz = vec2(u_xlatu2.xy);
    u_xlat2 = u_xlat3 * u_xlat4;
    u_xlat2 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    vs_COLOR0 = u_xlat2;
    u_xlat28 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat28 = floor(u_xlat28);
    u_xlat1.x = (-u_xlat28) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat2.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat1.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat2.y = (-u_xlat28) * unity_ParticleUVShiftData.w + u_xlat1.x;
    u_xlat1.xw = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat2.xy;
    u_xlatb2 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xw = (bool(u_xlatb2)) ? u_xlat1.xw : in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat1.xw * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat19 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.xyz = vec3(u_xlat19) * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat10.xxx + u_xlat2.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat10.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat1.x;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat10.xyz = u_xlat10.xyz + hlslcc_mtx4x4unity_MatrixVP[3].xyw;
    u_xlat0.x = u_xlat1.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat10.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat0.x * 0.5;
    u_xlat2.xz = u_xlat10.xz * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat10.z;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD3.z = (-u_xlat15);
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[3].xyw * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xz = u_xlat1.xz * vec2(0.5, 0.5);
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD3.w = u_xlat1.z;
    u_xlat2.w = u_xlat15 * 0.5;
#endif
#endif
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
#if defined(INSTANCING_ON)
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat16_7 = u_xlat9.y * u_xlat9.y;
    u_xlat16_7 = u_xlat9.x * u_xlat9.x + (-u_xlat16_7);
    u_xlat16_0 = u_xlat9.yzzx * u_xlat9.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_7) + u_xlat16_8.xyz;
#else
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
#endif
#endif
#endif
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
#else
#if defined(VERTEXLIGHT_ON)
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat7.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat7.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat7.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat3.w = u_xlat2.y;
    u_xlat11.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat11.y;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]));
    u_xlat3.z = u_xlat4.x;
    u_xlat5.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.x = u_xlat5.z;
    u_xlat21 = dot(u_xlat3, u_xlat0);
    u_xlat6.y = dot(u_xlat3, in_POSITION0);
    u_xlat7 = vec4(u_xlat21) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.w = u_xlat2.x;
    u_xlat5.z = u_xlat4.y;
    u_xlat4.x = u_xlat5.y;
    u_xlat4.y = u_xlat11.x;
    u_xlat5.y = u_xlat11.z;
    u_xlat11.x = dot(u_xlat4, u_xlat0);
    u_xlat6.x = dot(u_xlat4, in_POSITION0);
    u_xlat7 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat11.xxxx + u_xlat7;
    u_xlat5.w = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5, u_xlat0);
    u_xlat6.z = dot(u_xlat5, in_POSITION0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat7;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.xyz = u_xlat4.yzx * u_xlat5.zxy;
    u_xlat0.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat0.xyz);
    u_xlat11.xyz = u_xlat3.zxy * u_xlat5.yzx;
    u_xlat11.xyz = u_xlat3.yzx * u_xlat5.zxy + (-u_xlat11.xyz);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat11.xyz);
    u_xlat30 = float(1.0) / float(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat3.yzx * u_xlat4.zxy;
    u_xlat2.xyz = u_xlat4.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat11.xyz = vec3(u_xlat30) * u_xlat11.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat11.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat3 = (-u_xlat6.xxxx) + unity_4LightPosX0;
    u_xlat4 = (-u_xlat6.yyyy) + unity_4LightPosY0;
    u_xlat5 = (-u_xlat6.zzzz) + unity_4LightPosZ0;
    u_xlat6 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat6 = vec4(unity_ParticleUseMeshColors) * u_xlat6 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu30 = uint(floatBitsToUint(u_xlat2.w)) & 255u;
    u_xlat7.x = float(u_xlatu30);
    u_xlatu11.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu30 = uint(floatBitsToUint(u_xlat2.w)) >> (24u & uint(0x1F));
    u_xlat7.w = float(u_xlatu30);
    u_xlat7.yz = vec2(u_xlatu11.xy);
    u_xlat2 = u_xlat6 * u_xlat7;
    u_xlat2 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    vs_COLOR0 = u_xlat2;
    u_xlat30 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat30 = floor(u_xlat30);
    u_xlat1.x = (-u_xlat30) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat21 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat30) * unity_ParticleUVShiftData.w + u_xlat21;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb30 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb30)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * u_xlat4;
    u_xlat2 = u_xlat4 * u_xlat4;
    u_xlat2 = u_xlat3 * u_xlat3 + u_xlat2;
    u_xlat1 = u_xlat3 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat5 * u_xlat5 + u_xlat2;
    u_xlat2 = max(u_xlat2, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat2);
    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_8.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_8.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_8.x);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_8.xyz = unity_SHC.xyz * u_xlat16_8.xxx + u_xlat16_9.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_8.xyz;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
#endif
#endif
#else
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat3.w = u_xlat2.y;
    u_xlat10.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat10.y;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]));
    u_xlat3.z = u_xlat4.x;
    u_xlat5.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.x = u_xlat5.z;
    u_xlat19 = dot(u_xlat3, u_xlat0);
    vs_TEXCOORD1.y = dot(u_xlat3, in_POSITION0);
    u_xlat6 = vec4(u_xlat19) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.w = u_xlat2.x;
    u_xlat5.z = u_xlat4.y;
    u_xlat4.x = u_xlat5.y;
    u_xlat4.y = u_xlat10.x;
    u_xlat5.y = u_xlat10.z;
    u_xlat10.x = dot(u_xlat4, u_xlat0);
    vs_TEXCOORD1.x = dot(u_xlat4, in_POSITION0);
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat6;
    u_xlat5.w = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5, u_xlat0);
    vs_TEXCOORD1.z = dot(u_xlat5, in_POSITION0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat6;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.xyz = u_xlat4.yzx * u_xlat5.zxy;
    u_xlat0.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat0.xyz);
    u_xlat10.xyz = u_xlat3.zxy * u_xlat5.yzx;
    u_xlat10.xyz = u_xlat3.yzx * u_xlat5.zxy + (-u_xlat10.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat10.xyz);
    u_xlat27 = float(1.0) / float(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat3.yzx * u_xlat4.zxy;
    u_xlat2.xyz = u_xlat4.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat10.xyz = vec3(u_xlat27) * u_xlat10.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat10.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
#endif
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
#if defined(INSTANCING_ON)
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat3 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = vec4(unity_ParticleUseMeshColors) * u_xlat3 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu27 = uint(floatBitsToUint(u_xlat2.w)) & 255u;
    u_xlat4.x = float(u_xlatu27);
    u_xlatu10.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu27 = uint(floatBitsToUint(u_xlat2.w)) >> (24u & uint(0x1F));
    u_xlat4.w = float(u_xlatu27);
    u_xlat4.yz = vec2(u_xlatu10.xy);
    u_xlat2 = u_xlat3 * u_xlat4;
    u_xlat2 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    vs_COLOR0 = u_xlat2;
    u_xlat27 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.x = (-u_xlat27) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat19 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat27) * unity_ParticleUVShiftData.w + u_xlat19;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb27 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb27)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_7 = u_xlat0.y * u_xlat0.y;
    u_xlat16_7 = u_xlat0.x * u_xlat0.x + (-u_xlat16_7);
#else
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
#endif
#endif
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
#if defined(INSTANCING_ON)
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_7) + u_xlat16_8.xyz;
#else
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
#endif
#endif
#endif
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
#endif
#endif
#if defined(INSTANCING_ON)
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
#endif
#endif
    return;
}
#endif
#ifdef FRAGMENT
#version 310 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if defined(LIGHTPROBE_SH)
#if defined(INSTANCING_ON)
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
#if defined(LIGHTPROBE_SH)
#if !defined(INSTANCING_ON)
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
#endif
#else
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
#endif
#if defined(SHADOWS_SCREEN)
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
#endif
uniform 	mediump vec4 unity_SpecCube0_HDR;
#if defined(LIGHTPROBE_SH)
#if defined(INSTANCING_ON)
uniform 	int unity_BaseInstanceID;
#endif
#endif
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Glossiness;
#if defined(LIGHTPROBE_SH)
#if defined(INSTANCING_ON)
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
UNITY_LOCATION(1) uniform highp sampler2D unity_NHxRoughness;
UNITY_LOCATION(2) uniform mediump samplerCube unity_SpecCube0;
#if defined(SHADOWS_SCREEN)
UNITY_LOCATION(3) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(4) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
#endif
#if defined(LIGHTPROBE_SH)
#if defined(SOFTPARTICLES_ON)
#if defined(INSTANCING_ON)
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
flat in highp uint vs_SV_InstanceID0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) in highp vec3 vs_TEXCOORD0;
layout(location = 1) in highp vec3 vs_TEXCOORD1;
layout(location = 2) in mediump vec4 vs_COLOR0;
layout(location = 3) in highp vec2 vs_TEXCOORD2;
layout(location = 4) in mediump vec3 vs_TEXCOORD4;
#else
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
#endif
#endif
#else
#if defined(INSTANCING_ON)
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
flat in highp uint vs_SV_InstanceID0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) in highp vec3 vs_TEXCOORD0;
layout(location = 1) in highp vec3 vs_TEXCOORD1;
layout(location = 2) in mediump vec4 vs_COLOR0;
layout(location = 3) in highp vec2 vs_TEXCOORD2;
layout(location = 4) in mediump vec3 vs_TEXCOORD3;
#else
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
#endif
#endif
#endif
#else
#if defined(SOFTPARTICLES_ON)
#if defined(INSTANCING_ON)
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) in highp vec3 vs_TEXCOORD0;
layout(location = 1) in highp vec3 vs_TEXCOORD1;
layout(location = 2) in mediump vec4 vs_COLOR0;
layout(location = 3) in highp vec2 vs_TEXCOORD2;
layout(location = 4) in mediump vec3 vs_TEXCOORD4;
#else
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
#endif
#endif
#else
#if defined(INSTANCING_ON)
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) in highp vec3 vs_TEXCOORD0;
layout(location = 1) in highp vec3 vs_TEXCOORD1;
layout(location = 2) in mediump vec4 vs_COLOR0;
layout(location = 3) in highp vec2 vs_TEXCOORD2;
layout(location = 4) in mediump vec3 vs_TEXCOORD3;
#else
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
#endif
#endif
#endif
#endif
layout(location = 0) out mediump vec4 SV_Target0;
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
#if defined(INSTANCING_ON)
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
#else
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
#endif
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
#else
#if defined(INSTANCING_ON)
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
#else
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
#endif
#endif
#else
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
#if defined(SHADOWS_SCREEN)
vec3 u_xlat4;
#endif
mediump vec3 u_xlat16_4;
#if defined(SHADOWS_SCREEN)
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
#else
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
#endif
#endif
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
#if defined(INSTANCING_ON)
vec3 u_xlat10;
float u_xlat11;
mediump vec3 u_xlat16_12;
#else
float u_xlat10;
mediump vec3 u_xlat16_11;
float u_xlat12;
#endif
mediump vec3 u_xlat16_17;
float u_xlat20;
#if defined(INSTANCING_ON)
float u_xlat21;
#endif
#else
#if defined(INSTANCING_ON)
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
#else
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
#endif
#endif
#else
#if defined(SHADOWS_SCREEN)
float u_xlat10;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump vec3 u_xlat16_17;
float u_xlat20;
#else
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
#endif
#endif
float u_xlat30;
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
#if defined(INSTANCING_ON)
float u_xlat31;
float u_xlat33;
#else
float u_xlat32;
#endif
mediump float u_xlat16_35;
#else
#if defined(INSTANCING_ON)
float u_xlat31;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
mediump float u_xlat16_35;
#else
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_34;
mediump float u_xlat16_36;
#endif
#endif
#else
#if !defined(SHADOWS_SCREEN)
mediump float u_xlat16_31;
#endif
float u_xlat32;
#if defined(SHADOWS_SCREEN)
mediump float u_xlat16_35;
#else
mediump float u_xlat16_34;
mediump float u_xlat16_36;
#endif
#endif
void main()
{
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
#if defined(SOFTPARTICLES_ON)
#if defined(INSTANCING_ON)
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 * 7;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHArArray, u_xlat1);
    u_xlat16_2.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAgArray, u_xlat1);
    u_xlat16_2.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAbArray, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat10.xyz = log2(u_xlat16_2.xyz);
    u_xlat10.xyz = u_xlat10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat10.xyz = exp2(u_xlat10.xyz);
    u_xlat10.xyz = u_xlat10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat10.xyz = max(u_xlat10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.z = (-_Glossiness) + 1.0;
    u_xlat16_2.x = (-u_xlat1.z) * 0.699999988 + 1.70000005;
    u_xlat16_2.x = u_xlat1.z * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * 6.0;
#else
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.z = (-_Glossiness) + 1.0;
    u_xlat16_1.x = (-u_xlat2.z) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat2.z;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#endif
#else
#if defined(INSTANCING_ON)
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 * 7;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHArArray, u_xlat1);
    u_xlat16_2.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAgArray, u_xlat1);
    u_xlat16_2.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAbArray, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat10.xyz = log2(u_xlat16_2.xyz);
    u_xlat10.xyz = u_xlat10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat10.xyz = exp2(u_xlat10.xyz);
    u_xlat10.xyz = u_xlat10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat10.xyz = max(u_xlat10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.z = (-_Glossiness) + 1.0;
    u_xlat16_2.x = (-u_xlat1.z) * 0.699999988 + 1.70000005;
    u_xlat16_2.x = u_xlat1.z * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * 6.0;
#else
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.z = (-_Glossiness) + 1.0;
    u_xlat16_1.x = (-u_xlat2.z) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat2.z;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#endif
#endif
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
#if defined(INSTANCING_ON)
    u_xlat11 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat4.xyz = vec3(u_xlat11) * u_xlat3.xyz;
    u_xlat16_12.x = dot((-u_xlat4.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_12.x = u_xlat16_12.x + u_xlat16_12.x;
    u_xlat16_12.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_12.xxx) + (-u_xlat4.xyz);
    u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat16_12.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
#else
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_11.x = dot((-u_xlat4.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_11.x = u_xlat16_11.x + u_xlat16_11.x;
    u_xlat16_11.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_11.xxx) + (-u_xlat4.xyz);
    u_xlat16_1 = textureLod(unity_SpecCube0, u_xlat16_11.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
#endif
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
#if defined(INSTANCING_ON)
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat11 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat6.xyz = vec3(u_xlat11) * vs_TEXCOORD0.xyz;
    u_xlat11 = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat31 = u_xlat11;
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
    u_xlat11 = u_xlat11 + u_xlat11;
    u_xlat4.xyz = u_xlat6.xyz * (-vec3(u_xlat11)) + u_xlat4.xyz;
    u_xlat11 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat33 = u_xlat33 * u_xlat33;
    u_xlat1.x = u_xlat33 * u_xlat33;
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat1.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_35 = (-u_xlat31) + 1.0;
    u_xlat21 = u_xlat16_35 * u_xlat16_35;
    u_xlat21 = u_xlat16_35 * u_xlat21;
    u_xlat21 = u_xlat16_35 * u_xlat21;
#else
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
    u_xlat30 = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat12 = u_xlat30;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat4.xyz = u_xlat6.xyz * (-vec3(u_xlat30)) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat32 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat32 = u_xlat32 * u_xlat32;
    u_xlat2.x = u_xlat32 * u_xlat32;
    u_xlat2.x = texture(unity_NHxRoughness, u_xlat2.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_35 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat16_35 * u_xlat16_35;
    u_xlat12 = u_xlat16_35 * u_xlat12;
    u_xlat12 = u_xlat16_35 * u_xlat12;
#endif
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.x = (-u_xlat16_35) + _Glossiness;
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_17.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_17.xyz * vs_COLOR0.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat4.xyz = u_xlat16_17.xyz * vs_COLOR0.xyz;
    u_xlat16_17.xyz = vec3(u_xlat16_35) * u_xlat4.xyz;
#else
#if defined(SOFTPARTICLES_ON)
#if defined(INSTANCING_ON)
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 * 7;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHArArray, u_xlat1);
    u_xlat16_2.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAgArray, u_xlat1);
    u_xlat16_2.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAbArray, u_xlat1);
    u_xlat16_3.xyz = _LightColor0.xyz * unity_Builtins2Array[u_xlati0 / 7].unity_SHCArray.www;
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
#else
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_1.xyz);
#endif
#else
#if defined(INSTANCING_ON)
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 * 7;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHArArray, u_xlat1);
    u_xlat16_2.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAgArray, u_xlat1);
    u_xlat16_2.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAbArray, u_xlat1);
    u_xlat16_3.xyz = _LightColor0.xyz * unity_Builtins2Array[u_xlati0 / 7].unity_SHCArray.www;
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
#else
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_1.xyz);
#endif
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
#if defined(INSTANCING_ON)
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
#else
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
#endif
    u_xlat30 = inversesqrt(u_xlat30);
#if defined(INSTANCING_ON)
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat4.z = (-_Glossiness) + 1.0;
    u_xlat16_32 = (-u_xlat4.z) * 0.699999988 + 1.70000005;
    u_xlat16_32 = u_xlat16_32 * u_xlat4.z;
    u_xlat16_32 = u_xlat16_32 * 6.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat16_2.xyz, u_xlat16_32);
    u_xlat16_33 = u_xlat16_2.w + -1.0;
    u_xlat16_33 = unity_SpecCube0_HDR.w * u_xlat16_33 + 1.0;
    u_xlat16_33 = u_xlat16_33 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_33);
#else
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat3.z = (-_Glossiness) + 1.0;
    u_xlat16_31 = (-u_xlat3.z) * 0.699999988 + 1.70000005;
    u_xlat16_31 = u_xlat16_31 * u_xlat3.z;
    u_xlat16_31 = u_xlat16_31 * 6.0;
    u_xlat16_1 = textureLod(unity_SpecCube0, u_xlat16_1.xyz, u_xlat16_31);
    u_xlat16_4.x = u_xlat16_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
#endif
    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
#if defined(INSTANCING_ON)
    u_xlat6.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat6.xyz);
    u_xlat31 = u_xlat30;
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#else
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat32 = u_xlat30;
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
#if defined(INSTANCING_ON)
    u_xlat1.xyz = u_xlat6.xyz * (-vec3(u_xlat30)) + u_xlat1.xyz;
    u_xlat30 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#else
    u_xlat2.xyz = u_xlat5.xyz * (-vec3(u_xlat30)) + u_xlat2.xyz;
    u_xlat30 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#endif
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#if defined(INSTANCING_ON)
    u_xlat16_3.xyz = vec3(u_xlat30) * u_xlat16_3.xyz;
    u_xlat30 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#else
    u_xlat16_6.xyz = vec3(u_xlat30) * _LightColor0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#endif
    u_xlat30 = u_xlat30 * u_xlat30;
#if defined(INSTANCING_ON)
    u_xlat4.x = u_xlat30 * u_xlat30;
    u_xlat30 = texture(unity_NHxRoughness, u_xlat4.xz).x;
#else
    u_xlat3.x = u_xlat30 * u_xlat30;
    u_xlat30 = texture(unity_NHxRoughness, u_xlat3.xz).x;
#endif
    u_xlat30 = u_xlat30 * 16.0;
#if defined(INSTANCING_ON)
    u_xlat16_33 = (-u_xlat31) + 1.0;
    u_xlat1.x = u_xlat16_33 * u_xlat16_33;
    u_xlat1.x = u_xlat16_33 * u_xlat1.x;
    u_xlat1.x = u_xlat16_33 * u_xlat1.x;
    u_xlat16_33 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_35 = (-u_xlat16_33) + _Glossiness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_11.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_11.xyz * _Color.xyz;
#else
    u_xlat16_34 = (-u_xlat32) + 1.0;
    u_xlat2.x = u_xlat16_34 * u_xlat16_34;
    u_xlat2.x = u_xlat16_34 * u_xlat2.x;
    u_xlat2.x = u_xlat16_34 * u_xlat2.x;
    u_xlat16_34 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_36 = (-u_xlat16_34) + _Glossiness;
    u_xlat16_36 = u_xlat16_36 + 1.0;
    u_xlat16_36 = clamp(u_xlat16_36, 0.0, 1.0);
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_12.xyz * _Color.xyz;
#endif
    u_xlat16_8.xyz = u_xlat16_7.xyz * vs_COLOR0.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
#if defined(INSTANCING_ON)
    u_xlat11.xyz = u_xlat16_7.xyz * vs_COLOR0.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_33) * u_xlat11.xyz;
#else
    u_xlat12.xyz = u_xlat16_7.xyz * vs_COLOR0.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_34) * u_xlat12.xyz;
#endif
#endif
#else
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
#if defined(SOFTPARTICLES_ON)
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
#else
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
#endif
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
#if defined(SHADOWS_SCREEN)
    u_xlat2.z = (-_Glossiness) + 1.0;
    u_xlat16_1.x = (-u_xlat2.z) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat2.z;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
#else
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
#endif
    u_xlat30 = inversesqrt(u_xlat30);
#if defined(SHADOWS_SCREEN)
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_11.x = dot((-u_xlat4.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_11.x = u_xlat16_11.x + u_xlat16_11.x;
    u_xlat16_11.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_11.xxx) + (-u_xlat4.xyz);
    u_xlat16_1 = textureLod(unity_SpecCube0, u_xlat16_11.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
#else
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat3.z = (-_Glossiness) + 1.0;
    u_xlat16_31 = (-u_xlat3.z) * 0.699999988 + 1.70000005;
    u_xlat16_31 = u_xlat16_31 * u_xlat3.z;
    u_xlat16_31 = u_xlat16_31 * 6.0;
    u_xlat16_1 = textureLod(unity_SpecCube0, u_xlat16_1.xyz, u_xlat16_31);
    u_xlat16_4.x = u_xlat16_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
#endif
    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
#if defined(SHADOWS_SCREEN)
    u_xlat6.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
    u_xlat30 = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat12 = u_xlat30;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#else
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat32 = u_xlat30;
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
#if defined(SHADOWS_SCREEN)
    u_xlat4.xyz = u_xlat6.xyz * (-vec3(u_xlat30)) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#else
    u_xlat2.xyz = u_xlat5.xyz * (-vec3(u_xlat30)) + u_xlat2.xyz;
    u_xlat30 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#endif
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#if defined(SHADOWS_SCREEN)
    u_xlat32 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat32 = u_xlat32 * u_xlat32;
    u_xlat2.x = u_xlat32 * u_xlat32;
    u_xlat2.x = texture(unity_NHxRoughness, u_xlat2.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_35 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat16_35 * u_xlat16_35;
    u_xlat12 = u_xlat16_35 * u_xlat12;
    u_xlat12 = u_xlat16_35 * u_xlat12;
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.x = (-u_xlat16_35) + _Glossiness;
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_17.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_17.xyz * vs_COLOR0.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat4.xyz = u_xlat16_17.xyz * vs_COLOR0.xyz;
    u_xlat16_17.xyz = vec3(u_xlat16_35) * u_xlat4.xyz;
#else
    u_xlat16_6.xyz = vec3(u_xlat30) * _LightColor0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = u_xlat30 * u_xlat30;
    u_xlat3.x = u_xlat30 * u_xlat30;
    u_xlat30 = texture(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat30 = u_xlat30 * 16.0;
    u_xlat16_34 = (-u_xlat32) + 1.0;
    u_xlat2.x = u_xlat16_34 * u_xlat16_34;
    u_xlat2.x = u_xlat16_34 * u_xlat2.x;
    u_xlat2.x = u_xlat16_34 * u_xlat2.x;
    u_xlat16_34 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_36 = (-u_xlat16_34) + _Glossiness;
    u_xlat16_36 = u_xlat16_36 + 1.0;
    u_xlat16_36 = clamp(u_xlat16_36, 0.0, 1.0);
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_12.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * vs_COLOR0.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat12.xyz = u_xlat16_7.xyz * vs_COLOR0.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_34) * u_xlat12.xyz;
#endif
#endif
    u_xlat16_8.xyz = vec3(_Metallic) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
#if defined(LIGHTPROBE_SH)
#if defined(SHADOWS_SCREEN)
    u_xlat16_9.xyz = u_xlat16_7.xxx + (-u_xlat16_8.xyz);
#if defined(INSTANCING_ON)
    u_xlat16_9.xyz = vec3(u_xlat21) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat1.xxx * u_xlat16_8.xyz + u_xlat16_17.xyz;
#else
    u_xlat16_9.xyz = vec3(u_xlat12) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat2.xxx * u_xlat16_8.xyz + u_xlat16_17.xyz;
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
#if defined(INSTANCING_ON)
    u_xlat16_5.xyz = u_xlat10.xyz * u_xlat16_17.xyz + u_xlat16_5.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xzw = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat20 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat20 = sqrt(u_xlat20);
    u_xlat20 = (-u_xlat10.x) + u_xlat20;
    u_xlat10.x = unity_ShadowFadeCenterAndType.w * u_xlat20 + u_xlat10.x;
    u_xlat10.x = u_xlat10.x * _LightShadowData.z + _LightShadowData.w;
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat1.xzw = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xzw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xzw;
    u_xlat1.xzw = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat1.xz,u_xlat1.w);
    u_xlat20 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat30 = (-_LightShadowData.x) + 1.0;
    u_xlat20 = u_xlat20 * u_xlat30 + _LightShadowData.x;
    u_xlat16_35 = (-u_xlat20) + unity_Builtins2Array[u_xlati0 / 7].unity_SHCArray.w;
    u_xlat16_35 = u_xlat10.x * u_xlat16_35 + u_xlat20;
#else
    u_xlat16_5.xyz = u_xlat0.xyz * u_xlat16_17.xyz + u_xlat16_5.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = sqrt(u_xlat10);
    u_xlat10 = (-u_xlat0.x) + u_xlat10;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat10 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat2.xy,u_xlat2.z);
    u_xlat10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat20 = (-_LightShadowData.x) + 1.0;
    u_xlat10 = u_xlat10 * u_xlat20 + _LightShadowData.x;
    u_xlat16_35 = (-u_xlat10) + 1.0;
    u_xlat16_35 = u_xlat0.x * u_xlat16_35 + u_xlat10;
#endif
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
#if defined(INSTANCING_ON)
    u_xlat16_7.xyz = vec3(u_xlat11) * u_xlat16_7.xyz;
#else
    u_xlat16_7.xyz = vec3(u_xlat30) * u_xlat16_7.xyz;
#endif
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
#else
#if defined(INSTANCING_ON)
    u_xlat16_9.xyz = vec3(u_xlat16_35) + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = u_xlat1.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
#else
    u_xlat16_9.xyz = vec3(u_xlat16_36) + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = u_xlat2.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
#endif
    u_xlat16_8.xyz = vec3(u_xlat30) * u_xlat16_8.xyz + u_xlat16_7.xyz;
#if defined(INSTANCING_ON)
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_5.xyz = u_xlat0.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_3.xyz + u_xlat16_5.xyz;
#else
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat0.xyz * u_xlat16_7.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_4.xyz;
#endif
#endif
#else
#if defined(SHADOWS_SCREEN)
    u_xlat16_9.xyz = u_xlat16_7.xxx + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = vec3(u_xlat12) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat2.xxx * u_xlat16_8.xyz + u_xlat16_17.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_5.xyz = u_xlat0.xyz * u_xlat16_17.xyz + u_xlat16_5.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = sqrt(u_xlat10);
    u_xlat10 = (-u_xlat0.x) + u_xlat10;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat10 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat2.xy,u_xlat2.z);
    u_xlat10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat20 = (-_LightShadowData.x) + 1.0;
    u_xlat10 = u_xlat10 * u_xlat20 + _LightShadowData.x;
    u_xlat16_35 = (-u_xlat10) + 1.0;
    u_xlat16_35 = u_xlat0.x * u_xlat16_35 + u_xlat10;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat16_7.xyz = vec3(u_xlat30) * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
#else
    u_xlat16_9.xyz = vec3(u_xlat16_36) + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = u_xlat2.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = vec3(u_xlat30) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat0.xyz * u_xlat16_7.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_4.xyz;
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
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="DEFERRED" "PerformanceChecks"="False" "PreviewType"="Plane" "RenderType"="Opaque" }
			Blend [_SrcBlend] [_DstBlend], [_SrcBlend] [_DstBlend]
			BlendOp [_BlendOp], [_BlendOp]
			ZWrite [_ZWrite]
			Cull [_Cull]
			GLSLPROGRAM
#pragma multi_compile _ LIGHTPROBE_SH
#pragma multi_compile _ SOFTPARTICLES_ON
#pragma multi_compile _ UNITY_HDR_ON
#pragma multi_compile _ INSTANCING_ON PROCEDURAL_INSTANCING_ON
#ifdef VERTEX
#version 310 es
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
#if defined(SOFTPARTICLES_ON)
uniform 	vec4 _ProjectionParams;
#endif
#if defined(LIGHTPROBE_SH)
#if !defined(INSTANCING_ON)
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
#if !defined(PROCEDURAL_INSTANCING_ON)
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
#endif
#endif
#else
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
#if !defined(INSTANCING_ON)
#if !defined(PROCEDURAL_INSTANCING_ON)
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
#endif
#endif
#endif
#if defined(SOFTPARTICLES_ON)
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if defined(INSTANCING_ON)
uniform 	int unity_BaseInstanceID;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
#endif
#endif
uniform 	vec4 _MainTex_ST;
#if defined(LIGHTPROBE_SH)
#if defined(INSTANCING_ON)
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type                unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
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
#else
#if defined(PROCEDURAL_INSTANCING_ON)
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};
layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
#endif
#endif
#else
#if defined(INSTANCING_ON)
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type                unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#else
#if defined(PROCEDURAL_INSTANCING_ON)
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};
layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
#endif
#endif
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
#if defined(LIGHTPROBE_SH)
#if defined(SOFTPARTICLES_ON)
#if defined(INSTANCING_ON)
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
int u_xlati0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) out highp vec3 vs_TEXCOORD0;
layout(location = 4) out highp vec3 vs_TEXCOORD1;
layout(location = 1) out mediump vec4 vs_COLOR0;
layout(location = 2) out highp vec2 vs_TEXCOORD2;
layout(location = 5) out highp vec4 vs_TEXCOORD3;
layout(location = 6) out highp vec4 vs_TEXCOORD5;
layout(location = 3) out mediump vec3 vs_TEXCOORD6;
layout(location = 7) flat out highp uint vs_SV_InstanceID0;
#else
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
#endif
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
#endif
vec4 u_xlat1;
#if defined(INSTANCING_ON)
mediump vec4 u_xlat16_1;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
int u_xlati1;
#endif
#endif
vec4 u_xlat2;
#if defined(INSTANCING_ON)
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
int u_xlati5;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
float u_xlat19;
float u_xlat28;
uint u_xlatu28;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#else
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
#endif
#endif
#else
#if defined(INSTANCING_ON)
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
int u_xlati5;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) out highp vec3 vs_TEXCOORD0;
layout(location = 4) out highp vec3 vs_TEXCOORD1;
layout(location = 1) out mediump vec4 vs_COLOR0;
layout(location = 2) out highp vec2 vs_TEXCOORD2;
layout(location = 5) out highp vec4 vs_TEXCOORD4;
layout(location = 3) out mediump vec3 vs_TEXCOORD5;
layout(location = 6) flat out highp uint vs_SV_InstanceID0;
#else
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
#endif
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
#if defined(PROCEDURAL_INSTANCING_ON)
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
uvec2 u_xlatu10;
float u_xlat19;
float u_xlat27;
uint u_xlatu27;
bool u_xlatb27;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#else
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
#endif
#endif
#endif
#else
#if defined(SOFTPARTICLES_ON)
#if defined(INSTANCING_ON)
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) out highp vec3 vs_TEXCOORD0;
layout(location = 4) out highp vec3 vs_TEXCOORD1;
layout(location = 1) out mediump vec4 vs_COLOR0;
layout(location = 2) out highp vec2 vs_TEXCOORD2;
layout(location = 5) out highp vec4 vs_TEXCOORD3;
layout(location = 6) out highp vec4 vs_TEXCOORD5;
layout(location = 3) out mediump vec3 vs_TEXCOORD6;
layout(location = 7) flat out highp uint vs_SV_InstanceID0;
#else
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
#endif
vec4 u_xlat0;
#endif
#else
#if defined(INSTANCING_ON)
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) out highp vec3 vs_TEXCOORD0;
layout(location = 4) out highp vec3 vs_TEXCOORD1;
layout(location = 1) out mediump vec4 vs_COLOR0;
layout(location = 2) out highp vec2 vs_TEXCOORD2;
layout(location = 5) out highp vec4 vs_TEXCOORD4;
layout(location = 3) out mediump vec3 vs_TEXCOORD5;
layout(location = 6) flat out highp uint vs_SV_InstanceID0;
#else
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
#endif
vec4 u_xlat0;
#endif
#endif
mediump vec4 u_xlat16_0;
#if defined(SOFTPARTICLES_ON)
#if defined(INSTANCING_ON)
int u_xlati0;
#endif
vec4 u_xlat1;
#if !defined(INSTANCING_ON)
#if defined(PROCEDURAL_INSTANCING_ON)
int u_xlati1;
#endif
#endif
vec4 u_xlat2;
#if defined(INSTANCING_ON)
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
float u_xlat19;
float u_xlat28;
uint u_xlatu28;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#else
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
#endif
#endif
#else
#if defined(INSTANCING_ON)
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
uvec2 u_xlatu10;
float u_xlat19;
float u_xlat27;
uint u_xlatu27;
bool u_xlatb27;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#else
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
#endif
#endif
#endif
#endif
void main()
{
#if defined(LIGHTPROBE_SH)
#if defined(SOFTPARTICLES_ON)
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlati0 = u_xlati0 * 7;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat5.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat1.x;
    vs_TEXCOORD3.z = (-u_xlat1.x);
    u_xlat1.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat2.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[3].xyw * u_xlat2.www + u_xlat1.xyz;
    u_xlat2.xz = u_xlat1.xz * vec2(0.5, 0.5);
    u_xlat1.x = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD3.w = u_xlat1.z;
    u_xlat2.w = u_xlat1.x * 0.5;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat3.w = u_xlat2.y;
    u_xlat10.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat10.y;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]));
    u_xlat3.z = u_xlat4.x;
    u_xlat5.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.x = u_xlat5.z;
    u_xlat19 = dot(u_xlat3, u_xlat0);
    vs_TEXCOORD1.y = dot(u_xlat3, in_POSITION0);
    u_xlat6 = vec4(u_xlat19) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.w = u_xlat2.x;
    u_xlat5.z = u_xlat4.y;
    u_xlat4.x = u_xlat5.y;
    u_xlat4.y = u_xlat10.x;
    u_xlat5.y = u_xlat10.z;
    u_xlat10.x = dot(u_xlat4, u_xlat0);
    vs_TEXCOORD1.x = dot(u_xlat4, in_POSITION0);
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat6;
    u_xlat5.w = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5, u_xlat0);
    vs_TEXCOORD1.z = dot(u_xlat5, in_POSITION0);
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat6;
    gl_Position = u_xlat6 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat9.xyz = u_xlat4.yzx * u_xlat5.zxy;
    u_xlat9.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat9.xyz);
    u_xlat2.xyz = u_xlat3.zxy * u_xlat5.yzx;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat5.zxy + (-u_xlat2.xyz);
    u_xlat28 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat28 = float(1.0) / float(u_xlat28);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat28);
    u_xlat5.y = dot(in_NORMAL0.xyz, u_xlat9.xyz);
    u_xlat9.xyz = u_xlat3.yzx * u_xlat4.zxy;
    u_xlat9.xyz = u_xlat4.yzx * u_xlat3.zxy + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat28) * u_xlat9.xyz;
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat5.x = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, u_xlat9.xyz);
    u_xlat9.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * u_xlat5.xyz;
    vs_TEXCOORD0.xyz = u_xlat9.xyz;
    u_xlat3 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = vec4(unity_ParticleUseMeshColors) * u_xlat3 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu28 = uint(floatBitsToUint(u_xlat2.w)) & 255u;
    u_xlat4.x = float(u_xlatu28);
    u_xlatu2.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu28 = uint(floatBitsToUint(u_xlat2.w)) >> (24u & uint(0x1F));
    u_xlat4.w = float(u_xlatu28);
    u_xlat4.yz = vec2(u_xlatu2.xy);
    u_xlat2 = u_xlat3 * u_xlat4;
    u_xlat2 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    vs_COLOR0 = u_xlat2;
    u_xlat28 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat28 = floor(u_xlat28);
    u_xlat1.x = (-u_xlat28) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat2.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat1.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat2.y = (-u_xlat28) * unity_ParticleUVShiftData.w + u_xlat1.x;
    u_xlat1.xw = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat2.xy;
    u_xlatb2 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xw = (bool(u_xlatb2)) ? u_xlat1.xw : in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat1.xw * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat19 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.xyz = vec3(u_xlat19) * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat10.xxx + u_xlat2.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat10.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat1.x;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat10.xyz = u_xlat10.xyz + hlslcc_mtx4x4unity_MatrixVP[3].xyw;
    u_xlat0.x = u_xlat1.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat10.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat0.x * 0.5;
    u_xlat2.xz = u_xlat10.xz * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat10.z;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD3.z = (-u_xlat15);
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[3].xyw * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xz = u_xlat1.xz * vec2(0.5, 0.5);
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD3.w = u_xlat1.z;
    u_xlat2.w = u_xlat15 * 0.5;
#endif
#endif
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
#if defined(INSTANCING_ON)
    u_xlat16_3 = u_xlat5.y * u_xlat5.y;
    u_xlat16_3 = u_xlat5.x * u_xlat5.x + (-u_xlat16_3);
    u_xlat16_1 = u_xlat5.yzzx * u_xlat5.xyzz;
    u_xlat16_4.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBrArray, u_xlat16_1);
    u_xlat16_4.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBgArray, u_xlat16_1);
    u_xlat16_4.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBbArray, u_xlat16_1);
    vs_TEXCOORD6.xyz = unity_Builtins2Array[u_xlati0 / 7].unity_SHCArray.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat16_7 = u_xlat9.y * u_xlat9.y;
    u_xlat16_7 = u_xlat9.x * u_xlat9.x + (-u_xlat16_7);
    u_xlat16_0 = u_xlat9.yzzx * u_xlat9.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_7) + u_xlat16_8.xyz;
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
#else
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
#endif
#endif
#else
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlati0 = u_xlati0 * 7;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat5.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat3.w = u_xlat2.y;
    u_xlat10.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat10.y;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]));
    u_xlat3.z = u_xlat4.x;
    u_xlat5.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.x = u_xlat5.z;
    u_xlat19 = dot(u_xlat3, u_xlat0);
    vs_TEXCOORD1.y = dot(u_xlat3, in_POSITION0);
    u_xlat6 = vec4(u_xlat19) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.w = u_xlat2.x;
    u_xlat5.z = u_xlat4.y;
    u_xlat4.x = u_xlat5.y;
    u_xlat4.y = u_xlat10.x;
    u_xlat5.y = u_xlat10.z;
    u_xlat10.x = dot(u_xlat4, u_xlat0);
    vs_TEXCOORD1.x = dot(u_xlat4, in_POSITION0);
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat6;
    u_xlat5.w = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5, u_xlat0);
    vs_TEXCOORD1.z = dot(u_xlat5, in_POSITION0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat6;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.xyz = u_xlat4.yzx * u_xlat5.zxy;
    u_xlat0.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat0.xyz);
    u_xlat10.xyz = u_xlat3.zxy * u_xlat5.yzx;
    u_xlat10.xyz = u_xlat3.yzx * u_xlat5.zxy + (-u_xlat10.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat10.xyz);
    u_xlat27 = float(1.0) / float(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat3.yzx * u_xlat4.zxy;
    u_xlat2.xyz = u_xlat4.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat10.xyz = vec3(u_xlat27) * u_xlat10.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat10.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat3 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = vec4(unity_ParticleUseMeshColors) * u_xlat3 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu27 = uint(floatBitsToUint(u_xlat2.w)) & 255u;
    u_xlat4.x = float(u_xlatu27);
    u_xlatu10.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu27 = uint(floatBitsToUint(u_xlat2.w)) >> (24u & uint(0x1F));
    u_xlat4.w = float(u_xlatu27);
    u_xlat4.yz = vec2(u_xlatu10.xy);
    u_xlat2 = u_xlat3 * u_xlat4;
    u_xlat2 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    vs_COLOR0 = u_xlat2;
    u_xlat27 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.x = (-u_xlat27) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat19 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat27) * unity_ParticleUVShiftData.w + u_xlat19;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb27 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb27)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#else
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#endif
#endif
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
#if defined(INSTANCING_ON)
    u_xlat16_3 = u_xlat5.y * u_xlat5.y;
    u_xlat16_3 = u_xlat5.x * u_xlat5.x + (-u_xlat16_3);
    u_xlat16_1 = u_xlat5.yzzx * u_xlat5.xyzz;
    u_xlat16_4.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBrArray, u_xlat16_1);
    u_xlat16_4.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBgArray, u_xlat16_1);
    u_xlat16_4.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHBbArray, u_xlat16_1);
    vs_TEXCOORD5.xyz = unity_Builtins2Array[u_xlati0 / 7].unity_SHCArray.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat16_7 = u_xlat0.y * u_xlat0.y;
    u_xlat16_7 = u_xlat0.x * u_xlat0.x + (-u_xlat16_7);
#else
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
#endif
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_7) + u_xlat16_8.xyz;
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
#else
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
#endif
#endif
#endif
#else
#if defined(SOFTPARTICLES_ON)
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat15 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat15;
    vs_TEXCOORD3.z = (-u_xlat15);
    u_xlat1.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat2.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[3].xyw * u_xlat2.www + u_xlat1.xyz;
    u_xlat2.xz = u_xlat1.xz * vec2(0.5, 0.5);
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD3.w = u_xlat1.z;
    u_xlat2.w = u_xlat15 * 0.5;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat3.w = u_xlat2.y;
    u_xlat10.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat10.y;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]));
    u_xlat3.z = u_xlat4.x;
    u_xlat5.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.x = u_xlat5.z;
    u_xlat19 = dot(u_xlat3, u_xlat0);
    vs_TEXCOORD1.y = dot(u_xlat3, in_POSITION0);
    u_xlat6 = vec4(u_xlat19) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.w = u_xlat2.x;
    u_xlat5.z = u_xlat4.y;
    u_xlat4.x = u_xlat5.y;
    u_xlat4.y = u_xlat10.x;
    u_xlat5.y = u_xlat10.z;
    u_xlat10.x = dot(u_xlat4, u_xlat0);
    vs_TEXCOORD1.x = dot(u_xlat4, in_POSITION0);
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat6;
    u_xlat5.w = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5, u_xlat0);
    vs_TEXCOORD1.z = dot(u_xlat5, in_POSITION0);
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat6;
    gl_Position = u_xlat6 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat9.xyz = u_xlat4.yzx * u_xlat5.zxy;
    u_xlat9.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat9.xyz);
    u_xlat2.xyz = u_xlat3.zxy * u_xlat5.yzx;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat5.zxy + (-u_xlat2.xyz);
    u_xlat28 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat28 = float(1.0) / float(u_xlat28);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat28);
    u_xlat5.y = dot(in_NORMAL0.xyz, u_xlat9.xyz);
    u_xlat9.xyz = u_xlat3.yzx * u_xlat4.zxy;
    u_xlat9.xyz = u_xlat4.yzx * u_xlat3.zxy + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat28) * u_xlat9.xyz;
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat5.x = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, u_xlat9.xyz);
    u_xlat9.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * u_xlat5.xyz;
    vs_TEXCOORD0.xyz = u_xlat9.xyz;
    u_xlat3 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = vec4(unity_ParticleUseMeshColors) * u_xlat3 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu28 = uint(floatBitsToUint(u_xlat2.w)) & 255u;
    u_xlat4.x = float(u_xlatu28);
    u_xlatu2.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu28 = uint(floatBitsToUint(u_xlat2.w)) >> (24u & uint(0x1F));
    u_xlat4.w = float(u_xlatu28);
    u_xlat4.yz = vec2(u_xlatu2.xy);
    u_xlat2 = u_xlat3 * u_xlat4;
    u_xlat2 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    vs_COLOR0 = u_xlat2;
    u_xlat28 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat28 = floor(u_xlat28);
    u_xlat1.x = (-u_xlat28) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat2.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat1.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat2.y = (-u_xlat28) * unity_ParticleUVShiftData.w + u_xlat1.x;
    u_xlat1.xw = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat2.xy;
    u_xlatb2 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xw = (bool(u_xlatb2)) ? u_xlat1.xw : in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat1.xw * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat19 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.xyz = vec3(u_xlat19) * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat10.xxx + u_xlat2.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat10.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat1.x;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat10.xyz = u_xlat10.xyz + hlslcc_mtx4x4unity_MatrixVP[3].xyw;
    u_xlat0.x = u_xlat1.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat10.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat0.x * 0.5;
    u_xlat2.xz = u_xlat10.xz * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat10.z;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD3.z = (-u_xlat15);
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixVP[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixVP[0].xyw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[2].xyw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixVP[3].xyw * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xz = u_xlat1.xz * vec2(0.5, 0.5);
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD3.w = u_xlat1.z;
    u_xlat2.w = u_xlat15 * 0.5;
#endif
#endif
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
#if defined(INSTANCING_ON)
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat16_7 = u_xlat9.y * u_xlat9.y;
    u_xlat16_7 = u_xlat9.x * u_xlat9.x + (-u_xlat16_7);
    u_xlat16_0 = u_xlat9.yzzx * u_xlat9.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_7) + u_xlat16_8.xyz;
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
#else
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
#endif
#endif
#else
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat3.w = u_xlat2.y;
    u_xlat10.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat10.y;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]));
    u_xlat3.z = u_xlat4.x;
    u_xlat5.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.x = u_xlat5.z;
    u_xlat19 = dot(u_xlat3, u_xlat0);
    vs_TEXCOORD1.y = dot(u_xlat3, in_POSITION0);
    u_xlat6 = vec4(u_xlat19) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.w = u_xlat2.x;
    u_xlat5.z = u_xlat4.y;
    u_xlat4.x = u_xlat5.y;
    u_xlat4.y = u_xlat10.x;
    u_xlat5.y = u_xlat10.z;
    u_xlat10.x = dot(u_xlat4, u_xlat0);
    vs_TEXCOORD1.x = dot(u_xlat4, in_POSITION0);
    u_xlat6 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat10.xxxx + u_xlat6;
    u_xlat5.w = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5, u_xlat0);
    vs_TEXCOORD1.z = dot(u_xlat5, in_POSITION0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat6;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.xyz = u_xlat4.yzx * u_xlat5.zxy;
    u_xlat0.xyz = u_xlat4.zxy * u_xlat5.yzx + (-u_xlat0.xyz);
    u_xlat10.xyz = u_xlat3.zxy * u_xlat5.yzx;
    u_xlat10.xyz = u_xlat3.yzx * u_xlat5.zxy + (-u_xlat10.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat10.xyz);
    u_xlat27 = float(1.0) / float(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat2.xyz = u_xlat3.yzx * u_xlat4.zxy;
    u_xlat2.xyz = u_xlat4.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat10.xyz = vec3(u_xlat27) * u_xlat10.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat10.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
#endif
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
#if defined(INSTANCING_ON)
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat3 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = vec4(unity_ParticleUseMeshColors) * u_xlat3 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu27 = uint(floatBitsToUint(u_xlat2.w)) & 255u;
    u_xlat4.x = float(u_xlatu27);
    u_xlatu10.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat2.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu27 = uint(floatBitsToUint(u_xlat2.w)) >> (24u & uint(0x1F));
    u_xlat4.w = float(u_xlatu27);
    u_xlat4.yz = vec2(u_xlatu10.xy);
    u_xlat2 = u_xlat3 * u_xlat4;
    u_xlat2 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    vs_COLOR0 = u_xlat2;
    u_xlat27 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.x = (-u_xlat27) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat19 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat27) * unity_ParticleUVShiftData.w + u_xlat19;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb27 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb27)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#else
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#endif
#endif
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
#if defined(INSTANCING_ON)
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat16_7 = u_xlat0.y * u_xlat0.y;
    u_xlat16_7 = u_xlat0.x * u_xlat0.x + (-u_xlat16_7);
#else
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
#endif
#endif
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
#if defined(INSTANCING_ON)
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_7) + u_xlat16_8.xyz;
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
#else
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
#endif
#endif
#endif
#endif
    return;
}
#endif
#ifdef FRAGMENT
#version 310 es
#if defined(LIGHTPROBE_SH)
#if defined(INSTANCING_ON)
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
#if defined(LIGHTPROBE_SH)
#if defined(INSTANCING_ON)
uniform 	int unity_BaseInstanceID;
#else
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
#endif
#else
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
#endif
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Glossiness;
#if defined(LIGHTPROBE_SH)
#if defined(INSTANCING_ON)
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
#if defined(LIGHTPROBE_SH)
#if defined(SOFTPARTICLES_ON)
#if defined(INSTANCING_ON)
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD6;
flat in highp uint vs_SV_InstanceID0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) in highp vec3 vs_TEXCOORD0;
layout(location = 1) in mediump vec4 vs_COLOR0;
layout(location = 2) in highp vec2 vs_TEXCOORD2;
layout(location = 3) in mediump vec3 vs_TEXCOORD6;
#else
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD6;
#endif
#endif
#else
#if defined(INSTANCING_ON)
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD5;
flat in highp uint vs_SV_InstanceID0;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) in highp vec3 vs_TEXCOORD0;
layout(location = 1) in mediump vec4 vs_COLOR0;
layout(location = 2) in highp vec2 vs_TEXCOORD2;
layout(location = 3) in mediump vec3 vs_TEXCOORD5;
#else
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD5;
#endif
#endif
#endif
#else
#if defined(SOFTPARTICLES_ON)
#if defined(INSTANCING_ON)
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD6;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) in highp vec3 vs_TEXCOORD0;
layout(location = 1) in mediump vec4 vs_COLOR0;
layout(location = 2) in highp vec2 vs_TEXCOORD2;
layout(location = 3) in mediump vec3 vs_TEXCOORD6;
#else
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD6;
#endif
#endif
#else
#if defined(INSTANCING_ON)
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD5;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) in highp vec3 vs_TEXCOORD0;
layout(location = 1) in mediump vec4 vs_COLOR0;
layout(location = 2) in highp vec2 vs_TEXCOORD2;
layout(location = 3) in mediump vec3 vs_TEXCOORD5;
#else
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD5;
#endif
#endif
#endif
#endif
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
#if defined(LIGHTPROBE_SH)
#if defined(INSTANCING_ON)
int u_xlati0;
#endif
#endif
mediump vec3 u_xlat16_1;
#if defined(LIGHTPROBE_SH)
#if defined(INSTANCING_ON)
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
#else
mediump vec3 u_xlat16_2;
#endif
#else
mediump vec3 u_xlat16_2;
#endif
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    SV_Target1.xyz = vec3(_Metallic) * u_xlat16_1.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1.w = _Glossiness;
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
#if defined(LIGHTPROBE_SH)
#if defined(SOFTPARTICLES_ON)
#if defined(INSTANCING_ON)
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 * 7;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_3.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHArArray, u_xlat2);
    u_xlat16_3.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAgArray, u_xlat2);
    u_xlat16_3.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAbArray, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vs_TEXCOORD6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
#else
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
#endif
#else
#if defined(INSTANCING_ON)
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 * 7;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_3.x = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHArArray, u_xlat2);
    u_xlat16_3.y = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAgArray, u_xlat2);
    u_xlat16_3.z = dot(unity_Builtins2Array[u_xlati0 / 7].unity_SHAbArray, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
#else
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
#endif
#endif
#else
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
#if defined(SOFTPARTICLES_ON)
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
#else
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
#endif
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
#if defined(UNITY_HDR_ON)
    SV_Target3.xyz = u_xlat16_1.xyz * u_xlat0.xyz;
#else
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat0.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
#endif
    SV_Target3.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
	}
	Fallback "VertexLit"
}
