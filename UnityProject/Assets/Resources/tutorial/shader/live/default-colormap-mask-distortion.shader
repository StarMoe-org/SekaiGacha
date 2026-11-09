// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Default/ColorMap-Mask-Distortion"
{
	Properties
	{
		_MaskTex("Mask Texture", 2D) = "white" {}
		_MaskDistortionTex("Mask Distortion Texture", 2D) = "white" {}
		_NoiseTex("Noise Texture", 2D) = "white" {}
		_NoiseDistortionTex("Noise Distortion Texture", 2D) = "white" {}
		_MaskDistortionAmount("Mask Distortion Amount", Range(0, 1)) = 0.1
		_MaskDistortionSpeed("Mask Distortion Speed", Vector) = (0, -1, 0, 0)
		_NoiseSpeed("Noise Speed", Vector) = (0, -1, 0, 0)
		_NoiseDistortionAmount("Noise Distortion Amount", Range(0, 1)) = 0.1
		_NoiseDistortionSpeed("Noise Distortion Speed", Vector) = (0, -1, 0, 0)
		_MainColor("Main Color", Color) = (1, 1, 1, 1)
		_Soft("Soft", Vector) = (0.1, 0, 0, 0)
		_Intensity("Intensity", Float) = 1
		_EffectDistortionIntensity("Effect Distortion Intensity", Range(0, 1)) = 0
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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MaskTex_ST;
	UNITY_UNIFORM vec4                _MaskDistortionTex_ST;
	UNITY_UNIFORM mediump vec2                _MaskDistortionSpeed;
	UNITY_UNIFORM mediump float                _MaskDistortionAmount;
	UNITY_UNIFORM vec4                _NoiseTex_ST;
	UNITY_UNIFORM mediump vec2                _NoiseSpeed;
	UNITY_UNIFORM vec4                _NoiseDistortionTex_ST;
	UNITY_UNIFORM mediump vec2                _NoiseDistortionSpeed;
	UNITY_UNIFORM mediump float                _NoiseDistortionAmount;
	UNITY_UNIFORM vec4                _MainColor;
	UNITY_UNIFORM vec4                _Soft;
	UNITY_UNIFORM float                _Intensity;
	UNITY_UNIFORM int                _ZWrite;
	UNITY_UNIFORM int                _BlendMode;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EffectDistortionIntensity;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec2 in_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump float vs_TEXCOORD6;
out highp float vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * _MaskDistortionTex_ST.xy + _MaskDistortionTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD2.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD3.xy * _NoiseDistortionTex_ST.xy + _NoiseDistortionTex_ST.zw;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
    vs_TEXCOORD7 = u_xlat1.z;
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD6 = u_xlat0.x;
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
uniform 	float _PerformanceElapsedTime;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MaskTex_ST;
	UNITY_UNIFORM vec4                _MaskDistortionTex_ST;
	UNITY_UNIFORM mediump vec2                _MaskDistortionSpeed;
	UNITY_UNIFORM mediump float                _MaskDistortionAmount;
	UNITY_UNIFORM vec4                _NoiseTex_ST;
	UNITY_UNIFORM mediump vec2                _NoiseSpeed;
	UNITY_UNIFORM vec4                _NoiseDistortionTex_ST;
	UNITY_UNIFORM mediump vec2                _NoiseDistortionSpeed;
	UNITY_UNIFORM mediump float                _NoiseDistortionAmount;
	UNITY_UNIFORM vec4                _MainColor;
	UNITY_UNIFORM vec4                _Soft;
	UNITY_UNIFORM float                _Intensity;
	UNITY_UNIFORM int                _ZWrite;
	UNITY_UNIFORM int                _BlendMode;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EffectDistortionIntensity;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MaskDistortionTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(2) uniform mediump sampler2D _NoiseDistortionTex;
UNITY_LOCATION(3) uniform mediump sampler2D _NoiseTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump float vs_TEXCOORD6;
in highp float vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
vec2 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_8;
float u_xlat11;
void main()
{
    u_xlat0.x = _PerformanceElapsedTime * 0.0500000007;
    u_xlat5.xy = u_xlat0.xx * _MaskDistortionSpeed.xy + vs_TEXCOORD2.xy;
    u_xlat16_5 = texture(_MaskDistortionTex, u_xlat5.xy).x;
    u_xlat5.xy = vec2(u_xlat16_5) + (-vs_TEXCOORD1.xy);
    u_xlat5.xy = vec2(vec2(_MaskDistortionAmount, _MaskDistortionAmount)) * u_xlat5.xy + vs_TEXCOORD1.xy;
    u_xlat16_1 = texture(_MaskTex, u_xlat5.xy);
    u_xlat5.xy = u_xlat0.xx * _NoiseDistortionSpeed.xy + vs_TEXCOORD4.xy;
    u_xlat16_5 = texture(_NoiseDistortionTex, u_xlat5.xy).x;
    u_xlat0.xz = u_xlat0.xx * _NoiseSpeed.xy + vs_TEXCOORD3.xy;
    u_xlat0.xy = vec2(u_xlat16_5) * vec2(vec2(_NoiseDistortionAmount, _NoiseDistortionAmount)) + u_xlat0.xz;
    u_xlat16_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat0 = u_xlat16_0 * vec4(_Intensity);
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.x = vs_TEXCOORD5.y * _Soft.w + _Soft.z;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlatb6 = _BlendMode==1;
    u_xlat4 = (u_xlatb6) ? 1.0 : u_xlat1.x;
    u_xlat2.x = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat4;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat0.w * u_xlat1.x;
    u_xlat0 = u_xlat2 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
    u_xlat0 = u_xlat0 * vec4(_SekaiAllLightIntensity);
    u_xlatb1 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb1){
        u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xy = u_xlat1.xy * u_xlat1.xy;
        u_xlat1.x = u_xlat1.y + u_xlat1.x;
        u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
        u_xlat6.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat1.x = u_xlat1.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat6.x = float(1.0) / u_xlat6.x;
        u_xlat1.x = u_xlat6.x * u_xlat1.x;
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
        u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
        u_xlat1.x = u_xlat1.x * u_xlat1.x;
        u_xlat11 = u_xlat1.x * u_xlat6.x;
        u_xlat1.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
        u_xlat6.xyz = u_xlat0.xyz * vec3(u_xlat11);
        u_xlat6.xyz = u_xlat6.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat6.xyz;
    }
    u_xlat16_3 = max(u_xlat0.z, u_xlat0.y);
    u_xlat16_3 = max(u_xlat0.x, u_xlat16_3);
    u_xlat16_3 = u_xlat0.w * u_xlat16_3;
    u_xlat16_8 = (-vs_TEXCOORD6) + 1.0;
    u_xlat1.x = u_xlat16_8 * _SekaiFogColor.w;
    u_xlat6.xyz = _SekaiFogColor.xyz * vec3(u_xlat16_3) + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xxx * u_xlat6.xyz + u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD7 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat6.x = u_xlat6.x + -1.0;
    u_xlat6.x = u_xlat6.x * _ProjectionParams.w;
    u_xlat1.x = u_xlat6.x * u_xlat1.x + _ProjectionParams.w;
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
    u_xlat6.x = u_xlat1.x;
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
    u_xlat1.x = max(u_xlat1.x, -1.0);
    u_xlat1.x = min(u_xlat1.x, 0.0);
    u_xlat1.x = u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * 0.5;
    u_xlat2.x = float(_ZWrite);
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(1.0);
    u_xlat1 = u_xlat1 * u_xlat2.xxxx;
    SV_Target0 = u_xlat0;
    SV_Target1 = u_xlat1;
    u_xlat0.x = 0.0;
    SV_Target2 = u_xlat0.xxxw;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "DistortedUvBuffer"
			Tags { "LIGHTMODE"="DistortedUvBuffer" "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend One One, One One
			ZTest [_ZTest]
			ZWrite [_ZWrite]
			Cull [_Cull]
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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MaskTex_ST;
	UNITY_UNIFORM vec4                _MaskDistortionTex_ST;
	UNITY_UNIFORM mediump vec2                _MaskDistortionSpeed;
	UNITY_UNIFORM mediump float                _MaskDistortionAmount;
	UNITY_UNIFORM vec4                _NoiseTex_ST;
	UNITY_UNIFORM mediump vec2                _NoiseSpeed;
	UNITY_UNIFORM vec4                _NoiseDistortionTex_ST;
	UNITY_UNIFORM mediump vec2                _NoiseDistortionSpeed;
	UNITY_UNIFORM mediump float                _NoiseDistortionAmount;
	UNITY_UNIFORM vec4                _MainColor;
	UNITY_UNIFORM vec4                _Soft;
	UNITY_UNIFORM float                _Intensity;
	UNITY_UNIFORM int                _ZWrite;
	UNITY_UNIFORM int                _BlendMode;
	UNITY_UNIFORM mediump float                _EffectDistortionIntensity;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec2 in_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump float vs_TEXCOORD6;
out highp float vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * _MaskDistortionTex_ST.xy + _MaskDistortionTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD2.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD3.xy * _NoiseDistortionTex_ST.xy + _NoiseDistortionTex_ST.zw;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
    vs_TEXCOORD7 = u_xlat1.z;
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD6 = u_xlat0.x;
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
uniform 	float _PerformanceElapsedTime;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MaskTex_ST;
	UNITY_UNIFORM vec4                _MaskDistortionTex_ST;
	UNITY_UNIFORM mediump vec2                _MaskDistortionSpeed;
	UNITY_UNIFORM mediump float                _MaskDistortionAmount;
	UNITY_UNIFORM vec4                _NoiseTex_ST;
	UNITY_UNIFORM mediump vec2                _NoiseSpeed;
	UNITY_UNIFORM vec4                _NoiseDistortionTex_ST;
	UNITY_UNIFORM mediump vec2                _NoiseDistortionSpeed;
	UNITY_UNIFORM mediump float                _NoiseDistortionAmount;
	UNITY_UNIFORM vec4                _MainColor;
	UNITY_UNIFORM vec4                _Soft;
	UNITY_UNIFORM float                _Intensity;
	UNITY_UNIFORM int                _ZWrite;
	UNITY_UNIFORM int                _BlendMode;
	UNITY_UNIFORM mediump float                _EffectDistortionIntensity;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MaskDistortionTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(2) uniform mediump sampler2D _NoiseDistortionTex;
UNITY_LOCATION(3) uniform mediump sampler2D _NoiseTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp float vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
float u_xlat3;
vec2 u_xlat4;
mediump float u_xlat16_4;
float u_xlat5;
vec2 u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0.x = _PerformanceElapsedTime * 0.0500000007;
    u_xlat4.xy = u_xlat0.xx * _NoiseDistortionSpeed.xy + vs_TEXCOORD4.xy;
    u_xlat16_4 = texture(_NoiseDistortionTex, u_xlat4.xy).x;
    u_xlat8.xy = u_xlat0.xx * _NoiseSpeed.xy + vs_TEXCOORD3.xy;
    u_xlat1.xy = u_xlat0.xx * _MaskDistortionSpeed.xy + vs_TEXCOORD2.xy;
    u_xlat16_0.x = texture(_MaskDistortionTex, u_xlat1.xy).x;
    u_xlat1.xy = u_xlat16_0.xx + (-vs_TEXCOORD1.xy);
    u_xlat1.xy = vec2(vec2(_MaskDistortionAmount, _MaskDistortionAmount)) * u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat16_1.xy = texture(_MaskTex, u_xlat1.xy).xw;
    u_xlat0.xy = vec2(u_xlat16_4) * vec2(vec2(_NoiseDistortionAmount, _NoiseDistortionAmount)) + u_xlat8.xy;
    u_xlat16_0.xy = texture(_NoiseTex, u_xlat0.xy).xw;
    u_xlat16_2.xy = u_xlat16_0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat16_2.y * _Intensity;
    SV_Target0.xy = u_xlat16_2.xx * vec2(_EffectDistortionIntensity);
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat4.x = vs_TEXCOORD5.y * _Soft.w + _Soft.z;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlatb8 = _BlendMode==1;
    u_xlat4.x = (u_xlatb8) ? 1.0 : u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _SekaiGlowLightIntensity;
    u_xlat0.w = u_xlat0.x * _SekaiAllLightIntensity;
    SV_Target0.z = u_xlat0.w;
    SV_Target0.w = 1.0;
    u_xlat1.x = vs_TEXCOORD7 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat5 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat5 = u_xlat5 + -1.0;
    u_xlat5 = u_xlat5 * _ProjectionParams.w;
    u_xlat1.x = u_xlat5 * u_xlat1.x + _ProjectionParams.w;
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
    u_xlat5 = max(u_xlat1.x, -1.0);
    u_xlat1.x = u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat5 = min(u_xlat5, 0.0);
    u_xlat1.x = u_xlat5 + u_xlat1.x;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * 0.5;
    u_xlat3 = float(_ZWrite);
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(1.0);
    u_xlat1 = u_xlat1 * vec4(u_xlat3);
    SV_Target1 = u_xlat1;
    u_xlat0.x = float(0.0);
    u_xlat0.y = float(0.0);
    u_xlat0.z = float(0.0);
    SV_Target2 = u_xlat0;
    return;
}
#endif
			ENDGLSL
		}
	}
}
