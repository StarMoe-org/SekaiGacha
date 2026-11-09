// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Brightness/Billboard-Transparent"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Intensity("Intensity", Range(0, 2)) = 0.1
		_FloatMeshDist("FloatMeshDist", Range(0, 20)) = 0
		[HideInInspector] _Color("Color", Color) = (1, 1, 1, 1)
		[HideInInspector] _Scale("Scale", Float) = 0
		[HideInInspector] _Alpha("Alpha", Float) = 0
		[HideInInspector] _Axis("Axis", Float) = 0
		[HideInInspector] _Cull("Cull", Float) = 0
		[HideInInspector] _ZWrite("ZWrite", Float) = 0
		[HideInInspector] _ZTest("ZTest", Float) = 4
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
#pragma multi_compile _ INSTANCING_ON
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
#if defined(INSTANCING_ON)
uniform 	int unity_BaseInstanceID;
#endif
uniform 	vec2 _SekaiFogFactor;
uniform 	vec4 _MainTex_ST;
uniform 	int _Scale;
uniform 	int _Alpha;
uniform 	int _Axis;
uniform 	int _BlendSrc;
uniform 	int _BlendDst;
#if defined(INSTANCING_ON)
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type                unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#else
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
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if defined(INSTANCING_ON)
struct PropsArray_Type {
	vec4 _Color;
	float _Intensity;
	float _FloatMeshDist;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type                PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#else
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform Props {
#endif
	UNITY_UNIFORM vec4                _Color;
	UNITY_UNIFORM float                _Intensity;
	UNITY_UNIFORM float                _FloatMeshDist;
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out mediump float vs_TEXCOODRD4;
out highp vec3 vs_TEXCOORD3;
out highp float vs_TEXCOORD5;
vec4 u_xlat0;
#if !defined(INSTANCING_ON)
mediump float u_xlat16_0;
#endif
bvec4 u_xlatb0;
#if defined(INSTANCING_ON)
vec2 u_xlat1;
ivec2 u_xlati1;
#else
vec4 u_xlat1;
bvec4 u_xlatb1;
#endif
vec4 u_xlat2;
#if defined(INSTANCING_ON)
vec3 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
float u_xlat6;
float u_xlat10;
bool u_xlatb10;
ivec2 u_xlati11;
float u_xlat15;
int u_xlati15;
#else
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat6;
ivec2 u_xlati6;
bool u_xlatb6;
vec2 u_xlat11;
bool u_xlatb11;
float u_xlat16;
float u_xlat17;
#endif
void main()
{
#if defined(INSTANCING_ON)
    u_xlat0.z = 0.0;
    u_xlati1.xy = (-ivec2(_Scale, _Axis)) + ivec2(1, 1);
    u_xlat1.xy = vec2(u_xlati1.xy);
    u_xlati15 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati11.xy = ivec2(int(u_xlati15) << (int(3) & int(0x1F)), int(u_xlati15) << (int(1) & int(0x1F)));
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati11.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati11.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati11.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati11.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat2.xyz = vec3(ivec3(_Scale, _Axis, _Alpha));
    u_xlat1.x = u_xlat2.x * u_xlat15 + u_xlat1.x;
    u_xlat6 = u_xlat1.y * in_POSITION0.z;
    u_xlat2.y = u_xlat2.y * in_POSITION0.y + u_xlat6;
    u_xlat15 = u_xlat2.z * u_xlat15 + 1.0;
    vs_TEXCOORD2 = (-u_xlat2.z) + u_xlat15;
    u_xlat2.x = in_POSITION0.x;
    u_xlat15 = dot(unity_Builtins0Array[u_xlati11.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati11.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat3.x = sqrt(u_xlat15);
    u_xlat15 = dot(unity_Builtins0Array[u_xlati11.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati11.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat3.y = sqrt(u_xlat15);
    u_xlat2.xy = u_xlat2.xy * u_xlat3.xy;
    u_xlat0.xy = u_xlat1.xx * u_xlat2.xy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati11.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati11.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati11.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_MatrixV[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[0].z;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[1].z;
    u_xlat2.z = hlslcc_mtx4x4glstate_matrix_projection[2].z;
    u_xlat2.w = hlslcc_mtx4x4glstate_matrix_projection[3].z;
#else
    u_xlat16_0 = max(_Color.z, _Color.y);
    u_xlat16_0 = max(u_xlat16_0, _Color.x);
    u_xlatb1.x = u_xlat16_0>=0.00999999978;
    u_xlatb0 = equal(ivec4(_BlendSrc, _BlendSrc, _BlendDst, _BlendDst), ivec4(1, 5, 1, 10));
    u_xlatb6 = u_xlatb0.y || u_xlatb0.x;
    u_xlatb6 = u_xlatb0.z && u_xlatb6;
    u_xlatb11 = u_xlatb0.w && u_xlatb0.y;
    u_xlatb1.w = _Color.w>=0.00999999978;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat11.x = (u_xlatb11) ? u_xlat1.w : 1.0;
    u_xlat1.x = (u_xlatb6) ? u_xlat1.x : u_xlat11.x;
    u_xlat6.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat2.x = sqrt(u_xlat6.x);
    u_xlat6.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat2.y = sqrt(u_xlat6.x);
    u_xlat3.x = in_POSITION0.x;
    u_xlati6.xy = (-ivec2(_Scale, _Axis)) + ivec2(1, 1);
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat11.x = u_xlat6.y * in_POSITION0.z;
    u_xlat4.xyz = vec3(ivec3(_Scale, _Axis, _Alpha));
    u_xlat3.y = u_xlat4.y * in_POSITION0.y + u_xlat11.x;
    u_xlat11.xy = u_xlat2.xy * u_xlat3.xy;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat6.x = u_xlat4.x * u_xlat2.x + u_xlat6.x;
    u_xlat2.x = u_xlat4.z * u_xlat2.x + 1.0;
    vs_TEXCOORD2 = (-u_xlat4.z) + u_xlat2.x;
    u_xlat2.xy = u_xlat6.xx * u_xlat11.xy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_MatrixV[3].xyz;
    u_xlat2.z = 0.0;
    u_xlat0.xyz = u_xlat6.xyz + u_xlat2.xyz;
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[0].x;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[2].x;
    u_xlat2.z = hlslcc_mtx4x4glstate_matrix_projection[3].x;
#endif
    u_xlat0.w = 1.0;
#if defined(INSTANCING_ON)
    u_xlat1.x = dot(u_xlat2, u_xlat0);
    u_xlat6 = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat2.x = _ProjectionParams.x * PropsArray[u_xlati11.y / 2]._FloatMeshDist;
    u_xlat6 = u_xlat2.x / u_xlat6;
    u_xlat2.z = (-u_xlat6) + u_xlat1.x;
    u_xlat3.x = hlslcc_mtx4x4glstate_matrix_projection[0].x;
    u_xlat3.y = hlslcc_mtx4x4glstate_matrix_projection[2].x;
    u_xlat3.z = hlslcc_mtx4x4glstate_matrix_projection[3].x;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat0.xzw);
#else
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat0.xzw);
#endif
    u_xlat3.x = hlslcc_mtx4x4glstate_matrix_projection[1].y;
    u_xlat3.y = hlslcc_mtx4x4glstate_matrix_projection[2].y;
#if defined(INSTANCING_ON)
    u_xlat3.z = hlslcc_mtx4x4glstate_matrix_projection[3].y;
#else
    u_xlat3.zw = hlslcc_mtx4x4glstate_matrix_projection[3].yz;
#endif
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat0.yzw);
#if defined(INSTANCING_ON)
    u_xlat0.x = hlslcc_mtx4x4glstate_matrix_projection[2].w;
    u_xlat0.y = hlslcc_mtx4x4glstate_matrix_projection[3].w;
    u_xlat2.w = dot(u_xlat0.xy, u_xlat0.zw);
    u_xlat16_4 = max(PropsArray[u_xlati11.y / 2]._Color.z, PropsArray[u_xlati11.y / 2]._Color.y);
    u_xlat16_4 = max(u_xlat16_4, PropsArray[u_xlati11.y / 2]._Color.x);
    u_xlatb0.x = u_xlat16_4>=0.00999999978;
    u_xlatb3 = equal(ivec4(_BlendSrc, _BlendSrc, _BlendDst, _BlendDst), ivec4(1, 5, 1, 10));
    u_xlatb5 = u_xlatb3.y || u_xlatb3.x;
    u_xlatb5 = u_xlatb3.z && u_xlatb5;
    u_xlatb10 = u_xlatb3.w && u_xlatb3.y;
    u_xlatb0.w = PropsArray[u_xlati11.y / 2]._Color.w>=0.00999999978;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat10 = (u_xlatb10) ? u_xlat0.w : 1.0;
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : u_xlat10;
    gl_Position = u_xlat0.xxxx * u_xlat2;
#else
    u_xlat3.xz = hlslcc_mtx4x4glstate_matrix_projection[2].wz;
    u_xlat3.y = hlslcc_mtx4x4glstate_matrix_projection[3].w;
    u_xlat2.w = dot(u_xlat3.xy, u_xlat0.zw);
    u_xlat3.x = hlslcc_mtx4x4glstate_matrix_projection[0].z;
    u_xlat3.y = hlslcc_mtx4x4glstate_matrix_projection[1].z;
    u_xlat6.x = dot(u_xlat3, u_xlat0);
    u_xlat11.x = _ProjectionParams.x * _FloatMeshDist;
    u_xlat16 = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat11.x = u_xlat11.x / u_xlat16;
    u_xlat2.z = (-u_xlat11.x) + u_xlat6.x;
    gl_Position = u_xlat1.xxxx * u_xlat2;
#endif
    vs_TEXCOORD0.xyw = u_xlat2.xyw;
#if defined(INSTANCING_ON)
    vs_COLOR0 = in_COLOR0 * PropsArray[u_xlati11.y / 2]._Color;
    vs_TEXCOORD3.xyz = unity_Builtins0Array[u_xlati11.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    vs_TEXCOORD0.z = u_xlat1.x;
#else
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.z = u_xlat6.x;
#endif
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#if defined(INSTANCING_ON)
    vs_TEXCOORD5 = u_xlat1.x;
    u_xlat0.x = u_xlat1.x + _ProjectionParams.y;
    u_xlat5 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat5;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOODRD4 = u_xlat0.x;
#else
    vs_TEXCOORD5 = u_xlat6.x;
    u_xlat1.x = u_xlat6.x + _ProjectionParams.y;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat6.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat1.x = u_xlat1.x / u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = (-_SekaiFogFactor.y) * u_xlat1.x + _SekaiFogFactor.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    vs_TEXCOODRD4 = u_xlat1.x;
#endif
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
#if defined(INSTANCING_ON)
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _CoCParams;
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiGlowLightIntensity;
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
uniform 	vec4 _SekaiFogColor;
uniform 	int _ZWrite;
#if defined(INSTANCING_ON)
struct PropsArray_Type {
	vec4 _Color;
	float _Intensity;
	float _FloatMeshDist;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type                PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#else
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform Props {
#endif
	UNITY_UNIFORM vec4                _Color;
	UNITY_UNIFORM float                _Intensity;
	UNITY_UNIFORM float                _FloatMeshDist;
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump float vs_TEXCOODRD4;
in highp vec3 vs_TEXCOORD3;
in highp float vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
float u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat7;
float u_xlat9;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat0 = u_xlat0 * vec4(vs_TEXCOORD2);
    u_xlat0 = u_xlat0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
    u_xlat0 = u_xlat0 * vec4(_SekaiAllLightIntensity);
    u_xlatb1 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb1){
        u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xy = u_xlat1.xy * u_xlat1.xy;
        u_xlat1.x = u_xlat1.y + u_xlat1.x;
        u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
        u_xlat5.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat1.x = u_xlat1.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat5.x = float(1.0) / u_xlat5.x;
        u_xlat1.x = u_xlat5.x * u_xlat1.x;
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
        u_xlat5.x = u_xlat1.x * -2.0 + 3.0;
        u_xlat1.x = u_xlat1.x * u_xlat1.x;
        u_xlat9 = u_xlat1.x * u_xlat5.x;
        u_xlat1.x = (-u_xlat5.x) * u_xlat1.x + 1.0;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat9);
        u_xlat5.xyz = u_xlat5.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat5.xyz;
    }
    u_xlat16_2 = max(u_xlat0.z, u_xlat0.y);
    u_xlat16_2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat16_2 = u_xlat0.w * u_xlat16_2;
    u_xlat16_6 = (-vs_TEXCOODRD4) + 1.0;
    u_xlat1.x = u_xlat16_6 * _SekaiFogColor.w;
    u_xlat5.xyz = _SekaiFogColor.xyz * vec3(u_xlat16_2) + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xxx * u_xlat5.xyz + u_xlat0.xyz;
#if defined(INSTANCING_ON)
    u_xlat1 = u_xlat0 * vec4(PropsArray[0]._Intensity);
#else
    u_xlat1 = u_xlat0 * vec4(_Intensity);
#endif
    u_xlat1 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat2.yzw = vec3(vec3(_ZWrite));
    u_xlat3 = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat3 = u_xlat3 * 0.5 + 0.5;
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat7 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat7 = u_xlat7 + -1.0;
    u_xlat7 = u_xlat7 * _ProjectionParams.w;
    u_xlat3 = u_xlat7 * u_xlat3 + _ProjectionParams.w;
    u_xlat3 = (-_CoCParams.x) * u_xlat3 + 1.0;
    u_xlat3 = u_xlat3 * _CoCParams.y;
    u_xlat7 = u_xlat3;
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
    u_xlat3 = max(u_xlat3, -1.0);
    u_xlat3 = min(u_xlat3, 0.0);
    u_xlat3 = u_xlat3 + u_xlat7;
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat2.x = u_xlat2.w * u_xlat3;
    u_xlat2 = u_xlat2 * vec4(0.5, 0.0, 0.0, 1.0);
    SV_Target0 = u_xlat0;
    SV_Target1 = u_xlat2;
    SV_Target2 = u_xlat1;
    return;
}
#endif
			ENDGLSL
		}
	}
}
