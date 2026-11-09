// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Brightness/SphereMap"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Intensity("Intensity", Range(0, 2)) = 0.1
	}
	SubShader
	{
		Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
		LOD 100
		Pass
		{
			Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
			Cull Off
			GLSLPROGRAM
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _SekaiFogFactor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD3;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat4;
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
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_TEXCOORD0 = u_xlat1;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[1].xy * hlslcc_mtx4x4unity_ObjectToWorld[1].yy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * hlslcc_mtx4x4unity_ObjectToWorld[1].xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * hlslcc_mtx4x4unity_ObjectToWorld[1].zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[3].xy * hlslcc_mtx4x4unity_ObjectToWorld[1].ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * in_NORMAL0.yy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[1].xy * hlslcc_mtx4x4unity_ObjectToWorld[0].yy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * hlslcc_mtx4x4unity_ObjectToWorld[0].xx + u_xlat4.xy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * hlslcc_mtx4x4unity_ObjectToWorld[0].zz + u_xlat4.xy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[3].xy * hlslcc_mtx4x4unity_ObjectToWorld[0].ww + u_xlat4.xy;
    u_xlat0.xy = u_xlat4.xy * in_NORMAL0.xx + u_xlat0.xy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[1].xy * hlslcc_mtx4x4unity_ObjectToWorld[2].yy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * hlslcc_mtx4x4unity_ObjectToWorld[2].xx + u_xlat4.xy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * hlslcc_mtx4x4unity_ObjectToWorld[2].zz + u_xlat4.xy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[3].xy * hlslcc_mtx4x4unity_ObjectToWorld[2].ww + u_xlat4.xy;
    u_xlat0.xy = u_xlat4.xy * in_NORMAL0.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD4 = u_xlat1.z;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD3 = u_xlat0.x;
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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform Props {
#endif
	UNITY_UNIFORM float                _Intensity;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
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
vec3 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat7;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
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
    u_xlat16_5 = (-vs_TEXCOORD3) + 1.0;
    u_xlat1.x = u_xlat16_5 * _SekaiFogColor.w;
    u_xlat4.xyz = _SekaiFogColor.xyz * vec3(u_xlat16_2) + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xxx * u_xlat4.xyz + u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD4 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat4.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat4.x = u_xlat4.x + -1.0;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.w;
    u_xlat1.x = u_xlat4.x * u_xlat1.x + _ProjectionParams.w;
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
    u_xlat4.x = u_xlat1.x;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat1.x = max(u_xlat1.x, -1.0);
    u_xlat1.x = min(u_xlat1.x, 0.0);
    u_xlat1.x = u_xlat1.x + u_xlat4.x;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * 0.5;
    u_xlat2 = u_xlat0 * vec4(_Intensity);
    u_xlat2 = u_xlat2 * vec4(0.5, 0.5, 0.5, 0.5);
    SV_Target0 = u_xlat0;
    SV_Target1.x = u_xlat1.x;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2 = u_xlat2;
    return;
}
#endif
			ENDGLSL
		}
	}
}
