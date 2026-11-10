// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Note/Particles/Additive+AlphaBlend"
{
	Properties
	{
		_MainTex("Particle Texture", 2D) = "white" {}
		[Toggle] _UseFlipMatrix("UseFlipMatrix", Float) = 0
	}
	SubShader
	{
		Tags { "IGNOREPROJECTOR"="true" "PreviewType"="Plane" "QUEUE"="Transparent" "RenderType"="Transparent" }
		Pass
		{
			Tags { "IGNOREPROJECTOR"="true" "PreviewType"="Plane" "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ColorMask RGB
			ZTest Off
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 hlslcc_mtx4x4_TapEffectViewMatrix[4];
uniform 	vec4 hlslcc_mtx4x4_TapEffectProjectionMatrix[4];
uniform 	int _UseFlipMatrix;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
int u_xlati6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4_TapEffectViewMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_TapEffectViewMatrix[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_TapEffectViewMatrix[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4_TapEffectViewMatrix[3] * u_xlat0.wwww + u_xlat2;
    u_xlati2 = int((0.0<hlslcc_mtx4x4glstate_matrix_projection[1].y) ? 0xFFFFFFFFu : uint(0));
    u_xlati6 = int((hlslcc_mtx4x4glstate_matrix_projection[1].y<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati2 = (-u_xlati2) + u_xlati6;
    u_xlat2.x = float(u_xlati2);
    u_xlat2.y = u_xlat2.x * hlslcc_mtx4x4_TapEffectProjectionMatrix[1].y;
    u_xlat2.x = hlslcc_mtx4x4_TapEffectProjectionMatrix[0].y;
    u_xlat2.z = hlslcc_mtx4x4_TapEffectProjectionMatrix[2].y;
    u_xlat2.w = hlslcc_mtx4x4_TapEffectProjectionMatrix[3].y;
    u_xlat2.y = dot(u_xlat2, u_xlat0);
    u_xlat3.x = hlslcc_mtx4x4_TapEffectProjectionMatrix[0].x;
    u_xlat3.y = hlslcc_mtx4x4_TapEffectProjectionMatrix[1].x;
    u_xlat3.z = hlslcc_mtx4x4_TapEffectProjectionMatrix[2].x;
    u_xlat3.w = hlslcc_mtx4x4_TapEffectProjectionMatrix[3].x;
    u_xlat2.x = dot(u_xlat3, u_xlat0);
    u_xlat3.x = hlslcc_mtx4x4_TapEffectProjectionMatrix[0].z;
    u_xlat3.y = hlslcc_mtx4x4_TapEffectProjectionMatrix[1].z;
    u_xlat3.z = hlslcc_mtx4x4_TapEffectProjectionMatrix[2].z;
    u_xlat3.w = hlslcc_mtx4x4_TapEffectProjectionMatrix[3].z;
    u_xlat2.z = dot(u_xlat3, u_xlat0);
    u_xlat3.x = hlslcc_mtx4x4_TapEffectProjectionMatrix[0].w;
    u_xlat3.y = hlslcc_mtx4x4_TapEffectProjectionMatrix[1].w;
    u_xlat3.z = hlslcc_mtx4x4_TapEffectProjectionMatrix[2].w;
    u_xlat3.w = hlslcc_mtx4x4_TapEffectProjectionMatrix[3].w;
    u_xlat2.w = dot(u_xlat3, u_xlat0);
    u_xlatb0 = _UseFlipMatrix==1;
    gl_Position = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_TEXCOORD0.z;
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlatb0 = 0.5>=vs_TEXCOORD1;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat0 = u_xlat0 * u_xlat1.w;
    SV_Target0.xyz = u_xlat1.www * u_xlat1.xyz;
    SV_Target0.w = u_xlat0;
    return;
}
#endif
			ENDGLSL
		}
	}
}
