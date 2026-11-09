// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/RhythmGame/Fever-Frame"
{
	Properties
	{
		[PerRendererData] _MainTex("Sprite Texture", 2D) = "white" {}
		_ColorTex("Color Texture", 2D) = "white" {}
		_Speed("Speed", Float) = 1
		_Color("Tint", Color) = (1, 1, 1, 1)
		[MaterialToggle] PixelSnap("Pixel snap", Float) = 0
		[HideInInspector] _RendererColor("RendererColor", Color) = (1, 1, 1, 1)
		[HideInInspector] _Flip("Flip", Vector) = (1, 1, 1, 1)
		[PerRendererData] _AlphaTex("External Alpha", 2D) = "white" {}
		[PerRendererData] _EnableExternalAlpha("Enable External Alpha", Float) = 0
	}
	SubShader
	{
		Tags { "CanUseSpriteAtlas"="true" "IGNOREPROJECTOR"="true" "PreviewType"="Plane" "QUEUE"="Transparent" "RenderType"="Transparent" }
		Pass
		{
			Tags { "CanUseSpriteAtlas"="true" "IGNOREPROJECTOR"="true" "PreviewType"="Plane" "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GLSLPROGRAM
#pragma multi_compile _ INSTANCING_ON
#ifdef VERTEX
#version 300 es
#if defined(INSTANCING_ON)
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif
#endif
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
#if !defined(INSTANCING_ON)
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if defined(INSTANCING_ON)
uniform 	int unity_BaseInstanceID;
#endif
uniform 	mediump vec4 _RendererColor;
uniform 	mediump vec2 _Flip;
uniform 	mediump vec4 _Color;
#if defined(INSTANCING_ON)
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type                unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#endif
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
#if defined(INSTANCING_ON)
int u_xlati4;
#endif
void main()
{
    u_xlat0.xy = in_POSITION0.xy * _Flip.xy;
#if defined(INSTANCING_ON)
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = int(u_xlati4 << (3 & int(0x1F)));
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
#else
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
#endif
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = u_xlat0.xy * _ProjectionParams.xx;
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = clamp(vs_TEXCOORD1.xy, 0.0, 1.0);
    u_xlat0 = in_COLOR0 * _Color;
    u_xlat0 = u_xlat0 * _RendererColor;
    vs_COLOR0 = u_xlat0;
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
uniform 	vec4 _Time;
uniform 	float _Speed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ColorTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
vec2 u_xlat3;
void main()
{
    u_xlat0.x = _Time.y * _Speed;
    u_xlat1.x = sin((-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.xy = vs_TEXCOORD1.xy + vec2(-0.5, -0.5);
    u_xlat1.y = u_xlat2.x;
    u_xlat1.z = u_xlat0.x;
    u_xlat2.y = dot(u_xlat1.zy, u_xlat3.xy);
    u_xlat2.x = dot(u_xlat1.yx, u_xlat3.xy);
    u_xlat0.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_ColorTex, u_xlat0.xy);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat0 = u_xlat16_0 * u_xlat1;
    SV_Target0.xyz = u_xlat0.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}
#endif
			ENDGLSL
		}
	}
}
