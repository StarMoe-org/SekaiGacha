// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Default/Transparent"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		[HideInInspector] _Color("Color", Color) = (1, 1, 1, 1)
		[HideInInspector] _Cull("Cull", Float) = 0
		[HideInInspector] _ZWrite("ZWrite", Float) = 0
		[HideInInspector] _ZTest("ZTest", Float) = 4
		[HideInInspector] _BlendMode("Blend Mode", Float) = 0
		[HideInInspector] _BlendSrc("Blend Src", Float) = 1
		[HideInInspector] _BlendDst("Blend Dst", Float) = 0
		_RotateTheta("UV Rotate Theta", Range(-180, 180)) = 0
		_RotateOffset("UV Rotate Offset", Float) = 0
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if defined(INSTANCING_ON)
uniform 	int unity_BaseInstanceID;
#endif
uniform 	vec2 _SekaiFogFactor;
uniform 	vec4 _MainTex_ST;
uniform 	int _BlendSrc;
uniform 	int _BlendDst;
#if defined(INSTANCING_ON)
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type                unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
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
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if defined(INSTANCING_ON)
struct PropsArray_Type {
	vec4 _Color;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type                PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#else
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform Props {
#endif
	UNITY_UNIFORM vec4                _Color;
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD3;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
#if defined(INSTANCING_ON)
float u_xlat0;
ivec4 u_xlati0;
#else
vec4 u_xlat0;
mediump float u_xlat16_0;
bvec4 u_xlatb0;
#endif
vec4 u_xlat1;
#if defined(INSTANCING_ON)
mediump float u_xlat16_1;
#else
bvec4 u_xlatb1;
#endif
vec4 u_xlat2;
#if defined(INSTANCING_ON)
bool u_xlatb2;
float u_xlat3;
int u_xlati3;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
#else
float u_xlat4;
bool u_xlatb4;
float u_xlat7;
bool u_xlatb7;
#endif
void main()
{
#if defined(INSTANCING_ON)
    u_xlati0 = ivec4(uvec4(equal(ivec4(_BlendSrc, _BlendSrc, _BlendDst, _BlendDst), ivec4(1, 5, 1, 10))) * 0xFFFFFFFFu);
    u_xlati0.x = int(uint(uint(u_xlati0.y) | uint(u_xlati0.x)));
    u_xlati0.xy = ivec2(uvec2(uint(u_xlati0.z) & uint(u_xlati0.x), uint(u_xlati0.w) & uint(u_xlati0.y)));
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat16_1 = max(PropsArray[u_xlati6]._Color.z, PropsArray[u_xlati6]._Color.y);
    u_xlat16_1 = max(u_xlat16_1, PropsArray[u_xlati6]._Color.x);
    u_xlatb9 = u_xlat16_1>=0.00999999978;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlatb2 = PropsArray[u_xlati6]._Color.w>=0.00999999978;
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat3 = (u_xlati0.y != 0) ? u_xlat2.x : 1.0;
    u_xlat0 = (u_xlati0.x != 0) ? u_xlat9 : u_xlat3;
    u_xlati3 = int(u_xlati6 << (3 & int(0x1F)));
    vs_COLOR0 = in_COLOR0 * PropsArray[u_xlati6]._Color;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    gl_Position = vec4(u_xlat0) * u_xlat2;
#else
    u_xlat16_0 = max(_Color.z, _Color.y);
    u_xlat16_0 = max(u_xlat16_0, _Color.x);
    u_xlatb1.x = u_xlat16_0>=0.00999999978;
    u_xlatb0 = equal(ivec4(_BlendSrc, _BlendSrc, _BlendDst, _BlendDst), ivec4(1, 5, 1, 10));
    u_xlatb4 = u_xlatb0.y || u_xlatb0.x;
    u_xlatb4 = u_xlatb0.z && u_xlatb4;
    u_xlatb7 = u_xlatb0.w && u_xlatb0.y;
    u_xlatb1.w = _Color.w>=0.00999999978;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat7 = (u_xlatb7) ? u_xlat1.w : 1.0;
    u_xlat1.x = (u_xlatb4) ? u_xlat1.x : u_xlat7;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1.xxxx * u_xlat2;
    vs_COLOR0 = in_COLOR0 * _Color;
#endif
    vs_TEXCOORD0 = u_xlat2;
    vs_TEXCOORD4 = u_xlat2.z;
#if defined(INSTANCING_ON)
    u_xlat0 = u_xlat2.z + _ProjectionParams.y;
#else
    u_xlat1.x = u_xlat2.z + _ProjectionParams.y;
#endif
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#if defined(INSTANCING_ON)
    u_xlat3 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0 = u_xlat0 / u_xlat3;
    u_xlat0 = u_xlat0 * _ProjectionParams.z;
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlat0 = (-_SekaiFogFactor.y) * u_xlat0 + _SekaiFogFactor.x;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    vs_TEXCOORD3 = u_xlat0;
#else
    u_xlat4 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat1.x = u_xlat1.x / u_xlat4;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = (-_SekaiFogFactor.y) * u_xlat1.x + _SekaiFogFactor.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    vs_TEXCOORD3 = u_xlat1.x;
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
uniform 	float _RotateTheta;
uniform 	float _RotateOffset;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD3;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_6;
vec3 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0.x = _RotateTheta * 0.0174532942;
    u_xlat16_1 = sin(u_xlat0.x);
    u_xlat16_2 = cos(u_xlat0.x);
    u_xlat16_3.x = (-u_xlat16_1);
    u_xlat0.xy = vs_TEXCOORD1.xy + (-vec2(_RotateOffset));
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_3.z = u_xlat16_1;
    u_xlat4.x = dot(u_xlat0.xy, u_xlat16_3.yz);
    u_xlat4.y = dot(u_xlat0.xy, u_xlat16_3.xy);
    u_xlat0.xy = u_xlat4.xy + vec2(_RotateOffset);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat0 = u_xlat0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
    u_xlat0 = u_xlat0 * vec4(_SekaiAllLightIntensity);
    u_xlatb4 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb4){
        u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat4.xy = u_xlat4.xy * u_xlat4.xy;
        u_xlat4.x = u_xlat4.y + u_xlat4.x;
        u_xlat4.x = u_xlat4.z * u_xlat4.z + u_xlat4.x;
        u_xlat9.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat4.x = u_xlat4.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat9.x = float(1.0) / u_xlat9.x;
        u_xlat4.x = u_xlat9.x * u_xlat4.x;
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
        u_xlat9.x = u_xlat4.x * -2.0 + 3.0;
        u_xlat4.x = u_xlat4.x * u_xlat4.x;
        u_xlat14 = u_xlat4.x * u_xlat9.x;
        u_xlat4.x = (-u_xlat9.x) * u_xlat4.x + 1.0;
        u_xlat9.xyz = u_xlat0.xyz * vec3(u_xlat14);
        u_xlat9.xyz = u_xlat9.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat4.xxx * u_xlat0.xyz + u_xlat9.xyz;
    }
    u_xlat16_1 = max(u_xlat0.z, u_xlat0.y);
    u_xlat16_1 = max(u_xlat0.x, u_xlat16_1);
    u_xlat16_1 = u_xlat0.w * u_xlat16_1;
    u_xlat16_6 = (-vs_TEXCOORD3) + 1.0;
    u_xlat4.x = u_xlat16_6 * _SekaiFogColor.w;
    u_xlat9.xyz = _SekaiFogColor.xyz * vec3(u_xlat16_1) + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat4.xxx * u_xlat9.xyz + u_xlat0.xyz;
    u_xlat4.x = vs_TEXCOORD4 / vs_TEXCOORD0.w;
    u_xlat4.x = u_xlat4.x * 0.5 + 0.5;
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat9.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9.x = u_xlat9.x + -1.0;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.w;
    u_xlat4.x = u_xlat9.x * u_xlat4.x + _ProjectionParams.w;
    u_xlat4.x = (-_CoCParams.x) * u_xlat4.x + 1.0;
    u_xlat4.x = u_xlat4.x * _CoCParams.y;
    u_xlat9.x = u_xlat4.x;
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
    u_xlat4.x = max(u_xlat4.x, -1.0);
    u_xlat4.x = min(u_xlat4.x, 0.0);
    u_xlat4.x = u_xlat4.x + u_xlat9.x;
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat1.x = u_xlat4.x * 0.5;
    u_xlat4.x = float(_ZWrite);
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(1.0);
    u_xlat1 = u_xlat1 * u_xlat4.xxxx;
    SV_Target0 = u_xlat0;
    SV_Target1 = u_xlat1;
    SV_Target2 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}
#endif
			ENDGLSL
		}
	}
}
