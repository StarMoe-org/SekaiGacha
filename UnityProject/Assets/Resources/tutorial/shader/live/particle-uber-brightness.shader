// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Particle/Uber-Brightness"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ColorTex("ColorMap", 2D) = "white" {}
		[HideInInspector] _Cull("Cull", Float) = 0
		[HideInInspector] _ZWrite("ZWrite", Float) = 0
		[HideInInspector] _ZTest("ZTest", Float) = 4
		[HideInInspector] _ApplyFog("Apply Fog", Float) = 0
		[HideInInspector] _BlendMode("Blend Mode", Float) = 0
		[HideInInspector] _BlendSrc("Blend Src", Float) = 1
		[HideInInspector] _BlendDst("Blend Dst", Float) = 0
		[HideInInspector] _BrightnessMode("Brightness Mode", Float) = 0
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
#pragma multi_compile _ COLORMAP
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
#if defined(COLORMAP)
uniform 	vec4 _ColorTex_ST;
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
in highp vec4 in_POSITION0;
#if !defined(COLORMAP)
in highp vec4 in_COLOR0;
#endif
in highp vec2 in_TEXCOORD0;
#if defined(COLORMAP)
in highp vec2 in_TEXCOORD1;
#else
out highp vec4 vs_COLOR0;
#endif
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
#if defined(APPLY_FOG)
#if defined(CALC_DEPTH)
#if defined(COLORMAP)
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump float vs_TEXCOORD4;
out highp float vs_TEXCOORD5;
#else
out mediump float vs_TEXCOORD3;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
#endif
#else
#if defined(COLORMAP)
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump float vs_TEXCOORD4;
#else
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
#endif
#endif
#else
#if defined(CALC_DEPTH)
#if defined(COLORMAP)
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp float vs_TEXCOORD5;
#else
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
#endif
#else
#if defined(COLORMAP)
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
#else
out highp vec3 vs_TEXCOORD2;
#endif
#endif
#endif
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
#if defined(COLORMAP)
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
#else
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
#endif
    gl_Position = u_xlat1;
#if !defined(APPLY_FOG)
#if !defined(CALC_DEPTH)
    vs_TEXCOORD0 = u_xlat1;
#endif
#endif
#if !defined(COLORMAP)
    vs_COLOR0 = in_COLOR0;
#endif
#if defined(APPLY_FOG)
    vs_TEXCOORD0 = u_xlat1;
#if defined(CALC_DEPTH)
#if !defined(COLORMAP)
    vs_TEXCOORD4 = u_xlat1.z;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
#endif
#else
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
#endif
#else
#if defined(CALC_DEPTH)
    vs_TEXCOORD0 = u_xlat1;
#if defined(COLORMAP)
    vs_TEXCOORD5 = u_xlat1.z;
#else
    vs_TEXCOORD4 = u_xlat1.z;
#endif
#endif
#endif
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#if defined(APPLY_FOG)
#if defined(CALC_DEPTH)
#if defined(COLORMAP)
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * _ColorTex_ST.xy + _ColorTex_ST.zw;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
    vs_TEXCOORD5 = u_xlat1.z;
#endif
#else
#if defined(COLORMAP)
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * _ColorTex_ST.xy + _ColorTex_ST.zw;
#endif
#endif
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#if defined(COLORMAP)
    vs_TEXCOORD4 = u_xlat0.x;
#else
    vs_TEXCOORD3 = u_xlat0.x;
#endif
#else
#if defined(COLORMAP)
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * _ColorTex_ST.xy + _ColorTex_ST.zw;
#endif
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
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
#if defined(COLORMAP)
UNITY_LOCATION(1) uniform mediump sampler2D _ColorTex;
#else
in highp vec4 vs_COLOR0;
#endif
#if defined(CALC_DEPTH)
in highp vec4 vs_TEXCOORD0;
#endif
in highp vec2 vs_TEXCOORD1;
#if defined(APPLY_FOG)
#if defined(CALC_DEPTH)
#if defined(COLORMAP)
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump float vs_TEXCOORD4;
in highp float vs_TEXCOORD5;
#else
in mediump float vs_TEXCOORD3;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
#endif
#else
#if defined(COLORMAP)
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump float vs_TEXCOORD4;
#else
in mediump float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
#endif
#endif
#else
#if defined(CALC_DEPTH)
#if defined(COLORMAP)
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp float vs_TEXCOORD5;
#else
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
#endif
#else
#if defined(COLORMAP)
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
#else
in highp vec3 vs_TEXCOORD2;
#endif
#endif
#endif
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
#if defined(APPLY_FOG)
#if defined(COLORMAP)
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat7;
#else
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat6;
mediump float u_xlat16_7;
float u_xlat10;
#endif
#else
#if defined(COLORMAP)
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
vec3 u_xlat3;
float u_xlat5;
#else
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
vec3 u_xlat5;
float u_xlat8;
#endif
#endif
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
#if defined(APPLY_FOG)
#if defined(COLORMAP)
    u_xlat16_1 = texture(_ColorTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat0 = u_xlat0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
    u_xlat0 = u_xlat0 * vec4(_SekaiAllLightIntensity);
    u_xlatb1 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb1){
        u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
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
#else
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
        u_xlat6.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat2.x = u_xlat2.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat6.x = float(1.0) / u_xlat6.x;
        u_xlat2.x = u_xlat6.x * u_xlat2.x;
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
        u_xlat6.x = u_xlat2.x * -2.0 + 3.0;
        u_xlat2.x = u_xlat2.x * u_xlat2.x;
        u_xlat10 = u_xlat2.x * u_xlat6.x;
        u_xlat2.x = (-u_xlat6.x) * u_xlat2.x + 1.0;
        u_xlat6.xyz = u_xlat0.xyz * vec3(u_xlat10);
        u_xlat6.xyz = u_xlat6.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat2.xxx * u_xlat0.xyz + u_xlat6.xyz;
#endif
#else
#if defined(COLORMAP)
    u_xlat16_1 = texture(_ColorTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat0 = u_xlat0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
    u_xlat0 = u_xlat0 * vec4(_SekaiAllLightIntensity);
    u_xlatb1 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb1){
        u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xy = u_xlat1.xy * u_xlat1.xy;
        u_xlat1.x = u_xlat1.y + u_xlat1.x;
        u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
        u_xlat3.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat1.x = u_xlat1.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat3.x = float(1.0) / u_xlat3.x;
        u_xlat1.x = u_xlat3.x * u_xlat1.x;
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
        u_xlat3.x = u_xlat1.x * -2.0 + 3.0;
        u_xlat1.x = u_xlat1.x * u_xlat1.x;
        u_xlat5 = u_xlat1.x * u_xlat3.x;
        u_xlat1.x = (-u_xlat3.x) * u_xlat1.x + 1.0;
        u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat5);
        u_xlat3.xyz = u_xlat3.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat3.xyz;
#else
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
        u_xlat5.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat2.x = u_xlat2.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat5.x = float(1.0) / u_xlat5.x;
        u_xlat2.x = u_xlat5.x * u_xlat2.x;
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
        u_xlat5.x = u_xlat2.x * -2.0 + 3.0;
        u_xlat2.x = u_xlat2.x * u_xlat2.x;
        u_xlat8 = u_xlat2.x * u_xlat5.x;
        u_xlat2.x = (-u_xlat5.x) * u_xlat2.x + 1.0;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat8);
        u_xlat5.xyz = u_xlat5.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat2.xxx * u_xlat0.xyz + u_xlat5.xyz;
#endif
#endif
    }
#if defined(APPLY_FOG)
#if defined(COLORMAP)
    u_xlat16_2 = max(u_xlat0.z, u_xlat0.y);
    u_xlat16_2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat16_2 = u_xlat0.w * u_xlat16_2;
    u_xlat16_5 = (-vs_TEXCOORD4) + 1.0;
    u_xlat1.x = u_xlat16_5 * _SekaiFogColor.w;
    u_xlat4.xyz = _SekaiFogColor.xyz * vec3(u_xlat16_2) + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xxx * u_xlat4.xyz + u_xlat0.xyz;
#else
    u_xlat16_3 = max(u_xlat0.z, u_xlat0.y);
    u_xlat16_3 = max(u_xlat0.x, u_xlat16_3);
    u_xlat16_3 = u_xlat0.w * u_xlat16_3;
    u_xlat16_7 = (-vs_TEXCOORD3) + 1.0;
    u_xlat2.x = u_xlat16_7 * _SekaiFogColor.w;
    u_xlat6.xyz = _SekaiFogColor.xyz * vec3(u_xlat16_3) + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat2.xxx * u_xlat6.xyz + u_xlat0.xyz;
#endif
#endif
    SV_Target2 = u_xlat0 * vec4(0.5, 0.5, 0.5, 0.5);
#if defined(APPLY_FOG)
#if defined(CALC_DEPTH)
#if defined(COLORMAP)
    u_xlat1.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
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
#else
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
#endif
#else
#if defined(CALC_DEPTH)
#if defined(COLORMAP)
    u_xlat1.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat3.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat3.x = u_xlat3.x + -1.0;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.w;
    u_xlat1.x = u_xlat3.x * u_xlat1.x + _ProjectionParams.w;
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
    u_xlat3.x = u_xlat1.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat1.x = max(u_xlat1.x, -1.0);
    u_xlat1.x = min(u_xlat1.x, 0.0);
    u_xlat1.x = u_xlat1.x + u_xlat3.x;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * 0.5;
#else
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
#endif
    SV_Target0 = u_xlat0;
#if defined(CALC_DEPTH)
#if defined(COLORMAP)
    SV_Target1.x = u_xlat1.x;
#else
    SV_Target1.x = u_xlat2.x;
#endif
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
