// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Brightness/Billboard-Add"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Color("Color", Color) = (1, 1, 1, 1)
		_Intensity("Intensity", Range(0, 2)) = 0.1
		[HideInInspector] _Scale("Scale", Float) = 1
	}
	SubShader
	{
		Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
		LOD 100
		Pass
		{
			Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend One One, One One
			ZWrite Off
			Cull Off
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
uniform 	float _Scale;
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
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
#if defined(INSTANCING_ON)
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
#else
vec4 u_xlat0;
mediump float u_xlat16_0;
float u_xlat1;
bool u_xlatb1;
#endif
vec4 u_xlat2;
vec4 u_xlat3;
#if defined(INSTANCING_ON)
mediump float u_xlat16_4;
float u_xlat5;
ivec3 u_xlati5;
float u_xlat16;
#else
vec3 u_xlat5;
#endif
void main()
{
#if defined(INSTANCING_ON)
    u_xlat0.x = _Scale;
    u_xlat0.z = 0.0;
    u_xlat1.xy = in_POSITION0.xy;
    u_xlat1.z = _Scale;
    u_xlati5.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5.xz = ivec2(u_xlati5.x << (int(3) & int(0x1F)), u_xlati5.x << (int(1) & int(0x1F)));
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati5.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati5.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati5.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati5.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat16 = max(u_xlat16, 0.0);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati5.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati5.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati5.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat2.xyz;
#else
    u_xlat16_0 = max(_Color.z, _Color.y);
    u_xlat16_0 = max(u_xlat16_0, _Color.x);
    u_xlatb1 = u_xlat16_0>=0.00999999978;
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat2.xxx;
    u_xlat5.x = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat2.xy = in_POSITION0.xy;
    u_xlat2.z = _Scale;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat2.xyz;
#endif
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_MatrixV[3].xyz;
#if defined(INSTANCING_ON)
    u_xlat2.xyz = u_xlat1.xyz * u_xlat0.xxz + u_xlat2.xyz;
    vs_TEXCOORD3 = u_xlat1.z;
    u_xlat1.x = hlslcc_mtx4x4glstate_matrix_projection[0].x;
    u_xlat1.y = hlslcc_mtx4x4glstate_matrix_projection[2].x;
    u_xlat1.z = hlslcc_mtx4x4glstate_matrix_projection[3].x;
    u_xlat2.w = 1.0;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xzw);
#else
    u_xlat3.x = _Scale;
    u_xlat3.z = 0.0;
    u_xlat0.xyz = u_xlat5.xyz * u_xlat3.xxz + u_xlat2.xyz;
    vs_TEXCOORD3 = u_xlat5.z;
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[0].x;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[2].x;
    u_xlat2.z = hlslcc_mtx4x4glstate_matrix_projection[3].x;
    u_xlat0.w = 1.0;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat0.xzw);
#endif
    u_xlat3.x = hlslcc_mtx4x4glstate_matrix_projection[1].y;
    u_xlat3.y = hlslcc_mtx4x4glstate_matrix_projection[2].y;
    u_xlat3.zw = hlslcc_mtx4x4glstate_matrix_projection[3].yz;
#if defined(INSTANCING_ON)
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat2.yzw);
#else
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat0.yzw);
#endif
    u_xlat3.xz = hlslcc_mtx4x4glstate_matrix_projection[2].wz;
    u_xlat3.y = hlslcc_mtx4x4glstate_matrix_projection[3].w;
#if defined(INSTANCING_ON)
    u_xlat1.w = dot(u_xlat3.xy, u_xlat2.zw);
#else
    u_xlat2.w = dot(u_xlat3.xy, u_xlat0.zw);
#endif
    u_xlat3.x = hlslcc_mtx4x4glstate_matrix_projection[0].z;
    u_xlat3.y = hlslcc_mtx4x4glstate_matrix_projection[1].z;
#if defined(INSTANCING_ON)
    u_xlat1.z = dot(u_xlat3, u_xlat2);
    u_xlat16_4 = max(PropsArray[u_xlati5.z / 2]._Color.z, PropsArray[u_xlati5.z / 2]._Color.y);
    u_xlat16_4 = max(u_xlat16_4, PropsArray[u_xlati5.z / 2]._Color.x);
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati5.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlatb0 = u_xlat16_4>=0.00999999978;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    gl_Position = u_xlat0.xxxx * u_xlat1;
    vs_TEXCOORD0 = u_xlat1;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
#else
    u_xlat2.z = dot(u_xlat3, u_xlat0);
    gl_Position = vec4(u_xlat1) * u_xlat2;
    vs_TEXCOORD0 = u_xlat2;
    u_xlat1 = u_xlat2.z + _ProjectionParams.y;
#endif
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#if defined(INSTANCING_ON)
    u_xlat5 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat5;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD4 = u_xlat0.x;
#else
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat5.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat1 = u_xlat1 / u_xlat5.x;
    u_xlat1 = u_xlat1 * _ProjectionParams.z;
    u_xlat1 = max(u_xlat1, 0.0);
    u_xlat1 = (-_SekaiFogFactor.y) * u_xlat1 + _SekaiFogFactor.x;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    vs_TEXCOORD4 = u_xlat1;
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
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiGlowLightIntensity;
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
uniform 	vec4 _SekaiFogColor;
#if defined(INSTANCING_ON)
struct PropsArray_Type {
	vec4 _Color;
	float _Intensity;
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
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in mediump float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat7;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
#if defined(INSTANCING_ON)
    u_xlat0 = u_xlat16_0 * PropsArray[0]._Color;
#else
    u_xlat0 = u_xlat16_0 * _Color;
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(vs_TEXCOORD3);
    u_xlat0 = u_xlat0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
    u_xlat0 = u_xlat0 * vec4(_SekaiAllLightIntensity);
    u_xlatb1 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb1){
        u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xy = u_xlat1.xy * u_xlat1.xy;
        u_xlat1.x = u_xlat1.y + u_xlat1.x;
        u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
        u_xlat4.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat1.x = u_xlat1.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat4.x = float(1.0) / u_xlat4.x;
        u_xlat1.x = u_xlat4.x * u_xlat1.x;
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
        u_xlat4.x = u_xlat1.x * -2.0 + 3.0;
        u_xlat1.x = u_xlat1.x * u_xlat1.x;
        u_xlat7 = u_xlat1.x * u_xlat4.x;
        u_xlat1.x = (-u_xlat4.x) * u_xlat1.x + 1.0;
        u_xlat4.xyz = u_xlat0.xyz * vec3(u_xlat7);
        u_xlat4.xyz = u_xlat4.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat4.xyz;
    }
    u_xlat16_2 = max(u_xlat0.z, u_xlat0.y);
    u_xlat16_2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat16_2 = u_xlat0.w * u_xlat16_2;
    u_xlat16_5 = (-vs_TEXCOORD4) + 1.0;
    u_xlat1.x = u_xlat16_5 * _SekaiFogColor.w;
    u_xlat4.xyz = _SekaiFogColor.xyz * vec3(u_xlat16_2) + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xxx * u_xlat4.xyz + u_xlat0.xyz;
#if defined(INSTANCING_ON)
    u_xlat1 = u_xlat0 * vec4(PropsArray[0]._Intensity);
#else
    u_xlat1 = u_xlat0 * vec4(_Intensity);
#endif
    u_xlat1 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.5);
    SV_Target0 = u_xlat0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = u_xlat1;
    return;
}
#endif
			ENDGLSL
		}
	}
}
