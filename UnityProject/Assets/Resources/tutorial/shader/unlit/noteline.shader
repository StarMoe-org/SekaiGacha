// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Unlit/NoteLine"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Color("Main Color", Color) = (1, 1, 1, 1)
		_NoteShowRate("NoteShowRate", Range(0, 1)) = 1
	}
	SubShader
	{
		Tags { "IGNOREPROJECTOR"="true" "QUEUE"="Transparent" "RenderType"="Transparent" }
		LOD 100
		Pass
		{
			Tags { "IGNOREPROJECTOR"="true" "QUEUE"="Transparent" "RenderType"="Transparent" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec2 in_TEXCOORD3;
in highp vec2 in_TEXCOORD4;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    vs_TEXCOORD3.xy = in_TEXCOORD3.xy;
    vs_TEXCOORD4.xy = in_TEXCOORD4.xy;
    vs_TEXCOORD5.xy = in_POSITION0.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _NoteShowRate;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
float u_xlat2;
vec2 u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD6.y / vs_TEXCOORD6.w;
    u_xlat0.x = (-u_xlat0.x) + _NoteShowRate;
    u_xlatb0 = u_xlat0.x<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = vs_TEXCOORD2.y + (-vs_TEXCOORD5.x);
    u_xlat2 = (-vs_TEXCOORD1.y) + vs_TEXCOORD5.x;
    u_xlat0.x = u_xlat0.x + u_xlat2;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat2 = (-vs_TEXCOORD3.y) + vs_TEXCOORD4.y;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD3.y;
    u_xlat0.y = vs_TEXCOORD0.y * 0.200000003 + vs_TEXCOORD4.x;
    u_xlat4.xy = u_xlat0.xy + vec2(0.0, 0.25);
    u_xlat16_1 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0.xyz = texture(_MainTex, u_xlat4.xy).xyz;
    u_xlat0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = vs_TEXCOORD3.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_0 = u_xlat16_1 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}
#endif
			ENDGLSL
		}
	}
	Fallback "Legacy Shaders/VertexLit"
}
