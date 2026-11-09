// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Default/ColorMap-Smoke"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ColorTex("ColorMap", 2D) = "white" {}
		_SubTex("SmokeTex", 2D) = "white" {}
		_MoveVector("MoveVector", Vector) = (0, 0, 0, 0)
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
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4                _ColorTex_ST;
	UNITY_UNIFORM vec4                _SubTex_ST;
	UNITY_UNIFORM vec4                _MoveVector;
	UNITY_UNIFORM int                _ZWrite;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out mediump float vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD4;
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
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * _ColorTex_ST.xy + _ColorTex_ST.zw;
    vs_TEXCOORD6 = u_xlat1.z;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD5 = u_xlat0.x;
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
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4                _ColorTex_ST;
	UNITY_UNIFORM vec4                _SubTex_ST;
	UNITY_UNIFORM vec4                _MoveVector;
	UNITY_UNIFORM int                _ZWrite;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ColorTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in mediump float vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump float u_xlat16_2;
float u_xlat3;
vec3 u_xlat5;
float u_xlat7;
float u_xlat9;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = texture(_ColorTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1.xy = vec2(_PerformanceElapsedTime) * _MoveVector.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.0500000007, 0.0500000007) + vs_TEXCOORD3.xy;
    u_xlat16_1 = texture(_SubTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat0 * u_xlat16_1;
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_SekaiGlowLightIntensity, _SekaiGlowLightIntensity, _SekaiGlowLightIntensity));
    u_xlat1.w = u_xlat16_0.w * _SekaiGlowLightIntensity;
    u_xlat0 = u_xlat1 * vec4(_SekaiAllLightIntensity);
    u_xlatb1 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb1){
        u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _SekaiGlobalSpotLightPos.xyz;
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
    u_xlat16_2 = (-vs_TEXCOORD5) + 1.0;
    u_xlat1.x = u_xlat16_2 * _SekaiFogColor.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + _SekaiFogColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vs_COLOR0.www;
    u_xlat1.yzw = vec3(vec3(_ZWrite));
    u_xlat3 = vs_TEXCOORD6 / vs_TEXCOORD0.w;
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
    u_xlat1.x = u_xlat1.w * u_xlat3;
    u_xlat1 = u_xlat1 * vec4(0.5, 0.0, 0.0, 1.0);
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
