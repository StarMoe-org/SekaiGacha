// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Brightness/ColorMap"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ColorTex("ColorMap", 2D) = "white" {}
		_Intensity("Intensity", Range(0, 2)) = 0.1
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
#if defined(_USE_OVERLAY_FLIPBOOK)
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_WorldToObject[4];
#else
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_WorldToObject[4];
#endif
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
	UNITY_UNIFORM vec4                _ColorTex_ST;
	UNITY_UNIFORM float                _Intensity;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
#if defined(_USE_OVERLAY_FLIPBOOK)
in highp vec3 in_NORMAL0;
#endif
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump float vs_TEXCOORD4;
out highp float vs_TEXCOORD5;
#if defined(_USE_OVERLAY_FLIPBOOK)
out mediump float vs_TEXCOORD6;
#endif
vec4 u_xlat0;
vec4 u_xlat1;
#if defined(_USE_OVERLAY_FLIPBOOK)
mediump float u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
#else
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
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_TEXCOORD0 = u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * _ColorTex_ST.xy + _ColorTex_ST.zw;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
    vs_TEXCOORD5 = u_xlat1.z;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat3;
#else
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
#endif
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD4 = u_xlat0.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 1.17549435e-38);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlatb3 = 0.0>=u_xlat0.x;
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3 = u_xlat3 * _FlipBookLowerDotMaskOpacity_Stage;
    u_xlatb6 = u_xlat0.x>=0.0;
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat16_2 = u_xlat6 * _FlipBookUpperDotMaskOpacity_Stage + u_xlat3;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_2 = abs(u_xlat0.x) * u_xlat16_2 + (-_FlipBookMaskThreshold_Stage);
    u_xlat16_5 = _FlipBookMaskFallOff_Stage + 0.00100000005;
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
    u_xlat16_5 = float(1.0) / u_xlat16_5;
    u_xlat16_2 = u_xlat16_5 * u_xlat16_2;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = u_xlat16_2 * -2.0 + 3.0;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    vs_TEXCOORD6 = u_xlat16_2 * u_xlat16_5;
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
	UNITY_UNIFORM vec4                _ColorTex_ST;
	UNITY_UNIFORM float                _Intensity;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ColorTex;
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
bool u_xlatb1;
#if defined(_USE_OVERLAY_FLIPBOOK)
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
vec2 u_xlat7;
vec2 u_xlat11;
bool u_xlatb12;
float u_xlat16;
float u_xlat17;
#else
mediump float u_xlat16_2;
float u_xlat3;
vec3 u_xlat5;
float u_xlat7;
float u_xlat9;
#endif
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
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
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat6.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat5.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
        u_xlat1.x = u_xlat1.x + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat6.x = float(1.0) / u_xlat6.x;
        u_xlat1.x = u_xlat6.x * u_xlat1.x;
#else
        u_xlat5.x = float(1.0) / u_xlat5.x;
        u_xlat1.x = u_xlat5.x * u_xlat1.x;
#endif
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
#else
        u_xlat5.x = u_xlat1.x * -2.0 + 3.0;
#endif
        u_xlat1.x = u_xlat1.x * u_xlat1.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat11.x = u_xlat1.x * u_xlat6.x;
        u_xlat1.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
        u_xlat6.xyz = u_xlat0.xyz * u_xlat11.xxx;
        u_xlat6.xyz = u_xlat6.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat6.xyz;
#else
        u_xlat9 = u_xlat1.x * u_xlat5.x;
        u_xlat1.x = (-u_xlat5.x) * u_xlat1.x + 1.0;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat9);
        u_xlat5.xyz = u_xlat5.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat5.xyz;
#endif
    }
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat1.xy = vs_TEXCOORD3.xz + (-_FlipBookCenterPosition.xz);
    u_xlat11.xy = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * vec2(_FlipBookUVScroll_Stage.x, _FlipBookUVScroll_Stage.y);
    u_xlat11.xy = u_xlat1.xy * vec2(vec2(_FlipBookScale_Stage, _FlipBookScale_Stage)) + (-u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.x = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat7.x = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat2.x = u_xlat2.x / u_xlat7.x;
    u_xlatb12 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb12) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat2.x = u_xlat7.x * u_xlat2.x;
    u_xlat2.x = floor(u_xlat2.x);
    u_xlat7.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat17 = u_xlat7.x * u_xlat2.x;
    u_xlat17 = floor(u_xlat17);
    u_xlat3.x = (-_FlipBookFrameCountX) * u_xlat17 + u_xlat2.x;
    u_xlat2.x = u_xlat17 + 1.0;
    u_xlat3.y = (-u_xlat2.x) + _FlipBookFrameCountY;
    u_xlat11.xy = u_xlat11.xy + u_xlat3.xy;
    u_xlat11.xy = u_xlat7.xy * u_xlat11.xy;
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat16_2 = texture(_FlipBookTex, u_xlat11.xy);
    u_xlat16_4.xyz = u_xlat16_2.www * u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vs_TEXCOORD6);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _FlipBookColor_Stage.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _FlipBookColor_Stage.www;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlipBookOpacity);
    u_xlat1.x = u_xlat1.x + (-_FlipBookFadeRadius);
    u_xlat1.x = u_xlat1.x + (-_FlipBookFadeFallOff);
    u_xlat6.x = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
    u_xlat1.xyz = u_xlat16_4.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat16_4.x = (-vs_TEXCOORD4) + 1.0;
    u_xlat16 = u_xlat16_4.x * _SekaiFogColor.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + _SekaiFogColor.xyz;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat2.xyz + u_xlat1.xyz;
#else
    u_xlat16_2 = (-vs_TEXCOORD4) + 1.0;
    u_xlat1.x = u_xlat16_2 * _SekaiFogColor.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + _SekaiFogColor.xyz;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat5.xyz + u_xlat0.xyz;
#endif
    u_xlat1 = u_xlat0 * vec4(_Intensity);
    u_xlat1 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.5);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat2.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat7.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = u_xlat7.x * _ProjectionParams.w;
    u_xlat2.x = u_xlat7.x * u_xlat2.x + _ProjectionParams.w;
    u_xlat2.x = (-_CoCParams.x) * u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * _CoCParams.y;
    u_xlat7.x = u_xlat2.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, -1.0);
    u_xlat2.x = min(u_xlat2.x, 0.0);
    u_xlat2.x = u_xlat2.x + u_xlat7.x;
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
#else
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
    u_xlat3 = u_xlat3 * 0.5;
#endif
    SV_Target0 = u_xlat0;
#if defined(_USE_OVERLAY_FLIPBOOK)
    SV_Target1.x = u_xlat2.x;
#else
    SV_Target1.x = u_xlat3;
#endif
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2 = u_xlat1;
    return;
}
#endif
			ENDGLSL
		}
	}
}
