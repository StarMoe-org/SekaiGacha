// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Default/CrossLightFlare"
{
	Properties
	{
		_BaseLightTex("BaseLight", 2D) = "white" {}
		[HDR] _BaseLightTint("BaseLight Tint", Color) = (1, 1, 1, 1)
	}
	SubShader
	{
		Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
		LOD 100
		Pass
		{
			Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ZWrite Off
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _SekaiFogFactor;
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
	UNITY_UNIFORM vec4                _BaseLightTex_ST;
	UNITY_UNIFORM vec4                _BaseLightTint;
	UNITY_UNIFORM float Xhlslcc_UnusedX_GroundThreshold;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOODRD3;
out mediump vec4 vs_COLOR0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 1.17549435e-38);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlatb9 = unity_OrthoParams.w==0.0;
    u_xlat1.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat2.x = (u_xlatb9) ? u_xlat1.x : hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = (u_xlatb9) ? u_xlat1.y : hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = (u_xlatb9) ? u_xlat1.z : hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position.xyz = u_xlat0.xxx * u_xlat1.xyz;
    gl_Position.w = u_xlat1.w;
    vs_TEXCOORD0 = u_xlat1;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BaseLightTex_ST.xy + _BaseLightTex_ST.zw;
    u_xlat3.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOODRD3 = u_xlat0.x;
    vs_COLOR0 = in_COLOR0;
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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _BaseLightTex_ST;
	UNITY_UNIFORM vec4                _BaseLightTint;
	UNITY_UNIFORM float Xhlslcc_UnusedX_GroundThreshold;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseLightTex;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOODRD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
layout(location = 1) out highp vec4 SV_Target1;
layout(location = 2) out highp vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat4;
void main()
{
    u_xlat16_0.x = (-vs_TEXCOODRD3) + 1.0;
    u_xlat1 = u_xlat16_0.x * _SekaiFogColor.w;
    u_xlat4.xy = vs_TEXCOORD1.xy;
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
    u_xlat16_0 = texture(_BaseLightTex, u_xlat4.xy);
    u_xlat0 = u_xlat16_0 * _BaseLightTint;
    u_xlat16_2 = max(u_xlat0.z, u_xlat0.y);
    u_xlat16_2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat16_2 = u_xlat0.w * u_xlat16_2;
    u_xlat4.xyz = _SekaiFogColor.xyz * vec3(u_xlat16_2) + (-u_xlat0.xyz);
    u_xlat0.xyz = vec3(u_xlat1) * u_xlat4.xyz + u_xlat0.xyz;
    u_xlat16_0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}
#endif
			ENDGLSL
		}
	}
}
