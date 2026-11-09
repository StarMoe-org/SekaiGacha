// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sandbox/Particles/StandardUnlit"
{
	Properties
	{
		_MainTex("Albedo", 2D) = "white" {}
		_Color("Color", Color) = (1, 1, 1, 1)
		_Cutoff("Alpha Cutoff", Range(0, 1)) = 0.5
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
		[HideInInspector] _ColorMode("__colormode", Float) = 0
		[HideInInspector] _FlipbookMode("__flipbookmode", Float) = 0
		[HideInInspector] _LightingEnabled("__lightingenabled", Float) = 0
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
		[HideInInspector] _ColorAddSubDiff("__coloraddsubdiff", Vector) = (0, 0, 0, 0)
		[HideInInspector] _DistortionStrengthScaled("__distortionstrengthscaled", Float) = 0
	}
	SubShader
	{
		Tags { "IGNOREPROJECTOR"="true" "PerformanceChecks"="False" "PreviewType"="Plane" "RenderType"="Opaque" }
		GrabPass { "_GrabTexture" }
		Pass
		{
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="FORWARDBASE" "PerformanceChecks"="False" "PreviewType"="Plane" "RenderType"="Opaque" }
			Blend [_SrcBlend] [_DstBlend], [_SrcBlend] [_DstBlend]
			BlendOp [_BlendOp], [_BlendOp]
			ColorMask RGB
			ZWrite [_ZWrite]
			Cull [_Cull]
			GLSLPROGRAM
#pragma multi_compile _ _ALPHABLEND_ON
#pragma multi_compile _ SOFTPARTICLES_ON
#pragma multi_compile _ INSTANCING_ON PROCEDURAL_INSTANCING_ON
#pragma multi_compile _ _COLORCOLOR_ON _EMISSION _FADING_ON
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
#if !defined(INSTANCING_ON)
#if !defined(PROCEDURAL_INSTANCING_ON)
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
#endif
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
#else
#if defined(INSTANCING_ON)
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
#endif
#endif
#endif
#endif
#else
#if defined(PROCEDURAL_INSTANCING_ON)
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
#endif
#endif
#endif
#endif
#else
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
uniform 	vec4 _ProjectionParams;
#endif
#endif
#endif
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
#endif
#endif
#endif
#endif
#endif
#endif
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
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
#if defined(SOFTPARTICLES_ON)
#if defined(INSTANCING_ON)
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec4 vs_TEXCOORD3;
#else
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
#endif
#endif
#else
#if defined(INSTANCING_ON)
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
out highp vec4 vs_TEXCOORD3;
#endif
#endif
#endif
#endif
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
layout(location = 2) out highp vec4 vs_TEXCOORD3;
#endif
#endif
#endif
#endif
#else
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
out highp vec4 vs_TEXCOORD3;
#endif
#endif
#endif
#endif
#endif
#endif
#endif
vec4 u_xlat0;
#if defined(SOFTPARTICLES_ON)
#if defined(INSTANCING_ON)
int u_xlati0;
#endif
vec4 u_xlat1;
#if defined(INSTANCING_ON)
float u_xlat2;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
float u_xlat13;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#else
float u_xlat2;
#endif
#endif
#else
#if defined(INSTANCING_ON)
int u_xlati0;
vec4 u_xlat1;
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
float u_xlat2;
#endif
#endif
#endif
#endif
#else
#if defined(PROCEDURAL_INSTANCING_ON)
#if defined(_ALPHABLEND_ON)
#if defined(_COLORCOLOR_ON)
vec2 u_xlat1;
#else
#if defined(_EMISSION)
vec2 u_xlat1;
#else
#if defined(_FADING_ON)
vec4 u_xlat1;
#else
vec2 u_xlat1;
#endif
#endif
#endif
#else
vec2 u_xlat1;
#endif
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
#if defined(_ALPHABLEND_ON)
#if defined(_COLORCOLOR_ON)
float u_xlat6;
#else
#if defined(_EMISSION)
float u_xlat6;
#else
#if !defined(_FADING_ON)
float u_xlat6;
#endif
#endif
#endif
#else
float u_xlat6;
#endif
vec3 u_xlat7;
#if defined(_ALPHABLEND_ON)
#if defined(_COLORCOLOR_ON)
uvec3 u_xlatu7;
#else
#if defined(_EMISSION)
uvec3 u_xlatu7;
#else
#if defined(_FADING_ON)
uvec2 u_xlatu7;
float u_xlat12;
uint u_xlatu12;
#else
uvec3 u_xlatu7;
#endif
#endif
#endif
#else
uvec3 u_xlatu7;
#endif
bool u_xlatb12;
float u_xlat13;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#else
vec4 u_xlat1;
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
float u_xlat2;
#endif
#endif
#endif
#endif
#endif
#endif
#endif
void main()
{
#if defined(SOFTPARTICLES_ON)
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
#endif
#endif
    vs_TEXCOORD3.z = (-u_xlat0.x);
#if defined(INSTANCING_ON)
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu12 = uint(floatBitsToUint(u_xlat5.w)) & 255u;
    u_xlat3.x = float(u_xlatu12);
    u_xlatu7.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat5.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat5.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu12 = uint(floatBitsToUint(u_xlat5.w)) >> (24u & uint(0x1F));
    u_xlat3.w = float(u_xlatu12);
    u_xlat3.yz = vec2(u_xlatu7.xy);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat12 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.x = (-u_xlat12) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat13 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat12) * unity_ParticleUVShiftData.w + u_xlat13;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
#else
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
#endif
#endif
#else
#if defined(INSTANCING_ON)
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << (3 & int(0x1F)));
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
#if defined(_ALPHABLEND_ON)
#if defined(_COLORCOLOR_ON)
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#else
#if defined(_EMISSION)
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#else
#if defined(_FADING_ON)
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
#else
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#endif
#endif
#endif
#else
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
#endif
#endif
#endif
#endif
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
#endif
#endif
#endif
#endif
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
#endif
#endif
#endif
#endif
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
#if defined(_ALPHABLEND_ON)
#if defined(_COLORCOLOR_ON)
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = uint(floatBitsToUint(u_xlat5.w)) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
#else
#if defined(_EMISSION)
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = uint(floatBitsToUint(u_xlat5.w)) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
#else
#if defined(_FADING_ON)
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu12 = uint(floatBitsToUint(u_xlat5.w)) & 255u;
    u_xlat3.x = float(u_xlatu12);
#else
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = uint(floatBitsToUint(u_xlat5.w)) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
#endif
#endif
#endif
#else
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = uint(floatBitsToUint(u_xlat5.w)) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
#endif
    u_xlatu7.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat5.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat5.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
#if defined(_ALPHABLEND_ON)
#if defined(_COLORCOLOR_ON)
    u_xlatu7.z = uint(floatBitsToUint(u_xlat5.w)) >> (24u & uint(0x1F));
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.x = u_xlat6 * unity_ParticleUVShiftData.z;
    u_xlat6 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat6;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
#else
#if defined(_EMISSION)
    u_xlatu7.z = uint(floatBitsToUint(u_xlat5.w)) >> (24u & uint(0x1F));
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.x = u_xlat6 * unity_ParticleUVShiftData.z;
    u_xlat6 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat6;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
#else
#if defined(_FADING_ON)
    u_xlatu12 = uint(floatBitsToUint(u_xlat5.w)) >> (24u & uint(0x1F));
    u_xlat3.w = float(u_xlatu12);
    u_xlat3.yz = vec2(u_xlatu7.xy);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat12 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.x = (-u_xlat12) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat13 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat12) * unity_ParticleUVShiftData.w + u_xlat13;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
#else
    u_xlatu7.z = uint(floatBitsToUint(u_xlat5.w)) >> (24u & uint(0x1F));
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.x = u_xlat6 * unity_ParticleUVShiftData.z;
    u_xlat6 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat6;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
#endif
#endif
#endif
#else
    u_xlatu7.z = uint(floatBitsToUint(u_xlat5.w)) >> (24u & uint(0x1F));
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.x = u_xlat6 * unity_ParticleUVShiftData.z;
    u_xlat6 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat6;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
#endif
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
#if defined(_ALPHABLEND_ON)
#if defined(_COLORCOLOR_ON)
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#else
#if defined(_EMISSION)
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#else
#if defined(_FADING_ON)
    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
#else
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#endif
#endif
#endif
#else
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#endif
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
#if defined(_ALPHABLEND_ON)
#if defined(_COLORCOLOR_ON)
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#else
#if defined(_EMISSION)
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#else
#if defined(_FADING_ON)
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
#else
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#endif
#endif
#endif
#else
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
#endif
#endif
#endif
#endif
#endif
#endif
#endif
    return;
}
#endif
#ifdef FRAGMENT
#version 310 es
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
#if defined(SOFTPARTICLES_ON)
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
uniform 	vec4 _ZBufferParams;
#endif
#endif
#endif
#endif
#endif
uniform 	mediump vec4 _Color;
#if defined(SOFTPARTICLES_ON)
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if defined(_EMISSION)
uniform 	mediump vec3 _EmissionColor;
#else
#if defined(_FADING_ON)
uniform 	vec4 _SoftParticleFadeParams;
uniform 	vec4 _CameraFadeParams;
#endif
#endif
#endif
#endif
#else
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if defined(_EMISSION)
uniform 	mediump vec3 _EmissionColor;
#else
#if defined(_FADING_ON)
uniform 	vec4 _CameraFadeParams;
#endif
#endif
#endif
#endif
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
#if defined(SOFTPARTICLES_ON)
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if defined(_EMISSION)
UNITY_LOCATION(1) uniform mediump sampler2D _EmissionMap;
#else
#if defined(_FADING_ON)
UNITY_LOCATION(1) uniform highp sampler2D _CameraDepthTexture;
#endif
#endif
#endif
#endif
#else
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if defined(_EMISSION)
UNITY_LOCATION(1) uniform mediump sampler2D _EmissionMap;
#endif
#endif
#endif
#endif
#if defined(INSTANCING_ON)
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
in highp vec4 vs_TEXCOORD3;
#endif
#endif
#endif
#endif
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
layout(location = 2) in highp vec4 vs_TEXCOORD3;
#endif
#endif
#endif
#endif
#else
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
#if !defined(_EMISSION)
#if defined(_FADING_ON)
in highp vec4 vs_TEXCOORD3;
#endif
#endif
#endif
#endif
#endif
#endif
layout(location = 0) out mediump vec4 SV_Target0;
#if defined(SOFTPARTICLES_ON)
#if defined(_ALPHABLEND_ON)
#if !defined(_COLORCOLOR_ON)
vec4 u_xlat0;
#endif
mediump vec4 u_xlat16_0;
#if defined(_COLORCOLOR_ON)
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_6;
float u_xlat7;
mediump float u_xlat16_12;
#else
#if defined(_EMISSION)
mediump vec3 u_xlat16_1;
#else
#if defined(_FADING_ON)
vec2 u_xlat1;
mediump float u_xlat16_1;
bvec2 u_xlatb1;
float u_xlat2;
#endif
#endif
#endif
#else
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
#endif
#else
#if defined(_ALPHABLEND_ON)
#if defined(_COLORCOLOR_ON)
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_6;
float u_xlat7;
mediump float u_xlat16_12;
#else
#if defined(_EMISSION)
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
#else
#if defined(_FADING_ON)
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
#else
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
#endif
#endif
#endif
#else
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
#endif
#endif
void main()
{
#if defined(SOFTPARTICLES_ON)
#if defined(_ALPHABLEND_ON)
#if defined(_COLORCOLOR_ON)
    u_xlat16_0.w = (-vs_COLOR0.x);
    u_xlatb1 = vs_COLOR0.y>=vs_COLOR0.z;
    u_xlat16_2.xy = (-vs_COLOR0.zy) + vs_COLOR0.yz;
    u_xlat16_2.z = float(1.0);
    u_xlat16_2.w = float(-1.0);
    u_xlat16_1 = (bool(u_xlatb1)) ? u_xlat16_2 : vec4(0.0, 0.0, 0.0, -0.0);
    u_xlat16_2.zw = u_xlat16_1.zw + vec2(-1.0, 0.666666687);
    u_xlat16_2.xy = u_xlat16_1.xy + vs_COLOR0.zy;
    u_xlat16_0.xyz = (-u_xlat16_2.xyw);
    u_xlat16_1.yzw = u_xlat16_0.yzw + u_xlat16_2.yzx;
    u_xlat16_1.x = u_xlat16_0.x + vs_COLOR0.x;
    u_xlatb3 = vs_COLOR0.x>=u_xlat16_2.x;
    u_xlat16_0 = (bool(u_xlatb3)) ? u_xlat16_1 : vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_12 = u_xlat16_0.w + vs_COLOR0.x;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyw;
    u_xlat16_2.x = min(u_xlat16_0.y, u_xlat16_12);
    u_xlat16_4.x = (-u_xlat16_0.y) + u_xlat16_12;
    u_xlat16_12 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_12 * 6.0 + 9.99999975e-05;
    u_xlat16_4.x = u_xlat16_4.x / u_xlat16_2.x;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_0.z;
    u_xlat16_0.x = u_xlat16_0.x + 9.99999975e-05;
    u_xlat16_0.x = u_xlat16_12 / u_xlat16_0.x;
    u_xlat16_4.xyz = abs(u_xlat16_4.xxx) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat16_4.xyz = fract(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat16_4.xyz = abs(u_xlat16_4.xyz) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_2 = u_xlat16_1 * _Color;
    u_xlatb3 = u_xlat16_2.y>=u_xlat16_2.z;
    u_xlat16_12 = (u_xlatb3) ? 1.0 : 0.0;
    u_xlat16_6 = u_xlat16_1.y * _Color.y + (-u_xlat16_2.z);
    u_xlat16_12 = u_xlat16_12 * u_xlat16_6 + u_xlat16_2.z;
    u_xlatb3 = u_xlat16_2.x>=u_xlat16_12;
    u_xlat7 = u_xlat16_2.w * vs_COLOR0.w;
    SV_Target0.w = u_xlat7;
    u_xlat16_2.x = (u_xlatb3) ? 1.0 : 0.0;
    u_xlat16_6 = u_xlat16_1.x * _Color.x + (-u_xlat16_12);
    u_xlat16_12 = u_xlat16_2.x * u_xlat16_6 + u_xlat16_12;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_12);
#else
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
#if defined(_EMISSION)
    u_xlat16_1.xyz = texture(_EmissionMap, vs_TEXCOORD1.xy).xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_EmissionColor.x, _EmissionColor.y, _EmissionColor.z) + u_xlat0.xyz;
#else
#if defined(_FADING_ON)
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), _SoftParticleFadeParams.xyxx).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        u_xlat1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
        u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
        u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
        u_xlat1.x = float(1.0) / u_xlat1.x;
        u_xlat1.x = u_xlat1.x + (-_SoftParticleFadeParams.x);
        u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD3.z);
        u_xlat1.x = u_xlat1.x * _SoftParticleFadeParams.y;
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
        u_xlat1.x = u_xlat0.w * u_xlat1.x;
        u_xlat16_1 = u_xlat1.x;
    } else {
        u_xlat16_1 = u_xlat0.w;
    }
    u_xlat2 = vs_TEXCOORD3.z + (-_CameraFadeParams.x);
    u_xlat2 = u_xlat2 * _CameraFadeParams.y;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat0.w = u_xlat16_1 * u_xlat2;
#endif
#endif
    SV_Target0 = u_xlat0;
#endif
#else
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
#endif
#else
#if defined(_ALPHABLEND_ON)
#if defined(_COLORCOLOR_ON)
    u_xlat16_0.w = (-vs_COLOR0.x);
    u_xlatb1 = vs_COLOR0.y>=vs_COLOR0.z;
    u_xlat16_2.xy = (-vs_COLOR0.zy) + vs_COLOR0.yz;
    u_xlat16_2.z = float(1.0);
    u_xlat16_2.w = float(-1.0);
    u_xlat16_1 = (bool(u_xlatb1)) ? u_xlat16_2 : vec4(0.0, 0.0, 0.0, -0.0);
    u_xlat16_2.zw = u_xlat16_1.zw + vec2(-1.0, 0.666666687);
    u_xlat16_2.xy = u_xlat16_1.xy + vs_COLOR0.zy;
    u_xlat16_0.xyz = (-u_xlat16_2.xyw);
    u_xlat16_1.yzw = u_xlat16_0.yzw + u_xlat16_2.yzx;
    u_xlat16_1.x = u_xlat16_0.x + vs_COLOR0.x;
    u_xlatb3 = vs_COLOR0.x>=u_xlat16_2.x;
    u_xlat16_0 = (bool(u_xlatb3)) ? u_xlat16_1 : vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_12 = u_xlat16_0.w + vs_COLOR0.x;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyw;
    u_xlat16_2.x = min(u_xlat16_0.y, u_xlat16_12);
    u_xlat16_4.x = (-u_xlat16_0.y) + u_xlat16_12;
    u_xlat16_12 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_12 * 6.0 + 9.99999975e-05;
    u_xlat16_4.x = u_xlat16_4.x / u_xlat16_2.x;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_0.z;
    u_xlat16_0.x = u_xlat16_0.x + 9.99999975e-05;
    u_xlat16_0.x = u_xlat16_12 / u_xlat16_0.x;
    u_xlat16_4.xyz = abs(u_xlat16_4.xxx) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat16_4.xyz = fract(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat16_4.xyz = abs(u_xlat16_4.xyz) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_2 = u_xlat16_1 * _Color;
    u_xlatb3 = u_xlat16_2.y>=u_xlat16_2.z;
    u_xlat16_12 = (u_xlatb3) ? 1.0 : 0.0;
    u_xlat16_6 = u_xlat16_1.y * _Color.y + (-u_xlat16_2.z);
    u_xlat16_12 = u_xlat16_12 * u_xlat16_6 + u_xlat16_2.z;
    u_xlatb3 = u_xlat16_2.x>=u_xlat16_12;
    u_xlat7 = u_xlat16_2.w * vs_COLOR0.w;
    SV_Target0.w = u_xlat7;
    u_xlat16_2.x = (u_xlatb3) ? 1.0 : 0.0;
    u_xlat16_6 = u_xlat16_1.x * _Color.x + (-u_xlat16_12);
    u_xlat16_12 = u_xlat16_2.x * u_xlat16_6 + u_xlat16_12;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_12);
#else
#if defined(_EMISSION)
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_1.xyz = texture(_EmissionMap, vs_TEXCOORD1.xy).xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_EmissionColor.x, _EmissionColor.y, _EmissionColor.z) + u_xlat0.xyz;
    SV_Target0 = u_xlat0;
#else
#if defined(_FADING_ON)
    u_xlat0 = vs_TEXCOORD3.z + (-_CameraFadeParams.x);
    u_xlat0 = u_xlat0 * _CameraFadeParams.y;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * _Color;
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat1.w = u_xlat0 * u_xlat1.w;
    SV_Target0 = u_xlat1;
#else
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#endif
#endif
#endif
#else
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
#endif
#endif
    return;
}
#endif
			ENDGLSL
		}
	}
	Fallback "VertexLit"
}
