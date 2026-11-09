// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Particle/Mesh/Brightness/Add"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		[HideInInspector] _Cull("Cull", Float) = 2
		[HideInInspector] _ZWrite("ZWrite", Float) = 0
		[HideInInspector] _ZTest("ZTest", Float) = 4
		[HideInInspector] _ApplyFog("Apply Fog", Float) = 0
		[HideInInspector] _BlendMode("Blend Mode", Float) = 0
		[HideInInspector] _BlendSrc("Blend Src", Float) = 1
		[HideInInspector] _BlendDst("Blend Dst", Float) = 0
	}
	SubShader
	{
		Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
		LOD 100
		Pass
		{
			Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend [_BlendSrc] [_BlendDst], [_BlendSrc] [_BlendDst]
			ZTest [_ZTest]
			ZWrite [_ZWrite]
			Cull [_Cull]
			GLSLPROGRAM
#pragma multi_compile _ APPLY_FOG
#pragma multi_compile _ CALC_DEPTH
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
#if defined(APPLY_FOG)
uniform 	vec4 _ProjectionParams;
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if defined(APPLY_FOG)
#if defined(INSTANCING_ON)
uniform 	int unity_BaseInstanceID;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
#endif
#endif
uniform 	vec2 _SekaiFogFactor;
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
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};
layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
#else
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerDraw {
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
#endif
#endif
#else
#if defined(INSTANCING_ON)
uniform 	int unity_BaseInstanceID;
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
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};
layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
#else
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerDraw {
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
#endif
#endif
#endif
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
#if defined(APPLY_FOG)
#if defined(CALC_DEPTH)
#if defined(INSTANCING_ON)
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD3;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec4 vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
layout(location = 3) out mediump float vs_TEXCOORD3;
layout(location = 4) out highp float vs_TEXCOORD4;
layout(location = 5) out highp vec3 vs_TEXCOORD2;
#else
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD3;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
#endif
#endif
#else
#if defined(INSTANCING_ON)
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 4) out highp vec4 vs_TEXCOORD0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out mediump float vs_TEXCOORD3;
layout(location = 3) out highp vec3 vs_TEXCOORD2;
#else
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
#endif
#endif
#endif
#else
#if defined(CALC_DEPTH)
#if defined(INSTANCING_ON)
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec4 vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
layout(location = 3) out highp float vs_TEXCOORD4;
layout(location = 4) out highp vec3 vs_TEXCOORD2;
#else
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
#endif
#endif
#else
#if defined(INSTANCING_ON)
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 3) out highp vec4 vs_TEXCOORD0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec3 vs_TEXCOORD2;
#else
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
#endif
#endif
#endif
#endif
vec4 u_xlat0;
#if defined(APPLY_FOG)
#if defined(CALC_DEPTH)
#if defined(INSTANCING_ON)
int u_xlati0;
vec4 u_xlat1;
float u_xlat2;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
vec3 u_xlat8;
uvec3 u_xlatu8;
bool u_xlatb21;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#else
vec4 u_xlat1;
float u_xlat2;
#endif
#endif
#else
#if defined(INSTANCING_ON)
int u_xlati0;
vec4 u_xlat1;
float u_xlat2;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec2 u_xlat7;
vec3 u_xlat8;
uvec3 u_xlatu8;
float u_xlat14;
bool u_xlatb21;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#else
vec4 u_xlat1;
float u_xlat2;
#endif
#endif
#endif
#else
#if defined(INSTANCING_ON)
int u_xlati0;
vec4 u_xlat1;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
vec2 u_xlat1;
int u_xlati1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
vec3 u_xlat8;
uvec3 u_xlatu8;
vec2 u_xlat14;
uint uint_bitfieldExtract(uint value, int offset, int bits) { return (value >> uint(offset)) & uint(~(int(~0) << uint(bits))); }
#else
vec4 u_xlat1;
#endif
#endif
#endif
void main()
{
#if defined(APPLY_FOG)
#if defined(CALC_DEPTH)
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
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat1;
    vs_TEXCOORD4 = u_xlat1.z;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
    vs_TEXCOORD1.xy = vec2(0.0, 0.0);
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat8.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat8.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat3.y = dot(u_xlat3, u_xlat0);
    u_xlat6 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat8.x;
    u_xlat2.z = u_xlat8.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat3.x = dot(u_xlat4, u_xlat0);
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat6;
    u_xlat2.w = u_xlat5.z;
    u_xlat3.z = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu8.x = uint(floatBitsToUint(u_xlat5.w)) & 255u;
    u_xlat3.x = float(u_xlatu8.x);
    u_xlatu8.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat5.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat5.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu8.z = uint(floatBitsToUint(u_xlat5.w)) >> (24u & uint(0x1F));
    u_xlat3.yzw = vec3(u_xlatu8.xyz);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    vs_TEXCOORD0 = u_xlat0;
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat7 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat7 = floor(u_xlat7);
    u_xlat1.x = u_xlat7 * unity_ParticleUVShiftData.z;
    u_xlat7 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat7;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = u_xlat0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb21 = unity_ParticleUVShiftData.x!=0.0;
    vs_TEXCOORD1.xy = (bool(u_xlatb21)) ? u_xlat1.xy : u_xlat0.xy;
    vs_TEXCOORD4 = u_xlat0.z;
    u_xlat0.x = u_xlat0.z + _ProjectionParams.y;
    u_xlat7 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat7;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat1;
    vs_TEXCOORD4 = u_xlat1.z;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
    vs_TEXCOORD1.xy = vec2(0.0, 0.0);
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat1;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
    vs_TEXCOORD1.xy = vec2(0.0, 0.0);
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat8.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat8.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat3.y = dot(u_xlat3, u_xlat0);
    u_xlat6 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat8.x;
    u_xlat2.z = u_xlat8.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat3.x = dot(u_xlat4, u_xlat0);
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat6;
    u_xlat2.w = u_xlat5.z;
    u_xlat3.z = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu8.x = uint(floatBitsToUint(u_xlat5.w)) & 255u;
    u_xlat3.x = float(u_xlatu8.x);
    u_xlatu8.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat5.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat5.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu8.z = uint(floatBitsToUint(u_xlat5.w)) >> (24u & uint(0x1F));
    u_xlat3.yzw = vec3(u_xlatu8.xyz);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    vs_TEXCOORD0 = u_xlat0;
    u_xlat0.x = u_xlat0.z + _ProjectionParams.y;
    u_xlat7.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat14 = (-u_xlat7.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat14 = floor(u_xlat14);
    u_xlat1.x = u_xlat14 * unity_ParticleUVShiftData.z;
    u_xlat14 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat7.x) * unity_ParticleUVShiftData.w + u_xlat14;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = u_xlat7.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb21 = unity_ParticleUVShiftData.x!=0.0;
    vs_TEXCOORD1.xy = (bool(u_xlatb21)) ? u_xlat1.xy : u_xlat7.xy;
    u_xlat7.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat7.x;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat1;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
    vs_TEXCOORD1.xy = vec2(0.0, 0.0);
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
#endif
#endif
#endif
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD3 = u_xlat0.x;
#else
#if defined(CALC_DEPTH)
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
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat1;
    vs_TEXCOORD4 = u_xlat1.z;
    vs_TEXCOORD1.xy = vec2(0.0, 0.0);
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat8.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat8.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat3.y = dot(u_xlat3, u_xlat0);
    u_xlat6 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat8.x;
    u_xlat2.z = u_xlat8.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat3.x = dot(u_xlat4, u_xlat0);
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat6;
    u_xlat2.w = u_xlat5.z;
    u_xlat3.z = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu8.x = uint(floatBitsToUint(u_xlat5.w)) & 255u;
    u_xlat3.x = float(u_xlatu8.x);
    u_xlatu8.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat5.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat5.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu8.z = uint(floatBitsToUint(u_xlat5.w)) >> (24u & uint(0x1F));
    u_xlat3.yzw = vec3(u_xlatu8.xyz);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    vs_TEXCOORD0 = u_xlat0;
    vs_TEXCOORD4 = u_xlat0.z;
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat7 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat7 = floor(u_xlat7);
    u_xlat1.x = u_xlat7 * unity_ParticleUVShiftData.z;
    u_xlat7 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat7;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat14.xy = u_xlat0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb1 = unity_ParticleUVShiftData.x!=0.0;
    vs_TEXCOORD1.xy = (bool(u_xlatb1)) ? u_xlat14.xy : u_xlat0.xy;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat1;
    vs_TEXCOORD4 = u_xlat1.z;
    vs_TEXCOORD1.xy = vec2(0.0, 0.0);
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_TEXCOORD0 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = vec2(0.0, 0.0);
#else
#if defined(PROCEDURAL_INSTANCING_ON)
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat8.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat8.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat3.y = dot(u_xlat3, u_xlat0);
    u_xlat6 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat8.x;
    u_xlat2.z = u_xlat8.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat3.x = dot(u_xlat4, u_xlat0);
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat6;
    u_xlat2.w = u_xlat5.z;
    u_xlat3.z = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0;
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu8.x = uint(floatBitsToUint(u_xlat5.w)) & 255u;
    u_xlat2.x = float(u_xlatu8.x);
    u_xlatu8.xy = uvec2(uint_bitfieldExtract(uint(floatBitsToUint(u_xlat5.w)), int(8) & int(0x1F), int(8) & int(0x1F)), uint_bitfieldExtract(uint(floatBitsToUint(u_xlat5.w)), int(16) & int(0x1F), int(8) & int(0x1F)));
    u_xlatu8.z = uint(floatBitsToUint(u_xlat5.w)) >> (24u & uint(0x1F));
    u_xlat2.yzw = vec3(u_xlatu8.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat7 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat7 = floor(u_xlat7);
    u_xlat1.x = u_xlat7 * unity_ParticleUVShiftData.z;
    u_xlat7 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat7;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat14.xy = u_xlat0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb1 = unity_ParticleUVShiftData.x!=0.0;
    vs_TEXCOORD1.xy = (bool(u_xlatb1)) ? u_xlat14.xy : u_xlat0.xy;
#else
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_TEXCOORD0 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = vec2(0.0, 0.0);
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
#if defined(CALC_DEPTH)
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _CoCParams;
#endif
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiGlowLightIntensity;
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
#if defined(APPLY_FOG)
uniform 	vec4 _SekaiFogColor;
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
#if defined(APPLY_FOG)
#if defined(CALC_DEPTH)
#if defined(INSTANCING_ON)
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD3;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec4 vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 3) in mediump float vs_TEXCOORD3;
layout(location = 4) in highp float vs_TEXCOORD4;
layout(location = 5) in highp vec3 vs_TEXCOORD2;
#else
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD3;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
#endif
#endif
#else
#if defined(INSTANCING_ON)
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 2) in mediump float vs_TEXCOORD3;
layout(location = 3) in highp vec3 vs_TEXCOORD2;
#else
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
#endif
#endif
#endif
#else
#if defined(CALC_DEPTH)
#if defined(INSTANCING_ON)
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec4 vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 3) in highp float vs_TEXCOORD4;
layout(location = 4) in highp vec3 vs_TEXCOORD2;
#else
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
#endif
#endif
#else
#if defined(INSTANCING_ON)
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
#else
#if defined(PROCEDURAL_INSTANCING_ON)
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 2) in highp vec3 vs_TEXCOORD2;
#else
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
#endif
#endif
#endif
#endif
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
#if defined(APPLY_FOG)
mediump float u_xlat16_3;
vec3 u_xlat6;
mediump float u_xlat16_7;
float u_xlat10;
#else
vec3 u_xlat5;
float u_xlat8;
#endif
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(vec3(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
    u_xlat1.w = u_xlat0.w * _SekaiGlowLightIntensity;
    u_xlat0 = u_xlat1 * vec4(_SekaiAllLightIntensity);
    u_xlatb2 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb2){
        u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat2.xy = u_xlat2.xy * u_xlat2.xy;
        u_xlat2.x = u_xlat2.y + u_xlat2.x;
        u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
#if defined(APPLY_FOG)
        u_xlat6.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat5.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
        u_xlat2.x = u_xlat2.x + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(APPLY_FOG)
        u_xlat6.x = float(1.0) / u_xlat6.x;
        u_xlat2.x = u_xlat6.x * u_xlat2.x;
#else
        u_xlat5.x = float(1.0) / u_xlat5.x;
        u_xlat2.x = u_xlat5.x * u_xlat2.x;
#endif
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#if defined(APPLY_FOG)
        u_xlat6.x = u_xlat2.x * -2.0 + 3.0;
#else
        u_xlat5.x = u_xlat2.x * -2.0 + 3.0;
#endif
        u_xlat2.x = u_xlat2.x * u_xlat2.x;
#if defined(APPLY_FOG)
        u_xlat10 = u_xlat2.x * u_xlat6.x;
        u_xlat2.x = (-u_xlat6.x) * u_xlat2.x + 1.0;
        u_xlat6.xyz = u_xlat0.xyz * vec3(u_xlat10);
        u_xlat6.xyz = u_xlat6.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat2.xxx * u_xlat0.xyz + u_xlat6.xyz;
#else
        u_xlat8 = u_xlat2.x * u_xlat5.x;
        u_xlat2.x = (-u_xlat5.x) * u_xlat2.x + 1.0;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat8);
        u_xlat5.xyz = u_xlat5.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat2.xxx * u_xlat0.xyz + u_xlat5.xyz;
#endif
    }
#if defined(APPLY_FOG)
    u_xlat16_3 = max(u_xlat0.z, u_xlat0.y);
    u_xlat16_3 = max(u_xlat0.x, u_xlat16_3);
    u_xlat16_3 = u_xlat0.w * u_xlat16_3;
    u_xlat16_7 = (-vs_TEXCOORD3) + 1.0;
    u_xlat2.x = u_xlat16_7 * _SekaiFogColor.w;
    u_xlat6.xyz = _SekaiFogColor.xyz * vec3(u_xlat16_3) + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat2.xxx * u_xlat6.xyz + u_xlat0.xyz;
#endif
    SV_Target2 = u_xlat0 * vec4(0.5, 0.5, 0.5, 0.5);
#if defined(APPLY_FOG)
#if defined(CALC_DEPTH)
    u_xlat2.x = vs_TEXCOORD4 / vs_TEXCOORD0.w;
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat6.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat6.x = u_xlat6.x + -1.0;
    u_xlat6.x = u_xlat6.x * _ProjectionParams.w;
    u_xlat2.x = u_xlat6.x * u_xlat2.x + _ProjectionParams.w;
    u_xlat2.x = (-_CoCParams.x) * u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * _CoCParams.y;
    u_xlat6.x = u_xlat2.x;
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, -1.0);
    u_xlat2.x = min(u_xlat2.x, 0.0);
    u_xlat2.x = u_xlat2.x + u_xlat6.x;
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
#endif
#else
#if defined(CALC_DEPTH)
    u_xlat2.x = vs_TEXCOORD4 / vs_TEXCOORD0.w;
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat5.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat5.x = u_xlat5.x + -1.0;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.w;
    u_xlat2.x = u_xlat5.x * u_xlat2.x + _ProjectionParams.w;
    u_xlat2.x = (-_CoCParams.x) * u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * _CoCParams.y;
    u_xlat5.x = u_xlat2.x;
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, -1.0);
    u_xlat2.x = min(u_xlat2.x, 0.0);
    u_xlat2.x = u_xlat2.x + u_xlat5.x;
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
#endif
#endif
    SV_Target0 = u_xlat0;
#if defined(CALC_DEPTH)
    SV_Target1.x = u_xlat2.x;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
#else
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
#endif
    return;
}
#endif
			ENDGLSL
		}
	}
}
