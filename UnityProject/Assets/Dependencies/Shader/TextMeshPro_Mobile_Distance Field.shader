// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "TextMeshPro/Mobile/Distance Field"
{
	Properties
	{
		[HDR] _FaceColor("Face Color", Color) = (1, 1, 1, 1)
		_FaceDilate("Face Dilate", Range(-1, 1)) = 0
		[HDR] _OutlineColor("Outline Color", Color) = (0, 0, 0, 1)
		_OutlineWidth("Outline Thickness", Range(0, 1)) = 0
		_OutlineSoftness("Outline Softness", Range(0, 1)) = 0
		[HDR] _UnderlayColor("Border Color", Color) = (0, 0, 0, 0.5)
		_UnderlayOffsetX("Border OffsetX", Range(-1, 1)) = 0
		_UnderlayOffsetY("Border OffsetY", Range(-1, 1)) = 0
		_UnderlayDilate("Border Dilate", Range(-1, 1)) = 0
		_UnderlaySoftness("Border Softness", Range(0, 1)) = 0
		_WeightNormal("Weight Normal", Float) = 0
		_WeightBold("Weight Bold", Float) = 0.5
		_ShaderFlags("Flags", Float) = 0
		_ScaleRatioA("Scale RatioA", Float) = 1
		_ScaleRatioB("Scale RatioB", Float) = 1
		_ScaleRatioC("Scale RatioC", Float) = 1
		_MainTex("Font Atlas", 2D) = "white" {}
		_TextureWidth("Texture Width", Float) = 512
		_TextureHeight("Texture Height", Float) = 512
		_GradientScale("Gradient Scale", Float) = 5
		_ScaleX("Scale X", Float) = 1
		_ScaleY("Scale Y", Float) = 1
		_PerspectiveFilter("Perspective Correction", Range(0, 1)) = 0.875
		_Sharpness("Sharpness", Range(-1, 1)) = 0
		_VertexOffsetX("Vertex OffsetX", Float) = 0
		_VertexOffsetY("Vertex OffsetY", Float) = 0
		_ClipRect("Clip Rect", Vector) = (-32767, -32767, 32767, 32767)
		_MaskSoftnessX("Mask SoftnessX", Float) = 0
		_MaskSoftnessY("Mask SoftnessY", Float) = 0
		_StencilComp("Stencil Comparison", Float) = 8
		_Stencil("Stencil ID", Float) = 0
		_StencilOp("Stencil Operation", Float) = 0
		_StencilWriteMask("Stencil Write Mask", Float) = 255
		_StencilReadMask("Stencil Read Mask", Float) = 255
		_CullMode("Cull Mode", Float) = 0
		_ColorMask("Color Mask", Float) = 15
	}
	SubShader
	{
		Tags { "IGNOREPROJECTOR"="true" "QUEUE"="Transparent" "RenderType"="Transparent" }
		Pass
		{
			Tags { "IGNOREPROJECTOR"="true" "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ColorMask [_ColorMask]
			ZTest [unity_GUIZTestMode]
			ZWrite Off
			Cull [_CullMode]
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
#pragma multi_compile _ OUTLINE_ON UNDERLAY_ON
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _FaceColor;
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
#endif
#endif
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
uniform 	float _ScaleRatioC;
#endif
#endif
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
#endif
#endif
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	float _Sharpness;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
#endif
#endif
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
#if defined(OUTLINE_ON)
float u_xlat5;
float u_xlat7;
#else
#if defined(UNDERLAY_ON)
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
vec2 u_xlat7;
vec3 u_xlat8;
#else
float u_xlat5;
float u_xlat7;
#endif
#endif
float u_xlat10;
#if defined(OUTLINE_ON)
float u_xlat12;
float u_xlat15;
bool u_xlatb15;
#else
#if defined(UNDERLAY_ON)
float u_xlat16;
float u_xlat18;
float u_xlat24;
bool u_xlatb24;
#else
float u_xlat12;
float u_xlat15;
bool u_xlatb15;
#endif
#endif
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
#if defined(OUTLINE_ON)
    u_xlat16_3 = in_COLOR0 * _FaceColor;
    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
    vs_COLOR0 = u_xlat16_3;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#else
#if defined(UNDERLAY_ON)
    vs_COLOR0.w = _FaceColor.w;
    u_xlat16_3.xyz = in_COLOR0.xyz;
    u_xlat16_3.w = 1.0;
    u_xlat16_4 = u_xlat16_3 * _FaceColor;
    u_xlat16_5.xyz = u_xlat16_4.www * u_xlat16_4.xyz;
    vs_COLOR0.xyz = u_xlat16_5.xyz;
    u_xlat5.xyz = (-u_xlat16_5.xyz);
    u_xlat5.w = (-u_xlat16_4.w);
    u_xlat16_6.xyz = _OutlineColor.www * _OutlineColor.xyz;
    u_xlat16_6.w = _OutlineColor.w;
    u_xlat5 = u_xlat5 + u_xlat16_6;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
#else
    u_xlat16_3 = in_COLOR0 * _FaceColor;
    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
    vs_COLOR0 = u_xlat16_3;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#endif
#endif
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
#if defined(OUTLINE_ON)
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
#else
#if defined(UNDERLAY_ON)
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat1.xyz);
#else
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
#endif
#endif
    u_xlat1.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat1.xy;
    u_xlat1.xy = abs(u_xlat1.xy) * vec2(_ScaleX, _ScaleY);
    u_xlat1.xy = u_xlat2.ww / u_xlat1.xy;
#if defined(OUTLINE_ON)
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
#else
#if defined(UNDERLAY_ON)
    u_xlat24 = dot(u_xlat1.xy, u_xlat1.xy);
#else
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
#endif
#endif
    u_xlat1.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.xy;
    u_xlat1.zw = vec2(0.25, 0.25) / u_xlat1.xy;
#if defined(OUTLINE_ON)
    u_xlat15 = inversesqrt(u_xlat15);
#else
#if defined(UNDERLAY_ON)
    u_xlat24 = inversesqrt(u_xlat24);
#else
    u_xlat15 = inversesqrt(u_xlat15);
#endif
#endif
    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
#if defined(OUTLINE_ON)
    u_xlat7 = _Sharpness + 1.0;
    u_xlat2.x = u_xlat7 * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat12 = (-_PerspectiveFilter) + 1.0;
    u_xlat12 = u_xlat12 * abs(u_xlat7);
    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
    u_xlat2.x = u_xlat10 / u_xlat15;
    u_xlat10 = _OutlineWidth * _ScaleRatioA;
    u_xlat10 = u_xlat2.x * u_xlat10;
    u_xlat15 = min(u_xlat10, 1.0);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
    vs_COLOR1 = u_xlat3;
#else
#if defined(UNDERLAY_ON)
    u_xlat10 = _Sharpness + 1.0;
    u_xlat2.x = u_xlat10 * u_xlat2.x;
    u_xlat10 = u_xlat24 * u_xlat2.x;
    u_xlat18 = (-_PerspectiveFilter) + 1.0;
    u_xlat18 = u_xlat18 * abs(u_xlat10);
    u_xlat24 = u_xlat24 * u_xlat2.x + (-u_xlat18);
    u_xlat16 = abs(u_xlat16) * u_xlat24 + u_xlat18;
    u_xlatb24 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
    u_xlat16 = (u_xlatb24) ? u_xlat16 : u_xlat10;
    u_xlat24 = _OutlineSoftness * _ScaleRatioA;
    u_xlat24 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat2.x = u_xlat16 / u_xlat24;
    u_xlat24 = _OutlineWidth * _ScaleRatioA;
    u_xlat24 = u_xlat2.x * u_xlat24;
    u_xlat7.x = min(u_xlat24, 1.0);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat5 = u_xlat5 * u_xlat7.xxxx;
    u_xlat4.xyz = u_xlat16_4.xyz * u_xlat16_4.www + u_xlat5.xyz;
    u_xlat4.w = u_xlat16_3.w * _FaceColor.w + u_xlat5.w;
    vs_COLOR1 = u_xlat4;
#else
    u_xlat7 = _Sharpness + 1.0;
    u_xlat2.x = u_xlat7 * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat12 = (-_PerspectiveFilter) + 1.0;
    u_xlat12 = u_xlat12 * abs(u_xlat7);
    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
    u_xlat2.x = u_xlat10 / u_xlat15;
    u_xlat10 = _OutlineWidth * _ScaleRatioA;
    u_xlat10 = u_xlat2.x * u_xlat10;
    u_xlat15 = min(u_xlat10, 1.0);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
    vs_COLOR1 = u_xlat3;
#endif
#endif
    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
#if defined(OUTLINE_ON)
    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
#else
#if defined(UNDERLAY_ON)
    u_xlat7.xy = u_xlat0.xy + (-u_xlat3.xy);
#else
    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
#endif
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
    u_xlat1.xy = (-u_xlat3.zw) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat3.xy) + u_xlat3.zw;
#if defined(OUTLINE_ON)
    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
#else
#if defined(UNDERLAY_ON)
    vs_TEXCOORD0.zw = u_xlat7.xy / u_xlat0.xy;
#else
    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
#endif
#endif
    vs_TEXCOORD2 = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlatb0 = 0.0>=in_TEXCOORD1.y;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
#if defined(OUTLINE_ON)
    u_xlat5 = (-_WeightNormal) + _WeightBold;
    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
#else
#if defined(UNDERLAY_ON)
    u_xlat8.x = (-_WeightNormal) + _WeightBold;
    u_xlat0.x = u_xlat0.x * u_xlat8.x + _WeightNormal;
#else
    u_xlat5 = (-_WeightNormal) + _WeightBold;
    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
#endif
#endif
    u_xlat0.x = u_xlat0.x * 0.25 + _FaceDilate;
    u_xlat0.x = u_xlat0.x * _ScaleRatioA;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 0.5;
    u_xlat2.w = u_xlat0.x * u_xlat2.x + -0.5;
#if defined(OUTLINE_ON)
    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
#else
#if defined(UNDERLAY_ON)
    u_xlat2.y = (-u_xlat24) * 0.5 + u_xlat2.w;
    u_xlat2.z = u_xlat24 * 0.5 + u_xlat2.w;
#else
    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
#endif
#endif
    vs_TEXCOORD1 = u_xlat2;
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
    vs_TEXCOORD3.z = in_COLOR0.w;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat8.xz = (-u_xlat1.zw) * vec2(_GradientScale);
    u_xlat8.xz = u_xlat8.xz / vec2(_TextureWidth, _TextureHeight);
    vs_TEXCOORD3.xy = u_xlat8.xz + in_TEXCOORD0.xy;
    u_xlat8.x = u_xlat1.x * u_xlat16 + 1.0;
    u_xlat2.x = u_xlat16 / u_xlat8.x;
    u_xlat8.x = u_xlat1.y * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x + -0.5;
    u_xlat2.y = (-u_xlat8.x) * 0.5 + u_xlat0.x;
    vs_TEXCOORD4.xy = u_xlat2.xy;
#endif
#endif
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
#else
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#endif
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
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
uniform 	mediump vec4 _UnderlayColor;
#endif
#endif
#if defined(UNITY_UI_CLIP_RECT)
uniform 	vec4 _ClipRect;
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
#if defined(OUTLINE_ON)
in mediump vec4 vs_COLOR1;
#endif
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
#if defined(UNITY_UI_CLIP_RECT)
in mediump vec4 vs_TEXCOORD2;
#endif
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
in highp vec4 vs_TEXCOORD3;
in mediump vec2 vs_TEXCOORD4;
#endif
#endif
layout(location = 0) out mediump vec4 SV_Target0;
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
vec4 u_xlat0;
#else
vec2 u_xlat0;
#endif
#endif
#else
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
vec4 u_xlat0;
#endif
#endif
#endif
mediump vec4 u_xlat16_0;
#if defined(UNITY_UI_CLIP_RECT)
#if defined(OUTLINE_ON)
vec2 u_xlat1;
#endif
#endif
#else
#if defined(UNITY_UI_CLIP_RECT)
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
vec4 u_xlat0;
#else
vec2 u_xlat0;
#endif
#endif
mediump vec4 u_xlat16_0;
#if defined(OUTLINE_ON)
vec2 u_xlat1;
#endif
#else
#if defined(OUTLINE_ON)
mediump vec4 u_xlat16_0;
#else
#if defined(UNDERLAY_ON)
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
#else
mediump float u_xlat16_0;
#endif
#endif
#endif
#endif
mediump float u_xlat16_1;
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
#if defined(OUTLINE_ON)
bool u_xlatb1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_5;
#else
#if defined(UNDERLAY_ON)
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
bool u_xlatb3;
#else
bool u_xlatb2;
mediump float u_xlat16_4;
#endif
#endif
#else
#if defined(OUTLINE_ON)
bool u_xlatb1;
mediump vec2 u_xlat16_2;
#else
#if defined(UNDERLAY_ON)
mediump vec4 u_xlat16_2;
bool u_xlatb3;
#else
bool u_xlatb2;
mediump float u_xlat16_4;
#endif
#endif
#endif
#else
#if defined(UNITY_UI_CLIP_RECT)
#if defined(OUTLINE_ON)
mediump vec2 u_xlat16_2;
#else
#if defined(UNDERLAY_ON)
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
#else
mediump float u_xlat16_3;
#endif
#endif
#else
#if defined(OUTLINE_ON)
mediump vec2 u_xlat16_2;
#else
#if defined(UNDERLAY_ON)
mediump vec4 u_xlat16_2;
#endif
#endif
#endif
#endif
void main()
{
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
#if defined(OUTLINE_ON)
    u_xlat16_0 = vs_COLOR0 + (-vs_COLOR1);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_2.xy = vec2(u_xlat16_1) * vs_TEXCOORD1.xx + (-vs_TEXCOORD1.zy);
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_0 + vs_COLOR1;
    u_xlat16_0 = u_xlat16_2.yyyy * u_xlat16_0;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_2.x = u_xlat1.y * u_xlat1.x;
    u_xlat16_5 = u_xlat16_0.w * u_xlat16_2.x + -0.00100000005;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2.xxxx;
    SV_Target0 = u_xlat16_0;
    u_xlatb1 = u_xlat16_5<0.0;
    if(u_xlatb1){discard;}
#else
#if defined(UNDERLAY_ON)
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD3.xy).w;
    u_xlat16_1 = u_xlat16_0.x * vs_TEXCOORD4.x + (-vs_TEXCOORD4.y);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    u_xlat16_0.w = _UnderlayColor.w;
    u_xlat0 = vec4(u_xlat16_1) * u_xlat16_0;
    u_xlat16_2.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat16_2.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_2 = vec4(u_xlat16_1) * vs_COLOR0;
    u_xlat16_1 = (-vs_COLOR0.w) * u_xlat16_1 + 1.0;
    u_xlat0 = u_xlat0 * vec4(u_xlat16_1) + u_xlat16_2;
    u_xlat3.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat3.xy = u_xlat3.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat3.xy = u_xlat3.xy * vs_TEXCOORD2.zw;
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
    u_xlat16_1 = u_xlat3.y * u_xlat3.x;
    u_xlat16_0 = u_xlat0 * vec4(u_xlat16_1);
    u_xlat16_1 = u_xlat16_0.w * vs_TEXCOORD3.z + -0.00100000005;
    u_xlat0 = u_xlat16_0 * vs_TEXCOORD3.zzzz;
    SV_Target0 = u_xlat0;
    u_xlatb3 = u_xlat16_1<0.0;
    if(u_xlatb3){discard;}
#else
    u_xlat0.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat0.xy = u_xlat0.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD2.zw;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat16_1 = u_xlat0.y * u_xlat0.x;
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_4 = u_xlat16_0.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat16_0 = vec4(u_xlat16_4) * vs_COLOR0;
    u_xlat16_4 = u_xlat16_0.w * u_xlat16_1 + -0.00100000005;
    u_xlat16_0 = vec4(u_xlat16_1) * u_xlat16_0;
    SV_Target0 = u_xlat16_0;
    u_xlatb2 = u_xlat16_4<0.0;
    if(u_xlatb2){discard;}
#endif
#endif
#else
#if defined(OUTLINE_ON)
    u_xlat16_0 = vs_COLOR0 + (-vs_COLOR1);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_2.xy = vec2(u_xlat16_1) * vs_TEXCOORD1.xx + (-vs_TEXCOORD1.zy);
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_0 + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.y + -0.00100000005;
    u_xlat16_0 = u_xlat16_2.yyyy * u_xlat16_0;
    SV_Target0 = u_xlat16_0;
    u_xlatb1 = u_xlat16_2.x<0.0;
    if(u_xlatb1){discard;}
#else
#if defined(UNDERLAY_ON)
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD3.xy).w;
    u_xlat16_1 = u_xlat16_0.x * vs_TEXCOORD4.x + (-vs_TEXCOORD4.y);
#else
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat16_0.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
#endif
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#if defined(UNDERLAY_ON)
    u_xlat16_0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    u_xlat16_0.w = _UnderlayColor.w;
    u_xlat0 = vec4(u_xlat16_1) * u_xlat16_0;
    u_xlat16_2.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat16_2.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_2 = vec4(u_xlat16_1) * vs_COLOR0;
    u_xlat16_1 = (-vs_COLOR0.w) * u_xlat16_1 + 1.0;
    u_xlat0 = u_xlat0 * vec4(u_xlat16_1) + u_xlat16_2;
    u_xlat16_1 = u_xlat0.w * vs_TEXCOORD3.z + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_TEXCOORD3.zzzz;
    SV_Target0 = u_xlat0;
    u_xlatb3 = u_xlat16_1<0.0;
    if(u_xlatb3){discard;}
#else
    u_xlat16_4 = vs_COLOR0.w * u_xlat16_1 + -0.00100000005;
    u_xlat16_0 = vec4(u_xlat16_1) * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
    u_xlatb2 = u_xlat16_4<0.0;
    if(u_xlatb2){discard;}
#endif
#endif
#endif
#else
#if defined(UNITY_UI_CLIP_RECT)
#if defined(OUTLINE_ON)
    u_xlat16_0 = vs_COLOR0 + (-vs_COLOR1);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_2.xy = vec2(u_xlat16_1) * vs_TEXCOORD1.xx + (-vs_TEXCOORD1.zy);
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_0 + vs_COLOR1;
    u_xlat16_0 = u_xlat16_2.yyyy * u_xlat16_0;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_2.x = u_xlat1.y * u_xlat1.x;
    SV_Target0 = u_xlat16_0 * u_xlat16_2.xxxx;
#else
#if defined(UNDERLAY_ON)
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD3.xy).w;
    u_xlat16_1 = u_xlat16_0.x * vs_TEXCOORD4.x + (-vs_TEXCOORD4.y);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    u_xlat16_0.w = _UnderlayColor.w;
    u_xlat0 = vec4(u_xlat16_1) * u_xlat16_0;
    u_xlat16_2.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat16_2.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_2 = vec4(u_xlat16_1) * vs_COLOR0;
    u_xlat16_1 = (-vs_COLOR0.w) * u_xlat16_1 + 1.0;
    u_xlat0 = u_xlat0 * vec4(u_xlat16_1) + u_xlat16_2;
    u_xlat3.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat3.xy = u_xlat3.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat3.xy = u_xlat3.xy * vs_TEXCOORD2.zw;
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
    u_xlat16_1 = u_xlat3.y * u_xlat3.x;
    u_xlat16_0 = u_xlat0 * vec4(u_xlat16_1);
    u_xlat0 = u_xlat16_0 * vs_TEXCOORD3.zzzz;
    SV_Target0 = u_xlat0;
#else
    u_xlat0.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat0.xy = u_xlat0.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD2.zw;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat16_1 = u_xlat0.y * u_xlat0.x;
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3 = u_xlat16_0.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_0 = vec4(u_xlat16_3) * vs_COLOR0;
    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_0;
#endif
#endif
#else
#if defined(OUTLINE_ON)
    u_xlat16_0 = vs_COLOR0 + (-vs_COLOR1);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_2.xy = vec2(u_xlat16_1) * vs_TEXCOORD1.xx + (-vs_TEXCOORD1.zy);
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_0 + vs_COLOR1;
    SV_Target0 = u_xlat16_2.yyyy * u_xlat16_0;
#else
#if defined(UNDERLAY_ON)
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD3.xy).w;
    u_xlat16_1 = u_xlat16_0.x * vs_TEXCOORD4.x + (-vs_TEXCOORD4.y);
#else
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat16_0 * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
#endif
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#if defined(UNDERLAY_ON)
    u_xlat16_0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    u_xlat16_0.w = _UnderlayColor.w;
    u_xlat0 = vec4(u_xlat16_1) * u_xlat16_0;
    u_xlat16_2.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat16_2.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_2 = vec4(u_xlat16_1) * vs_COLOR0;
    u_xlat16_1 = (-vs_COLOR0.w) * u_xlat16_1 + 1.0;
    u_xlat0 = u_xlat0 * vec4(u_xlat16_1) + u_xlat16_2;
    u_xlat0 = u_xlat0 * vs_TEXCOORD3.zzzz;
    SV_Target0 = u_xlat0;
#else
    SV_Target0 = vec4(u_xlat16_1) * vs_COLOR0;
#endif
#endif
#endif
#endif
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="SekaiUI" "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ColorMask [_ColorMask]
			ZTest [unity_GUIZTestMode]
			ZWrite Off
			Cull [_CullMode]
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
#pragma multi_compile _ OUTLINE_ON UNDERLAY_ON
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _FaceColor;
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
#endif
#endif
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
uniform 	float _ScaleRatioC;
#endif
#endif
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
#endif
#endif
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	float _Sharpness;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
#endif
#endif
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
#if defined(OUTLINE_ON)
float u_xlat5;
float u_xlat7;
#else
#if defined(UNDERLAY_ON)
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
vec2 u_xlat7;
vec3 u_xlat8;
#else
float u_xlat5;
float u_xlat7;
#endif
#endif
float u_xlat10;
#if defined(OUTLINE_ON)
float u_xlat12;
float u_xlat15;
bool u_xlatb15;
#else
#if defined(UNDERLAY_ON)
float u_xlat16;
float u_xlat18;
float u_xlat24;
bool u_xlatb24;
#else
float u_xlat12;
float u_xlat15;
bool u_xlatb15;
#endif
#endif
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
#if defined(OUTLINE_ON)
    u_xlat16_3 = in_COLOR0 * _FaceColor;
    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
    vs_COLOR0 = u_xlat16_3;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#else
#if defined(UNDERLAY_ON)
    vs_COLOR0.w = _FaceColor.w;
    u_xlat16_3.xyz = in_COLOR0.xyz;
    u_xlat16_3.w = 1.0;
    u_xlat16_4 = u_xlat16_3 * _FaceColor;
    u_xlat16_5.xyz = u_xlat16_4.www * u_xlat16_4.xyz;
    vs_COLOR0.xyz = u_xlat16_5.xyz;
    u_xlat5.xyz = (-u_xlat16_5.xyz);
    u_xlat5.w = (-u_xlat16_4.w);
    u_xlat16_6.xyz = _OutlineColor.www * _OutlineColor.xyz;
    u_xlat16_6.w = _OutlineColor.w;
    u_xlat5 = u_xlat5 + u_xlat16_6;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
#else
    u_xlat16_3 = in_COLOR0 * _FaceColor;
    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
    vs_COLOR0 = u_xlat16_3;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
#endif
#endif
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
#if defined(OUTLINE_ON)
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
#else
#if defined(UNDERLAY_ON)
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat1.xyz);
#else
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
#endif
#endif
    u_xlat1.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat1.xy;
    u_xlat1.xy = abs(u_xlat1.xy) * vec2(_ScaleX, _ScaleY);
    u_xlat1.xy = u_xlat2.ww / u_xlat1.xy;
#if defined(OUTLINE_ON)
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
#else
#if defined(UNDERLAY_ON)
    u_xlat24 = dot(u_xlat1.xy, u_xlat1.xy);
#else
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
#endif
#endif
    u_xlat1.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.xy;
    u_xlat1.zw = vec2(0.25, 0.25) / u_xlat1.xy;
#if defined(OUTLINE_ON)
    u_xlat15 = inversesqrt(u_xlat15);
#else
#if defined(UNDERLAY_ON)
    u_xlat24 = inversesqrt(u_xlat24);
#else
    u_xlat15 = inversesqrt(u_xlat15);
#endif
#endif
    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
#if defined(OUTLINE_ON)
    u_xlat7 = _Sharpness + 1.0;
    u_xlat2.x = u_xlat7 * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat12 = (-_PerspectiveFilter) + 1.0;
    u_xlat12 = u_xlat12 * abs(u_xlat7);
    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
    u_xlat2.x = u_xlat10 / u_xlat15;
    u_xlat10 = _OutlineWidth * _ScaleRatioA;
    u_xlat10 = u_xlat2.x * u_xlat10;
    u_xlat15 = min(u_xlat10, 1.0);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
    vs_COLOR1 = u_xlat3;
#else
#if defined(UNDERLAY_ON)
    u_xlat10 = _Sharpness + 1.0;
    u_xlat2.x = u_xlat10 * u_xlat2.x;
    u_xlat10 = u_xlat24 * u_xlat2.x;
    u_xlat18 = (-_PerspectiveFilter) + 1.0;
    u_xlat18 = u_xlat18 * abs(u_xlat10);
    u_xlat24 = u_xlat24 * u_xlat2.x + (-u_xlat18);
    u_xlat16 = abs(u_xlat16) * u_xlat24 + u_xlat18;
    u_xlatb24 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
    u_xlat16 = (u_xlatb24) ? u_xlat16 : u_xlat10;
    u_xlat24 = _OutlineSoftness * _ScaleRatioA;
    u_xlat24 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat2.x = u_xlat16 / u_xlat24;
    u_xlat24 = _OutlineWidth * _ScaleRatioA;
    u_xlat24 = u_xlat2.x * u_xlat24;
    u_xlat7.x = min(u_xlat24, 1.0);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat5 = u_xlat5 * u_xlat7.xxxx;
    u_xlat4.xyz = u_xlat16_4.xyz * u_xlat16_4.www + u_xlat5.xyz;
    u_xlat4.w = u_xlat16_3.w * _FaceColor.w + u_xlat5.w;
    vs_COLOR1 = u_xlat4;
#else
    u_xlat7 = _Sharpness + 1.0;
    u_xlat2.x = u_xlat7 * u_xlat2.x;
    u_xlat7 = u_xlat15 * u_xlat2.x;
    u_xlat12 = (-_PerspectiveFilter) + 1.0;
    u_xlat12 = u_xlat12 * abs(u_xlat7);
    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
    u_xlat2.x = u_xlat10 / u_xlat15;
    u_xlat10 = _OutlineWidth * _ScaleRatioA;
    u_xlat10 = u_xlat2.x * u_xlat10;
    u_xlat15 = min(u_xlat10, 1.0);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
    vs_COLOR1 = u_xlat3;
#endif
#endif
    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
#if defined(OUTLINE_ON)
    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
#else
#if defined(UNDERLAY_ON)
    u_xlat7.xy = u_xlat0.xy + (-u_xlat3.xy);
#else
    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
#endif
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
    u_xlat1.xy = (-u_xlat3.zw) + u_xlat0.xy;
    u_xlat0.xy = (-u_xlat3.xy) + u_xlat3.zw;
#if defined(OUTLINE_ON)
    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
#else
#if defined(UNDERLAY_ON)
    vs_TEXCOORD0.zw = u_xlat7.xy / u_xlat0.xy;
#else
    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
#endif
#endif
    vs_TEXCOORD2 = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlatb0 = 0.0>=in_TEXCOORD1.y;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
#if defined(OUTLINE_ON)
    u_xlat5 = (-_WeightNormal) + _WeightBold;
    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
#else
#if defined(UNDERLAY_ON)
    u_xlat8.x = (-_WeightNormal) + _WeightBold;
    u_xlat0.x = u_xlat0.x * u_xlat8.x + _WeightNormal;
#else
    u_xlat5 = (-_WeightNormal) + _WeightBold;
    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
#endif
#endif
    u_xlat0.x = u_xlat0.x * 0.25 + _FaceDilate;
    u_xlat0.x = u_xlat0.x * _ScaleRatioA;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 0.5;
    u_xlat2.w = u_xlat0.x * u_xlat2.x + -0.5;
#if defined(OUTLINE_ON)
    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
#else
#if defined(UNDERLAY_ON)
    u_xlat2.y = (-u_xlat24) * 0.5 + u_xlat2.w;
    u_xlat2.z = u_xlat24 * 0.5 + u_xlat2.w;
#else
    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
#endif
#endif
    vs_TEXCOORD1 = u_xlat2;
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
    vs_TEXCOORD3.z = in_COLOR0.w;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat8.xz = (-u_xlat1.zw) * vec2(_GradientScale);
    u_xlat8.xz = u_xlat8.xz / vec2(_TextureWidth, _TextureHeight);
    vs_TEXCOORD3.xy = u_xlat8.xz + in_TEXCOORD0.xy;
    u_xlat8.x = u_xlat1.x * u_xlat16 + 1.0;
    u_xlat2.x = u_xlat16 / u_xlat8.x;
    u_xlat8.x = u_xlat1.y * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x + -0.5;
    u_xlat2.y = (-u_xlat8.x) * 0.5 + u_xlat0.x;
    vs_TEXCOORD4.xy = u_xlat2.xy;
#endif
#endif
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
#else
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#endif
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
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
uniform 	mediump vec4 _UnderlayColor;
#endif
#endif
#if defined(UNITY_UI_CLIP_RECT)
uniform 	vec4 _ClipRect;
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
#if defined(OUTLINE_ON)
in mediump vec4 vs_COLOR1;
#endif
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
#if defined(UNITY_UI_CLIP_RECT)
in mediump vec4 vs_TEXCOORD2;
#endif
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
in highp vec4 vs_TEXCOORD3;
in mediump vec2 vs_TEXCOORD4;
#endif
#endif
layout(location = 0) out mediump vec4 SV_Target0;
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
vec4 u_xlat0;
#else
vec2 u_xlat0;
#endif
#endif
#else
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
vec4 u_xlat0;
#endif
#endif
#endif
mediump vec4 u_xlat16_0;
#if defined(UNITY_UI_CLIP_RECT)
#if defined(OUTLINE_ON)
vec2 u_xlat1;
#endif
#endif
#else
#if defined(UNITY_UI_CLIP_RECT)
#if !defined(OUTLINE_ON)
#if defined(UNDERLAY_ON)
vec4 u_xlat0;
#else
vec2 u_xlat0;
#endif
#endif
mediump vec4 u_xlat16_0;
#if defined(OUTLINE_ON)
vec2 u_xlat1;
#endif
#else
#if defined(OUTLINE_ON)
mediump vec4 u_xlat16_0;
#else
#if defined(UNDERLAY_ON)
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
#else
mediump float u_xlat16_0;
#endif
#endif
#endif
#endif
mediump float u_xlat16_1;
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
#if defined(OUTLINE_ON)
bool u_xlatb1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_5;
#else
#if defined(UNDERLAY_ON)
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
bool u_xlatb3;
#else
bool u_xlatb2;
mediump float u_xlat16_4;
#endif
#endif
#else
#if defined(OUTLINE_ON)
bool u_xlatb1;
mediump vec2 u_xlat16_2;
#else
#if defined(UNDERLAY_ON)
mediump vec4 u_xlat16_2;
bool u_xlatb3;
#else
bool u_xlatb2;
mediump float u_xlat16_4;
#endif
#endif
#endif
#else
#if defined(UNITY_UI_CLIP_RECT)
#if defined(OUTLINE_ON)
mediump vec2 u_xlat16_2;
#else
#if defined(UNDERLAY_ON)
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
#else
mediump float u_xlat16_3;
#endif
#endif
#else
#if defined(OUTLINE_ON)
mediump vec2 u_xlat16_2;
#else
#if defined(UNDERLAY_ON)
mediump vec4 u_xlat16_2;
#endif
#endif
#endif
#endif
void main()
{
#if defined(UNITY_UI_ALPHACLIP)
#if defined(UNITY_UI_CLIP_RECT)
#if defined(OUTLINE_ON)
    u_xlat16_0 = vs_COLOR0 + (-vs_COLOR1);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_2.xy = vec2(u_xlat16_1) * vs_TEXCOORD1.xx + (-vs_TEXCOORD1.zy);
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_0 + vs_COLOR1;
    u_xlat16_0 = u_xlat16_2.yyyy * u_xlat16_0;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_2.x = u_xlat1.y * u_xlat1.x;
    u_xlat16_5 = u_xlat16_0.w * u_xlat16_2.x + -0.00100000005;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2.xxxx;
    SV_Target0 = u_xlat16_0;
    u_xlatb1 = u_xlat16_5<0.0;
    if(u_xlatb1){discard;}
#else
#if defined(UNDERLAY_ON)
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD3.xy).w;
    u_xlat16_1 = u_xlat16_0.x * vs_TEXCOORD4.x + (-vs_TEXCOORD4.y);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    u_xlat16_0.w = _UnderlayColor.w;
    u_xlat0 = vec4(u_xlat16_1) * u_xlat16_0;
    u_xlat16_2.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat16_2.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_2 = vec4(u_xlat16_1) * vs_COLOR0;
    u_xlat16_1 = (-vs_COLOR0.w) * u_xlat16_1 + 1.0;
    u_xlat0 = u_xlat0 * vec4(u_xlat16_1) + u_xlat16_2;
    u_xlat3.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat3.xy = u_xlat3.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat3.xy = u_xlat3.xy * vs_TEXCOORD2.zw;
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
    u_xlat16_1 = u_xlat3.y * u_xlat3.x;
    u_xlat16_0 = u_xlat0 * vec4(u_xlat16_1);
    u_xlat16_1 = u_xlat16_0.w * vs_TEXCOORD3.z + -0.00100000005;
    u_xlat0 = u_xlat16_0 * vs_TEXCOORD3.zzzz;
    SV_Target0 = u_xlat0;
    u_xlatb3 = u_xlat16_1<0.0;
    if(u_xlatb3){discard;}
#else
    u_xlat0.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat0.xy = u_xlat0.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD2.zw;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat16_1 = u_xlat0.y * u_xlat0.x;
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_4 = u_xlat16_0.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat16_0 = vec4(u_xlat16_4) * vs_COLOR0;
    u_xlat16_4 = u_xlat16_0.w * u_xlat16_1 + -0.00100000005;
    u_xlat16_0 = vec4(u_xlat16_1) * u_xlat16_0;
    SV_Target0 = u_xlat16_0;
    u_xlatb2 = u_xlat16_4<0.0;
    if(u_xlatb2){discard;}
#endif
#endif
#else
#if defined(OUTLINE_ON)
    u_xlat16_0 = vs_COLOR0 + (-vs_COLOR1);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_2.xy = vec2(u_xlat16_1) * vs_TEXCOORD1.xx + (-vs_TEXCOORD1.zy);
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_0 + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.y + -0.00100000005;
    u_xlat16_0 = u_xlat16_2.yyyy * u_xlat16_0;
    SV_Target0 = u_xlat16_0;
    u_xlatb1 = u_xlat16_2.x<0.0;
    if(u_xlatb1){discard;}
#else
#if defined(UNDERLAY_ON)
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD3.xy).w;
    u_xlat16_1 = u_xlat16_0.x * vs_TEXCOORD4.x + (-vs_TEXCOORD4.y);
#else
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat16_0.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
#endif
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#if defined(UNDERLAY_ON)
    u_xlat16_0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    u_xlat16_0.w = _UnderlayColor.w;
    u_xlat0 = vec4(u_xlat16_1) * u_xlat16_0;
    u_xlat16_2.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat16_2.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_2 = vec4(u_xlat16_1) * vs_COLOR0;
    u_xlat16_1 = (-vs_COLOR0.w) * u_xlat16_1 + 1.0;
    u_xlat0 = u_xlat0 * vec4(u_xlat16_1) + u_xlat16_2;
    u_xlat16_1 = u_xlat0.w * vs_TEXCOORD3.z + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_TEXCOORD3.zzzz;
    SV_Target0 = u_xlat0;
    u_xlatb3 = u_xlat16_1<0.0;
    if(u_xlatb3){discard;}
#else
    u_xlat16_4 = vs_COLOR0.w * u_xlat16_1 + -0.00100000005;
    u_xlat16_0 = vec4(u_xlat16_1) * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
    u_xlatb2 = u_xlat16_4<0.0;
    if(u_xlatb2){discard;}
#endif
#endif
#endif
#else
#if defined(UNITY_UI_CLIP_RECT)
#if defined(OUTLINE_ON)
    u_xlat16_0 = vs_COLOR0 + (-vs_COLOR1);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_2.xy = vec2(u_xlat16_1) * vs_TEXCOORD1.xx + (-vs_TEXCOORD1.zy);
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_0 + vs_COLOR1;
    u_xlat16_0 = u_xlat16_2.yyyy * u_xlat16_0;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_2.x = u_xlat1.y * u_xlat1.x;
    SV_Target0 = u_xlat16_0 * u_xlat16_2.xxxx;
#else
#if defined(UNDERLAY_ON)
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD3.xy).w;
    u_xlat16_1 = u_xlat16_0.x * vs_TEXCOORD4.x + (-vs_TEXCOORD4.y);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    u_xlat16_0.w = _UnderlayColor.w;
    u_xlat0 = vec4(u_xlat16_1) * u_xlat16_0;
    u_xlat16_2.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat16_2.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_2 = vec4(u_xlat16_1) * vs_COLOR0;
    u_xlat16_1 = (-vs_COLOR0.w) * u_xlat16_1 + 1.0;
    u_xlat0 = u_xlat0 * vec4(u_xlat16_1) + u_xlat16_2;
    u_xlat3.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat3.xy = u_xlat3.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat3.xy = u_xlat3.xy * vs_TEXCOORD2.zw;
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
    u_xlat16_1 = u_xlat3.y * u_xlat3.x;
    u_xlat16_0 = u_xlat0 * vec4(u_xlat16_1);
    u_xlat0 = u_xlat16_0 * vs_TEXCOORD3.zzzz;
    SV_Target0 = u_xlat0;
#else
    u_xlat0.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat0.xy = u_xlat0.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD2.zw;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat16_1 = u_xlat0.y * u_xlat0.x;
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3 = u_xlat16_0.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_0 = vec4(u_xlat16_3) * vs_COLOR0;
    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_0;
#endif
#endif
#else
#if defined(OUTLINE_ON)
    u_xlat16_0 = vs_COLOR0 + (-vs_COLOR1);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_2.xy = vec2(u_xlat16_1) * vs_TEXCOORD1.xx + (-vs_TEXCOORD1.zy);
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_0 + vs_COLOR1;
    SV_Target0 = u_xlat16_2.yyyy * u_xlat16_0;
#else
#if defined(UNDERLAY_ON)
    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD3.xy).w;
    u_xlat16_1 = u_xlat16_0.x * vs_TEXCOORD4.x + (-vs_TEXCOORD4.y);
#else
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat16_0 * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
#endif
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#if defined(UNDERLAY_ON)
    u_xlat16_0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    u_xlat16_0.w = _UnderlayColor.w;
    u_xlat0 = vec4(u_xlat16_1) * u_xlat16_0;
    u_xlat16_2.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat16_2.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_2 = vec4(u_xlat16_1) * vs_COLOR0;
    u_xlat16_1 = (-vs_COLOR0.w) * u_xlat16_1 + 1.0;
    u_xlat0 = u_xlat0 * vec4(u_xlat16_1) + u_xlat16_2;
    u_xlat0 = u_xlat0 * vs_TEXCOORD3.zzzz;
    SV_Target0 = u_xlat0;
#else
    SV_Target0 = vec4(u_xlat16_1) * vs_COLOR0;
#endif
#endif
#endif
#endif
    return;
}
#endif
			ENDGLSL
		}
	}
}
