// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/UI/FillColor"
{
	Properties
	{
		[PerRendererData] _MainTex("Sprite Texture", 2D) = "white" {}
		_Color("Tint", Color) = (1, 1, 1, 1)
		_StencilComp("Stencil Comparison", Float) = 8
		_Stencil("Stencil ID", Float) = 0
		_StencilOp("Stencil Operation", Float) = 0
		_StencilWriteMask("Stencil Write Mask", Float) = 255
		_StencilReadMask("Stencil Read Mask", Float) = 255
		_ColorMask("Color Mask", Float) = 15
		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip("Use Alpha Clip", Float) = 0
	}
	SubShader
	{
		Tags { "CanUseSpriteAtlas"="true" "IGNOREPROJECTOR"="true" "PreviewType"="Plane" "QUEUE"="Transparent" "RenderType"="Transparent" }
		Pass
		{
			Name "FillColor"
			Tags { "CanUseSpriteAtlas"="true" "IGNOREPROJECTOR"="true" "PreviewType"="Plane" "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask [_ColorMask]
			ZTest [unity_GUIZTestMode]
			ZWrite Off
			Cull Off
			Stencil
			{
				Ref [_Stencil]
				ReadMask [_StencilReadMask]
				WriteMask [_StencilWriteMask]
				Comp [_StencilComp]
				Pass [_StencilOp]
			}
			GLSLPROGRAM
#pragma multi_compile _ UNITY_UI_ALPHACLIP
#pragma multi_compile _ UNITY_UI_CLIP_RECT
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
#if defined(UNITY_UI_CLIP_RECT)
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if defined(UNITY_UI_CLIP_RECT)
uniform 	vec4 _ClipRect;
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
#if defined(UNITY_UI_CLIP_RECT)
in highp vec4 vs_TEXCOORD1;
#endif
layout(location = 0) out mediump vec4 SV_Target0;
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
vec4 u_xlat0;
bvec4 u_xlatb0;
#else
float u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
#endif
mediump float u_xlat16_1;
#if defined(UNITY_UI_CLIP_RECT)
float u_xlat2;
mediump float u_xlat16_2;
#endif
#else
#if defined(UNITY_UI_CLIP_RECT)
vec4 u_xlat0;
bvec4 u_xlatb0;
float u_xlat1;
mediump float u_xlat16_1;
#else
float u_xlat0;
mediump float u_xlat16_0;
#endif
#endif
void main()
{
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat2 = u_xlat16_2 * vs_COLOR0.w;
    u_xlat16_1 = u_xlat2 * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0.x = u_xlat16_1<0.0;
    if(u_xlatb0.x){discard;}
#else
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = vs_COLOR0.w * u_xlat16_0 + -0.00100000005;
    u_xlat0 = u_xlat16_0 * vs_COLOR0.w;
    SV_Target0.w = u_xlat0;
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
#endif
#else
#if defined(UNITY_UI_CLIP_RECT)
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat1;
    SV_Target0.w = u_xlat0.x;
#else
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat16_0 * vs_COLOR0.w;
    SV_Target0.w = u_xlat0;
#endif
#endif
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "FillColorRP"
			Tags { "CanUseSpriteAtlas"="true" "IGNOREPROJECTOR"="true" "LIGHTMODE"="SekaiUI" "PreviewType"="Plane" "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask [_ColorMask]
			ZTest [unity_GUIZTestMode]
			ZWrite Off
			Cull Off
			Stencil
			{
				Ref [_Stencil]
				ReadMask [_StencilReadMask]
				WriteMask [_StencilWriteMask]
				Comp [_StencilComp]
				Pass [_StencilOp]
			}
			GLSLPROGRAM
#pragma multi_compile _ UNITY_UI_ALPHACLIP
#pragma multi_compile _ UNITY_UI_CLIP_RECT
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
#if defined(UNITY_UI_CLIP_RECT)
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if defined(UNITY_UI_CLIP_RECT)
uniform 	vec4 _ClipRect;
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
#if defined(UNITY_UI_CLIP_RECT)
in highp vec4 vs_TEXCOORD1;
#endif
layout(location = 0) out mediump vec4 SV_Target0;
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
vec4 u_xlat0;
bvec4 u_xlatb0;
#else
float u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
#endif
mediump float u_xlat16_1;
#if defined(UNITY_UI_CLIP_RECT)
float u_xlat2;
mediump float u_xlat16_2;
#endif
#else
#if defined(UNITY_UI_CLIP_RECT)
vec4 u_xlat0;
bvec4 u_xlatb0;
float u_xlat1;
mediump float u_xlat16_1;
#else
float u_xlat0;
mediump float u_xlat16_0;
#endif
#endif
void main()
{
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat2 = u_xlat16_2 * vs_COLOR0.w;
    u_xlat16_1 = u_xlat2 * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0.x = u_xlat16_1<0.0;
    if(u_xlatb0.x){discard;}
#else
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = vs_COLOR0.w * u_xlat16_0 + -0.00100000005;
    u_xlat0 = u_xlat16_0 * vs_COLOR0.w;
    SV_Target0.w = u_xlat0;
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
#endif
#else
#if defined(UNITY_UI_CLIP_RECT)
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat1;
    SV_Target0.w = u_xlat0.x;
#else
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat16_0 * vs_COLOR0.w;
    SV_Target0.w = u_xlat0;
#endif
#endif
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}
#endif
			ENDGLSL
		}
	}
}
