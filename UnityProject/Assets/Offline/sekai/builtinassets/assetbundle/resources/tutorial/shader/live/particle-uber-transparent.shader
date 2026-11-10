// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Particle/Uber-Transparent"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Soft("Soft", Vector) = (0.1, 0, 0, 0)
		_Intensity("Intensity", Range(0, 2)) = 0.1
		_ColorTex("ColorMap", 2D) = "white" {}
		_Color("Color", Color) = (1, 1, 1, 1)
		[HideInInspector] _Cull("Cull", Float) = 0
		[HideInInspector] _ZWrite("ZWrite", Float) = 0
		[HideInInspector] _ZTest("ZTest", Float) = 4
		[HideInInspector] _ZAlpha("ZAlpha", Float) = 0
		[HideInInspector] _ApplyFog("Apply Fog", Float) = 0
		[HideInInspector] _BlendMode("Blend Mode", Float) = 0
		[HideInInspector] _BlendSrc("Blend Src", Float) = 1
		[HideInInspector] _BlendDst("Blend Dst", Float) = 0
		[HideInInspector] _TransparentMode("Transparent Mode", Float) = 0
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
#pragma multi_compile _ BRIGHTNESS COLORMAP SOFT
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
#if defined(APPLY_FOG)
uniform 	vec4 _ProjectionParams;
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if defined(APPLY_FOG)
uniform 	vec2 _SekaiFogFactor;
#endif
uniform 	vec4 _MainTex_ST;
#if defined(BRIGHTNESS)
uniform 	vec4 _Color;
#else
#if defined(COLORMAP)
uniform 	vec4 _ColorTex_ST;
#else
uniform 	vec4 _Color;
#endif
#endif
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
#if !defined(BRIGHTNESS)
#if defined(COLORMAP)
UNITY_LOCATION(1) uniform mediump sampler2D _ColorTex;
#endif
#endif
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
#if defined(APPLY_FOG)
out mediump float vs_TEXCOORD3;
#endif
#if defined(CALC_DEPTH)
out highp float vs_TEXCOORD4;
#endif
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
#if defined(APPLY_FOG)
float u_xlat2;
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
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
#if !defined(APPLY_FOG)
#if !defined(CALC_DEPTH)
    vs_TEXCOORD0 = u_xlat1;
#endif
#endif
#if defined(BRIGHTNESS)
    vs_COLOR0 = in_COLOR0 * _Color;
#else
#if defined(COLORMAP)
    u_xlat0.xy = in_COLOR0.xy * _ColorTex_ST.xy + _ColorTex_ST.zw;
    vs_COLOR0 = textureLod(_ColorTex, u_xlat0.xy, 0.0);
#else
    vs_COLOR0 = in_COLOR0 * _Color;
#endif
#endif
#if defined(APPLY_FOG)
    vs_TEXCOORD0 = u_xlat1;
#if defined(CALC_DEPTH)
    vs_TEXCOORD4 = u_xlat1.z;
#endif
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
#else
#if defined(CALC_DEPTH)
    vs_TEXCOORD0 = u_xlat1;
    vs_TEXCOORD4 = u_xlat1.z;
#endif
#endif
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#if defined(APPLY_FOG)
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD3 = u_xlat0.x;
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
#if defined(BRIGHTNESS)
uniform 	float _Intensity;
#else
#if defined(COLORMAP)
uniform 	vec4 _Color;
#else
#if defined(SOFT)
uniform 	int _BlendMode;
uniform 	vec4 _Soft;
#endif
#endif
#endif
#if defined(CALC_DEPTH)
uniform 	int _ZAlpha;
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
#if defined(CALC_DEPTH)
in highp vec4 vs_TEXCOORD0;
#endif
in highp vec2 vs_TEXCOORD1;
#if defined(APPLY_FOG)
in mediump float vs_TEXCOORD3;
#endif
#if defined(CALC_DEPTH)
in highp float vs_TEXCOORD4;
#endif
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
#if defined(APPLY_FOG)
#if defined(CALC_DEPTH)
bool u_xlatb0;
vec4 u_xlat1;
#if defined(BRIGHTNESS)
vec4 u_xlat2;
#else
#if defined(COLORMAP)
vec3 u_xlat2;
#else
#if defined(SOFT)
vec4 u_xlat2;
#else
vec3 u_xlat2;
#endif
#endif
#endif
mediump float u_xlat16_3;
float u_xlat4;
#if defined(BRIGHTNESS)
mediump float u_xlat16_7;
float u_xlat8;
#else
#if defined(COLORMAP)
mediump float u_xlat16_7;
float u_xlat8;
#else
#if defined(SOFT)
float u_xlat5;
bool u_xlatb6;
mediump float u_xlat16_8;
float u_xlat10;
#else
mediump float u_xlat16_7;
float u_xlat8;
#endif
#endif
#endif
#else
#if defined(BRIGHTNESS)
vec4 u_xlat1;
#else
vec3 u_xlat1;
#endif
bool u_xlatb1;
#if defined(BRIGHTNESS)
mediump float u_xlat16_2;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat7;
#else
#if defined(COLORMAP)
mediump float u_xlat16_2;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat7;
#else
#if defined(SOFT)
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_8;
float u_xlat11;
#else
mediump float u_xlat16_2;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat7;
#endif
#endif
#endif
#endif
#else
#if defined(CALC_DEPTH)
bool u_xlatb0;
vec4 u_xlat1;
#if defined(BRIGHTNESS)
vec4 u_xlat2;
#else
#if defined(COLORMAP)
vec3 u_xlat2;
#else
#if defined(SOFT)
vec4 u_xlat2;
#else
vec3 u_xlat2;
#endif
#endif
#endif
mediump float u_xlat16_3;
float u_xlat4;
#if defined(BRIGHTNESS)
mediump float u_xlat16_7;
float u_xlat8;
#else
#if defined(COLORMAP)
mediump float u_xlat16_7;
float u_xlat8;
#else
#if defined(SOFT)
float u_xlat5;
bool u_xlatb6;
mediump float u_xlat16_8;
float u_xlat10;
#else
mediump float u_xlat16_7;
float u_xlat8;
#endif
#endif
#endif
#else
#if defined(BRIGHTNESS)
vec4 u_xlat1;
#else
vec3 u_xlat1;
#endif
bool u_xlatb1;
#if defined(BRIGHTNESS)
vec3 u_xlat3;
float u_xlat5;
#else
#if defined(COLORMAP)
vec3 u_xlat3;
float u_xlat5;
#else
#if defined(SOFT)
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
float u_xlat9;
#else
vec3 u_xlat3;
float u_xlat5;
#endif
#endif
#endif
#endif
#endif
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
#if defined(APPLY_FOG)
#if defined(BRIGHTNESS)
    u_xlat0 = u_xlat0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
#else
#if defined(COLORMAP)
    u_xlat0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
#else
#if defined(SOFT)
    u_xlat1.x = vs_TEXCOORD2.y * _Soft.w + _Soft.z;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlatb6 = _BlendMode==1;
    u_xlat4 = (u_xlatb6) ? 1.0 : u_xlat1.x;
    u_xlat2.x = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat4;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat0.w * u_xlat1.x;
    u_xlat0 = u_xlat2 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
#else
    u_xlat0 = u_xlat0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
#endif
#endif
#endif
#if defined(CALC_DEPTH)
    u_xlat1 = u_xlat0 * vec4(_SekaiAllLightIntensity);
    u_xlatb0 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb0){
        u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
        u_xlat0.x = u_xlat0.y + u_xlat0.x;
        u_xlat0.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
#if defined(BRIGHTNESS)
        u_xlat4 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
#if defined(COLORMAP)
        u_xlat4 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
#if defined(SOFT)
        u_xlat5 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat4 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
#endif
#endif
        u_xlat0.x = u_xlat0.x + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(BRIGHTNESS)
        u_xlat4 = float(1.0) / u_xlat4;
        u_xlat0.x = u_xlat4 * u_xlat0.x;
#else
#if defined(COLORMAP)
        u_xlat4 = float(1.0) / u_xlat4;
        u_xlat0.x = u_xlat4 * u_xlat0.x;
#else
#if defined(SOFT)
        u_xlat5 = float(1.0) / u_xlat5;
        u_xlat0.x = u_xlat5 * u_xlat0.x;
#else
        u_xlat4 = float(1.0) / u_xlat4;
        u_xlat0.x = u_xlat4 * u_xlat0.x;
#endif
#endif
#endif
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#if defined(BRIGHTNESS)
        u_xlat4 = u_xlat0.x * -2.0 + 3.0;
#else
#if defined(COLORMAP)
        u_xlat4 = u_xlat0.x * -2.0 + 3.0;
#else
#if defined(SOFT)
        u_xlat5 = u_xlat0.x * -2.0 + 3.0;
#else
        u_xlat4 = u_xlat0.x * -2.0 + 3.0;
#endif
#endif
#endif
        u_xlat0.x = u_xlat0.x * u_xlat0.x;
#if defined(BRIGHTNESS)
        u_xlat8 = u_xlat0.x * u_xlat4;
        u_xlat0.x = (-u_xlat4) * u_xlat0.x + 1.0;
        u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat8);
#else
#if defined(COLORMAP)
        u_xlat8 = u_xlat0.x * u_xlat4;
        u_xlat0.x = (-u_xlat4) * u_xlat0.x + 1.0;
        u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat8);
#else
#if defined(SOFT)
        u_xlat10 = u_xlat0.x * u_xlat5;
        u_xlat0.x = (-u_xlat5) * u_xlat0.x + 1.0;
        u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat10);
#else
        u_xlat8 = u_xlat0.x * u_xlat4;
        u_xlat0.x = (-u_xlat4) * u_xlat0.x + 1.0;
        u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat8);
#endif
#endif
#endif
        u_xlat2.xyz = u_xlat2.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
#else
    u_xlat0 = u_xlat0 * vec4(_SekaiAllLightIntensity);
    u_xlatb1 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb1){
        u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xy = u_xlat1.xy * u_xlat1.xy;
        u_xlat1.x = u_xlat1.y + u_xlat1.x;
        u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
#if defined(BRIGHTNESS)
        u_xlat4.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
#if defined(COLORMAP)
        u_xlat4.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
#if defined(SOFT)
        u_xlat6.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat4.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
#endif
#endif
        u_xlat1.x = u_xlat1.x + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(BRIGHTNESS)
        u_xlat4.x = float(1.0) / u_xlat4.x;
        u_xlat1.x = u_xlat4.x * u_xlat1.x;
#else
#if defined(COLORMAP)
        u_xlat4.x = float(1.0) / u_xlat4.x;
        u_xlat1.x = u_xlat4.x * u_xlat1.x;
#else
#if defined(SOFT)
        u_xlat6.x = float(1.0) / u_xlat6.x;
        u_xlat1.x = u_xlat6.x * u_xlat1.x;
#else
        u_xlat4.x = float(1.0) / u_xlat4.x;
        u_xlat1.x = u_xlat4.x * u_xlat1.x;
#endif
#endif
#endif
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#if defined(BRIGHTNESS)
        u_xlat4.x = u_xlat1.x * -2.0 + 3.0;
#else
#if defined(COLORMAP)
        u_xlat4.x = u_xlat1.x * -2.0 + 3.0;
#else
#if defined(SOFT)
        u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
#else
        u_xlat4.x = u_xlat1.x * -2.0 + 3.0;
#endif
#endif
#endif
        u_xlat1.x = u_xlat1.x * u_xlat1.x;
#if defined(BRIGHTNESS)
        u_xlat7 = u_xlat1.x * u_xlat4.x;
        u_xlat1.x = (-u_xlat4.x) * u_xlat1.x + 1.0;
        u_xlat4.xyz = u_xlat0.xyz * vec3(u_xlat7);
        u_xlat4.xyz = u_xlat4.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat4.xyz;
#else
#if defined(COLORMAP)
        u_xlat7 = u_xlat1.x * u_xlat4.x;
        u_xlat1.x = (-u_xlat4.x) * u_xlat1.x + 1.0;
        u_xlat4.xyz = u_xlat0.xyz * vec3(u_xlat7);
        u_xlat4.xyz = u_xlat4.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat4.xyz;
#else
#if defined(SOFT)
        u_xlat11 = u_xlat1.x * u_xlat6.x;
        u_xlat1.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
        u_xlat6.xyz = u_xlat0.xyz * vec3(u_xlat11);
        u_xlat6.xyz = u_xlat6.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat6.xyz;
#else
        u_xlat7 = u_xlat1.x * u_xlat4.x;
        u_xlat1.x = (-u_xlat4.x) * u_xlat1.x + 1.0;
        u_xlat4.xyz = u_xlat0.xyz * vec3(u_xlat7);
        u_xlat4.xyz = u_xlat4.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat4.xyz;
#endif
#endif
#endif
#endif
#else
#if defined(CALC_DEPTH)
#if defined(BRIGHTNESS)
    u_xlat0 = u_xlat0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
#else
#if defined(COLORMAP)
    u_xlat0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
#else
#if defined(SOFT)
    u_xlat1.x = vs_TEXCOORD2.y * _Soft.w + _Soft.z;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlatb6 = _BlendMode==1;
    u_xlat4 = (u_xlatb6) ? 1.0 : u_xlat1.x;
    u_xlat2.x = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat4;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat0.w * u_xlat1.x;
    u_xlat0 = u_xlat2 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
#else
    u_xlat0 = u_xlat0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
#endif
#endif
#endif
    u_xlat1 = u_xlat0 * vec4(_SekaiAllLightIntensity);
    u_xlatb0 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb0){
        u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
        u_xlat0.x = u_xlat0.y + u_xlat0.x;
        u_xlat0.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
#if defined(BRIGHTNESS)
        u_xlat4 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
#if defined(COLORMAP)
        u_xlat4 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
#if defined(SOFT)
        u_xlat5 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat4 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
#endif
#endif
        u_xlat0.x = u_xlat0.x + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(BRIGHTNESS)
        u_xlat4 = float(1.0) / u_xlat4;
        u_xlat0.x = u_xlat4 * u_xlat0.x;
#else
#if defined(COLORMAP)
        u_xlat4 = float(1.0) / u_xlat4;
        u_xlat0.x = u_xlat4 * u_xlat0.x;
#else
#if defined(SOFT)
        u_xlat5 = float(1.0) / u_xlat5;
        u_xlat0.x = u_xlat5 * u_xlat0.x;
#else
        u_xlat4 = float(1.0) / u_xlat4;
        u_xlat0.x = u_xlat4 * u_xlat0.x;
#endif
#endif
#endif
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#if defined(BRIGHTNESS)
        u_xlat4 = u_xlat0.x * -2.0 + 3.0;
#else
#if defined(COLORMAP)
        u_xlat4 = u_xlat0.x * -2.0 + 3.0;
#else
#if defined(SOFT)
        u_xlat5 = u_xlat0.x * -2.0 + 3.0;
#else
        u_xlat4 = u_xlat0.x * -2.0 + 3.0;
#endif
#endif
#endif
        u_xlat0.x = u_xlat0.x * u_xlat0.x;
#if defined(BRIGHTNESS)
        u_xlat8 = u_xlat0.x * u_xlat4;
        u_xlat0.x = (-u_xlat4) * u_xlat0.x + 1.0;
        u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat8);
#else
#if defined(COLORMAP)
        u_xlat8 = u_xlat0.x * u_xlat4;
        u_xlat0.x = (-u_xlat4) * u_xlat0.x + 1.0;
        u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat8);
#else
#if defined(SOFT)
        u_xlat10 = u_xlat0.x * u_xlat5;
        u_xlat0.x = (-u_xlat5) * u_xlat0.x + 1.0;
        u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat10);
#else
        u_xlat8 = u_xlat0.x * u_xlat4;
        u_xlat0.x = (-u_xlat4) * u_xlat0.x + 1.0;
        u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat8);
#endif
#endif
#endif
        u_xlat2.xyz = u_xlat2.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
#else
#if defined(BRIGHTNESS)
    u_xlat0 = u_xlat0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
#else
#if defined(COLORMAP)
    u_xlat0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
#else
#if defined(SOFT)
    u_xlat1.x = vs_TEXCOORD2.y * _Soft.w + _Soft.z;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlatb5 = _BlendMode==1;
    u_xlat3 = (u_xlatb5) ? 1.0 : u_xlat1.x;
    u_xlat2.x = (u_xlatb5) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat3;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat0.w * u_xlat1.x;
    u_xlat0 = u_xlat2 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
#else
    u_xlat0 = u_xlat0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
#endif
#endif
#endif
    u_xlat0 = u_xlat0 * vec4(_SekaiAllLightIntensity);
    u_xlatb1 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb1){
        u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xy = u_xlat1.xy * u_xlat1.xy;
        u_xlat1.x = u_xlat1.y + u_xlat1.x;
        u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
#if defined(BRIGHTNESS)
        u_xlat3.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
#if defined(COLORMAP)
        u_xlat3.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
#if defined(SOFT)
        u_xlat5.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat3.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
#endif
#endif
        u_xlat1.x = u_xlat1.x + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(BRIGHTNESS)
        u_xlat3.x = float(1.0) / u_xlat3.x;
        u_xlat1.x = u_xlat3.x * u_xlat1.x;
#else
#if defined(COLORMAP)
        u_xlat3.x = float(1.0) / u_xlat3.x;
        u_xlat1.x = u_xlat3.x * u_xlat1.x;
#else
#if defined(SOFT)
        u_xlat5.x = float(1.0) / u_xlat5.x;
        u_xlat1.x = u_xlat5.x * u_xlat1.x;
#else
        u_xlat3.x = float(1.0) / u_xlat3.x;
        u_xlat1.x = u_xlat3.x * u_xlat1.x;
#endif
#endif
#endif
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#if defined(BRIGHTNESS)
        u_xlat3.x = u_xlat1.x * -2.0 + 3.0;
#else
#if defined(COLORMAP)
        u_xlat3.x = u_xlat1.x * -2.0 + 3.0;
#else
#if defined(SOFT)
        u_xlat5.x = u_xlat1.x * -2.0 + 3.0;
#else
        u_xlat3.x = u_xlat1.x * -2.0 + 3.0;
#endif
#endif
#endif
        u_xlat1.x = u_xlat1.x * u_xlat1.x;
#if defined(BRIGHTNESS)
        u_xlat5 = u_xlat1.x * u_xlat3.x;
        u_xlat1.x = (-u_xlat3.x) * u_xlat1.x + 1.0;
        u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat5);
        u_xlat3.xyz = u_xlat3.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat3.xyz;
#else
#if defined(COLORMAP)
        u_xlat5 = u_xlat1.x * u_xlat3.x;
        u_xlat1.x = (-u_xlat3.x) * u_xlat1.x + 1.0;
        u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat5);
        u_xlat3.xyz = u_xlat3.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat3.xyz;
#else
#if defined(SOFT)
        u_xlat9 = u_xlat1.x * u_xlat5.x;
        u_xlat1.x = (-u_xlat5.x) * u_xlat1.x + 1.0;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat9);
        u_xlat5.xyz = u_xlat5.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat5.xyz;
#else
        u_xlat5 = u_xlat1.x * u_xlat3.x;
        u_xlat1.x = (-u_xlat3.x) * u_xlat1.x + 1.0;
        u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat5);
        u_xlat3.xyz = u_xlat3.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat3.xyz;
#endif
#endif
#endif
#endif
#endif
    }
#if defined(APPLY_FOG)
#if defined(CALC_DEPTH)
    u_xlat16_3 = max(u_xlat1.z, u_xlat1.y);
    u_xlat16_3 = max(u_xlat1.x, u_xlat16_3);
    u_xlat16_3 = u_xlat1.w * u_xlat16_3;
#if defined(BRIGHTNESS)
    u_xlat16_7 = (-vs_TEXCOORD3) + 1.0;
    u_xlat0.x = u_xlat16_7 * _SekaiFogColor.w;
#else
#if defined(COLORMAP)
    u_xlat16_7 = (-vs_TEXCOORD3) + 1.0;
    u_xlat0.x = u_xlat16_7 * _SekaiFogColor.w;
#else
#if defined(SOFT)
    u_xlat16_8 = (-vs_TEXCOORD3) + 1.0;
    u_xlat0.x = u_xlat16_8 * _SekaiFogColor.w;
#else
    u_xlat16_7 = (-vs_TEXCOORD3) + 1.0;
    u_xlat0.x = u_xlat16_7 * _SekaiFogColor.w;
#endif
#endif
#endif
    u_xlat2.xyz = _SekaiFogColor.xyz * vec3(u_xlat16_3) + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
#if defined(BRIGHTNESS)
    u_xlat2 = u_xlat1 * vec4(_Intensity);
    u_xlat2 = u_xlat2 * vec4(0.5, 0.5, 0.5, 0.5);
#endif
    u_xlat16_3 = float(_ZAlpha);
#if defined(BRIGHTNESS)
    u_xlat16_7 = u_xlat0.w * _SekaiAllLightIntensity + -1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7 + 1.0;
#else
#if defined(COLORMAP)
    u_xlat16_7 = u_xlat0.w * _SekaiAllLightIntensity + -1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7 + 1.0;
#else
#if defined(SOFT)
    u_xlat16_8 = u_xlat0.w * _SekaiAllLightIntensity + -1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_8 + 1.0;
#else
    u_xlat16_7 = u_xlat0.w * _SekaiAllLightIntensity + -1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7 + 1.0;
#endif
#endif
#endif
    u_xlat0.x = vs_TEXCOORD4 / vs_TEXCOORD0.w;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#if defined(BRIGHTNESS)
    u_xlat4 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat4 = u_xlat4 + -1.0;
    u_xlat4 = u_xlat4 * _ProjectionParams.w;
    u_xlat0.x = u_xlat4 * u_xlat0.x + _ProjectionParams.w;
#else
#if defined(COLORMAP)
    u_xlat4 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat4 = u_xlat4 + -1.0;
    u_xlat4 = u_xlat4 * _ProjectionParams.w;
    u_xlat0.x = u_xlat4 * u_xlat0.x + _ProjectionParams.w;
#else
#if defined(SOFT)
    u_xlat5 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat5 = u_xlat5 + -1.0;
    u_xlat5 = u_xlat5 * _ProjectionParams.w;
    u_xlat0.x = u_xlat5 * u_xlat0.x + _ProjectionParams.w;
#else
    u_xlat4 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat4 = u_xlat4 + -1.0;
    u_xlat4 = u_xlat4 * _ProjectionParams.w;
    u_xlat0.x = u_xlat4 * u_xlat0.x + _ProjectionParams.w;
#endif
#endif
#endif
    u_xlat0.x = (-_CoCParams.x) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _CoCParams.y;
#if defined(BRIGHTNESS)
    u_xlat4 = u_xlat0.x;
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#else
#if defined(COLORMAP)
    u_xlat4 = u_xlat0.x;
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#else
#if defined(SOFT)
    u_xlat5 = u_xlat0.x;
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#else
    u_xlat4 = u_xlat0.x;
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
#endif
#endif
    u_xlat0.x = max(u_xlat0.x, -1.0);
    u_xlat0.x = min(u_xlat0.x, 0.0);
#if defined(BRIGHTNESS)
    u_xlat0.x = u_xlat0.x + u_xlat4;
#else
#if defined(COLORMAP)
    u_xlat0.x = u_xlat0.x + u_xlat4;
#else
#if defined(SOFT)
    u_xlat0.x = u_xlat0.x + u_xlat5;
#else
    u_xlat0.x = u_xlat0.x + u_xlat4;
#endif
#endif
#endif
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat0.y = float(0.0);
    u_xlat0.z = float(0.0);
    u_xlat0.w = float(1.0);
    u_xlat0 = vec4(u_xlat16_3) * u_xlat0;
    SV_Target0 = u_xlat1;
    SV_Target1 = u_xlat0;
#if defined(BRIGHTNESS)
    SV_Target2 = u_xlat2;
#else
    SV_Target2 = vec4(0.0, 0.0, 0.0, 1.0);
#endif
#else
#if defined(BRIGHTNESS)
    u_xlat16_2 = max(u_xlat0.z, u_xlat0.y);
    u_xlat16_2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat16_2 = u_xlat0.w * u_xlat16_2;
    u_xlat16_5 = (-vs_TEXCOORD3) + 1.0;
    u_xlat1.x = u_xlat16_5 * _SekaiFogColor.w;
    u_xlat4.xyz = _SekaiFogColor.xyz * vec3(u_xlat16_2) + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xxx * u_xlat4.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0 * vec4(_Intensity);
    u_xlat1 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.5);
#else
#if defined(COLORMAP)
    u_xlat16_2 = max(u_xlat0.z, u_xlat0.y);
    u_xlat16_2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat16_2 = u_xlat0.w * u_xlat16_2;
    u_xlat16_5 = (-vs_TEXCOORD3) + 1.0;
    u_xlat1.x = u_xlat16_5 * _SekaiFogColor.w;
    u_xlat4.xyz = _SekaiFogColor.xyz * vec3(u_xlat16_2) + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xxx * u_xlat4.xyz + u_xlat0.xyz;
#else
#if defined(SOFT)
    u_xlat16_3 = max(u_xlat0.z, u_xlat0.y);
    u_xlat16_3 = max(u_xlat0.x, u_xlat16_3);
    u_xlat16_3 = u_xlat0.w * u_xlat16_3;
    u_xlat16_8 = (-vs_TEXCOORD3) + 1.0;
    u_xlat1.x = u_xlat16_8 * _SekaiFogColor.w;
    u_xlat6.xyz = _SekaiFogColor.xyz * vec3(u_xlat16_3) + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xxx * u_xlat6.xyz + u_xlat0.xyz;
#else
    u_xlat16_2 = max(u_xlat0.z, u_xlat0.y);
    u_xlat16_2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat16_2 = u_xlat0.w * u_xlat16_2;
    u_xlat16_5 = (-vs_TEXCOORD3) + 1.0;
    u_xlat1.x = u_xlat16_5 * _SekaiFogColor.w;
    u_xlat4.xyz = _SekaiFogColor.xyz * vec3(u_xlat16_2) + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xxx * u_xlat4.xyz + u_xlat0.xyz;
#endif
#endif
#endif
    SV_Target0 = u_xlat0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
#if defined(BRIGHTNESS)
    SV_Target2 = u_xlat1;
#else
    SV_Target2 = vec4(0.0, 0.0, 0.0, 1.0);
#endif
#endif
#else
#if defined(CALC_DEPTH)
#if defined(BRIGHTNESS)
    u_xlat2 = u_xlat1 * vec4(_Intensity);
    u_xlat2 = u_xlat2 * vec4(0.5, 0.5, 0.5, 0.5);
#endif
    u_xlat16_3 = float(_ZAlpha);
#if defined(BRIGHTNESS)
    u_xlat16_7 = u_xlat0.w * _SekaiAllLightIntensity + -1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7 + 1.0;
#else
#if defined(COLORMAP)
    u_xlat16_7 = u_xlat0.w * _SekaiAllLightIntensity + -1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7 + 1.0;
#else
#if defined(SOFT)
    u_xlat16_8 = u_xlat0.w * _SekaiAllLightIntensity + -1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_8 + 1.0;
#else
    u_xlat16_7 = u_xlat0.w * _SekaiAllLightIntensity + -1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7 + 1.0;
#endif
#endif
#endif
    u_xlat0.x = vs_TEXCOORD4 / vs_TEXCOORD0.w;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#if defined(BRIGHTNESS)
    u_xlat4 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat4 = u_xlat4 + -1.0;
    u_xlat4 = u_xlat4 * _ProjectionParams.w;
    u_xlat0.x = u_xlat4 * u_xlat0.x + _ProjectionParams.w;
#else
#if defined(COLORMAP)
    u_xlat4 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat4 = u_xlat4 + -1.0;
    u_xlat4 = u_xlat4 * _ProjectionParams.w;
    u_xlat0.x = u_xlat4 * u_xlat0.x + _ProjectionParams.w;
#else
#if defined(SOFT)
    u_xlat5 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat5 = u_xlat5 + -1.0;
    u_xlat5 = u_xlat5 * _ProjectionParams.w;
    u_xlat0.x = u_xlat5 * u_xlat0.x + _ProjectionParams.w;
#else
    u_xlat4 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat4 = u_xlat4 + -1.0;
    u_xlat4 = u_xlat4 * _ProjectionParams.w;
    u_xlat0.x = u_xlat4 * u_xlat0.x + _ProjectionParams.w;
#endif
#endif
#endif
    u_xlat0.x = (-_CoCParams.x) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _CoCParams.y;
#if defined(BRIGHTNESS)
    u_xlat4 = u_xlat0.x;
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#else
#if defined(COLORMAP)
    u_xlat4 = u_xlat0.x;
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#else
#if defined(SOFT)
    u_xlat5 = u_xlat0.x;
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#else
    u_xlat4 = u_xlat0.x;
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
#endif
#endif
    u_xlat0.x = max(u_xlat0.x, -1.0);
    u_xlat0.x = min(u_xlat0.x, 0.0);
#if defined(BRIGHTNESS)
    u_xlat0.x = u_xlat0.x + u_xlat4;
#else
#if defined(COLORMAP)
    u_xlat0.x = u_xlat0.x + u_xlat4;
#else
#if defined(SOFT)
    u_xlat0.x = u_xlat0.x + u_xlat5;
#else
    u_xlat0.x = u_xlat0.x + u_xlat4;
#endif
#endif
#endif
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat0.y = float(0.0);
    u_xlat0.z = float(0.0);
    u_xlat0.w = float(1.0);
    u_xlat0 = vec4(u_xlat16_3) * u_xlat0;
    SV_Target0 = u_xlat1;
    SV_Target1 = u_xlat0;
#if defined(BRIGHTNESS)
    SV_Target2 = u_xlat2;
#else
    SV_Target2 = vec4(0.0, 0.0, 0.0, 1.0);
#endif
#else
#if defined(BRIGHTNESS)
    u_xlat1 = u_xlat0 * vec4(_Intensity);
    u_xlat1 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.5);
#endif
    SV_Target0 = u_xlat0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
#if defined(BRIGHTNESS)
    SV_Target2 = u_xlat1;
#else
    SV_Target2 = vec4(0.0, 0.0, 0.0, 1.0);
#endif
#endif
#endif
    return;
}
#endif
			ENDGLSL
		}
	}
}
