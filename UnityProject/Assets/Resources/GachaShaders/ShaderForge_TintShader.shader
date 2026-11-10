// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Shader Forge/TintShader"
{
	Properties
	{
		_MainTex("MainTexture", 2D) = "white" {}
		_Tint("Tint", Color) = (1, 1, 1, 1)
		_BlackColor("BlackColor", Color) = (0, 0, 0, 1)
		_WhiteColor("WhiteColor", Color) = (1, 1, 1, 1)
		_monocolor("mono <=> color", Range(0, 1)) = 1
		[HideInInspector] _Cutoff("Alpha cutoff", Range(0, 1)) = 0.5
	}
	SubShader
	{
		Tags { "IGNOREPROJECTOR"="true" "QUEUE"="Transparent" "RenderType"="Transparent" }
		Pass
		{
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="SRPDEFAULTUNLIT" "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _BlackColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WhiteColor;
uniform 	float _monocolor;
uniform 	vec4 _Tint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat1.x = u_xlat16_0.z + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.333333343;
    u_xlat3.xyz = (-_BlackColor.xyz) + _WhiteColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz + _BlackColor.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz + (-u_xlat1.xyz);
    u_xlat16_0.xyz = vec3(_monocolor) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat16_0 * _Tint;
    return;
}
#endif
			ENDGLSL
		}
	}
	Fallback "Diffuse"
}
