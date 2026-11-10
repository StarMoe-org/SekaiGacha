// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Brightness/LightMap"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_LightMapTex("LightMapTex", 2D) = "white" {}
		_Intensity("Intensity", Range(0, 2)) = 0.1
		_RotateTheta("UV Rotate Theta", Range(-180, 180)) = 0
		_RotateOffset("UV Rotate Offset", Float) = 0
	}
	SubShader
	{
		Tags { "QUEUE"="Geometry+1" "RenderType"="Geometry" }
		LOD 100
		Pass
		{
			Tags { "QUEUE"="Geometry+1" "RenderType"="Geometry" }
			GLSLPROGRAM
#pragma multi_compile _ _USE_OVERLAY_FLIPBOOK
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
#if defined(_USE_OVERLAY_FLIPBOOK)
uniform 	mediump float _FlipBookMaskThreshold_Stage;
uniform 	mediump float _FlipBookMaskFallOff_Stage;
uniform 	mediump float _FlipBookUpperDotMaskOpacity_Stage;
uniform 	mediump float _FlipBookLowerDotMaskOpacity_Stage;
#endif
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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4                _LightMapTex_ST;
	UNITY_UNIFORM float                _Intensity;
	UNITY_UNIFORM float                _RotateTheta;
	UNITY_UNIFORM float                _RotateOffset;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump float vs_TEXCOORD4;
out highp float vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
#if defined(_USE_OVERLAY_FLIPBOOK)
out mediump float vs_TEXCOORD6;
#endif
vec4 u_xlat0;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb0;
#endif
vec4 u_xlat1;
#if defined(_USE_OVERLAY_FLIPBOOK)
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_5;
#else
vec3 u_xlat2;
#endif
float u_xlat6;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb6;
float u_xlat9;
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
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_TEXCOORD0 = u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * _LightMapTex_ST.xy + _LightMapTex_ST.zw;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
    vs_TEXCOORD5 = u_xlat1.z;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
#else
    u_xlat2.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2.x;
#endif
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD4 = u_xlat0.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
#else
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
#endif
    u_xlat0.x = max(u_xlat0.x, 1.17549435e-38);
    u_xlat0.x = inversesqrt(u_xlat0.x);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_NORMAL0.xyz = u_xlat0.xyz;
    u_xlatb0 = 0.0>=u_xlat0.y;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * _FlipBookLowerDotMaskOpacity_Stage;
    u_xlatb6 = u_xlat0.y>=0.0;
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat16_2 = u_xlat6 * _FlipBookUpperDotMaskOpacity_Stage + u_xlat0.x;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_2 = abs(u_xlat0.y) * u_xlat16_2 + (-_FlipBookMaskThreshold_Stage);
    u_xlat16_5 = _FlipBookMaskFallOff_Stage + 0.00100000005;
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
    u_xlat16_5 = float(1.0) / u_xlat16_5;
    u_xlat16_2 = u_xlat16_5 * u_xlat16_2;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = u_xlat16_2 * -2.0 + 3.0;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    vs_TEXCOORD6 = u_xlat16_2 * u_xlat16_5;
#else
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_NORMAL0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
#if defined(_USE_OVERLAY_FLIPBOOK)
uniform 	vec3 _FlipBookCenterPosition;
uniform 	float _GlobalFlipBookTime;
uniform 	mediump float _FlipBookFrameCountX;
uniform 	mediump float _FlipBookFrameCountY;
uniform 	mediump float _FlipBookFPS;
uniform 	mediump vec4 _FlipBookColor_Stage;
uniform 	mediump float _FlipBookOpacity;
uniform 	mediump float _FlipBookFadeRadius;
uniform 	mediump float _FlipBookFadeFallOff;
uniform 	mediump float _FlipBookScale_Stage;
uniform 	vec2 _FlipBookUVScroll_Stage;
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4                _LightMapTex_ST;
	UNITY_UNIFORM float                _Intensity;
	UNITY_UNIFORM float                _RotateTheta;
	UNITY_UNIFORM float                _RotateOffset;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _LightMapTex;
#if defined(_USE_OVERLAY_FLIPBOOK)
UNITY_LOCATION(2) uniform mediump sampler2D _FlipBookTex;
#endif
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump float vs_TEXCOORD4;
in highp float vs_TEXCOORD5;
#if defined(_USE_OVERLAY_FLIPBOOK)
in mediump float vs_TEXCOORD6;
#endif
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
#if defined(_USE_OVERLAY_FLIPBOOK)
mediump vec3 u_xlat16_2;
#else
mediump float u_xlat16_2;
#endif
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
#if defined(_USE_OVERLAY_FLIPBOOK)
vec3 u_xlat5;
vec2 u_xlat6;
vec3 u_xlat11;
vec2 u_xlat12;
vec2 u_xlat18;
bool u_xlatb19;
float u_xlat25;
float u_xlat26;
#else
vec3 u_xlat9;
float u_xlat14;
#endif
void main()
{
    u_xlat0.x = _RotateTheta * 0.0174532942;
    u_xlat16_1.x = sin(u_xlat0.x);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_2.x = cos(u_xlat0.x);
#else
    u_xlat16_2 = cos(u_xlat0.x);
#endif
    u_xlat16_3.x = (-u_xlat16_1.x);
    u_xlat0.xy = vs_TEXCOORD1.xy + (-vec2(vec2(_RotateOffset, _RotateOffset)));
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_3.y = u_xlat16_2.x;
#else
    u_xlat16_3.y = u_xlat16_2;
#endif
    u_xlat16_3.z = u_xlat16_1.x;
    u_xlat4.x = dot(u_xlat0.xy, u_xlat16_3.yz);
    u_xlat4.y = dot(u_xlat0.xy, u_xlat16_3.xy);
    u_xlat0.xy = u_xlat4.xy + vec2(vec2(_RotateOffset, _RotateOffset));
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = texture(_LightMapTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat0 = u_xlat0 * vec4(vec4(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
    u_xlat0 = u_xlat0 * vec4(_SekaiAllLightIntensity);
    u_xlatb4 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb4){
        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat4.xy = u_xlat4.xy * u_xlat4.xy;
        u_xlat4.x = u_xlat4.y + u_xlat4.x;
        u_xlat4.x = u_xlat4.z * u_xlat4.z + u_xlat4.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat11.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat9.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
        u_xlat4.x = u_xlat4.x + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat11.x = float(1.0) / u_xlat11.x;
        u_xlat4.x = u_xlat11.x * u_xlat4.x;
#else
        u_xlat9.x = float(1.0) / u_xlat9.x;
        u_xlat4.x = u_xlat9.x * u_xlat4.x;
#endif
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat11.x = u_xlat4.x * -2.0 + 3.0;
#else
        u_xlat9.x = u_xlat4.x * -2.0 + 3.0;
#endif
        u_xlat4.x = u_xlat4.x * u_xlat4.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat18.x = u_xlat4.x * u_xlat11.x;
        u_xlat4.x = (-u_xlat11.x) * u_xlat4.x + 1.0;
        u_xlat11.xyz = u_xlat0.xyz * u_xlat18.xxx;
        u_xlat11.xyz = u_xlat11.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat4.xxx * u_xlat0.xyz + u_xlat11.xyz;
#else
        u_xlat14 = u_xlat4.x * u_xlat9.x;
        u_xlat4.x = (-u_xlat9.x) * u_xlat4.x + 1.0;
        u_xlat9.xyz = u_xlat0.xyz * vec3(u_xlat14);
        u_xlat9.xyz = u_xlat9.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat4.xxx * u_xlat0.xyz + u_xlat9.xyz;
#endif
    }
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat4.xy = vs_TEXCOORD3.xz + (-_FlipBookCenterPosition.xz);
    u_xlat18.xy = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * vec2(_FlipBookUVScroll_Stage.x, _FlipBookUVScroll_Stage.y);
    u_xlat18.xy = u_xlat4.xy * vec2(vec2(_FlipBookScale_Stage, _FlipBookScale_Stage)) + (-u_xlat18.xy);
    u_xlat18.xy = fract(u_xlat18.xy);
    u_xlat5.x = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat12.x = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat5.x = u_xlat5.x / u_xlat12.x;
    u_xlatb19 = u_xlat5.x>=(-u_xlat5.x);
    u_xlat5.x = fract(abs(u_xlat5.x));
    u_xlat5.x = (u_xlatb19) ? u_xlat5.x : (-u_xlat5.x);
    u_xlat5.x = u_xlat12.x * u_xlat5.x;
    u_xlat5.x = floor(u_xlat5.x);
    u_xlat12.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat26 = u_xlat12.x * u_xlat5.x;
    u_xlat26 = floor(u_xlat26);
    u_xlat6.x = (-_FlipBookFrameCountX) * u_xlat26 + u_xlat5.x;
    u_xlat5.x = u_xlat26 + 1.0;
    u_xlat6.y = (-u_xlat5.x) + _FlipBookFrameCountY;
    u_xlat18.xy = u_xlat18.xy + u_xlat6.xy;
    u_xlat18.xy = u_xlat12.xy * u_xlat18.xy;
    u_xlat4.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_1 = texture(_FlipBookTex, u_xlat18.xy);
    u_xlat16_2.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vs_TEXCOORD6);
    u_xlat16_2.xyz = u_xlat16_2.xyz * _FlipBookColor_Stage.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _FlipBookColor_Stage.www;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_FlipBookOpacity);
    u_xlat4.x = u_xlat4.x + (-_FlipBookFadeRadius);
    u_xlat4.x = u_xlat4.x + (-_FlipBookFadeFallOff);
    u_xlat11.x = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat4.x = u_xlat11.x * u_xlat4.x;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat11.x = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat11.x;
    u_xlat4.xyz = u_xlat16_2.xyz * u_xlat4.xxx + u_xlat0.xyz;
    u_xlat16_2.x = (-vs_TEXCOORD4) + 1.0;
    u_xlat25 = u_xlat16_2.x * _SekaiFogColor.w;
    u_xlat5.xyz = (-u_xlat4.xyz) + _SekaiFogColor.xyz;
    u_xlat0.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat4.xyz;
#else
    u_xlat16_2 = (-vs_TEXCOORD4) + 1.0;
    u_xlat4.x = u_xlat16_2 * _SekaiFogColor.w;
    u_xlat9.xyz = (-u_xlat0.xyz) + _SekaiFogColor.xyz;
    u_xlat0.xyz = u_xlat4.xxx * u_xlat9.xyz + u_xlat0.xyz;
#endif
    u_xlat1 = u_xlat0 * vec4(_Intensity);
    u_xlat1 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat4.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat4.x = u_xlat4.x * 0.5 + 0.5;
    u_xlat4.x = (-u_xlat4.x) + 1.0;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat11.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat11.x = u_xlat11.x + -1.0;
    u_xlat11.x = u_xlat11.x * _ProjectionParams.w;
    u_xlat4.x = u_xlat11.x * u_xlat4.x + _ProjectionParams.w;
#else
    u_xlat9.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9.x = u_xlat9.x + -1.0;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.w;
    u_xlat4.x = u_xlat9.x * u_xlat4.x + _ProjectionParams.w;
#endif
    u_xlat4.x = (-_CoCParams.x) * u_xlat4.x + 1.0;
    u_xlat4.x = u_xlat4.x * _CoCParams.y;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat11.x = u_xlat4.x;
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#else
    u_xlat9.x = u_xlat4.x;
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat4.x = max(u_xlat4.x, -1.0);
    u_xlat4.x = min(u_xlat4.x, 0.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat4.x = u_xlat4.x + u_xlat11.x;
#else
    u_xlat4.x = u_xlat4.x + u_xlat9.x;
#endif
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat4.x = u_xlat4.x * 0.5;
    SV_Target0 = u_xlat0;
    SV_Target1.x = u_xlat4.x;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2 = u_xlat1;
    return;
}
#endif
			ENDGLSL
		}
	}
}
