// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Brightness/Penlight"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		_ColorTex("Color Texture", 2D) = "white" {}
		_AnimTex("Anim Texture", 2D) = "white" {}
		_Intensity("Intensity", Range(0, 2)) = 0.1
		_ColorTimeline("Color Timeline", Range(0, 0.9999)) = 0
	}
	SubShader
	{
		Tags { "QUEUE"="Geometry+1" "RenderType"="Opaque" }
		Pass
		{
			Tags { "QUEUE"="Geometry+1" "RenderType"="Opaque" }
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
uniform 	vec4 _MainTex_ST;
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
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat6;
bool u_xlatb6;
bool u_xlatb11;
void main()
{
    u_xlat0.xz = in_POSITION0.xz + (-in_NORMAL0.xz);
    u_xlat5 = max(abs(u_xlat0.z), abs(u_xlat0.x));
    u_xlat5 = float(1.0) / u_xlat5;
    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.x));
    u_xlat5 = u_xlat5 * u_xlat1.x;
    u_xlat1.x = u_xlat5 * u_xlat5;
    u_xlat6 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat1.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat1.x * u_xlat6 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat5 * u_xlat1.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
    u_xlatb11 = abs(u_xlat0.z)<abs(u_xlat0.x);
    u_xlat6 = u_xlatb11 ? u_xlat6 : float(0.0);
    u_xlat5 = u_xlat5 * u_xlat1.x + u_xlat6;
    u_xlatb1 = (-u_xlat0.z)<u_xlat0.z;
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat5 = u_xlat5 + u_xlat1.x;
    u_xlat1.x = min((-u_xlat0.z), (-u_xlat0.x));
    u_xlatb1 = u_xlat1.x<(-u_xlat1.x);
    u_xlat6 = max((-u_xlat0.z), (-u_xlat0.x));
    u_xlatb6 = u_xlat6>=(-u_xlat6);
    u_xlatb1 = u_xlatb6 && u_xlatb1;
    u_xlat5 = (u_xlatb1) ? (-u_xlat5) : u_xlat5;
    u_xlatb1 = u_xlat5<0.0;
    u_xlat6 = u_xlat5 + 6.28299999;
    u_xlat5 = (u_xlatb1) ? u_xlat6 : u_xlat5;
    u_xlat1.x = sin(u_xlat5);
    u_xlat2.x = cos(u_xlat5);
    u_xlat3.x = sin((-u_xlat5));
    u_xlat3.z = u_xlat1.x;
    u_xlat3.y = u_xlat2.x;
    u_xlat1.xy = in_POSITION0.xz;
    u_xlat1.xy = (-u_xlat0.xz) + u_xlat1.xy;
    u_xlat2.x = dot(u_xlat3.yz, u_xlat1.xy);
    u_xlat2.z = dot(u_xlat3.xy, u_xlat1.xy);
    u_xlat2.y = 0.0;
    u_xlat0.w = in_POSITION0.y + 1.0;
    u_xlat0.xyz = u_xlat0.xwz + u_xlat2.xyz;
    u_xlat16_4 = in_COLOR0.x * 6.28299999;
    u_xlat16_4 = sin(u_xlat16_4);
    u_xlat5 = u_xlat16_4 * 0.200000003 + u_xlat0.y;
    u_xlat1 = vec4(u_xlat5) * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat0;
    u_xlat0.x = u_xlat0.z + _ProjectionParams.y;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat5 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat5;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD2 = u_xlat0.x;
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
uniform 	vec4 _SekaiFogColor;
uniform 	float _Intensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ColorTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat5;
void main()
{
    u_xlat16_0.x = (-vs_TEXCOORD2) + 1.0;
    u_xlat1.x = u_xlat16_0.x * _SekaiFogColor.w;
    u_xlat16_0.x = 0.0;
    u_xlat16_0.y = vs_COLOR0.x * 4.0;
    u_xlat16_0 = texture(_ColorTex, u_xlat16_0.xy);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_3 = (-u_xlat16_0) + u_xlat16_2;
    u_xlat16_0 = u_xlat16_2.wwww * u_xlat16_3 + u_xlat16_0;
    u_xlat5.xyz = (-u_xlat16_0.xyz) + _SekaiFogColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_Intensity);
    SV_Target0.w = u_xlat16_0.w;
    u_xlat1.w = u_xlat16_0.w * _Intensity;
    u_xlat0 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.5);
    SV_Target2 = u_xlat0;
    u_xlat1.x = vs_TEXCOORD0.z;
    u_xlat1.y = float(0.0);
    u_xlat1.w = float(1.0);
    SV_Target1 = u_xlat1.xyyw;
    return;
}
#endif
			ENDGLSL
		}
	}
}
