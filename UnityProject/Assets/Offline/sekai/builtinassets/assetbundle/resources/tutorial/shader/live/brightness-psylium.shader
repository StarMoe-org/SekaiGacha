// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Brightness/Psylium"
{
	Properties
	{
		_MainTex("Color Texture", 2D) = "white" {}
		_PsyliumTex("Psylium Texture", 2D) = "white" {}
		_Intensity("Intensity", Range(0, 2)) = 0.1
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _SekaiFogFactor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _PsyliumTex_ST;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerDraw {
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
int u_xlati8;
float u_xlat16;
int u_xlati16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xy = (-in_TEXCOORD0.xy) + vec2(0.5, 0.5);
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-u_xlat1.xyz);
    u_xlat16 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat8.xy = vec2(u_xlat16) * u_xlat8.xz;
    u_xlat0.w = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat0.xw = sqrt(u_xlat0.xw);
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat24 = dot(u_xlat8.xy, in_NORMAL0.xz);
    u_xlat0.x = u_xlat24 / u_xlat0.x;
    u_xlat24 = abs(u_xlat0.x) * -0.0187292993 + 0.0742610022;
    u_xlat24 = u_xlat24 * abs(u_xlat0.x) + -0.212114394;
    u_xlat24 = u_xlat24 * abs(u_xlat0.x) + 1.57072878;
    u_xlat25 = -abs(u_xlat0.x) + 1.0;
    u_xlatb0 = u_xlat0.x<(-u_xlat0.x);
    u_xlat25 = sqrt(u_xlat25);
    u_xlat2.x = u_xlat24 * u_xlat25;
    u_xlat2.x = u_xlat2.x * -2.0 + 3.14159274;
    u_xlat0.x = u_xlatb0 ? u_xlat2.x : float(0.0);
    u_xlat0.x = u_xlat24 * u_xlat25 + u_xlat0.x;
    u_xlat16 = u_xlat8.y * in_NORMAL0.x;
    u_xlat8.x = u_xlat8.x * in_NORMAL0.z + (-u_xlat16);
    u_xlati16 = int((0.0<u_xlat8.x) ? 0xFFFFFFFFu : uint(0));
    u_xlati8 = int((u_xlat8.x<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati8 = u_xlati16 + (-u_xlati8);
    u_xlat8.x = float(u_xlati8);
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat2.x = sin((-u_xlat0.x));
    u_xlat3.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.y = u_xlat3.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = (-u_xlat0.xy) * vec2(0.949999988, 0.75) + in_POSITION0.xy;
    u_xlat0.z = u_xlat0.y + 1.0;
    u_xlat0.w = in_POSITION0.z;
    u_xlat0.xyz = (-u_xlat1.xyz) + u_xlat0.xzw;
    u_xlat3.y = dot(u_xlat2.yx, u_xlat0.xz);
    u_xlat0.w = dot(u_xlat2.zy, u_xlat0.xz);
    u_xlat0.x = dot((-u_xlat1.xz), (-u_xlat1.xz));
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xz = u_xlat0.xx * (-u_xlat1.zx);
    u_xlat16_4.xy = in_COLOR0.xx * vec2(0.5, 5.0);
    u_xlat25 = _Time.z * 1.70000005 + u_xlat16_4.x;
    u_xlat16_4.x = sin(u_xlat16_4.y);
    u_xlat25 = sin(u_xlat25);
    u_xlat0.xz = u_xlat0.xz * vec2(u_xlat25);
    u_xlat2.xy = sin((-u_xlat0.xz));
    u_xlat5.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat6 = sin(u_xlat0.z);
    u_xlat7.x = cos(u_xlat0.z);
    u_xlat2.z = u_xlat5.x;
    u_xlat2.w = u_xlat0.x;
    u_xlat5.z = dot(u_xlat2.wz, u_xlat0.yw);
    u_xlat3.x = dot(u_xlat2.zx, u_xlat0.yw);
    u_xlat7.y = u_xlat2.y;
    u_xlat7.z = u_xlat6;
    u_xlat5.x = dot(u_xlat7.zx, u_xlat3.xy);
    u_xlat5.y = dot(u_xlat7.xy, u_xlat3.xy);
    u_xlat0.xyz = u_xlat1.xyz + u_xlat5.xyz;
    u_xlat8.x = u_xlat16_4.x * 0.300000012 + u_xlat0.y;
    u_xlat1 = u_xlat8.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
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
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy;
    vs_TEXCOORD1.xy = u_xlat8.xy * vec2(0.0078125, 0.0078125) + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PsyliumTex_ST.xy + _PsyliumTex_ST.zw;
    u_xlat8.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat8.x;
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
uniform 	vec4 _SekaiFogColor;
uniform 	float _Intensity;
UNITY_LOCATION(0) uniform mediump sampler2D _PsyliumTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat4;
void main()
{
    u_xlat16_0.x = (-vs_TEXCOORD3) + 1.0;
    u_xlat1.x = u_xlat16_0.x * _SekaiFogColor.w;
    u_xlat2.x = vs_TEXCOORD1.x;
    u_xlat2.y = vs_COLOR0.x * 4.0;
    u_xlat16_0 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_PsyliumTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat4.xyz = (-u_xlat16_0.xyz) + _SekaiFogColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz + u_xlat16_0.xyz;
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
