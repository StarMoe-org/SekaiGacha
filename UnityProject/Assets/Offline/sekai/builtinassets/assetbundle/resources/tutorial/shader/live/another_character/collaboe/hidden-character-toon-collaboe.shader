// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Hidden/Sekai/Live/Character/Toon-CollaboE"
{
	Properties
	{
		[Title(Stencil)] _Stencil("Stencil ID [0;255]", Float) = 1
		_ReadMask("ReadMask [0;255]", Float) = 255
		_WriteMask("WriteMask [0;255]", Float) = 255
		[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp("Stencil Comparison", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp("Stencil Operation", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilFail("Stencil Fail", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilZFail("Stencil ZFail", Float) = 0
		[Toggle(_LAMBERT)] _UseLambert("Use Lambert", Float) = 1
		[Title(Textures)] _MainTex("Main", 2D) = "white" {}
		_ShadowTex("Shadow", 2D) = "white" {}
		[Header(MRS)] [Toggle(ENABLE_MRS_MAP)] _EnableMRSMask("Enable MRS Map", Float) = 0
		_MRSTexture("MRS (Mask / Reflection / Specular)", 2D) = "black" {}
		[Title(FaceShadow)] [Toggle(_UseFaceSDF)] _UseFaceSDF("Use Face SDF", Float) = 0
		_RangeLimit("Range Limit", Range(0, 1)) = 0
		[Title(Outline)] _OutlineWidth("Outline Width", Float) = 0.001
		_OutlineOffset("Outline Offset", Float) = 0
		[Toggle(_OUTLINE_SECOND_NORMAL)] _UseOutlineSecondNormal("Use Second Normal", Float) = 0
		[Header(Alpha Clip)] [Toggle(ENABLE_ALPHA_CLIP)] _EnableAlphaClip("Enable Alpha Clip", Float) = 0
		_Cutoff("Alpha Clip", Range(0, 1)) = 0.1
		[Header(Shadow)] _ShadowThreshold("Shadow Threshold", Range(0, 1)) = 0.5
		[Space] [Title(Rim)] _RimThreshold("Rim Threshold", Range(0.01, 1)) = 0.2
		[Title(Specular)] _SpecularPower("Specular Power", Range(0, 5)) = 0
		[Header(Render States)] [Enum(Front, 2, Back, 1, Both, 0)] _Culling("Face Rendering", Float) = 1
		[Title(HairShadow)] _HeadNormalBlend("Head Normal Blend", Range(0, 1)) = 0
		[HideInInspector] _FaceFront("FaceFront", Vector) = (0, 0, 0, 0)
		[HideInInspector] _PartsAmbientColor("Parts Ambient Color", Color) = (1, 1, 1, 1)
		[Title(Eyelash)] _EyelashTransparent("Eyelash Transparent", Range(0, 1)) = 0
		_EyelashFaceCameraEdge1("フェードがかかり始める角度 (1:顔の正面, 0:顔の真横)", Range(0, 1)) = 0.5
		_EyelashFaceCameraEdge2("フェードがかかり終わる角度 (1:顔の正面, 0:顔の真横)", Range(0, 1)) = 0
		_EyelashMaskTex("Eyelash Mask", 2D) = "black" {}
		_EyelashStencil("Stencil ID [0;255]", Float) = 1
		_EyelashReadMask("ReadMask [0;255]", Float) = 255
		_EyelashWriteMask("WriteMask [0;255]", Float) = 255
		_UseEyebrowVertexAlpha("Use Eyebrow Vertex Alpha", Range(0, 1)) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _EyelashStencilComp("Stencil Comparison", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _EyelashStencilOp("Stencil Operation", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _EyelashStencilFail("Stencil Fail", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _EyelashStencilZFail("Stencil ZFail", Float) = 0
		[HideInInspector] _CharacterId("CharacterId", Float) = 0
		[HideInInspector] _DefaultSkinColor("DefaultSkinColor", Color) = (0.9921875, 0.9609375, 0.921875, 1)
		[HideInInspector] _Shadow1SkinColor("Shadow1SkinColor", Color) = (0.890625, 0.76953125, 0.796875, 1)
		[HideInInspector] _Shadow2SkinColor("Shadow2SkinColor", Color) = (0.796875, 0.59375, 0.63671875, 1)
		[HideInInspector] _HeadPosition("HeadPosition", Vector) = (0, 0, 0, 0)
		[HideInInspector] _IsLeftEyeClose("IsLeftEyeClose", Float) = 0
		[HideInInspector] _IsRightEyeClose("IsRightEyeClose", Float) = 0
		[HideInInspector] _CharacterReflectionOff("CharacterReflectionOff", Float) = 0
		[HideInInspector] _HeadDotDirectionalLightValues("_HeadDotDirectionalLightValues", Vector) = (1, 1, 1, 1)
	}
	SubShader
	{
		Tags { "IGNOREPROJECTOR"="true" "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
		Pass
		{
			Name "Base"
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="SRPDEFAULTUNLIT" "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
			Stencil
			{
				Ref [_Stencil]
				ReadMask [_ReadMask]
				WriteMask [_WriteMask]
				Comp [_StencilComp]
				Pass [_StencilOp]
				Fail [_StencilFail]
				ZFail [_StencilZFail]
			}
			GLSLPROGRAM
#pragma multi_compile _ USE_DITHER_ALPHA
#pragma multi_compile _ _FACE_SHADOW_RANGE_LIMIT
#pragma multi_compile _ _HAIR_SHADOW
#pragma multi_compile _ _LAMBERT
#pragma multi_compile _ _USE_OVERLAY_FLIPBOOK
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
#if defined(_USE_OVERLAY_FLIPBOOK)
uniform 	mediump float _FlipBookMaskThreshold_Character;
uniform 	mediump float _FlipBookMaskFallOff_Character;
uniform 	mediump float _FlipBookUpperDotMaskOpacity_Character;
uniform 	mediump float _FlipBookLowerDotMaskOpacity_Character;
#endif
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
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_FaceShadowTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineOffset;
	UNITY_UNIFORM float                _SpecularPower;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM mediump float                _HeadNormalBlend;
#else
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HeadNormalBlend;
#endif
	UNITY_UNIFORM mediump float                _EyelashTransparent;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump float                _IsLeftEyeClose;
	UNITY_UNIFORM mediump float                _IsRightEyeClose;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM vec3                _FaceFront;
	UNITY_UNIFORM int                _CharacterId;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM vec3                _HeadPosition;
#else
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_HeadPosition;
#endif
	UNITY_UNIFORM float Xhlslcc_UnusedX_RangeLimit;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HeadDotDirectionalLightValues;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Cutoff;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowThreshold;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out mediump float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD4;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD5;
#if defined(_USE_OVERLAY_FLIPBOOK)
out mediump float vs_TEXCOORD8;
#endif
#if defined(USE_DITHER_ALPHA)
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
#else
vec3 u_xlat0;
#endif
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
#if defined(USE_DITHER_ALPHA)
#if defined(_USE_OVERLAY_FLIPBOOK)
vec4 u_xlat4;
#else
vec3 u_xlat4;
#endif
#if defined(_HAIR_SHADOW)
vec3 u_xlat5;
float u_xlat6;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb6;
#endif
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
#else
float u_xlat5;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb5;
#endif
float u_xlat7;
mediump float u_xlat16_8;
float u_xlat15;
bool u_xlatb15;
float u_xlat17;
#endif
#else
#if defined(_HAIR_SHADOW)
vec3 u_xlat4;
float u_xlat5;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb5;
#endif
float u_xlat7;
mediump float u_xlat16_8;
float u_xlat15;
bool u_xlatb15;
float u_xlat17;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
float u_xlat7;
mediump float u_xlat16_8;
float u_xlat15;
bool u_xlatb15;
float u_xlat17;
#else
float u_xlat4;
float u_xlat6;
mediump float u_xlat16_7;
float u_xlat12;
bool u_xlatb12;
float u_xlat14;
#endif
#endif
#endif
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat1;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlatb18 = 0.0>=in_POSITION0.y;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
#else
#if !defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = max(u_xlat15, 1.17549435e-38);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_NORMAL0.xyz = u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
#endif
    u_xlatb15 = 0.0>=in_POSITION0.y;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
#endif
#else
#if defined(_HAIR_SHADOW)
    u_xlatb15 = 0.0>=in_POSITION0.y;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlatb15 = 0.0>=in_POSITION0.y;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
#else
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = max(u_xlat12, 1.17549435e-38);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_NORMAL0.xyz = u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlatb12 = 0.0>=in_POSITION0.y;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
#endif
#endif
#endif
    u_xlat2.x = (-in_COLOR0.w) + 1.0;
    u_xlat2.xy = vec2(_IsRightEyeClose, _IsLeftEyeClose) * u_xlat2.xx + in_COLOR0.ww;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat8 = (-u_xlat2.x) + u_xlat2.y;
    u_xlat18 = u_xlat18 * u_xlat8 + u_xlat2.x;
#else
    u_xlat7 = (-u_xlat2.x) + u_xlat2.y;
    u_xlat15 = u_xlat15 * u_xlat7 + u_xlat2.x;
#endif
#else
#if defined(_HAIR_SHADOW)
    u_xlat7 = (-u_xlat2.x) + u_xlat2.y;
    u_xlat15 = u_xlat15 * u_xlat7 + u_xlat2.x;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat7 = (-u_xlat2.x) + u_xlat2.y;
    u_xlat15 = u_xlat15 * u_xlat7 + u_xlat2.x;
#else
    u_xlat6 = (-u_xlat2.x) + u_xlat2.y;
    u_xlat12 = u_xlat12 * u_xlat6 + u_xlat2.x;
#endif
#endif
#endif
    u_xlat16_3 = (-_EyelashFaceCameraEdge2) + _EyelashFaceCameraEdge1;
    u_xlat16_3 = float(1.0) / u_xlat16_3;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat20 = dot(u_xlat2.xyz, vec3(_FaceFront.x, _FaceFront.y, _FaceFront.z));
    u_xlat16_9 = u_xlat20 + (-_EyelashFaceCameraEdge2);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_9;
#else
    u_xlat17 = dot(u_xlat2.xyz, vec3(_FaceFront.x, _FaceFront.y, _FaceFront.z));
    u_xlat16_8 = u_xlat17 + (-_EyelashFaceCameraEdge2);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
#endif
#else
#if defined(_HAIR_SHADOW)
    u_xlat17 = dot(u_xlat2.xyz, vec3(_FaceFront.x, _FaceFront.y, _FaceFront.z));
    u_xlat16_8 = u_xlat17 + (-_EyelashFaceCameraEdge2);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat17 = dot(u_xlat2.xyz, vec3(_FaceFront.x, _FaceFront.y, _FaceFront.z));
    u_xlat16_8 = u_xlat17 + (-_EyelashFaceCameraEdge2);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
#else
    u_xlat14 = dot(u_xlat2.xyz, vec3(_FaceFront.x, _FaceFront.y, _FaceFront.z));
    u_xlat16_7 = u_xlat14 + (-_EyelashFaceCameraEdge2);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
#endif
#endif
#endif
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat16_9 = u_xlat16_3 * -2.0 + 3.0;
#else
    u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
#endif
#else
#if defined(_HAIR_SHADOW)
    u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
#else
    u_xlat16_7 = u_xlat16_3 * -2.0 + 3.0;
#endif
#endif
#endif
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat16_3 = u_xlat16_3 * u_xlat16_9;
    u_xlat18 = u_xlat18 * u_xlat16_3;
    vs_TEXCOORD2 = u_xlat18 * _EyelashTransparent;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = max(u_xlat18, 1.17549435e-38);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_NORMAL0.xyz = u_xlat4.xyz;
#else
    u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
    u_xlat15 = u_xlat15 * u_xlat16_3;
    vs_TEXCOORD2 = u_xlat15 * _EyelashTransparent;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = max(u_xlat15, 1.17549435e-38);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    vs_NORMAL0.xyz = u_xlat4.xyz;
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
    u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
    u_xlat15 = u_xlat15 * u_xlat16_3;
    vs_TEXCOORD2 = u_xlat15 * _EyelashTransparent;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = max(u_xlat15, 1.17549435e-38);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    vs_NORMAL0.xyz = u_xlat4.xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
    u_xlat15 = u_xlat15 * u_xlat16_3;
    vs_TEXCOORD2 = u_xlat15 * _EyelashTransparent;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = max(u_xlat15, 1.17549435e-38);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    vs_NORMAL0.xyz = u_xlat4.xyz;
#else
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat12 = u_xlat12 * u_xlat16_3;
    vs_TEXCOORD2 = u_xlat12 * _EyelashTransparent;
#endif
#endif
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat5.xyz = u_xlat0.xyz + (-vec3(_HeadPosition.x, _HeadPosition.y, _HeadPosition.z));
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat18) + (-u_xlat4.xyz);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat4.xzw = vec3(_HeadNormalBlend) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat4.xzw, u_xlat4.xzw);
#else
    u_xlat4.xyz = vec3(_HeadNormalBlend) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
#endif
    u_xlat18 = inversesqrt(u_xlat18);
#if defined(_USE_OVERLAY_FLIPBOOK)
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat4.xzw;
    u_xlat4.xzw = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
#else
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    u_xlat4.xzw = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
#else
    u_xlat4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
    u_xlat1.xyw = u_xlat0.xyz + (-vec3(_HeadPosition.x, _HeadPosition.y, _HeadPosition.z));
    u_xlat15 = dot(u_xlat1.xyw, u_xlat1.xyw);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyw = u_xlat1.xyw * vec3(u_xlat15) + (-u_xlat4.xyz);
    u_xlat1.xyw = vec3(_HeadNormalBlend) * u_xlat1.xyw + u_xlat4.xyz;
    u_xlat15 = dot(u_xlat1.xyw, u_xlat1.xyw);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD3.xyz = vec3(u_xlat15) * u_xlat1.xyw;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
#endif
#endif
    u_xlat1.xyw = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlatb0 = unity_OrthoParams.w==0.0;
#if defined(USE_DITHER_ALPHA)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat4.xzw : u_xlat2.xyz;
#else
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat4.xyz : u_xlat2.xyz;
#endif
#if defined(_HAIR_SHADOW)
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD4.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#else
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
#endif
#else
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat1.xyw : u_xlat2.xyz;
#if defined(_HAIR_SHADOW)
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
#else
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat0.xyz;
#endif
#endif
#endif
    vs_TEXCOORD7 = u_xlat1.z;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat6 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat6;
#else
    u_xlat5 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat5;
#endif
#else
#if defined(_HAIR_SHADOW)
    u_xlat5 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat5;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat5 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat5;
#else
    u_xlat4 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat4;
#endif
#endif
#endif
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD6 = u_xlat0.x;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlatb0 = 0.0>=u_xlat4.y;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * _FlipBookLowerDotMaskOpacity_Character;
    u_xlatb6 = u_xlat4.y>=0.0;
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat16_3 = u_xlat6 * _FlipBookUpperDotMaskOpacity_Character + u_xlat0.x;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = abs(u_xlat4.y) * u_xlat16_3 + (-_FlipBookMaskThreshold_Character);
    u_xlat16_9 = _FlipBookMaskFallOff_Character + 0.00100000005;
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_3 = u_xlat16_9 * u_xlat16_3;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_9 = u_xlat16_3 * -2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    vs_TEXCOORD8 = u_xlat16_3 * u_xlat16_9;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlatb0 = 0.0>=u_xlat4.y;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * _FlipBookLowerDotMaskOpacity_Character;
    u_xlatb5 = u_xlat4.y>=0.0;
    u_xlat5 = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat16_3 = u_xlat5 * _FlipBookUpperDotMaskOpacity_Character + u_xlat0.x;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = abs(u_xlat4.y) * u_xlat16_3 + (-_FlipBookMaskThreshold_Character);
    u_xlat16_8 = _FlipBookMaskFallOff_Character + 0.00100000005;
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
    u_xlat16_8 = float(1.0) / u_xlat16_8;
    u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    vs_TEXCOORD8 = u_xlat16_3 * u_xlat16_8;
#endif
#endif
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlatb0 = 0.0>=u_xlat4.y;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * _FlipBookLowerDotMaskOpacity_Character;
    u_xlatb5 = u_xlat4.y>=0.0;
    u_xlat5 = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat16_3 = u_xlat5 * _FlipBookUpperDotMaskOpacity_Character + u_xlat0.x;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = abs(u_xlat4.y) * u_xlat16_3 + (-_FlipBookMaskThreshold_Character);
    u_xlat16_8 = _FlipBookMaskFallOff_Character + 0.00100000005;
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
    u_xlat16_8 = float(1.0) / u_xlat16_8;
    u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    vs_TEXCOORD8 = u_xlat16_3 * u_xlat16_8;
#endif
#endif
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
uniform 	vec2 _GlobalMipBias;
uniform 	vec4 _ProjectionParams;
#if defined(USE_DITHER_ALPHA)
uniform 	vec4 _ScreenParams;
#endif
uniform 	vec4 _SekaiDirectionalLight;
uniform 	mediump vec4 _SekaiShadowColor;
uniform 	mediump float _SekaiShadowThreshold;
uniform 	mediump vec4 _SekaiCharacterSpecularColorArray[10];
#if defined(USE_DITHER_ALPHA)
uniform 	mediump float _DitherAlpha;
#endif
uniform 	vec4 _CoCParams;
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiCharacterAmbientLightIntensityArray[12];
uniform 	vec4 _SekaiCharacterAmbientLightColorArray[12];
uniform 	vec4 _SekaiRimLightArray[12];
uniform 	vec4 _SekaiRimLightColorArray[12];
uniform 	vec4 _SekaiShadowRimLightColorArray[12];
uniform 	mediump vec4 _SekaiRimLightFactor[12];
uniform 	mediump float _SekaiRimLightShadowSharpnessArray[12];
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
uniform 	vec4 _SekaiFogColor;
#if defined(_USE_OVERLAY_FLIPBOOK)
uniform 	vec3 _FlipBookCenterPosition;
uniform 	float _GlobalFlipBookTime;
uniform 	mediump float _FlipBookFrameCountX;
uniform 	mediump float _FlipBookFrameCountY;
uniform 	mediump float _FlipBookFPS;
uniform 	mediump vec4 _FlipBookColor_Character;
uniform 	mediump float _FlipBookOpacity;
uniform 	mediump float _FlipBookFadeRadius;
uniform 	mediump float _FlipBookFadeFallOff;
uniform 	mediump float _FlipBookScale_Character;
uniform 	vec2 _FlipBookUVScroll_Character;
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_FaceShadowTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineOffset;
	UNITY_UNIFORM float                _SpecularPower;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM mediump float                _HeadNormalBlend;
#else
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HeadNormalBlend;
#endif
	UNITY_UNIFORM mediump float                _EyelashTransparent;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump float                _IsLeftEyeClose;
	UNITY_UNIFORM mediump float                _IsRightEyeClose;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM vec3                _FaceFront;
	UNITY_UNIFORM int                _CharacterId;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM vec3                _HeadPosition;
#else
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_HeadPosition;
#endif
	UNITY_UNIFORM float Xhlslcc_UnusedX_RangeLimit;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HeadDotDirectionalLightValues;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Cutoff;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowThreshold;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if defined(USE_DITHER_ALPHA)
#if defined(_USE_OVERLAY_FLIPBOOK)
UNITY_LOCATION(0) uniform mediump sampler2D _FlipBookTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(3) uniform mediump sampler2D _ValueTex;
UNITY_LOCATION(4) uniform mediump sampler2D _DitherTex;
#else
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ValueTex;
UNITY_LOCATION(3) uniform mediump sampler2D _DitherTex;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
UNITY_LOCATION(0) uniform mediump sampler2D _FlipBookTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(3) uniform mediump sampler2D _ValueTex;
#else
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ValueTex;
#endif
#endif
in highp vec3 vs_NORMAL0;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in mediump float vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD5;
#if defined(_USE_OVERLAY_FLIPBOOK)
in mediump float vs_TEXCOORD8;
#endif
#if defined(USE_DITHER_ALPHA)
in highp vec4 vs_TEXCOORD9;
#endif
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
#if defined(USE_DITHER_ALPHA)
vec2 u_xlat0;
#endif
mediump vec4 u_xlat16_0;
#if defined(USE_DITHER_ALPHA)
bool u_xlatb0;
#if defined(_USE_OVERLAY_FLIPBOOK)
mediump vec4 u_xlat16_1;
#else
mediump vec3 u_xlat16_1;
#endif
#if defined(_LAMBERT)
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
#else
vec4 u_xlat2;
mediump float u_xlat16_2;
#endif
bool u_xlatb2;
#else
#if defined(_LAMBERT)
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
#else
vec4 u_xlat1;
mediump float u_xlat16_1;
#endif
bool u_xlatb1;
#if defined(_USE_OVERLAY_FLIPBOOK)
mediump vec4 u_xlat16_2;
#else
mediump vec3 u_xlat16_2;
#endif
#endif
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec4 u_xlatb3;
vec3 u_xlat4;
int u_xlati4;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb6;
#endif
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
vec3 u_xlat13;
mediump vec3 u_xlat16_14;
#else
vec3 u_xlat5;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb5;
#endif
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat8;
float u_xlat11;
int u_xlati11;
float u_xlat13;
mediump vec3 u_xlat16_15;
#else
float u_xlat10;
int u_xlati10;
float u_xlat12;
mediump vec3 u_xlat16_14;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
int u_xlati19;
#endif
#endif
#else
vec3 u_xlat5;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb5;
#endif
#if defined(_LAMBERT)
vec3 u_xlat6;
#else
mediump vec3 u_xlat16_6;
#endif
mediump vec3 u_xlat16_7;
#if defined(_LAMBERT)
mediump vec3 u_xlat16_8;
float u_xlat11;
float u_xlat13;
mediump vec3 u_xlat16_16;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat8;
float u_xlat11;
int u_xlati11;
float u_xlat13;
mediump vec3 u_xlat16_15;
#else
float u_xlat10;
int u_xlati10;
float u_xlat12;
mediump vec3 u_xlat16_14;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
int u_xlati19;
#endif
#endif
#endif
float u_xlat20;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat22;
#else
float u_xlat22;
#endif
mediump float u_xlat16_28;
float u_xlat29;
int u_xlati29;
#if defined(_USE_OVERLAY_FLIPBOOK)
float u_xlat30;
#endif
float u_xlat31;
mediump float u_xlat16_32;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb20;
float u_xlat21;
int u_xlati21;
vec2 u_xlat22;
mediump float u_xlat16_28;
float u_xlat29;
float u_xlat30;
float u_xlat31;
mediump float u_xlat16_33;
#else
mediump float u_xlat16_25;
float u_xlat26;
float u_xlat28;
mediump float u_xlat16_30;
#endif
#endif
#else
#if defined(_LAMBERT)
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat22;
#else
float u_xlat22;
#endif
mediump float u_xlat16_28;
float u_xlat29;
int u_xlati29;
#if defined(_USE_OVERLAY_FLIPBOOK)
float u_xlat30;
#endif
float u_xlat31;
mediump float u_xlat16_34;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb20;
float u_xlat21;
int u_xlati21;
vec2 u_xlat22;
mediump float u_xlat16_28;
float u_xlat29;
float u_xlat30;
float u_xlat31;
mediump float u_xlat16_33;
#else
mediump float u_xlat16_25;
float u_xlat26;
float u_xlat28;
mediump float u_xlat16_30;
#endif
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb6;
#endif
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat10;
vec3 u_xlat13;
mediump vec3 u_xlat16_14;
#else
vec3 u_xlat5;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb5;
#endif
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat8;
float u_xlat10;
int u_xlati10;
float u_xlat13;
mediump vec3 u_xlat16_15;
#else
float u_xlat9;
int u_xlati9;
float u_xlat12;
mediump vec3 u_xlat16_14;
float u_xlat17;
bool u_xlatb17;
#endif
#endif
#else
vec3 u_xlat5;
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb5;
#endif
#if defined(_LAMBERT)
vec3 u_xlat6;
#else
mediump vec3 u_xlat16_6;
#endif
mediump vec3 u_xlat16_7;
#if defined(_LAMBERT)
mediump vec3 u_xlat16_8;
float u_xlat10;
float u_xlat13;
mediump vec3 u_xlat16_16;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat8;
float u_xlat10;
int u_xlati10;
float u_xlat13;
mediump vec3 u_xlat16_15;
#else
float u_xlat9;
int u_xlati9;
float u_xlat12;
mediump vec3 u_xlat16_14;
float u_xlat17;
bool u_xlatb17;
#endif
#endif
#endif
float u_xlat19;
#if defined(_LAMBERT)
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
#if defined(_USE_OVERLAY_FLIPBOOK)
vec2 u_xlat22;
#else
float u_xlat22;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
bool u_xlatb19;
float u_xlat21;
int u_xlati21;
vec2 u_xlat22;
#else
int u_xlati19;
float u_xlat20;
float u_xlat25;
mediump float u_xlat16_26;
#endif
#endif
float u_xlat28;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
int u_xlati28;
mediump float u_xlat16_29;
#if defined(_USE_OVERLAY_FLIPBOOK)
float u_xlat30;
#endif
float u_xlat31;
mediump float u_xlat16_32;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
mediump float u_xlat16_29;
float u_xlat30;
float u_xlat31;
mediump float u_xlat16_33;
#else
mediump float u_xlat16_30;
#endif
#endif
#else
#if defined(_LAMBERT)
int u_xlati28;
mediump float u_xlat16_29;
#if defined(_USE_OVERLAY_FLIPBOOK)
float u_xlat30;
#endif
float u_xlat31;
mediump float u_xlat16_34;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
mediump float u_xlat16_29;
float u_xlat30;
float u_xlat31;
mediump float u_xlat16_33;
#else
mediump float u_xlat16_30;
#endif
#endif
#endif
#endif
void main()
{
#if defined(USE_DITHER_ALPHA)
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat16_0.x = texture(_DitherTex, u_xlat0.xy, _GlobalMipBias.x).x;
    u_xlat16_1.x = (-u_xlat16_0.x) + _DitherAlpha;
    u_xlatb0 = u_xlat16_1.x<0.0;
    if(u_xlatb0){discard;}
#endif
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat16_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlati29 = _CharacterId;
    u_xlat16_1.xyz = _SekaiCharacterSpecularColorArray[u_xlati29].www * _SekaiCharacterSpecularColorArray[u_xlati29].xyz;
#else
    u_xlat16_2 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlati11 = _CharacterId;
    u_xlat16_1.xyz = _SekaiCharacterSpecularColorArray[u_xlati11].www * _SekaiCharacterSpecularColorArray[u_xlati11].xyz;
#else
    u_xlati10 = _CharacterId;
    u_xlat16_1.xyz = _SekaiCharacterSpecularColorArray[u_xlati10].www * _SekaiCharacterSpecularColorArray[u_xlati10].xyz;
#endif
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlati28 = _CharacterId;
    u_xlat16_2.xyz = _SekaiCharacterSpecularColorArray[u_xlati28].www * _SekaiCharacterSpecularColorArray[u_xlati28].xyz;
#else
    u_xlat16_1 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlati10 = _CharacterId;
    u_xlat16_2.xyz = _SekaiCharacterSpecularColorArray[u_xlati10].www * _SekaiCharacterSpecularColorArray[u_xlati10].xyz;
#else
    u_xlati9 = _CharacterId;
    u_xlat16_2.xyz = _SekaiCharacterSpecularColorArray[u_xlati9].www * _SekaiCharacterSpecularColorArray[u_xlati9].xyz;
#endif
#endif
#endif
    u_xlat16_3 = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_28 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat4.x = u_xlat16_28 + u_xlat21;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlatb4 = u_xlat4.x>=_SekaiShadowThreshold;
    u_xlat4.x = (u_xlatb4) ? 0.0 : 1.0;
    u_xlat21 = u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = _SekaiShadowThreshold>=u_xlat21;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat16_5.xyz = (-u_xlat16_0.xyz) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = vec3(u_xlat21) * u_xlat16_5.xyz + u_xlat16_0.xyz;
    u_xlat13.xyz = u_xlat16_5.xyz * _SekaiShadowColor.xyz + (-u_xlat16_0.xyz);
    u_xlat13.xyz = u_xlat4.xxx * u_xlat13.xyz + u_xlat16_0.xyz;
    u_xlat2.x = (-u_xlat16_0.x) + u_xlat16_2.x;
    u_xlat2.x = u_xlat4.x * u_xlat2.x + u_xlat16_0.x;
    u_xlat6.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat7.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_28 = u_xlat2.x + u_xlat2.x;
    u_xlat16_5.x = u_xlat2.x * 2.0 + -1.0;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_14.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz + u_xlat6.xyz;
    u_xlat16_28 = u_xlat16_28;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_5.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz + u_xlat7.xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_28 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat20 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat20 = u_xlat20 * 0.5 + 0.5;
    u_xlat20 = u_xlat16_28 + u_xlat20;
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
    u_xlatb20 = u_xlat20>=_SekaiShadowThreshold;
    u_xlat20 = (u_xlatb20) ? 0.0 : 1.0;
#else
    u_xlat16_25 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat18 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = u_xlat18 * 0.5 + 0.5;
    u_xlat18 = u_xlat16_25 + u_xlat18;
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlatb18 = u_xlat18>=_SekaiShadowThreshold;
    u_xlat18 = (u_xlatb18) ? 0.0 : 1.0;
#endif
    u_xlat2.x = (-u_xlat16_0.x) + u_xlat16_2;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat2.x = u_xlat20 * u_xlat2.x + u_xlat16_0.x;
#else
    u_xlat2.x = u_xlat18 * u_xlat2.x + u_xlat16_0.x;
#endif
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_28 = u_xlat2.x + u_xlat2.x;
#else
    u_xlat16_25 = u_xlat2.x + u_xlat2.x;
#endif
    u_xlat16_6.x = u_xlat2.x * 2.0 + -1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_15.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_15.xyz + u_xlat4.xyz;
    u_xlat16_28 = u_xlat16_28;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#else
    u_xlat16_14.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz + u_xlat4.xyz;
    u_xlat16_25 = u_xlat16_25;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_6.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz + u_xlat5.xyz;
#else
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz + u_xlat5.xyz;
#endif
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_28 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat21 = u_xlat16_28 + u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = u_xlat21>=_SekaiShadowThreshold;
    u_xlat21 = (u_xlatb21) ? 0.0 : 1.0;
    u_xlat4.xyz = u_xlat16_2.xyz * _SekaiShadowColor.xyz + (-u_xlat16_0.xyz);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz + u_xlat16_0.xyz;
    u_xlat2.x = (-u_xlat16_0.x) + u_xlat16_2.x;
    u_xlat2.x = u_xlat21 * u_xlat2.x + u_xlat16_0.x;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat6.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_28 = u_xlat2.x + u_xlat2.x;
    u_xlat16_7.x = u_xlat2.x * 2.0 + -1.0;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_16.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_16.xyz + u_xlat5.xyz;
    u_xlat16_28 = u_xlat16_28;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_7.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz + u_xlat6.xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_28 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat20 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat20 = u_xlat20 * 0.5 + 0.5;
    u_xlat20 = u_xlat16_28 + u_xlat20;
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
    u_xlatb20 = u_xlat20>=_SekaiShadowThreshold;
    u_xlat20 = (u_xlatb20) ? 0.0 : 1.0;
#else
    u_xlat16_25 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat18 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = u_xlat18 * 0.5 + 0.5;
    u_xlat18 = u_xlat16_25 + u_xlat18;
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlatb18 = u_xlat18>=_SekaiShadowThreshold;
    u_xlat18 = (u_xlatb18) ? 0.0 : 1.0;
#endif
    u_xlat2.x = (-u_xlat16_0.x) + u_xlat16_2;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat2.x = u_xlat20 * u_xlat2.x + u_xlat16_0.x;
#else
    u_xlat2.x = u_xlat18 * u_xlat2.x + u_xlat16_0.x;
#endif
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_28 = u_xlat2.x + u_xlat2.x;
#else
    u_xlat16_25 = u_xlat2.x + u_xlat2.x;
#endif
    u_xlat16_6.x = u_xlat2.x * 2.0 + -1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_15.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_15.xyz + u_xlat4.xyz;
    u_xlat16_28 = u_xlat16_28;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#else
    u_xlat16_14.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz + u_xlat4.xyz;
    u_xlat16_25 = u_xlat16_25;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_6.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz + u_xlat5.xyz;
#else
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz + u_xlat5.xyz;
#endif
#endif
#endif
    u_xlatb2 = u_xlat16_3.x>=0.5;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_28 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_5.xyz = (-u_xlat13.xyz) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz + u_xlat13.xyz;
    u_xlat2.xyz = _SekaiRimLightColorArray[u_xlati29].www * _SekaiRimLightColorArray[u_xlati29].xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_28 = (u_xlatb2) ? 1.0 : 0.0;
#else
    u_xlat16_25 = (u_xlatb2) ? 1.0 : 0.0;
#endif
    u_xlat16_6.xyz = (-u_xlat16_0.xyz) + u_xlat16_6.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat2.xzw = _SekaiRimLightColorArray[u_xlati11].www * _SekaiRimLightColorArray[u_xlati11].xyz;
#else
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat2.xzw = _SekaiRimLightColorArray[u_xlati10].www * _SekaiRimLightColorArray[u_xlati10].xyz;
#endif
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_28 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_7.xyz = (-u_xlat4.xyz) + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz + u_xlat4.xyz;
    u_xlat2.xyz = _SekaiRimLightColorArray[u_xlati29].www * _SekaiRimLightColorArray[u_xlati29].xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_28 = (u_xlatb2) ? 1.0 : 0.0;
#else
    u_xlat16_25 = (u_xlatb2) ? 1.0 : 0.0;
#endif
    u_xlat16_6.xyz = (-u_xlat16_0.xyz) + u_xlat16_6.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat2.xzw = _SekaiRimLightColorArray[u_xlati11].www * _SekaiRimLightColorArray[u_xlati11].xyz;
#else
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat2.xzw = _SekaiRimLightColorArray[u_xlati10].www * _SekaiRimLightColorArray[u_xlati10].xyz;
#endif
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_29 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat4.x = u_xlat16_29 + u_xlat21;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlatb4 = u_xlat4.x>=_SekaiShadowThreshold;
    u_xlat4.x = (u_xlatb4) ? 0.0 : 1.0;
    u_xlat21 = u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = _SekaiShadowThreshold>=u_xlat21;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat16_5.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat21) * u_xlat16_5.xyz + u_xlat16_0.xyz;
    u_xlat13.xyz = u_xlat16_5.xyz * _SekaiShadowColor.xyz + (-u_xlat16_0.xyz);
    u_xlat13.xyz = u_xlat4.xxx * u_xlat13.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat1.x = u_xlat4.x * u_xlat1.x + u_xlat16_0.x;
    u_xlat6.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat7.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_29 = u_xlat1.x + u_xlat1.x;
    u_xlat16_5.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_14.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz + u_xlat6.xyz;
    u_xlat16_29 = u_xlat16_29;
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_5.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_29) * u_xlat16_5.xyz + u_xlat7.xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_29 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat19 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat19 = u_xlat19 * 0.5 + 0.5;
    u_xlat19 = u_xlat16_29 + u_xlat19;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlatb19 = u_xlat19>=_SekaiShadowThreshold;
    u_xlat19 = (u_xlatb19) ? 0.0 : 1.0;
#else
    u_xlat16_26 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat17 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat17 = u_xlat17 * 0.5 + 0.5;
    u_xlat17 = u_xlat16_26 + u_xlat17;
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
    u_xlatb17 = u_xlat17>=_SekaiShadowThreshold;
    u_xlat17 = (u_xlatb17) ? 0.0 : 1.0;
#endif
    u_xlat1.x = (-u_xlat16_0.x) + u_xlat16_1;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat1.x = u_xlat19 * u_xlat1.x + u_xlat16_0.x;
#else
    u_xlat1.x = u_xlat17 * u_xlat1.x + u_xlat16_0.x;
#endif
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_29 = u_xlat1.x + u_xlat1.x;
#else
    u_xlat16_26 = u_xlat1.x + u_xlat1.x;
#endif
    u_xlat16_6.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_15.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_15.xyz + u_xlat4.xyz;
    u_xlat16_29 = u_xlat16_29;
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#else
    u_xlat16_14.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz + u_xlat4.xyz;
    u_xlat16_26 = u_xlat16_26;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_6.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_6.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz + u_xlat5.xyz;
#else
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat5.xyz;
#endif
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_29 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat21 = u_xlat16_29 + u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = u_xlat21>=_SekaiShadowThreshold;
    u_xlat21 = (u_xlatb21) ? 0.0 : 1.0;
    u_xlat4.xyz = u_xlat16_1.xyz * _SekaiShadowColor.xyz + (-u_xlat16_0.xyz);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat1.x = u_xlat21 * u_xlat1.x + u_xlat16_0.x;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat6.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_29 = u_xlat1.x + u_xlat1.x;
    u_xlat16_7.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_16.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_16.xyz + u_xlat5.xyz;
    u_xlat16_29 = u_xlat16_29;
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_7.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat6.xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_29 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat19 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat19 = u_xlat19 * 0.5 + 0.5;
    u_xlat19 = u_xlat16_29 + u_xlat19;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlatb19 = u_xlat19>=_SekaiShadowThreshold;
    u_xlat19 = (u_xlatb19) ? 0.0 : 1.0;
#else
    u_xlat16_26 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat17 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat17 = u_xlat17 * 0.5 + 0.5;
    u_xlat17 = u_xlat16_26 + u_xlat17;
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
    u_xlatb17 = u_xlat17>=_SekaiShadowThreshold;
    u_xlat17 = (u_xlatb17) ? 0.0 : 1.0;
#endif
    u_xlat1.x = (-u_xlat16_0.x) + u_xlat16_1;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat1.x = u_xlat19 * u_xlat1.x + u_xlat16_0.x;
#else
    u_xlat1.x = u_xlat17 * u_xlat1.x + u_xlat16_0.x;
#endif
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_29 = u_xlat1.x + u_xlat1.x;
#else
    u_xlat16_26 = u_xlat1.x + u_xlat1.x;
#endif
    u_xlat16_6.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_15.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_15.xyz + u_xlat4.xyz;
    u_xlat16_29 = u_xlat16_29;
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#else
    u_xlat16_14.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz + u_xlat4.xyz;
    u_xlat16_26 = u_xlat16_26;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_6.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_6.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz + u_xlat5.xyz;
#else
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat5.xyz;
#endif
#endif
#endif
    u_xlatb1 = u_xlat16_3.x>=0.5;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_29 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_5.xyz = (-u_xlat13.xyz) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_29) * u_xlat16_5.xyz + u_xlat13.xyz;
    u_xlat1.xyz = _SekaiRimLightColorArray[u_xlati28].www * _SekaiRimLightColorArray[u_xlati28].xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_29 = (u_xlatb1) ? 1.0 : 0.0;
#else
    u_xlat16_26 = (u_xlatb1) ? 1.0 : 0.0;
#endif
    u_xlat16_6.xyz = (-u_xlat16_0.xyz) + u_xlat16_6.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_6.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat1.xzw = _SekaiRimLightColorArray[u_xlati10].www * _SekaiRimLightColorArray[u_xlati10].xyz;
#else
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat1.xzw = _SekaiRimLightColorArray[u_xlati9].www * _SekaiRimLightColorArray[u_xlati9].xyz;
#endif
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_29 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_7.xyz = (-u_xlat4.xyz) + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat4.xyz;
    u_xlat1.xyz = _SekaiRimLightColorArray[u_xlati28].www * _SekaiRimLightColorArray[u_xlati28].xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_29 = (u_xlatb1) ? 1.0 : 0.0;
#else
    u_xlat16_26 = (u_xlatb1) ? 1.0 : 0.0;
#endif
    u_xlat16_6.xyz = (-u_xlat16_0.xyz) + u_xlat16_6.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_6.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat1.xzw = _SekaiRimLightColorArray[u_xlati10].www * _SekaiRimLightColorArray[u_xlati10].xyz;
#else
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat1.xzw = _SekaiRimLightColorArray[u_xlati9].www * _SekaiRimLightColorArray[u_xlati9].xyz;
#endif
#endif
#endif
#endif
    u_xlat3.x = dot(vs_NORMAL0.xyz, vs_TEXCOORD4.xyz);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat3.z = dot(vs_TEXCOORD4.xyz, _SekaiRimLightArray[u_xlati29].xyz);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.z = dot(vs_TEXCOORD4.xyz, _SekaiRimLightArray[u_xlati11].xyz);
#else
    u_xlat3.z = dot(vs_TEXCOORD4.xyz, _SekaiRimLightArray[u_xlati10].xyz);
#endif
#endif
#else
#if defined(_LAMBERT)
    u_xlat3.z = dot(vs_TEXCOORD4.xyz, _SekaiRimLightArray[u_xlati28].xyz);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.z = dot(vs_TEXCOORD4.xyz, _SekaiRimLightArray[u_xlati10].xyz);
#else
    u_xlat3.z = dot(vs_TEXCOORD4.xyz, _SekaiRimLightArray[u_xlati9].xyz);
#endif
#endif
#endif
    u_xlat4.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_NORMAL0.xyz;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati29].xyz, _SekaiRimLightArray[u_xlati29].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat6.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati29].xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat16_28 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati29];
    u_xlat16_32 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati29]);
    u_xlat13.x = (-u_xlat16_28) + u_xlat16_32;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat22.x = (-u_xlat16_28) + u_xlat4.x;
#else
    u_xlat22 = (-u_xlat16_28) + u_xlat4.x;
#endif
    u_xlat13.x = float(1.0) / u_xlat13.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat13.x = u_xlat13.x * u_xlat22.x;
#else
    u_xlat13.x = u_xlat13.x * u_xlat22;
#endif
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat22.x = u_xlat13.x * -2.0 + 3.0;
#else
    u_xlat22 = u_xlat13.x * -2.0 + 3.0;
#endif
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat13.x = u_xlat13.x * u_xlat22.x;
#else
    u_xlat13.x = u_xlat13.x * u_xlat22;
#endif
    u_xlat6.xyz = _SekaiShadowRimLightColorArray[u_xlati29].xyz * _SekaiShadowRimLightColorArray[u_xlati29].www + (-u_xlat2.xyz);
    u_xlat2.xyz = u_xlat13.xxx * u_xlat6.xyz + u_xlat2.xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati11].xyz, _SekaiRimLightArray[u_xlati11].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat5.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati11].xyz;
#else
    u_xlat28 = dot(_SekaiRimLightArray[u_xlati10].xyz, _SekaiRimLightArray[u_xlati10].xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = vec3(u_xlat28) * _SekaiRimLightArray[u_xlati10].xyz;
#endif
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat5.xyz);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_28 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati11];
    u_xlat16_33 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati11]);
    u_xlat13 = (-u_xlat16_28) + u_xlat16_33;
    u_xlat22.x = (-u_xlat16_28) + u_xlat4.x;
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22.x;
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
    u_xlat22.x = u_xlat13 * -2.0 + 3.0;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22.x;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati11].xyz * _SekaiShadowRimLightColorArray[u_xlati11].www + (-u_xlat2.xzw);
    u_xlat2.xzw = vec3(u_xlat13) * u_xlat5.xyz + u_xlat2.xzw;
#else
    u_xlat16_25 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati10];
    u_xlat16_30 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati10]);
    u_xlat12 = (-u_xlat16_25) + u_xlat16_30;
    u_xlat20 = (-u_xlat16_25) + u_xlat4.x;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat20 = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati10].xyz * _SekaiShadowRimLightColorArray[u_xlati10].www + (-u_xlat2.xzw);
    u_xlat2.xzw = vec3(u_xlat12) * u_xlat5.xyz + u_xlat2.xzw;
#endif
#endif
#else
#if defined(_LAMBERT)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati29].xyz, _SekaiRimLightArray[u_xlati29].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat5.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati29].xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati11].xyz, _SekaiRimLightArray[u_xlati11].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat5.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati11].xyz;
#else
    u_xlat28 = dot(_SekaiRimLightArray[u_xlati10].xyz, _SekaiRimLightArray[u_xlati10].xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = vec3(u_xlat28) * _SekaiRimLightArray[u_xlati10].xyz;
#endif
#endif
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat5.xyz);
#if defined(_LAMBERT)
    u_xlat16_28 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati29];
    u_xlat16_34 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati29]);
    u_xlat13 = (-u_xlat16_28) + u_xlat16_34;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat22.x = (-u_xlat16_28) + u_xlat4.x;
#else
    u_xlat22 = (-u_xlat16_28) + u_xlat4.x;
#endif
    u_xlat13 = float(1.0) / u_xlat13;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat13 = u_xlat13 * u_xlat22.x;
#else
    u_xlat13 = u_xlat13 * u_xlat22;
#endif
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat22.x = u_xlat13 * -2.0 + 3.0;
#else
    u_xlat22 = u_xlat13 * -2.0 + 3.0;
#endif
    u_xlat13 = u_xlat13 * u_xlat13;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat13 = u_xlat13 * u_xlat22.x;
#else
    u_xlat13 = u_xlat13 * u_xlat22;
#endif
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati29].xyz * _SekaiShadowRimLightColorArray[u_xlati29].www + (-u_xlat2.xyz);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat5.xyz + u_xlat2.xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_28 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati11];
    u_xlat16_33 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati11]);
    u_xlat13 = (-u_xlat16_28) + u_xlat16_33;
    u_xlat22.x = (-u_xlat16_28) + u_xlat4.x;
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22.x;
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
    u_xlat22.x = u_xlat13 * -2.0 + 3.0;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22.x;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati11].xyz * _SekaiShadowRimLightColorArray[u_xlati11].www + (-u_xlat2.xzw);
    u_xlat2.xzw = vec3(u_xlat13) * u_xlat5.xyz + u_xlat2.xzw;
#else
    u_xlat16_25 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati10];
    u_xlat16_30 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati10]);
    u_xlat12 = (-u_xlat16_25) + u_xlat16_30;
    u_xlat20 = (-u_xlat16_25) + u_xlat4.x;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat20 = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati10].xyz * _SekaiShadowRimLightColorArray[u_xlati10].www + (-u_xlat2.xzw);
    u_xlat2.xzw = vec3(u_xlat12) * u_xlat5.xyz + u_xlat2.xzw;
#endif
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati28].xyz, _SekaiRimLightArray[u_xlati28].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat6.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati28].xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat16_29 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati28];
    u_xlat16_32 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati28]);
    u_xlat13.x = (-u_xlat16_29) + u_xlat16_32;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat22.x = (-u_xlat16_29) + u_xlat4.x;
#else
    u_xlat22 = (-u_xlat16_29) + u_xlat4.x;
#endif
    u_xlat13.x = float(1.0) / u_xlat13.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat13.x = u_xlat13.x * u_xlat22.x;
#else
    u_xlat13.x = u_xlat13.x * u_xlat22;
#endif
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat22.x = u_xlat13.x * -2.0 + 3.0;
#else
    u_xlat22 = u_xlat13.x * -2.0 + 3.0;
#endif
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat13.x = u_xlat13.x * u_xlat22.x;
#else
    u_xlat13.x = u_xlat13.x * u_xlat22;
#endif
    u_xlat6.xyz = _SekaiShadowRimLightColorArray[u_xlati28].xyz * _SekaiShadowRimLightColorArray[u_xlati28].www + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat13.xxx * u_xlat6.xyz + u_xlat1.xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati10].xyz, _SekaiRimLightArray[u_xlati10].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat5.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati10].xyz;
#else
    u_xlat28 = dot(_SekaiRimLightArray[u_xlati9].xyz, _SekaiRimLightArray[u_xlati9].xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = vec3(u_xlat28) * _SekaiRimLightArray[u_xlati9].xyz;
#endif
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat5.xyz);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_29 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati10];
    u_xlat16_33 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati10]);
    u_xlat13 = (-u_xlat16_29) + u_xlat16_33;
    u_xlat22.x = (-u_xlat16_29) + u_xlat4.x;
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22.x;
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
    u_xlat22.x = u_xlat13 * -2.0 + 3.0;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22.x;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati10].xyz * _SekaiShadowRimLightColorArray[u_xlati10].www + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat13) * u_xlat5.xyz + u_xlat1.xzw;
#else
    u_xlat16_26 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati9];
    u_xlat16_30 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati9]);
    u_xlat12 = (-u_xlat16_26) + u_xlat16_30;
    u_xlat20 = (-u_xlat16_26) + u_xlat4.x;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat20 = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati9].xyz * _SekaiShadowRimLightColorArray[u_xlati9].www + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat12) * u_xlat5.xyz + u_xlat1.xzw;
#endif
#endif
#else
#if defined(_LAMBERT)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati28].xyz, _SekaiRimLightArray[u_xlati28].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat5.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati28].xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati10].xyz, _SekaiRimLightArray[u_xlati10].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat5.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati10].xyz;
#else
    u_xlat28 = dot(_SekaiRimLightArray[u_xlati9].xyz, _SekaiRimLightArray[u_xlati9].xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = vec3(u_xlat28) * _SekaiRimLightArray[u_xlati9].xyz;
#endif
#endif
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat5.xyz);
#if defined(_LAMBERT)
    u_xlat16_29 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati28];
    u_xlat16_34 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati28]);
    u_xlat13 = (-u_xlat16_29) + u_xlat16_34;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat22.x = (-u_xlat16_29) + u_xlat4.x;
#else
    u_xlat22 = (-u_xlat16_29) + u_xlat4.x;
#endif
    u_xlat13 = float(1.0) / u_xlat13;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat13 = u_xlat13 * u_xlat22.x;
#else
    u_xlat13 = u_xlat13 * u_xlat22;
#endif
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat22.x = u_xlat13 * -2.0 + 3.0;
#else
    u_xlat22 = u_xlat13 * -2.0 + 3.0;
#endif
    u_xlat13 = u_xlat13 * u_xlat13;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat13 = u_xlat13 * u_xlat22.x;
#else
    u_xlat13 = u_xlat13 * u_xlat22;
#endif
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati28].xyz * _SekaiShadowRimLightColorArray[u_xlati28].www + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat5.xyz + u_xlat1.xyz;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_29 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati10];
    u_xlat16_33 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati10]);
    u_xlat13 = (-u_xlat16_29) + u_xlat16_33;
    u_xlat22.x = (-u_xlat16_29) + u_xlat4.x;
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22.x;
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
    u_xlat22.x = u_xlat13 * -2.0 + 3.0;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22.x;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati10].xyz * _SekaiShadowRimLightColorArray[u_xlati10].www + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat13) * u_xlat5.xyz + u_xlat1.xzw;
#else
    u_xlat16_26 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati9];
    u_xlat16_30 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati9]);
    u_xlat12 = (-u_xlat16_26) + u_xlat16_30;
    u_xlat20 = (-u_xlat16_26) + u_xlat4.x;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat20 = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati9].xyz * _SekaiShadowRimLightColorArray[u_xlati9].www + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat12) * u_xlat5.xyz + u_xlat1.xzw;
#endif
#endif
#endif
#endif
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlat3.x = (-u_xlat3.x) + 1.0;
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat16_28 = 10.0 + (-_SekaiRimLightFactor[u_xlati29].x);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_28 = 10.0 + (-_SekaiRimLightFactor[u_xlati11].x);
#else
    u_xlat16_25 = 10.0 + (-_SekaiRimLightFactor[u_xlati10].x);
#endif
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_29 = 10.0 + (-_SekaiRimLightFactor[u_xlati28].x);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_29 = 10.0 + (-_SekaiRimLightFactor[u_xlati10].x);
#else
    u_xlat16_26 = 10.0 + (-_SekaiRimLightFactor[u_xlati9].x);
#endif
#endif
#endif
    u_xlat3.x = log2(u_xlat3.x);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat16_28 * u_xlat3.x;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.x = u_xlat16_28 * u_xlat3.x;
#else
    u_xlat3.x = u_xlat16_25 * u_xlat3.x;
#endif
#endif
#else
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat16_29 * u_xlat3.x;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.x = u_xlat16_29 * u_xlat3.x;
#else
    u_xlat3.x = u_xlat16_26 * u_xlat3.x;
#endif
#endif
#endif
    u_xlat3.x = exp2(u_xlat3.x);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat21 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati29].w * u_xlat21 + u_xlat3.x;
    u_xlat21 = (-u_xlat4.x) + 0.0500000007;
    u_xlati4 = int((0.0<u_xlat21) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = int((u_xlat21<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = (-u_xlati4) + u_xlati21;
    u_xlat21 = float(u_xlati21);
    u_xlat21 = u_xlat3.x * u_xlat21 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati29].w * u_xlat21 + u_xlat3.x;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat21 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati11].w * u_xlat21 + u_xlat3.x;
    u_xlat21 = (-u_xlat4.x) + 0.0500000007;
    u_xlati4 = int((0.0<u_xlat21) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = int((u_xlat21<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = (-u_xlati4) + u_xlati21;
    u_xlat21 = float(u_xlati21);
    u_xlat21 = u_xlat3.x * u_xlat21 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati11].w * u_xlat21 + u_xlat3.x;
#else
    u_xlat19 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati10].w * u_xlat19 + u_xlat3.x;
    u_xlat19 = (-u_xlat4.x) + 0.0500000007;
    u_xlati4 = int((0.0<u_xlat19) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = int((u_xlat19<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = (-u_xlati4) + u_xlati19;
    u_xlat19 = float(u_xlati19);
    u_xlat19 = u_xlat3.x * u_xlat19 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati10].w * u_xlat19 + u_xlat3.x;
#endif
#endif
#else
#if defined(_LAMBERT)
    u_xlat21 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati28].w * u_xlat21 + u_xlat3.x;
    u_xlat21 = (-u_xlat4.x) + 0.0500000007;
    u_xlati4 = int((0.0<u_xlat21) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = int((u_xlat21<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = (-u_xlati4) + u_xlati21;
    u_xlat21 = float(u_xlati21);
    u_xlat21 = u_xlat3.x * u_xlat21 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati28].w * u_xlat21 + u_xlat3.x;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat21 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati10].w * u_xlat21 + u_xlat3.x;
    u_xlat21 = (-u_xlat4.x) + 0.0500000007;
    u_xlati4 = int((0.0<u_xlat21) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = int((u_xlat21<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = (-u_xlati4) + u_xlati21;
    u_xlat21 = float(u_xlati21);
    u_xlat21 = u_xlat3.x * u_xlat21 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati10].w * u_xlat21 + u_xlat3.x;
#else
    u_xlat19 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati9].w * u_xlat19 + u_xlat3.x;
    u_xlat19 = (-u_xlat4.x) + 0.0500000007;
    u_xlati4 = int((0.0<u_xlat19) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = int((u_xlat19<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = (-u_xlati4) + u_xlati19;
    u_xlat19 = float(u_xlati19);
    u_xlat19 = u_xlat3.x * u_xlat19 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati9].w * u_xlat19 + u_xlat3.x;
#endif
#endif
#endif
    u_xlat3.x = u_xlat3.x + (-_RimThreshold);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat21 = float(1.0) / _SekaiRimLightFactor[u_xlati29].z;
    u_xlat3.x = u_xlat21 * u_xlat3.x;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat21 = float(1.0) / _SekaiRimLightFactor[u_xlati11].z;
    u_xlat3.x = u_xlat21 * u_xlat3.x;
#else
    u_xlat19 = float(1.0) / _SekaiRimLightFactor[u_xlati10].z;
    u_xlat3.x = u_xlat19 * u_xlat3.x;
#endif
#endif
#else
#if defined(_LAMBERT)
    u_xlat21 = float(1.0) / _SekaiRimLightFactor[u_xlati28].z;
    u_xlat3.x = u_xlat21 * u_xlat3.x;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat21 = float(1.0) / _SekaiRimLightFactor[u_xlati10].z;
    u_xlat3.x = u_xlat21 * u_xlat3.x;
#else
    u_xlat19 = float(1.0) / _SekaiRimLightFactor[u_xlati9].z;
    u_xlat3.x = u_xlat19 * u_xlat3.x;
#endif
#endif
#endif
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#if defined(_LAMBERT)
    u_xlat21 = u_xlat3.x * -2.0 + 3.0;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat21 = u_xlat3.x * -2.0 + 3.0;
#else
    u_xlat19 = u_xlat3.x * -2.0 + 3.0;
#endif
#endif
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat3.x * u_xlat21;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat2.xyz * vs_COLOR0.yyy;
    u_xlat16_5.xyz = u_xlat2.xyz * vs_COLOR0.yyy + u_xlat16_5.xyz;
    u_xlat2.xyz = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.x = u_xlat3.x * u_xlat21;
#else
    u_xlat3.x = u_xlat3.x * u_xlat19;
#endif
    u_xlat2.xzw = u_xlat2.xzw * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat2.xzw * vs_COLOR0.yyy;
    u_xlat16_6.xyz = u_xlat2.xzw * vs_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat2.xzw = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat2.xzw, u_xlat2.xzw);
#endif
#else
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat3.x * u_xlat21;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat2.xyz * vs_COLOR0.yyy;
    u_xlat16_7.xyz = u_xlat2.xyz * vs_COLOR0.yyy + u_xlat16_7.xyz;
    u_xlat2.xyz = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.x = u_xlat3.x * u_xlat21;
#else
    u_xlat3.x = u_xlat3.x * u_xlat19;
#endif
    u_xlat2.xzw = u_xlat2.xzw * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat2.xzw * vs_COLOR0.yyy;
    u_xlat16_6.xyz = u_xlat2.xzw * vs_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat2.xzw = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat2.xzw, u_xlat2.xzw);
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat3.x * u_xlat21;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat16_5.xyz = u_xlat1.xyz * vs_COLOR0.yyy + u_xlat16_5.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.x = u_xlat3.x * u_xlat21;
#else
    u_xlat3.x = u_xlat3.x * u_xlat19;
#endif
    u_xlat1.xzw = u_xlat1.xzw * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat1.xzw * vs_COLOR0.yyy;
    u_xlat16_6.xyz = u_xlat1.xzw * vs_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat1.xzw = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat1.xzw, u_xlat1.xzw);
#endif
#else
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat3.x * u_xlat21;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat16_7.xyz = u_xlat1.xyz * vs_COLOR0.yyy + u_xlat16_7.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.x = u_xlat3.x * u_xlat21;
#else
    u_xlat3.x = u_xlat3.x * u_xlat19;
#endif
    u_xlat1.xzw = u_xlat1.xzw * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat1.xzw * vs_COLOR0.yyy;
    u_xlat16_6.xyz = u_xlat1.xzw * vs_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat1.xzw = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat1.xzw, u_xlat1.xzw);
#endif
#endif
#endif
    u_xlat3.x = inversesqrt(u_xlat3.x);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xxx;
    u_xlat2.x = dot(u_xlat2.xyz, vs_NORMAL0.xyz);
#else
    u_xlat2.xzw = u_xlat2.xzw * u_xlat3.xxx;
    u_xlat2.x = dot(u_xlat2.xzw, vs_NORMAL0.xyz);
#endif
    u_xlat2.x = max(u_xlat2.x, 0.0);
#if defined(_LAMBERT)
    u_xlat11 = 10.0 / _SpecularPower;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat20 = 10.0 / _SpecularPower;
#else
    u_xlat18 = 10.0 / _SpecularPower;
#endif
#endif
    u_xlat2.x = log2(u_xlat2.x);
#if defined(_LAMBERT)
    u_xlat2.x = u_xlat2.x * u_xlat11;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat2.x = u_xlat2.x * u_xlat20;
#else
    u_xlat2.x = u_xlat2.x * u_xlat18;
#endif
#endif
    u_xlat2.x = exp2(u_xlat2.x);
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xxx;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat16_3.www + u_xlat16_5.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat2.xxyz, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#else
    u_xlat2.xzw = u_xlat16_1.xyz * u_xlat2.xxx;
    u_xlat2.xzw = u_xlat2.xzw * u_xlat16_3.www + u_xlat16_6.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat2.xxzw, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#endif
#else
#if defined(_LAMBERT)
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xxx;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat16_3.www + u_xlat16_7.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat2.xxyz, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#else
    u_xlat2.xzw = u_xlat16_1.xyz * u_xlat2.xxx;
    u_xlat2.xzw = u_xlat2.xzw * u_xlat16_3.www + u_xlat16_6.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat2.xxzw, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#endif
#endif
    u_xlat16_1.x = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_1.y = (u_xlatb3.z) ? float(1.0) : float(0.0);
    u_xlat16_1.z = (u_xlatb3.w) ? float(1.0) : float(0.0);
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_5.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xzw = u_xlat16_5.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati29].xyz;
    u_xlat16_8.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati29].xyz);
    u_xlat2.xyz = (-u_xlat16_8.xyz) * u_xlat2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati29].xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + u_xlat3.xzw;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati29]);
    u_xlat3.xzw = u_xlat2.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat2.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#else
    u_xlat16_6.xyz = u_xlat2.xzw + u_xlat2.xzw;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati11].xyz;
#else
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz;
#endif
    u_xlat16_7.xyz = (-u_xlat2.xzw) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_7.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat2.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati11].xyz);
#else
    u_xlat2.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati10].xyz);
#endif
    u_xlat2.xzw = (-u_xlat16_7.xyz) * u_xlat2.xzw + vec3(1.0, 1.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati11].xyz + u_xlat2.xzw;
#else
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz + u_xlat2.xzw;
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + u_xlat3.xzw;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat2.xzw = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati11]);
#else
    u_xlat2.xzw = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati10]);
#endif
    u_xlat3.xzw = u_xlat2.xzw * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat2.xzw) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_7.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xzw = u_xlat16_7.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati29].xyz;
    u_xlat16_8.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati29].xyz);
    u_xlat2.xyz = (-u_xlat16_8.xyz) * u_xlat2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati29].xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat3.xzw;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati29]);
    u_xlat3.xzw = u_xlat2.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat2.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#else
    u_xlat16_6.xyz = u_xlat2.xzw + u_xlat2.xzw;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati11].xyz;
#else
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz;
#endif
    u_xlat16_7.xyz = (-u_xlat2.xzw) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_7.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat2.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati11].xyz);
#else
    u_xlat2.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati10].xyz);
#endif
    u_xlat2.xzw = (-u_xlat16_7.xyz) * u_xlat2.xzw + vec3(1.0, 1.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati11].xyz + u_xlat2.xzw;
#else
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz + u_xlat2.xzw;
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + u_xlat3.xzw;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat2.xzw = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati11]);
#else
    u_xlat2.xzw = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati10]);
#endif
    u_xlat3.xzw = u_xlat2.xzw * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat2.xzw) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#endif
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_5.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
#else
    u_xlat16_6.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_6.xyz + u_xlat16_1.xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_7.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_7.xyz + u_xlat16_1.xyz;
#else
    u_xlat16_6.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_6.xyz + u_xlat16_1.xyz;
#endif
#endif
    u_xlatb2 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb2){
#if defined(_LAMBERT)
        u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat2.xy = u_xlat2.xy * u_xlat2.xy;
        u_xlat2.x = u_xlat2.y + u_xlat2.x;
        u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
        u_xlat11 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat2.xzw = (-vs_TEXCOORD5.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat2.xz = u_xlat2.xz * u_xlat2.xz;
        u_xlat2.x = u_xlat2.z + u_xlat2.x;
        u_xlat2.x = u_xlat2.w * u_xlat2.w + u_xlat2.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat20 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat18 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
#endif
        u_xlat2.x = u_xlat2.x + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(_LAMBERT)
        u_xlat11 = float(1.0) / u_xlat11;
        u_xlat2.x = u_xlat11 * u_xlat2.x;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat20 = float(1.0) / u_xlat20;
        u_xlat2.x = u_xlat20 * u_xlat2.x;
#else
        u_xlat18 = float(1.0) / u_xlat18;
        u_xlat2.x = u_xlat18 * u_xlat2.x;
#endif
#endif
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#if defined(_LAMBERT)
        u_xlat11 = u_xlat2.x * -2.0 + 3.0;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat20 = u_xlat2.x * -2.0 + 3.0;
#else
        u_xlat18 = u_xlat2.x * -2.0 + 3.0;
#endif
#endif
        u_xlat2.x = u_xlat2.x * u_xlat2.x;
#if defined(_LAMBERT)
        u_xlat20 = u_xlat2.x * u_xlat11;
        u_xlat2.x = (-u_xlat11) * u_xlat2.x + 1.0;
        u_xlat3.xzw = u_xlat16_1.xyz * vec3(u_xlat20);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat29 = u_xlat2.x * u_xlat20;
        u_xlat2.x = (-u_xlat20) * u_xlat2.x + 1.0;
        u_xlat3.xzw = u_xlat16_1.xyz * vec3(u_xlat29);
#else
        u_xlat26 = u_xlat2.x * u_xlat18;
        u_xlat2.x = (-u_xlat18) * u_xlat2.x + 1.0;
        u_xlat3.xzw = u_xlat16_1.xyz * vec3(u_xlat26);
#endif
#endif
#else
#if defined(_LAMBERT)
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat1.x = dot(u_xlat1.xyz, vs_NORMAL0.xyz);
#else
    u_xlat1.xzw = u_xlat1.xzw * u_xlat3.xxx;
    u_xlat1.x = dot(u_xlat1.xzw, vs_NORMAL0.xyz);
#endif
    u_xlat1.x = max(u_xlat1.x, 0.0);
#if defined(_LAMBERT)
    u_xlat10 = 10.0 / _SpecularPower;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat19 = 10.0 / _SpecularPower;
#else
    u_xlat17 = 10.0 / _SpecularPower;
#endif
#endif
    u_xlat1.x = log2(u_xlat1.x);
#if defined(_LAMBERT)
    u_xlat1.x = u_xlat1.x * u_xlat10;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat1.x = u_xlat1.x * u_xlat19;
#else
    u_xlat1.x = u_xlat1.x * u_xlat17;
#endif
#endif
    u_xlat1.x = exp2(u_xlat1.x);
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat1.xyz = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_3.www + u_xlat16_5.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat1.xxyz, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#else
    u_xlat1.xzw = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat1.xzw = u_xlat1.xzw * u_xlat16_3.www + u_xlat16_6.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat1.xxzw, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#endif
#else
#if defined(_LAMBERT)
    u_xlat1.xyz = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_3.www + u_xlat16_7.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat1.xxyz, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#else
    u_xlat1.xzw = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat1.xzw = u_xlat1.xzw * u_xlat16_3.www + u_xlat16_6.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat1.xxzw, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#endif
#endif
    u_xlat16_2.x = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb3.z) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb3.w) ? float(1.0) : float(0.0);
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_5.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat3.xzw = u_xlat16_5.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati28].xyz;
    u_xlat16_8.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_8.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati28].xyz);
    u_xlat1.xyz = (-u_xlat16_8.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati28].xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + u_xlat3.xzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati28]);
    u_xlat3.xzw = u_xlat1.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat1.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#else
    u_xlat16_6.xyz = u_xlat1.xzw + u_xlat1.xzw;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz;
#else
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati9].xyz;
#endif
    u_xlat16_7.xyz = (-u_xlat1.xzw) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_7.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat1.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati10].xyz);
#else
    u_xlat1.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati9].xyz);
#endif
    u_xlat1.xzw = (-u_xlat16_7.xyz) * u_xlat1.xzw + vec3(1.0, 1.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz + u_xlat1.xzw;
#else
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati9].xyz + u_xlat1.xzw;
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz + u_xlat3.xzw;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat1.xzw = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati10]);
#else
    u_xlat1.xzw = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati9]);
#endif
    u_xlat3.xzw = u_xlat1.xzw * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat1.xzw) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_7.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat3.xzw = u_xlat16_7.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati28].xyz;
    u_xlat16_8.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_8.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati28].xyz);
    u_xlat1.xyz = (-u_xlat16_8.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati28].xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz + u_xlat3.xzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati28]);
    u_xlat3.xzw = u_xlat1.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat1.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#else
    u_xlat16_6.xyz = u_xlat1.xzw + u_xlat1.xzw;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz;
#else
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati9].xyz;
#endif
    u_xlat16_7.xyz = (-u_xlat1.xzw) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_7.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat1.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati10].xyz);
#else
    u_xlat1.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati9].xyz);
#endif
    u_xlat1.xzw = (-u_xlat16_7.xyz) * u_xlat1.xzw + vec3(1.0, 1.0, 1.0);
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz + u_xlat1.xzw;
#else
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati9].xyz + u_xlat1.xzw;
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz + u_xlat3.xzw;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat1.xzw = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati10]);
#else
    u_xlat1.xzw = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati9]);
#endif
    u_xlat3.xzw = u_xlat1.xzw * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat1.xzw) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#endif
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_5.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_5.xyz + u_xlat16_2.xyz;
#else
    u_xlat16_6.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_6.xyz + u_xlat16_2.xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_7.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_7.xyz + u_xlat16_2.xyz;
#else
    u_xlat16_6.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_6.xyz + u_xlat16_2.xyz;
#endif
#endif
    u_xlatb1 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb1){
#if defined(_LAMBERT)
        u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xy = u_xlat1.xy * u_xlat1.xy;
        u_xlat1.x = u_xlat1.y + u_xlat1.x;
        u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
        u_xlat10 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat1.xzw = (-vs_TEXCOORD5.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xz = u_xlat1.xz * u_xlat1.xz;
        u_xlat1.x = u_xlat1.z + u_xlat1.x;
        u_xlat1.x = u_xlat1.w * u_xlat1.w + u_xlat1.x;
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat19 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat17 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
#endif
        u_xlat1.x = u_xlat1.x + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(_LAMBERT)
        u_xlat10 = float(1.0) / u_xlat10;
        u_xlat1.x = u_xlat10 * u_xlat1.x;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat19 = float(1.0) / u_xlat19;
        u_xlat1.x = u_xlat19 * u_xlat1.x;
#else
        u_xlat17 = float(1.0) / u_xlat17;
        u_xlat1.x = u_xlat17 * u_xlat1.x;
#endif
#endif
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#if defined(_LAMBERT)
        u_xlat10 = u_xlat1.x * -2.0 + 3.0;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat19 = u_xlat1.x * -2.0 + 3.0;
#else
        u_xlat17 = u_xlat1.x * -2.0 + 3.0;
#endif
#endif
        u_xlat1.x = u_xlat1.x * u_xlat1.x;
#if defined(_LAMBERT)
        u_xlat19 = u_xlat1.x * u_xlat10;
        u_xlat1.x = (-u_xlat10) * u_xlat1.x + 1.0;
        u_xlat3.xzw = u_xlat16_2.xyz * vec3(u_xlat19);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
        u_xlat28 = u_xlat1.x * u_xlat19;
        u_xlat1.x = (-u_xlat19) * u_xlat1.x + 1.0;
        u_xlat3.xzw = u_xlat16_2.xyz * vec3(u_xlat28);
#else
        u_xlat25 = u_xlat1.x * u_xlat17;
        u_xlat1.x = (-u_xlat17) * u_xlat1.x + 1.0;
        u_xlat3.xzw = u_xlat16_2.xyz * vec3(u_xlat25);
#endif
#endif
#endif
        u_xlat3.xzw = u_xlat3.xzw * _SekaiGlobalSpotLightColor.xyz;
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
        u_xlat2.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat3.xzw;
#else
        u_xlat2.xzw = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat3.xzw;
#endif
#else
#if defined(_LAMBERT)
        u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat3.xzw;
#else
        u_xlat1.xzw = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat3.xzw;
#endif
#endif
    } else {
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
        u_xlat2.xyz = u_xlat16_1.xyz;
#else
        u_xlat2.xzw = u_xlat16_1.xyz;
#endif
#else
#if defined(_LAMBERT)
        u_xlat1.xyz = u_xlat16_2.xyz;
#else
        u_xlat1.xzw = u_xlat16_2.xyz;
#endif
#endif
    }
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat3.xzw = u_xlat4.xyz * _SekaiRimLightFactor[u_xlati29].yyy;
    u_xlat3.xyz = u_xlat2.xyz * u_xlat16_3.yyy + u_xlat3.xzw;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.xzw = u_xlat4.xyz * _SekaiRimLightFactor[u_xlati11].yyy;
#else
    u_xlat3.xzw = u_xlat4.xyz * _SekaiRimLightFactor[u_xlati10].yyy;
#endif
    u_xlat3.xyz = u_xlat2.xzw * u_xlat16_3.yyy + u_xlat3.xzw;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD6) + 1.0;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat29 = u_xlat16_1.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat2.xyz) + _SekaiFogColor.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat2.xyz = vec3(u_xlat29) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.xy = vs_TEXCOORD5.xz + (-_FlipBookCenterPosition.xz);
    u_xlat22.xy = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat22.xy = u_xlat4.xy * vec2(_FlipBookScale_Character) + (-u_xlat22.xy);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat29 = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat30 = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat29 = u_xlat29 / u_xlat30;
    u_xlatb6 = u_xlat29>=(-u_xlat29);
    u_xlat29 = fract(abs(u_xlat29));
    u_xlat29 = (u_xlatb6) ? u_xlat29 : (-u_xlat29);
    u_xlat29 = u_xlat30 * u_xlat29;
    u_xlat29 = floor(u_xlat29);
    u_xlat6.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat30 = u_xlat29 * u_xlat6.x;
    u_xlat30 = floor(u_xlat30);
    u_xlat7.x = (-_FlipBookFrameCountX) * u_xlat30 + u_xlat29;
    u_xlat29 = u_xlat30 + 1.0;
    u_xlat7.y = (-u_xlat29) + _FlipBookFrameCountY;
    u_xlat22.xy = u_xlat22.xy + u_xlat7.xy;
    u_xlat22.xy = u_xlat6.xy * u_xlat22.xy;
    u_xlat29 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat29 = sqrt(u_xlat29);
    u_xlat16_1 = texture(_FlipBookTex, u_xlat22.xy);
    u_xlat16_5.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vs_TEXCOORD8);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _FlipBookColor_Character.www;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_FlipBookOpacity);
    u_xlat29 = u_xlat29 + (-_FlipBookFadeRadius);
    u_xlat29 = u_xlat29 + (-_FlipBookFadeFallOff);
    u_xlat30 = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat29 = u_xlat29 * u_xlat30;
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
    u_xlat30 = u_xlat29 * -2.0 + 3.0;
    u_xlat29 = u_xlat29 * u_xlat29;
    u_xlat29 = u_xlat29 * u_xlat30;
    u_xlat16_0.xyz = u_xlat16_5.xyz * vec3(u_xlat29) + u_xlat2.xyz;
#else
    u_xlat16_0.xyz = vec3(u_xlat29) * u_xlat4.xyz + u_xlat2.xyz;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat11 = u_xlat16_1.x * _SekaiFogColor.w;
#else
    u_xlat10 = u_xlat16_1.x * _SekaiFogColor.w;
#endif
    u_xlat4.xyz = (-u_xlat2.xzw) + _SekaiFogColor.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat2.xyz = vec3(u_xlat11) * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat4.xy = vs_TEXCOORD5.xz + (-_FlipBookCenterPosition.xz);
    u_xlat22.xy = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat22.xy = u_xlat4.xy * vec2(_FlipBookScale_Character) + (-u_xlat22.xy);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat29 = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat30 = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat29 = u_xlat29 / u_xlat30;
    u_xlatb5 = u_xlat29>=(-u_xlat29);
    u_xlat29 = fract(abs(u_xlat29));
    u_xlat29 = (u_xlatb5) ? u_xlat29 : (-u_xlat29);
    u_xlat29 = u_xlat30 * u_xlat29;
    u_xlat29 = floor(u_xlat29);
    u_xlat5.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat30 = u_xlat29 * u_xlat5.x;
    u_xlat30 = floor(u_xlat30);
    u_xlat8.x = (-_FlipBookFrameCountX) * u_xlat30 + u_xlat29;
    u_xlat29 = u_xlat30 + 1.0;
    u_xlat8.y = (-u_xlat29) + _FlipBookFrameCountY;
    u_xlat22.xy = u_xlat22.xy + u_xlat8.xy;
    u_xlat22.xy = u_xlat5.xy * u_xlat22.xy;
    u_xlat29 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat29 = sqrt(u_xlat29);
    u_xlat16_1 = texture(_FlipBookTex, u_xlat22.xy);
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vs_TEXCOORD8);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _FlipBookColor_Character.www;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_FlipBookOpacity);
    u_xlat29 = u_xlat29 + (-_FlipBookFadeRadius);
    u_xlat29 = u_xlat29 + (-_FlipBookFadeFallOff);
    u_xlat30 = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat29 = u_xlat29 * u_xlat30;
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
    u_xlat30 = u_xlat29 * -2.0 + 3.0;
    u_xlat29 = u_xlat29 * u_xlat29;
    u_xlat29 = u_xlat29 * u_xlat30;
    u_xlat16_0.xyz = u_xlat16_6.xyz * vec3(u_xlat29) + u_xlat2.xyz;
#else
    u_xlat16_0.xyz = vec3(u_xlat10) * u_xlat4.xyz + u_xlat2.xzw;
#endif
#endif
#else
#if defined(_LAMBERT)
    u_xlat29 = u_xlat16_1.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat2.xyz) + _SekaiFogColor.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat2.xyz = vec3(u_xlat29) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.xy = vs_TEXCOORD5.xz + (-_FlipBookCenterPosition.xz);
    u_xlat22.xy = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat22.xy = u_xlat4.xy * vec2(_FlipBookScale_Character) + (-u_xlat22.xy);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat29 = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat30 = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat29 = u_xlat29 / u_xlat30;
    u_xlatb5 = u_xlat29>=(-u_xlat29);
    u_xlat29 = fract(abs(u_xlat29));
    u_xlat29 = (u_xlatb5) ? u_xlat29 : (-u_xlat29);
    u_xlat29 = u_xlat30 * u_xlat29;
    u_xlat29 = floor(u_xlat29);
    u_xlat5.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat30 = u_xlat29 * u_xlat5.x;
    u_xlat30 = floor(u_xlat30);
    u_xlat6.x = (-_FlipBookFrameCountX) * u_xlat30 + u_xlat29;
    u_xlat29 = u_xlat30 + 1.0;
    u_xlat6.y = (-u_xlat29) + _FlipBookFrameCountY;
    u_xlat22.xy = u_xlat22.xy + u_xlat6.xy;
    u_xlat22.xy = u_xlat5.xy * u_xlat22.xy;
    u_xlat29 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat29 = sqrt(u_xlat29);
    u_xlat16_1 = texture(_FlipBookTex, u_xlat22.xy);
    u_xlat16_7.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vs_TEXCOORD8);
    u_xlat16_7.xyz = u_xlat16_7.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _FlipBookColor_Character.www;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_FlipBookOpacity);
    u_xlat29 = u_xlat29 + (-_FlipBookFadeRadius);
    u_xlat29 = u_xlat29 + (-_FlipBookFadeFallOff);
    u_xlat30 = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat29 = u_xlat29 * u_xlat30;
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
    u_xlat30 = u_xlat29 * -2.0 + 3.0;
    u_xlat29 = u_xlat29 * u_xlat29;
    u_xlat29 = u_xlat29 * u_xlat30;
    u_xlat16_0.xyz = u_xlat16_7.xyz * vec3(u_xlat29) + u_xlat2.xyz;
#else
    u_xlat16_0.xyz = vec3(u_xlat29) * u_xlat4.xyz + u_xlat2.xyz;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat11 = u_xlat16_1.x * _SekaiFogColor.w;
#else
    u_xlat10 = u_xlat16_1.x * _SekaiFogColor.w;
#endif
    u_xlat4.xyz = (-u_xlat2.xzw) + _SekaiFogColor.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat2.xyz = vec3(u_xlat11) * u_xlat4.xyz + u_xlat2.xzw;
    u_xlat4.xy = vs_TEXCOORD5.xz + (-_FlipBookCenterPosition.xz);
    u_xlat22.xy = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat22.xy = u_xlat4.xy * vec2(_FlipBookScale_Character) + (-u_xlat22.xy);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat29 = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat30 = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat29 = u_xlat29 / u_xlat30;
    u_xlatb5 = u_xlat29>=(-u_xlat29);
    u_xlat29 = fract(abs(u_xlat29));
    u_xlat29 = (u_xlatb5) ? u_xlat29 : (-u_xlat29);
    u_xlat29 = u_xlat30 * u_xlat29;
    u_xlat29 = floor(u_xlat29);
    u_xlat5.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat30 = u_xlat29 * u_xlat5.x;
    u_xlat30 = floor(u_xlat30);
    u_xlat8.x = (-_FlipBookFrameCountX) * u_xlat30 + u_xlat29;
    u_xlat29 = u_xlat30 + 1.0;
    u_xlat8.y = (-u_xlat29) + _FlipBookFrameCountY;
    u_xlat22.xy = u_xlat22.xy + u_xlat8.xy;
    u_xlat22.xy = u_xlat5.xy * u_xlat22.xy;
    u_xlat29 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat29 = sqrt(u_xlat29);
    u_xlat16_1 = texture(_FlipBookTex, u_xlat22.xy);
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vs_TEXCOORD8);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _FlipBookColor_Character.www;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_FlipBookOpacity);
    u_xlat29 = u_xlat29 + (-_FlipBookFadeRadius);
    u_xlat29 = u_xlat29 + (-_FlipBookFadeFallOff);
    u_xlat30 = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat29 = u_xlat29 * u_xlat30;
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
    u_xlat30 = u_xlat29 * -2.0 + 3.0;
    u_xlat29 = u_xlat29 * u_xlat29;
    u_xlat29 = u_xlat29 * u_xlat30;
    u_xlat16_0.xyz = u_xlat16_6.xyz * vec3(u_xlat29) + u_xlat2.xyz;
#else
    u_xlat16_0.xyz = vec3(u_xlat10) * u_xlat4.xyz + u_xlat2.xzw;
#endif
#endif
#endif
    u_xlat2.x = vs_TEXCOORD7 / vs_TEXCOORD0.w;
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
#if defined(_LAMBERT)
    u_xlat11 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat11 = u_xlat11 + -1.0;
    u_xlat11 = u_xlat11 * _ProjectionParams.w;
    u_xlat2.x = u_xlat11 * u_xlat2.x + _ProjectionParams.w;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat11 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat11 = u_xlat11 + -1.0;
    u_xlat11 = u_xlat11 * _ProjectionParams.w;
    u_xlat2.x = u_xlat11 * u_xlat2.x + _ProjectionParams.w;
#else
    u_xlat10 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat10 = u_xlat10 + -1.0;
    u_xlat10 = u_xlat10 * _ProjectionParams.w;
    u_xlat2.x = u_xlat10 * u_xlat2.x + _ProjectionParams.w;
#endif
#endif
    u_xlat2.x = (-_CoCParams.x) * u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * _CoCParams.y;
#if defined(_LAMBERT)
    u_xlat11 = u_xlat2.x;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat11 = u_xlat2.x;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#else
    u_xlat10 = u_xlat2.x;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
#endif
    u_xlat2.x = max(u_xlat2.x, -1.0);
    u_xlat2.x = min(u_xlat2.x, 0.0);
#if defined(_LAMBERT)
    u_xlat2.x = u_xlat2.x + u_xlat11;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat2.x = u_xlat2.x + u_xlat11;
#else
    u_xlat2.x = u_xlat2.x + u_xlat10;
#endif
#endif
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
#else
#if defined(_LAMBERT)
    u_xlat3.xzw = u_xlat4.xyz * _SekaiRimLightFactor[u_xlati28].yyy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat16_3.yyy + u_xlat3.xzw;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat3.xzw = u_xlat4.xyz * _SekaiRimLightFactor[u_xlati10].yyy;
#else
    u_xlat3.xzw = u_xlat4.xyz * _SekaiRimLightFactor[u_xlati9].yyy;
#endif
    u_xlat3.xyz = u_xlat1.xzw * u_xlat16_3.yyy + u_xlat3.xzw;
#endif
    u_xlat16_2.x = (-vs_TEXCOORD6) + 1.0;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat28 = u_xlat16_2.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat1.xyz) + _SekaiFogColor.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat4.xy = vs_TEXCOORD5.xz + (-_FlipBookCenterPosition.xz);
    u_xlat22.xy = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat22.xy = u_xlat4.xy * vec2(_FlipBookScale_Character) + (-u_xlat22.xy);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat28 = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat30 = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat28 = u_xlat28 / u_xlat30;
    u_xlatb6 = u_xlat28>=(-u_xlat28);
    u_xlat28 = fract(abs(u_xlat28));
    u_xlat28 = (u_xlatb6) ? u_xlat28 : (-u_xlat28);
    u_xlat28 = u_xlat30 * u_xlat28;
    u_xlat28 = floor(u_xlat28);
    u_xlat6.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat30 = u_xlat28 * u_xlat6.x;
    u_xlat30 = floor(u_xlat30);
    u_xlat7.x = (-_FlipBookFrameCountX) * u_xlat30 + u_xlat28;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat7.y = (-u_xlat28) + _FlipBookFrameCountY;
    u_xlat22.xy = u_xlat22.xy + u_xlat7.xy;
    u_xlat22.xy = u_xlat6.xy * u_xlat22.xy;
    u_xlat28 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat28 = sqrt(u_xlat28);
    u_xlat16_2 = texture(_FlipBookTex, u_xlat22.xy);
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vs_TEXCOORD8);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _FlipBookColor_Character.www;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_FlipBookOpacity);
    u_xlat28 = u_xlat28 + (-_FlipBookFadeRadius);
    u_xlat28 = u_xlat28 + (-_FlipBookFadeFallOff);
    u_xlat30 = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat28 = u_xlat28 * u_xlat30;
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat30 = u_xlat28 * -2.0 + 3.0;
    u_xlat28 = u_xlat28 * u_xlat28;
    u_xlat28 = u_xlat28 * u_xlat30;
    u_xlat16_0.xyz = u_xlat16_5.xyz * vec3(u_xlat28) + u_xlat1.xyz;
#else
    u_xlat16_0.xyz = vec3(u_xlat28) * u_xlat4.xyz + u_xlat1.xyz;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat10 = u_xlat16_2.x * _SekaiFogColor.w;
#else
    u_xlat9 = u_xlat16_2.x * _SekaiFogColor.w;
#endif
    u_xlat4.xyz = (-u_xlat1.xzw) + _SekaiFogColor.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat4.xyz + u_xlat1.xzw;
    u_xlat4.xy = vs_TEXCOORD5.xz + (-_FlipBookCenterPosition.xz);
    u_xlat22.xy = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat22.xy = u_xlat4.xy * vec2(_FlipBookScale_Character) + (-u_xlat22.xy);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat28 = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat30 = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat28 = u_xlat28 / u_xlat30;
    u_xlatb5 = u_xlat28>=(-u_xlat28);
    u_xlat28 = fract(abs(u_xlat28));
    u_xlat28 = (u_xlatb5) ? u_xlat28 : (-u_xlat28);
    u_xlat28 = u_xlat30 * u_xlat28;
    u_xlat28 = floor(u_xlat28);
    u_xlat5.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat30 = u_xlat28 * u_xlat5.x;
    u_xlat30 = floor(u_xlat30);
    u_xlat8.x = (-_FlipBookFrameCountX) * u_xlat30 + u_xlat28;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat8.y = (-u_xlat28) + _FlipBookFrameCountY;
    u_xlat22.xy = u_xlat22.xy + u_xlat8.xy;
    u_xlat22.xy = u_xlat5.xy * u_xlat22.xy;
    u_xlat28 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat28 = sqrt(u_xlat28);
    u_xlat16_2 = texture(_FlipBookTex, u_xlat22.xy);
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vs_TEXCOORD8);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _FlipBookColor_Character.www;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_FlipBookOpacity);
    u_xlat28 = u_xlat28 + (-_FlipBookFadeRadius);
    u_xlat28 = u_xlat28 + (-_FlipBookFadeFallOff);
    u_xlat30 = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat28 = u_xlat28 * u_xlat30;
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat30 = u_xlat28 * -2.0 + 3.0;
    u_xlat28 = u_xlat28 * u_xlat28;
    u_xlat28 = u_xlat28 * u_xlat30;
    u_xlat16_0.xyz = u_xlat16_6.xyz * vec3(u_xlat28) + u_xlat1.xyz;
#else
    u_xlat16_0.xyz = vec3(u_xlat9) * u_xlat4.xyz + u_xlat1.xzw;
#endif
#endif
#else
#if defined(_LAMBERT)
    u_xlat28 = u_xlat16_2.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat1.xyz) + _SekaiFogColor.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat4.xy = vs_TEXCOORD5.xz + (-_FlipBookCenterPosition.xz);
    u_xlat22.xy = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat22.xy = u_xlat4.xy * vec2(_FlipBookScale_Character) + (-u_xlat22.xy);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat28 = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat30 = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat28 = u_xlat28 / u_xlat30;
    u_xlatb5 = u_xlat28>=(-u_xlat28);
    u_xlat28 = fract(abs(u_xlat28));
    u_xlat28 = (u_xlatb5) ? u_xlat28 : (-u_xlat28);
    u_xlat28 = u_xlat30 * u_xlat28;
    u_xlat28 = floor(u_xlat28);
    u_xlat5.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat30 = u_xlat28 * u_xlat5.x;
    u_xlat30 = floor(u_xlat30);
    u_xlat6.x = (-_FlipBookFrameCountX) * u_xlat30 + u_xlat28;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat6.y = (-u_xlat28) + _FlipBookFrameCountY;
    u_xlat22.xy = u_xlat22.xy + u_xlat6.xy;
    u_xlat22.xy = u_xlat5.xy * u_xlat22.xy;
    u_xlat28 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat28 = sqrt(u_xlat28);
    u_xlat16_2 = texture(_FlipBookTex, u_xlat22.xy);
    u_xlat16_7.xyz = u_xlat16_2.www * u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vs_TEXCOORD8);
    u_xlat16_7.xyz = u_xlat16_7.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _FlipBookColor_Character.www;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_FlipBookOpacity);
    u_xlat28 = u_xlat28 + (-_FlipBookFadeRadius);
    u_xlat28 = u_xlat28 + (-_FlipBookFadeFallOff);
    u_xlat30 = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat28 = u_xlat28 * u_xlat30;
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat30 = u_xlat28 * -2.0 + 3.0;
    u_xlat28 = u_xlat28 * u_xlat28;
    u_xlat28 = u_xlat28 * u_xlat30;
    u_xlat16_0.xyz = u_xlat16_7.xyz * vec3(u_xlat28) + u_xlat1.xyz;
#else
    u_xlat16_0.xyz = vec3(u_xlat28) * u_xlat4.xyz + u_xlat1.xyz;
#endif
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat10 = u_xlat16_2.x * _SekaiFogColor.w;
#else
    u_xlat9 = u_xlat16_2.x * _SekaiFogColor.w;
#endif
    u_xlat4.xyz = (-u_xlat1.xzw) + _SekaiFogColor.xyz;
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat4.xyz + u_xlat1.xzw;
    u_xlat4.xy = vs_TEXCOORD5.xz + (-_FlipBookCenterPosition.xz);
    u_xlat22.xy = vec2(vec2(_GlobalFlipBookTime, _GlobalFlipBookTime)) * _FlipBookUVScroll_Character.xy;
    u_xlat22.xy = u_xlat4.xy * vec2(_FlipBookScale_Character) + (-u_xlat22.xy);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat28 = _GlobalFlipBookTime * _FlipBookFPS + 9.99999975e-06;
    u_xlat30 = _FlipBookFrameCountY * _FlipBookFrameCountX;
    u_xlat28 = u_xlat28 / u_xlat30;
    u_xlatb5 = u_xlat28>=(-u_xlat28);
    u_xlat28 = fract(abs(u_xlat28));
    u_xlat28 = (u_xlatb5) ? u_xlat28 : (-u_xlat28);
    u_xlat28 = u_xlat30 * u_xlat28;
    u_xlat28 = floor(u_xlat28);
    u_xlat5.xy = vec2(1.0, 1.0) / vec2(_FlipBookFrameCountX, _FlipBookFrameCountY);
    u_xlat30 = u_xlat28 * u_xlat5.x;
    u_xlat30 = floor(u_xlat30);
    u_xlat8.x = (-_FlipBookFrameCountX) * u_xlat30 + u_xlat28;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat8.y = (-u_xlat28) + _FlipBookFrameCountY;
    u_xlat22.xy = u_xlat22.xy + u_xlat8.xy;
    u_xlat22.xy = u_xlat5.xy * u_xlat22.xy;
    u_xlat28 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat28 = sqrt(u_xlat28);
    u_xlat16_2 = texture(_FlipBookTex, u_xlat22.xy);
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vs_TEXCOORD8);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _FlipBookColor_Character.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _FlipBookColor_Character.www;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_FlipBookOpacity);
    u_xlat28 = u_xlat28 + (-_FlipBookFadeRadius);
    u_xlat28 = u_xlat28 + (-_FlipBookFadeFallOff);
    u_xlat30 = float(1.0) / (-_FlipBookFadeFallOff);
    u_xlat28 = u_xlat28 * u_xlat30;
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat30 = u_xlat28 * -2.0 + 3.0;
    u_xlat28 = u_xlat28 * u_xlat28;
    u_xlat28 = u_xlat28 * u_xlat30;
    u_xlat16_0.xyz = u_xlat16_6.xyz * vec3(u_xlat28) + u_xlat1.xyz;
#else
    u_xlat16_0.xyz = vec3(u_xlat9) * u_xlat4.xyz + u_xlat1.xzw;
#endif
#endif
#endif
    u_xlat1.x = vs_TEXCOORD7 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
#if defined(_LAMBERT)
    u_xlat10 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat10 = u_xlat10 + -1.0;
    u_xlat10 = u_xlat10 * _ProjectionParams.w;
    u_xlat1.x = u_xlat10 * u_xlat1.x + _ProjectionParams.w;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat10 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat10 = u_xlat10 + -1.0;
    u_xlat10 = u_xlat10 * _ProjectionParams.w;
    u_xlat1.x = u_xlat10 * u_xlat1.x + _ProjectionParams.w;
#else
    u_xlat9 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9 = u_xlat9 + -1.0;
    u_xlat9 = u_xlat9 * _ProjectionParams.w;
    u_xlat1.x = u_xlat9 * u_xlat1.x + _ProjectionParams.w;
#endif
#endif
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
#if defined(_LAMBERT)
    u_xlat10 = u_xlat1.x;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat10 = u_xlat1.x;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#else
    u_xlat9 = u_xlat1.x;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
#endif
    u_xlat1.x = max(u_xlat1.x, -1.0);
    u_xlat1.x = min(u_xlat1.x, 0.0);
#if defined(_LAMBERT)
    u_xlat1.x = u_xlat1.x + u_xlat10;
#else
#if defined(_USE_OVERLAY_FLIPBOOK)
    u_xlat1.x = u_xlat1.x + u_xlat10;
#else
    u_xlat1.x = u_xlat1.x + u_xlat9;
#endif
#endif
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * 0.5;
#endif
    SV_Target0 = u_xlat16_0;
#if defined(USE_DITHER_ALPHA)
    SV_Target1.x = u_xlat2.x;
#else
    SV_Target1.x = u_xlat1.x;
#endif
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2.xyz = u_xlat3.xyz;
    SV_Target2.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "Monitor"
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="SekaiMonitor" "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
			GLSLPROGRAM
#pragma multi_compile _ USE_DITHER_ALPHA
#pragma multi_compile _ _FACE_SHADOW_RANGE_LIMIT
#pragma multi_compile _ _HAIR_SHADOW
#pragma multi_compile _ _LAMBERT
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
uniform 	vec4 _MonitorObjectPositionArray[10];
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
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_FaceShadowTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineOffset;
	UNITY_UNIFORM float                _SpecularPower;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM mediump float                _HeadNormalBlend;
#else
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HeadNormalBlend;
#endif
	UNITY_UNIFORM mediump float                _EyelashTransparent;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump float                _IsLeftEyeClose;
	UNITY_UNIFORM mediump float                _IsRightEyeClose;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM vec3                _FaceFront;
	UNITY_UNIFORM int                _CharacterId;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM vec3                _HeadPosition;
#else
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_HeadPosition;
#endif
	UNITY_UNIFORM float Xhlslcc_UnusedX_RangeLimit;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HeadDotDirectionalLightValues;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Cutoff;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowThreshold;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out mediump float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD4;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD5;
#if defined(USE_DITHER_ALPHA)
out highp vec4 vs_TEXCOORD9;
#endif
vec4 u_xlat0;
bool u_xlatb0;
#if defined(_HAIR_SHADOW)
vec3 u_xlat1;
#else
vec4 u_xlat1;
#endif
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
#if !defined(_HAIR_SHADOW)
float u_xlat8;
#endif
mediump float u_xlat16_11;
float u_xlat18;
bool u_xlatb18;
#if defined(_HAIR_SHADOW)
float u_xlat19;
#else
float u_xlat20;
#endif
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlati1 = _CharacterId;
    u_xlat0.w = _MonitorObjectPositionArray[u_xlati1].y;
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat0.y = dot(u_xlat0, u_xlat2);
    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
#if !defined(_HAIR_SHADOW)
    u_xlat4.w = _MonitorObjectPositionArray[u_xlati1].x;
    u_xlat1.w = _MonitorObjectPositionArray[u_xlati1].z;
#endif
    u_xlat4.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
#if defined(_HAIR_SHADOW)
    u_xlat4.w = _MonitorObjectPositionArray[u_xlati1].x;
#endif
    u_xlat0.x = dot(u_xlat4, u_xlat2);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
#if defined(_HAIR_SHADOW)
    u_xlat4.w = _MonitorObjectPositionArray[u_xlati1].z;
    u_xlat1.xyz = (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz) + _MonitorObjectPositionArray[u_xlati1].xyz;
    u_xlat1.xyz = u_xlat1.xyz + vec3(_HeadPosition.x, _HeadPosition.y, _HeadPosition.z);
    u_xlat4.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat0.z = dot(u_xlat4, u_xlat2);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat2;
#else
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat0.z = dot(u_xlat1, u_xlat2);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat1;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = max(u_xlat18, 1.17549435e-38);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    vs_NORMAL0.xyz = u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
#endif
    u_xlatb18 = 0.0>=in_POSITION0.y;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
#if defined(_HAIR_SHADOW)
    u_xlat19 = (-in_COLOR0.w) + 1.0;
    u_xlat3.xy = vec2(_IsRightEyeClose, _IsLeftEyeClose) * vec2(u_xlat19) + in_COLOR0.ww;
    u_xlat19 = (-u_xlat3.x) + u_xlat3.y;
    u_xlat18 = u_xlat18 * u_xlat19 + u_xlat3.x;
#else
    u_xlat2.x = (-in_COLOR0.w) + 1.0;
    u_xlat2.xy = vec2(_IsRightEyeClose, _IsLeftEyeClose) * u_xlat2.xx + in_COLOR0.ww;
    u_xlat8 = (-u_xlat2.x) + u_xlat2.y;
    u_xlat18 = u_xlat18 * u_xlat8 + u_xlat2.x;
#endif
    u_xlat16_5 = (-_EyelashFaceCameraEdge2) + _EyelashFaceCameraEdge1;
    u_xlat16_5 = float(1.0) / u_xlat16_5;
#if defined(_HAIR_SHADOW)
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat19 = dot(u_xlat3.xyz, vec3(_FaceFront.x, _FaceFront.y, _FaceFront.z));
    u_xlat16_11 = u_xlat19 + (-_EyelashFaceCameraEdge2);
#else
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat20 = dot(u_xlat2.xyz, vec3(_FaceFront.x, _FaceFront.y, _FaceFront.z));
    u_xlat16_11 = u_xlat20 + (-_EyelashFaceCameraEdge2);
#endif
    u_xlat16_5 = u_xlat16_5 * u_xlat16_11;
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
    u_xlat16_11 = u_xlat16_5 * -2.0 + 3.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_11;
    u_xlat18 = u_xlat18 * u_xlat16_5;
    vs_TEXCOORD2 = u_xlat18 * _EyelashTransparent;
#if defined(_HAIR_SHADOW)
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = max(u_xlat18, 1.17549435e-38);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_NORMAL0.xyz = u_xlat4.xyz;
#endif
    vs_COLOR0 = in_COLOR0;
#if defined(_HAIR_SHADOW)
    vs_TEXCOORD0 = u_xlat2;
#else
    vs_TEXCOORD0 = u_xlat1;
#endif
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18) + (-u_xlat4.xyz);
    u_xlat1.xyz = vec3(_HeadNormalBlend) * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
#else
    u_xlat3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
#endif
#else
#if defined(_HAIR_SHADOW)
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18) + (-u_xlat4.xyz);
    u_xlat1.xyz = vec3(_HeadNormalBlend) * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
#else
    u_xlat1.xyw = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
#endif
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlatb0 = unity_OrthoParams.w==0.0;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : u_xlat3.xyz;
#else
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.xyz : u_xlat2.xyz;
#endif
#else
#if defined(_HAIR_SHADOW)
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : u_xlat3.xyz;
#else
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat1.xyw : u_xlat2.xyz;
#endif
#endif
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD4.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#if defined(_HAIR_SHADOW)
    vs_TEXCOORD7 = u_xlat2.z;
    u_xlat0.x = u_xlat2.z + _ProjectionParams.y;
#else
    vs_TEXCOORD7 = u_xlat1.z;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
#endif
    u_xlat6 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat6;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD6 = u_xlat0.x;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
#else
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
#endif
    u_xlat0.w = u_xlat0.x * 0.5;
#if defined(_HAIR_SHADOW)
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat2.zw;
#else
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
#endif
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
#endif
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
uniform 	vec2 _GlobalMipBias;
uniform 	vec4 _ProjectionParams;
#if defined(USE_DITHER_ALPHA)
uniform 	vec4 _ScreenParams;
#endif
uniform 	vec4 _SekaiDirectionalLight;
uniform 	mediump vec4 _SekaiShadowColor;
uniform 	mediump float _SekaiShadowThreshold;
uniform 	mediump vec4 _SekaiCharacterSpecularColorArray[10];
#if defined(USE_DITHER_ALPHA)
uniform 	mediump float _DitherAlpha;
#endif
uniform 	vec4 _CoCParams;
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiCharacterAmbientLightIntensityArray[12];
uniform 	vec4 _SekaiCharacterAmbientLightColorArray[12];
uniform 	vec4 _SekaiRimLightArray[12];
uniform 	vec4 _SekaiRimLightColorArray[12];
uniform 	vec4 _SekaiShadowRimLightColorArray[12];
uniform 	mediump vec4 _SekaiRimLightFactor[12];
uniform 	mediump float _SekaiRimLightShadowSharpnessArray[12];
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
uniform 	vec4 _SekaiFogColor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_FaceShadowTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineOffset;
	UNITY_UNIFORM float                _SpecularPower;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM mediump float                _HeadNormalBlend;
#else
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HeadNormalBlend;
#endif
	UNITY_UNIFORM mediump float                _EyelashTransparent;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump float                _IsLeftEyeClose;
	UNITY_UNIFORM mediump float                _IsRightEyeClose;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM vec3                _FaceFront;
	UNITY_UNIFORM int                _CharacterId;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM vec3                _HeadPosition;
#else
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_HeadPosition;
#endif
	UNITY_UNIFORM float Xhlslcc_UnusedX_RangeLimit;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HeadDotDirectionalLightValues;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Cutoff;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowThreshold;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ValueTex;
#if defined(USE_DITHER_ALPHA)
UNITY_LOCATION(3) uniform mediump sampler2D _DitherTex;
#endif
in highp vec3 vs_NORMAL0;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in mediump float vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD5;
#if defined(USE_DITHER_ALPHA)
in highp vec4 vs_TEXCOORD9;
#endif
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
#if defined(USE_DITHER_ALPHA)
vec2 u_xlat0;
#endif
mediump vec4 u_xlat16_0;
#if defined(USE_DITHER_ALPHA)
bool u_xlatb0;
mediump vec3 u_xlat16_1;
#if defined(_LAMBERT)
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
#else
vec4 u_xlat2;
mediump float u_xlat16_2;
#endif
bool u_xlatb2;
#else
#if defined(_LAMBERT)
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
#else
vec4 u_xlat1;
mediump float u_xlat16_1;
#endif
bool u_xlatb1;
mediump vec3 u_xlat16_2;
#endif
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec4 u_xlatb3;
vec3 u_xlat4;
int u_xlati4;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
vec3 u_xlat13;
#else
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat10;
int u_xlati10;
float u_xlat12;
#endif
mediump vec3 u_xlat16_14;
#if !defined(_LAMBERT)
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
int u_xlati19;
#endif
#else
vec3 u_xlat5;
#if defined(_LAMBERT)
vec3 u_xlat6;
#else
mediump vec3 u_xlat16_6;
#endif
mediump vec3 u_xlat16_7;
#if defined(_LAMBERT)
mediump vec3 u_xlat16_8;
float u_xlat11;
float u_xlat13;
mediump vec3 u_xlat16_16;
#else
float u_xlat10;
int u_xlati10;
float u_xlat12;
mediump vec3 u_xlat16_14;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
int u_xlati19;
#endif
#endif
float u_xlat20;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
mediump float u_xlat16_28;
float u_xlat29;
int u_xlati29;
float u_xlat31;
mediump float u_xlat16_32;
#else
mediump float u_xlat16_25;
float u_xlat26;
float u_xlat28;
mediump float u_xlat16_30;
#endif
#else
#if defined(_LAMBERT)
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
mediump float u_xlat16_28;
float u_xlat29;
int u_xlati29;
float u_xlat31;
mediump float u_xlat16_34;
#else
mediump float u_xlat16_25;
float u_xlat26;
float u_xlat28;
mediump float u_xlat16_30;
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat10;
vec3 u_xlat13;
#else
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat9;
int u_xlati9;
float u_xlat12;
#endif
mediump vec3 u_xlat16_14;
#if !defined(_LAMBERT)
float u_xlat17;
bool u_xlatb17;
#endif
#else
vec3 u_xlat5;
#if defined(_LAMBERT)
vec3 u_xlat6;
#else
mediump vec3 u_xlat16_6;
#endif
mediump vec3 u_xlat16_7;
#if defined(_LAMBERT)
mediump vec3 u_xlat16_8;
float u_xlat10;
float u_xlat13;
mediump vec3 u_xlat16_16;
#else
float u_xlat9;
int u_xlati9;
float u_xlat12;
mediump vec3 u_xlat16_14;
float u_xlat17;
bool u_xlatb17;
#endif
#endif
float u_xlat19;
#if defined(_LAMBERT)
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
#else
int u_xlati19;
float u_xlat20;
float u_xlat25;
mediump float u_xlat16_26;
#endif
float u_xlat28;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
int u_xlati28;
mediump float u_xlat16_29;
float u_xlat31;
mediump float u_xlat16_32;
#else
mediump float u_xlat16_30;
#endif
#else
#if defined(_LAMBERT)
int u_xlati28;
mediump float u_xlat16_29;
float u_xlat31;
mediump float u_xlat16_34;
#else
mediump float u_xlat16_30;
#endif
#endif
#endif
void main()
{
#if defined(USE_DITHER_ALPHA)
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat16_0.x = texture(_DitherTex, u_xlat0.xy, _GlobalMipBias.x).x;
    u_xlat16_1.x = (-u_xlat16_0.x) + _DitherAlpha;
    u_xlatb0 = u_xlat16_1.x<0.0;
    if(u_xlatb0){discard;}
#endif
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat16_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlati29 = _CharacterId;
    u_xlat16_1.xyz = _SekaiCharacterSpecularColorArray[u_xlati29].www * _SekaiCharacterSpecularColorArray[u_xlati29].xyz;
#else
    u_xlat16_2 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
    u_xlati10 = _CharacterId;
    u_xlat16_1.xyz = _SekaiCharacterSpecularColorArray[u_xlati10].www * _SekaiCharacterSpecularColorArray[u_xlati10].xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlati28 = _CharacterId;
    u_xlat16_2.xyz = _SekaiCharacterSpecularColorArray[u_xlati28].www * _SekaiCharacterSpecularColorArray[u_xlati28].xyz;
#else
    u_xlat16_1 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
    u_xlati9 = _CharacterId;
    u_xlat16_2.xyz = _SekaiCharacterSpecularColorArray[u_xlati9].www * _SekaiCharacterSpecularColorArray[u_xlati9].xyz;
#endif
#endif
    u_xlat16_3 = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_28 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat4.x = u_xlat16_28 + u_xlat21;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlatb4 = u_xlat4.x>=_SekaiShadowThreshold;
    u_xlat4.x = (u_xlatb4) ? 0.0 : 1.0;
    u_xlat21 = u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = _SekaiShadowThreshold>=u_xlat21;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat16_5.xyz = (-u_xlat16_0.xyz) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = vec3(u_xlat21) * u_xlat16_5.xyz + u_xlat16_0.xyz;
    u_xlat13.xyz = u_xlat16_5.xyz * _SekaiShadowColor.xyz + (-u_xlat16_0.xyz);
    u_xlat13.xyz = u_xlat4.xxx * u_xlat13.xyz + u_xlat16_0.xyz;
    u_xlat2.x = (-u_xlat16_0.x) + u_xlat16_2.x;
    u_xlat2.x = u_xlat4.x * u_xlat2.x + u_xlat16_0.x;
    u_xlat6.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat7.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_28 = u_xlat2.x + u_xlat2.x;
    u_xlat16_5.x = u_xlat2.x * 2.0 + -1.0;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#else
    u_xlat16_25 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat18 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = u_xlat18 * 0.5 + 0.5;
    u_xlat18 = u_xlat16_25 + u_xlat18;
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlatb18 = u_xlat18>=_SekaiShadowThreshold;
    u_xlat18 = (u_xlatb18) ? 0.0 : 1.0;
    u_xlat2.x = (-u_xlat16_0.x) + u_xlat16_2;
    u_xlat2.x = u_xlat18 * u_xlat2.x + u_xlat16_0.x;
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_25 = u_xlat2.x + u_xlat2.x;
    u_xlat16_6.x = u_xlat2.x * 2.0 + -1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
#if defined(_LAMBERT)
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz + u_xlat6.xyz;
    u_xlat16_28 = u_xlat16_28;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_5.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz + u_xlat7.xyz;
#else
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz + u_xlat4.xyz;
    u_xlat16_25 = u_xlat16_25;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_6.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz + u_xlat5.xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_28 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat21 = u_xlat16_28 + u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = u_xlat21>=_SekaiShadowThreshold;
    u_xlat21 = (u_xlatb21) ? 0.0 : 1.0;
    u_xlat4.xyz = u_xlat16_2.xyz * _SekaiShadowColor.xyz + (-u_xlat16_0.xyz);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz + u_xlat16_0.xyz;
    u_xlat2.x = (-u_xlat16_0.x) + u_xlat16_2.x;
    u_xlat2.x = u_xlat21 * u_xlat2.x + u_xlat16_0.x;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat6.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_28 = u_xlat2.x + u_xlat2.x;
    u_xlat16_7.x = u_xlat2.x * 2.0 + -1.0;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_16.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_16.xyz + u_xlat5.xyz;
    u_xlat16_28 = u_xlat16_28;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_7.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz + u_xlat6.xyz;
#else
    u_xlat16_25 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat18 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = u_xlat18 * 0.5 + 0.5;
    u_xlat18 = u_xlat16_25 + u_xlat18;
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlatb18 = u_xlat18>=_SekaiShadowThreshold;
    u_xlat18 = (u_xlatb18) ? 0.0 : 1.0;
    u_xlat2.x = (-u_xlat16_0.x) + u_xlat16_2;
    u_xlat2.x = u_xlat18 * u_xlat2.x + u_xlat16_0.x;
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_25 = u_xlat2.x + u_xlat2.x;
    u_xlat16_6.x = u_xlat2.x * 2.0 + -1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
    u_xlat16_14.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz + u_xlat4.xyz;
    u_xlat16_25 = u_xlat16_25;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_6.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz + u_xlat5.xyz;
#endif
#endif
    u_xlatb2 = u_xlat16_3.x>=0.5;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_28 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_5.xyz = (-u_xlat13.xyz) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz + u_xlat13.xyz;
    u_xlat2.xyz = _SekaiRimLightColorArray[u_xlati29].www * _SekaiRimLightColorArray[u_xlati29].xyz;
#else
    u_xlat16_25 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_6.xyz = (-u_xlat16_0.xyz) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat2.xzw = _SekaiRimLightColorArray[u_xlati10].www * _SekaiRimLightColorArray[u_xlati10].xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_28 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_7.xyz = (-u_xlat4.xyz) + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz + u_xlat4.xyz;
    u_xlat2.xyz = _SekaiRimLightColorArray[u_xlati29].www * _SekaiRimLightColorArray[u_xlati29].xyz;
#else
    u_xlat16_25 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_6.xyz = (-u_xlat16_0.xyz) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat2.xzw = _SekaiRimLightColorArray[u_xlati10].www * _SekaiRimLightColorArray[u_xlati10].xyz;
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_29 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat4.x = u_xlat16_29 + u_xlat21;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlatb4 = u_xlat4.x>=_SekaiShadowThreshold;
    u_xlat4.x = (u_xlatb4) ? 0.0 : 1.0;
    u_xlat21 = u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = _SekaiShadowThreshold>=u_xlat21;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat16_5.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat21) * u_xlat16_5.xyz + u_xlat16_0.xyz;
    u_xlat13.xyz = u_xlat16_5.xyz * _SekaiShadowColor.xyz + (-u_xlat16_0.xyz);
    u_xlat13.xyz = u_xlat4.xxx * u_xlat13.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat1.x = u_xlat4.x * u_xlat1.x + u_xlat16_0.x;
    u_xlat6.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat7.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_29 = u_xlat1.x + u_xlat1.x;
    u_xlat16_5.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#else
    u_xlat16_26 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat17 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat17 = u_xlat17 * 0.5 + 0.5;
    u_xlat17 = u_xlat16_26 + u_xlat17;
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
    u_xlatb17 = u_xlat17>=_SekaiShadowThreshold;
    u_xlat17 = (u_xlatb17) ? 0.0 : 1.0;
    u_xlat1.x = (-u_xlat16_0.x) + u_xlat16_1;
    u_xlat1.x = u_xlat17 * u_xlat1.x + u_xlat16_0.x;
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_26 = u_xlat1.x + u_xlat1.x;
    u_xlat16_6.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
#if defined(_LAMBERT)
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz + u_xlat6.xyz;
    u_xlat16_29 = u_xlat16_29;
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_5.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_29) * u_xlat16_5.xyz + u_xlat7.xyz;
#else
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz + u_xlat4.xyz;
    u_xlat16_26 = u_xlat16_26;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_6.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat5.xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_29 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat21 = u_xlat16_29 + u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = u_xlat21>=_SekaiShadowThreshold;
    u_xlat21 = (u_xlatb21) ? 0.0 : 1.0;
    u_xlat4.xyz = u_xlat16_1.xyz * _SekaiShadowColor.xyz + (-u_xlat16_0.xyz);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat1.x = u_xlat21 * u_xlat1.x + u_xlat16_0.x;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat6.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_29 = u_xlat1.x + u_xlat1.x;
    u_xlat16_7.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_16.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_16.xyz + u_xlat5.xyz;
    u_xlat16_29 = u_xlat16_29;
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_7.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat6.xyz;
#else
    u_xlat16_26 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat17 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat17 = u_xlat17 * 0.5 + 0.5;
    u_xlat17 = u_xlat16_26 + u_xlat17;
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
    u_xlatb17 = u_xlat17>=_SekaiShadowThreshold;
    u_xlat17 = (u_xlatb17) ? 0.0 : 1.0;
    u_xlat1.x = (-u_xlat16_0.x) + u_xlat16_1;
    u_xlat1.x = u_xlat17 * u_xlat1.x + u_xlat16_0.x;
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_26 = u_xlat1.x + u_xlat1.x;
    u_xlat16_6.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
    u_xlat16_14.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz + u_xlat4.xyz;
    u_xlat16_26 = u_xlat16_26;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_6.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat5.xyz;
#endif
#endif
    u_xlatb1 = u_xlat16_3.x>=0.5;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_29 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_5.xyz = (-u_xlat13.xyz) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_29) * u_xlat16_5.xyz + u_xlat13.xyz;
    u_xlat1.xyz = _SekaiRimLightColorArray[u_xlati28].www * _SekaiRimLightColorArray[u_xlati28].xyz;
#else
    u_xlat16_26 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_6.xyz = (-u_xlat16_0.xyz) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat1.xzw = _SekaiRimLightColorArray[u_xlati9].www * _SekaiRimLightColorArray[u_xlati9].xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_29 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_7.xyz = (-u_xlat4.xyz) + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat4.xyz;
    u_xlat1.xyz = _SekaiRimLightColorArray[u_xlati28].www * _SekaiRimLightColorArray[u_xlati28].xyz;
#else
    u_xlat16_26 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_6.xyz = (-u_xlat16_0.xyz) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat1.xzw = _SekaiRimLightColorArray[u_xlati9].www * _SekaiRimLightColorArray[u_xlati9].xyz;
#endif
#endif
#endif
    u_xlat3.x = dot(vs_NORMAL0.xyz, vs_TEXCOORD4.xyz);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat3.z = dot(vs_TEXCOORD4.xyz, _SekaiRimLightArray[u_xlati29].xyz);
#else
    u_xlat3.z = dot(vs_TEXCOORD4.xyz, _SekaiRimLightArray[u_xlati10].xyz);
#endif
#else
#if defined(_LAMBERT)
    u_xlat3.z = dot(vs_TEXCOORD4.xyz, _SekaiRimLightArray[u_xlati28].xyz);
#else
    u_xlat3.z = dot(vs_TEXCOORD4.xyz, _SekaiRimLightArray[u_xlati9].xyz);
#endif
#endif
    u_xlat4.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_NORMAL0.xyz;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati29].xyz, _SekaiRimLightArray[u_xlati29].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat6.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati29].xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat16_28 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati29];
    u_xlat16_32 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati29]);
    u_xlat13.x = (-u_xlat16_28) + u_xlat16_32;
    u_xlat22 = (-u_xlat16_28) + u_xlat4.x;
    u_xlat13.x = float(1.0) / u_xlat13.x;
    u_xlat13.x = u_xlat13.x * u_xlat22;
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
    u_xlat22 = u_xlat13.x * -2.0 + 3.0;
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat13.x = u_xlat13.x * u_xlat22;
    u_xlat6.xyz = _SekaiShadowRimLightColorArray[u_xlati29].xyz * _SekaiShadowRimLightColorArray[u_xlati29].www + (-u_xlat2.xyz);
    u_xlat2.xyz = u_xlat13.xxx * u_xlat6.xyz + u_xlat2.xyz;
#else
    u_xlat28 = dot(_SekaiRimLightArray[u_xlati10].xyz, _SekaiRimLightArray[u_xlati10].xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = vec3(u_xlat28) * _SekaiRimLightArray[u_xlati10].xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat16_25 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati10];
    u_xlat16_30 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati10]);
    u_xlat12 = (-u_xlat16_25) + u_xlat16_30;
    u_xlat20 = (-u_xlat16_25) + u_xlat4.x;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat20 = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati10].xyz * _SekaiShadowRimLightColorArray[u_xlati10].www + (-u_xlat2.xzw);
    u_xlat2.xzw = vec3(u_xlat12) * u_xlat5.xyz + u_xlat2.xzw;
#endif
#else
#if defined(_LAMBERT)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati29].xyz, _SekaiRimLightArray[u_xlati29].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat5.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati29].xyz;
#else
    u_xlat28 = dot(_SekaiRimLightArray[u_xlati10].xyz, _SekaiRimLightArray[u_xlati10].xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = vec3(u_xlat28) * _SekaiRimLightArray[u_xlati10].xyz;
#endif
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat5.xyz);
#if defined(_LAMBERT)
    u_xlat16_28 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati29];
    u_xlat16_34 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati29]);
    u_xlat13 = (-u_xlat16_28) + u_xlat16_34;
    u_xlat22 = (-u_xlat16_28) + u_xlat4.x;
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22;
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
    u_xlat22 = u_xlat13 * -2.0 + 3.0;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati29].xyz * _SekaiShadowRimLightColorArray[u_xlati29].www + (-u_xlat2.xyz);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat5.xyz + u_xlat2.xyz;
#else
    u_xlat16_25 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati10];
    u_xlat16_30 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati10]);
    u_xlat12 = (-u_xlat16_25) + u_xlat16_30;
    u_xlat20 = (-u_xlat16_25) + u_xlat4.x;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat20 = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati10].xyz * _SekaiShadowRimLightColorArray[u_xlati10].www + (-u_xlat2.xzw);
    u_xlat2.xzw = vec3(u_xlat12) * u_xlat5.xyz + u_xlat2.xzw;
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati28].xyz, _SekaiRimLightArray[u_xlati28].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat6.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati28].xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat16_29 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati28];
    u_xlat16_32 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati28]);
    u_xlat13.x = (-u_xlat16_29) + u_xlat16_32;
    u_xlat22 = (-u_xlat16_29) + u_xlat4.x;
    u_xlat13.x = float(1.0) / u_xlat13.x;
    u_xlat13.x = u_xlat13.x * u_xlat22;
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
    u_xlat22 = u_xlat13.x * -2.0 + 3.0;
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat13.x = u_xlat13.x * u_xlat22;
    u_xlat6.xyz = _SekaiShadowRimLightColorArray[u_xlati28].xyz * _SekaiShadowRimLightColorArray[u_xlati28].www + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat13.xxx * u_xlat6.xyz + u_xlat1.xyz;
#else
    u_xlat28 = dot(_SekaiRimLightArray[u_xlati9].xyz, _SekaiRimLightArray[u_xlati9].xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = vec3(u_xlat28) * _SekaiRimLightArray[u_xlati9].xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat16_26 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati9];
    u_xlat16_30 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati9]);
    u_xlat12 = (-u_xlat16_26) + u_xlat16_30;
    u_xlat20 = (-u_xlat16_26) + u_xlat4.x;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat20 = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati9].xyz * _SekaiShadowRimLightColorArray[u_xlati9].www + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat12) * u_xlat5.xyz + u_xlat1.xzw;
#endif
#else
#if defined(_LAMBERT)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati28].xyz, _SekaiRimLightArray[u_xlati28].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat5.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati28].xyz;
#else
    u_xlat28 = dot(_SekaiRimLightArray[u_xlati9].xyz, _SekaiRimLightArray[u_xlati9].xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = vec3(u_xlat28) * _SekaiRimLightArray[u_xlati9].xyz;
#endif
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat5.xyz);
#if defined(_LAMBERT)
    u_xlat16_29 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati28];
    u_xlat16_34 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati28]);
    u_xlat13 = (-u_xlat16_29) + u_xlat16_34;
    u_xlat22 = (-u_xlat16_29) + u_xlat4.x;
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22;
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
    u_xlat22 = u_xlat13 * -2.0 + 3.0;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati28].xyz * _SekaiShadowRimLightColorArray[u_xlati28].www + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat5.xyz + u_xlat1.xyz;
#else
    u_xlat16_26 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati9];
    u_xlat16_30 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati9]);
    u_xlat12 = (-u_xlat16_26) + u_xlat16_30;
    u_xlat20 = (-u_xlat16_26) + u_xlat4.x;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat20 = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati9].xyz * _SekaiShadowRimLightColorArray[u_xlati9].www + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat12) * u_xlat5.xyz + u_xlat1.xzw;
#endif
#endif
#endif
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlat3.x = (-u_xlat3.x) + 1.0;
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat16_28 = 10.0 + (-_SekaiRimLightFactor[u_xlati29].x);
#else
    u_xlat16_25 = 10.0 + (-_SekaiRimLightFactor[u_xlati10].x);
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_29 = 10.0 + (-_SekaiRimLightFactor[u_xlati28].x);
#else
    u_xlat16_26 = 10.0 + (-_SekaiRimLightFactor[u_xlati9].x);
#endif
#endif
    u_xlat3.x = log2(u_xlat3.x);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat16_28 * u_xlat3.x;
#else
    u_xlat3.x = u_xlat16_25 * u_xlat3.x;
#endif
#else
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat16_29 * u_xlat3.x;
#else
    u_xlat3.x = u_xlat16_26 * u_xlat3.x;
#endif
#endif
    u_xlat3.x = exp2(u_xlat3.x);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat21 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati29].w * u_xlat21 + u_xlat3.x;
    u_xlat21 = (-u_xlat4.x) + 0.0500000007;
    u_xlati4 = int((0.0<u_xlat21) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = int((u_xlat21<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = (-u_xlati4) + u_xlati21;
    u_xlat21 = float(u_xlati21);
    u_xlat21 = u_xlat3.x * u_xlat21 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati29].w * u_xlat21 + u_xlat3.x;
#else
    u_xlat19 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati10].w * u_xlat19 + u_xlat3.x;
    u_xlat19 = (-u_xlat4.x) + 0.0500000007;
    u_xlati4 = int((0.0<u_xlat19) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = int((u_xlat19<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = (-u_xlati4) + u_xlati19;
    u_xlat19 = float(u_xlati19);
    u_xlat19 = u_xlat3.x * u_xlat19 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati10].w * u_xlat19 + u_xlat3.x;
#endif
#else
#if defined(_LAMBERT)
    u_xlat21 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati28].w * u_xlat21 + u_xlat3.x;
    u_xlat21 = (-u_xlat4.x) + 0.0500000007;
    u_xlati4 = int((0.0<u_xlat21) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = int((u_xlat21<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = (-u_xlati4) + u_xlati21;
    u_xlat21 = float(u_xlati21);
    u_xlat21 = u_xlat3.x * u_xlat21 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati28].w * u_xlat21 + u_xlat3.x;
#else
    u_xlat19 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati9].w * u_xlat19 + u_xlat3.x;
    u_xlat19 = (-u_xlat4.x) + 0.0500000007;
    u_xlati4 = int((0.0<u_xlat19) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = int((u_xlat19<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = (-u_xlati4) + u_xlati19;
    u_xlat19 = float(u_xlati19);
    u_xlat19 = u_xlat3.x * u_xlat19 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati9].w * u_xlat19 + u_xlat3.x;
#endif
#endif
    u_xlat3.x = u_xlat3.x + (-_RimThreshold);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat21 = float(1.0) / _SekaiRimLightFactor[u_xlati29].z;
    u_xlat3.x = u_xlat21 * u_xlat3.x;
#else
    u_xlat19 = float(1.0) / _SekaiRimLightFactor[u_xlati10].z;
    u_xlat3.x = u_xlat19 * u_xlat3.x;
#endif
#else
#if defined(_LAMBERT)
    u_xlat21 = float(1.0) / _SekaiRimLightFactor[u_xlati28].z;
    u_xlat3.x = u_xlat21 * u_xlat3.x;
#else
    u_xlat19 = float(1.0) / _SekaiRimLightFactor[u_xlati9].z;
    u_xlat3.x = u_xlat19 * u_xlat3.x;
#endif
#endif
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#if defined(_LAMBERT)
    u_xlat21 = u_xlat3.x * -2.0 + 3.0;
#else
    u_xlat19 = u_xlat3.x * -2.0 + 3.0;
#endif
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat3.x * u_xlat21;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat2.xyz * vs_COLOR0.yyy;
    u_xlat16_5.xyz = u_xlat2.xyz * vs_COLOR0.yyy + u_xlat16_5.xyz;
    u_xlat2.xyz = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
#else
    u_xlat3.x = u_xlat3.x * u_xlat19;
    u_xlat2.xzw = u_xlat2.xzw * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat2.xzw * vs_COLOR0.yyy;
    u_xlat16_6.xyz = u_xlat2.xzw * vs_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat2.xzw = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat2.xzw, u_xlat2.xzw);
#endif
#else
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat3.x * u_xlat21;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat2.xyz * vs_COLOR0.yyy;
    u_xlat16_7.xyz = u_xlat2.xyz * vs_COLOR0.yyy + u_xlat16_7.xyz;
    u_xlat2.xyz = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
#else
    u_xlat3.x = u_xlat3.x * u_xlat19;
    u_xlat2.xzw = u_xlat2.xzw * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat2.xzw * vs_COLOR0.yyy;
    u_xlat16_6.xyz = u_xlat2.xzw * vs_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat2.xzw = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat2.xzw, u_xlat2.xzw);
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat3.x * u_xlat21;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat16_5.xyz = u_xlat1.xyz * vs_COLOR0.yyy + u_xlat16_5.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
#else
    u_xlat3.x = u_xlat3.x * u_xlat19;
    u_xlat1.xzw = u_xlat1.xzw * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat1.xzw * vs_COLOR0.yyy;
    u_xlat16_6.xyz = u_xlat1.xzw * vs_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat1.xzw = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat1.xzw, u_xlat1.xzw);
#endif
#else
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat3.x * u_xlat21;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat16_7.xyz = u_xlat1.xyz * vs_COLOR0.yyy + u_xlat16_7.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
#else
    u_xlat3.x = u_xlat3.x * u_xlat19;
    u_xlat1.xzw = u_xlat1.xzw * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat1.xzw * vs_COLOR0.yyy;
    u_xlat16_6.xyz = u_xlat1.xzw * vs_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat1.xzw = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat1.xzw, u_xlat1.xzw);
#endif
#endif
#endif
    u_xlat3.x = inversesqrt(u_xlat3.x);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xxx;
    u_xlat2.x = dot(u_xlat2.xyz, vs_NORMAL0.xyz);
#else
    u_xlat2.xzw = u_xlat2.xzw * u_xlat3.xxx;
    u_xlat2.x = dot(u_xlat2.xzw, vs_NORMAL0.xyz);
#endif
    u_xlat2.x = max(u_xlat2.x, 0.0);
#if defined(_LAMBERT)
    u_xlat11 = 10.0 / _SpecularPower;
#else
    u_xlat18 = 10.0 / _SpecularPower;
#endif
    u_xlat2.x = log2(u_xlat2.x);
#if defined(_LAMBERT)
    u_xlat2.x = u_xlat2.x * u_xlat11;
#else
    u_xlat2.x = u_xlat2.x * u_xlat18;
#endif
    u_xlat2.x = exp2(u_xlat2.x);
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xxx;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat16_3.www + u_xlat16_5.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat2.xxyz, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#else
    u_xlat2.xzw = u_xlat16_1.xyz * u_xlat2.xxx;
    u_xlat2.xzw = u_xlat2.xzw * u_xlat16_3.www + u_xlat16_6.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat2.xxzw, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#endif
#else
#if defined(_LAMBERT)
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xxx;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat16_3.www + u_xlat16_7.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat2.xxyz, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#else
    u_xlat2.xzw = u_xlat16_1.xyz * u_xlat2.xxx;
    u_xlat2.xzw = u_xlat2.xzw * u_xlat16_3.www + u_xlat16_6.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat2.xxzw, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#endif
#endif
    u_xlat16_1.x = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_1.y = (u_xlatb3.z) ? float(1.0) : float(0.0);
    u_xlat16_1.z = (u_xlatb3.w) ? float(1.0) : float(0.0);
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_5.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xzw = u_xlat16_5.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati29].xyz;
    u_xlat16_8.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati29].xyz);
    u_xlat2.xyz = (-u_xlat16_8.xyz) * u_xlat2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati29].xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + u_xlat3.xzw;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati29]);
    u_xlat3.xzw = u_xlat2.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat2.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#else
    u_xlat16_6.xyz = u_xlat2.xzw + u_xlat2.xzw;
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz;
    u_xlat16_7.xyz = (-u_xlat2.xzw) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_7.xyz;
    u_xlat2.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati10].xyz);
    u_xlat2.xzw = (-u_xlat16_7.xyz) * u_xlat2.xzw + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz + u_xlat2.xzw;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + u_xlat3.xzw;
    u_xlat2.xzw = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati10]);
    u_xlat3.xzw = u_xlat2.xzw * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat2.xzw) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_7.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xzw = u_xlat16_7.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati29].xyz;
    u_xlat16_8.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati29].xyz);
    u_xlat2.xyz = (-u_xlat16_8.xyz) * u_xlat2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati29].xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat3.xzw;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati29]);
    u_xlat3.xzw = u_xlat2.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat2.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#else
    u_xlat16_6.xyz = u_xlat2.xzw + u_xlat2.xzw;
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz;
    u_xlat16_7.xyz = (-u_xlat2.xzw) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_7.xyz;
    u_xlat2.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati10].xyz);
    u_xlat2.xzw = (-u_xlat16_7.xyz) * u_xlat2.xzw + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz + u_xlat2.xzw;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + u_xlat3.xzw;
    u_xlat2.xzw = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati10]);
    u_xlat3.xzw = u_xlat2.xzw * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat2.xzw) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#endif
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_5.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
#else
    u_xlat16_6.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_6.xyz + u_xlat16_1.xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_7.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_7.xyz + u_xlat16_1.xyz;
#else
    u_xlat16_6.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_6.xyz + u_xlat16_1.xyz;
#endif
#endif
    u_xlatb2 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb2){
#if defined(_LAMBERT)
        u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat2.xy = u_xlat2.xy * u_xlat2.xy;
        u_xlat2.x = u_xlat2.y + u_xlat2.x;
        u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
        u_xlat11 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat2.xzw = (-vs_TEXCOORD5.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat2.xz = u_xlat2.xz * u_xlat2.xz;
        u_xlat2.x = u_xlat2.z + u_xlat2.x;
        u_xlat2.x = u_xlat2.w * u_xlat2.w + u_xlat2.x;
        u_xlat18 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
        u_xlat2.x = u_xlat2.x + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(_LAMBERT)
        u_xlat11 = float(1.0) / u_xlat11;
        u_xlat2.x = u_xlat11 * u_xlat2.x;
#else
        u_xlat18 = float(1.0) / u_xlat18;
        u_xlat2.x = u_xlat18 * u_xlat2.x;
#endif
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#if defined(_LAMBERT)
        u_xlat11 = u_xlat2.x * -2.0 + 3.0;
#else
        u_xlat18 = u_xlat2.x * -2.0 + 3.0;
#endif
        u_xlat2.x = u_xlat2.x * u_xlat2.x;
#if defined(_LAMBERT)
        u_xlat20 = u_xlat2.x * u_xlat11;
        u_xlat2.x = (-u_xlat11) * u_xlat2.x + 1.0;
        u_xlat3.xzw = u_xlat16_1.xyz * vec3(u_xlat20);
#else
        u_xlat26 = u_xlat2.x * u_xlat18;
        u_xlat2.x = (-u_xlat18) * u_xlat2.x + 1.0;
        u_xlat3.xzw = u_xlat16_1.xyz * vec3(u_xlat26);
#endif
#else
#if defined(_LAMBERT)
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat1.x = dot(u_xlat1.xyz, vs_NORMAL0.xyz);
#else
    u_xlat1.xzw = u_xlat1.xzw * u_xlat3.xxx;
    u_xlat1.x = dot(u_xlat1.xzw, vs_NORMAL0.xyz);
#endif
    u_xlat1.x = max(u_xlat1.x, 0.0);
#if defined(_LAMBERT)
    u_xlat10 = 10.0 / _SpecularPower;
#else
    u_xlat17 = 10.0 / _SpecularPower;
#endif
    u_xlat1.x = log2(u_xlat1.x);
#if defined(_LAMBERT)
    u_xlat1.x = u_xlat1.x * u_xlat10;
#else
    u_xlat1.x = u_xlat1.x * u_xlat17;
#endif
    u_xlat1.x = exp2(u_xlat1.x);
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat1.xyz = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_3.www + u_xlat16_5.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat1.xxyz, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#else
    u_xlat1.xzw = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat1.xzw = u_xlat1.xzw * u_xlat16_3.www + u_xlat16_6.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat1.xxzw, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#endif
#else
#if defined(_LAMBERT)
    u_xlat1.xyz = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_3.www + u_xlat16_7.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat1.xxyz, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#else
    u_xlat1.xzw = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat1.xzw = u_xlat1.xzw * u_xlat16_3.www + u_xlat16_6.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat1.xxzw, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#endif
#endif
    u_xlat16_2.x = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb3.z) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb3.w) ? float(1.0) : float(0.0);
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_5.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat3.xzw = u_xlat16_5.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati28].xyz;
    u_xlat16_8.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_8.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati28].xyz);
    u_xlat1.xyz = (-u_xlat16_8.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati28].xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + u_xlat3.xzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati28]);
    u_xlat3.xzw = u_xlat1.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat1.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#else
    u_xlat16_6.xyz = u_xlat1.xzw + u_xlat1.xzw;
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati9].xyz;
    u_xlat16_7.xyz = (-u_xlat1.xzw) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_7.xyz;
    u_xlat1.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati9].xyz);
    u_xlat1.xzw = (-u_xlat16_7.xyz) * u_xlat1.xzw + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati9].xyz + u_xlat1.xzw;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz + u_xlat3.xzw;
    u_xlat1.xzw = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati9]);
    u_xlat3.xzw = u_xlat1.xzw * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat1.xzw) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_7.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat3.xzw = u_xlat16_7.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati28].xyz;
    u_xlat16_8.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_8.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati28].xyz);
    u_xlat1.xyz = (-u_xlat16_8.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati28].xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz + u_xlat3.xzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati28]);
    u_xlat3.xzw = u_xlat1.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat1.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#else
    u_xlat16_6.xyz = u_xlat1.xzw + u_xlat1.xzw;
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati9].xyz;
    u_xlat16_7.xyz = (-u_xlat1.xzw) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_7.xyz;
    u_xlat1.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati9].xyz);
    u_xlat1.xzw = (-u_xlat16_7.xyz) * u_xlat1.xzw + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati9].xyz + u_xlat1.xzw;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz + u_xlat3.xzw;
    u_xlat1.xzw = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati9]);
    u_xlat3.xzw = u_xlat1.xzw * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat1.xzw) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#endif
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_5.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_5.xyz + u_xlat16_2.xyz;
#else
    u_xlat16_6.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_6.xyz + u_xlat16_2.xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_7.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_7.xyz + u_xlat16_2.xyz;
#else
    u_xlat16_6.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_6.xyz + u_xlat16_2.xyz;
#endif
#endif
    u_xlatb1 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb1){
#if defined(_LAMBERT)
        u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xy = u_xlat1.xy * u_xlat1.xy;
        u_xlat1.x = u_xlat1.y + u_xlat1.x;
        u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
        u_xlat10 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat1.xzw = (-vs_TEXCOORD5.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xz = u_xlat1.xz * u_xlat1.xz;
        u_xlat1.x = u_xlat1.z + u_xlat1.x;
        u_xlat1.x = u_xlat1.w * u_xlat1.w + u_xlat1.x;
        u_xlat17 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
        u_xlat1.x = u_xlat1.x + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(_LAMBERT)
        u_xlat10 = float(1.0) / u_xlat10;
        u_xlat1.x = u_xlat10 * u_xlat1.x;
#else
        u_xlat17 = float(1.0) / u_xlat17;
        u_xlat1.x = u_xlat17 * u_xlat1.x;
#endif
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#if defined(_LAMBERT)
        u_xlat10 = u_xlat1.x * -2.0 + 3.0;
#else
        u_xlat17 = u_xlat1.x * -2.0 + 3.0;
#endif
        u_xlat1.x = u_xlat1.x * u_xlat1.x;
#if defined(_LAMBERT)
        u_xlat19 = u_xlat1.x * u_xlat10;
        u_xlat1.x = (-u_xlat10) * u_xlat1.x + 1.0;
        u_xlat3.xzw = u_xlat16_2.xyz * vec3(u_xlat19);
#else
        u_xlat25 = u_xlat1.x * u_xlat17;
        u_xlat1.x = (-u_xlat17) * u_xlat1.x + 1.0;
        u_xlat3.xzw = u_xlat16_2.xyz * vec3(u_xlat25);
#endif
#endif
        u_xlat3.xzw = u_xlat3.xzw * _SekaiGlobalSpotLightColor.xyz;
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
        u_xlat2.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat3.xzw;
#else
        u_xlat2.xzw = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat3.xzw;
#endif
#else
#if defined(_LAMBERT)
        u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat3.xzw;
#else
        u_xlat1.xzw = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat3.xzw;
#endif
#endif
    } else {
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
        u_xlat2.xyz = u_xlat16_1.xyz;
#else
        u_xlat2.xzw = u_xlat16_1.xyz;
#endif
#else
#if defined(_LAMBERT)
        u_xlat1.xyz = u_xlat16_2.xyz;
#else
        u_xlat1.xzw = u_xlat16_2.xyz;
#endif
#endif
    }
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat3.xzw = u_xlat4.xyz * _SekaiRimLightFactor[u_xlati29].yyy;
    u_xlat3.xyz = u_xlat2.xyz * u_xlat16_3.yyy + u_xlat3.xzw;
#else
    u_xlat3.xzw = u_xlat4.xyz * _SekaiRimLightFactor[u_xlati10].yyy;
    u_xlat3.xyz = u_xlat2.xzw * u_xlat16_3.yyy + u_xlat3.xzw;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD6) + 1.0;
#if defined(_LAMBERT)
    u_xlat29 = u_xlat16_1.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat2.xyz) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat29) * u_xlat4.xyz + u_xlat2.xyz;
#else
    u_xlat10 = u_xlat16_1.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat2.xzw) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat10) * u_xlat4.xyz + u_xlat2.xzw;
#endif
    u_xlat2.x = vs_TEXCOORD7 / vs_TEXCOORD0.w;
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
#if defined(_LAMBERT)
    u_xlat11 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat11 = u_xlat11 + -1.0;
    u_xlat11 = u_xlat11 * _ProjectionParams.w;
    u_xlat2.x = u_xlat11 * u_xlat2.x + _ProjectionParams.w;
#else
    u_xlat10 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat10 = u_xlat10 + -1.0;
    u_xlat10 = u_xlat10 * _ProjectionParams.w;
    u_xlat2.x = u_xlat10 * u_xlat2.x + _ProjectionParams.w;
#endif
    u_xlat2.x = (-_CoCParams.x) * u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * _CoCParams.y;
#if defined(_LAMBERT)
    u_xlat11 = u_xlat2.x;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#else
    u_xlat10 = u_xlat2.x;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat2.x = max(u_xlat2.x, -1.0);
    u_xlat2.x = min(u_xlat2.x, 0.0);
#if defined(_LAMBERT)
    u_xlat2.x = u_xlat2.x + u_xlat11;
#else
    u_xlat2.x = u_xlat2.x + u_xlat10;
#endif
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
#else
#if defined(_LAMBERT)
    u_xlat3.xzw = u_xlat4.xyz * _SekaiRimLightFactor[u_xlati28].yyy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat16_3.yyy + u_xlat3.xzw;
#else
    u_xlat3.xzw = u_xlat4.xyz * _SekaiRimLightFactor[u_xlati9].yyy;
    u_xlat3.xyz = u_xlat1.xzw * u_xlat16_3.yyy + u_xlat3.xzw;
#endif
    u_xlat16_2.x = (-vs_TEXCOORD6) + 1.0;
#if defined(_LAMBERT)
    u_xlat28 = u_xlat16_2.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat1.xyz) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat28) * u_xlat4.xyz + u_xlat1.xyz;
#else
    u_xlat9 = u_xlat16_2.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat1.xzw) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat9) * u_xlat4.xyz + u_xlat1.xzw;
#endif
    u_xlat1.x = vs_TEXCOORD7 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
#if defined(_LAMBERT)
    u_xlat10 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat10 = u_xlat10 + -1.0;
    u_xlat10 = u_xlat10 * _ProjectionParams.w;
    u_xlat1.x = u_xlat10 * u_xlat1.x + _ProjectionParams.w;
#else
    u_xlat9 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9 = u_xlat9 + -1.0;
    u_xlat9 = u_xlat9 * _ProjectionParams.w;
    u_xlat1.x = u_xlat9 * u_xlat1.x + _ProjectionParams.w;
#endif
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
#if defined(_LAMBERT)
    u_xlat10 = u_xlat1.x;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#else
    u_xlat9 = u_xlat1.x;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, -1.0);
    u_xlat1.x = min(u_xlat1.x, 0.0);
#if defined(_LAMBERT)
    u_xlat1.x = u_xlat1.x + u_xlat10;
#else
    u_xlat1.x = u_xlat1.x + u_xlat9;
#endif
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * 0.5;
#endif
    SV_Target0 = u_xlat16_0;
#if defined(USE_DITHER_ALPHA)
    SV_Target1.x = u_xlat2.x;
#else
    SV_Target1.x = u_xlat1.x;
#endif
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2.xyz = u_xlat3.xyz;
    SV_Target2.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "Outline"
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="SekaiOutline" "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
			ZTest Less
			Cull Front
			Stencil
			{
				Ref [_Stencil]
				ReadMask [_ReadMask]
				WriteMask [_WriteMask]
				Comp [_StencilComp]
				Pass [_StencilOp]
				Fail [_StencilFail]
				ZFail [_StencilZFail]
			}
		}
		Pass
		{
			Name "Reflection"
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="SekaiReflection" "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
			Cull Front
			GLSLPROGRAM
#pragma multi_compile _ USE_DITHER_ALPHA
#pragma multi_compile _ _FACE_SHADOW_RANGE_LIMIT
#pragma multi_compile _ _HAIR_SHADOW
#pragma multi_compile _ _LAMBERT
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
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_FaceShadowTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineOffset;
	UNITY_UNIFORM float                _SpecularPower;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM mediump float                _HeadNormalBlend;
#else
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HeadNormalBlend;
#endif
	UNITY_UNIFORM mediump float                _EyelashTransparent;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump float                _IsLeftEyeClose;
	UNITY_UNIFORM mediump float                _IsRightEyeClose;
	UNITY_UNIFORM int                _CharacterReflectionOff;
	UNITY_UNIFORM vec3                _FaceFront;
	UNITY_UNIFORM int                _CharacterId;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM vec3                _HeadPosition;
#else
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_HeadPosition;
#endif
	UNITY_UNIFORM float Xhlslcc_UnusedX_RangeLimit;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HeadDotDirectionalLightValues;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Cutoff;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowThreshold;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out mediump float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD4;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD5;
#if defined(USE_DITHER_ALPHA)
out highp vec4 vs_TEXCOORD9;
#endif
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
vec3 u_xlat5;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
float u_xlat18;
int u_xlati18;
float u_xlat19;
#else
vec2 u_xlat6;
mediump float u_xlat16_8;
float u_xlat11;
float u_xlat15;
int u_xlati15;
float u_xlat16;
#endif
#else
vec2 u_xlat6;
mediump float u_xlat16_8;
float u_xlat11;
float u_xlat15;
int u_xlati15;
float u_xlat16;
#endif
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = (-u_xlat0.yyy) * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlati18 = (-_CharacterReflectionOff) + 1;
    u_xlat18 = float(u_xlati18);
    u_xlat2 = u_xlat1 * vec4(u_xlat18);
    u_xlat18 = u_xlat18 * u_xlat1.z + _ProjectionParams.y;
#else
    u_xlati15 = (-_CharacterReflectionOff) + 1;
    u_xlat15 = float(u_xlati15);
    u_xlat2 = u_xlat1 * vec4(u_xlat15);
    u_xlat15 = u_xlat15 * u_xlat1.z + _ProjectionParams.y;
#endif
#else
    u_xlati15 = (-_CharacterReflectionOff) + 1;
    u_xlat15 = float(u_xlati15);
    u_xlat2 = u_xlat1 * vec4(u_xlat15);
    u_xlat15 = u_xlat15 * u_xlat1.z + _ProjectionParams.y;
#endif
    gl_Position = u_xlat2;
#if !defined(_HAIR_SHADOW)
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = max(u_xlat16, 1.17549435e-38);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_NORMAL0.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
#endif
    u_xlatb1 = 0.0>=in_POSITION0.y;
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat7.x = (-in_COLOR0.w) + 1.0;
    u_xlat7.xy = vec2(_IsRightEyeClose, _IsLeftEyeClose) * u_xlat7.xx + in_COLOR0.ww;
    u_xlat13 = (-u_xlat7.x) + u_xlat7.y;
    u_xlat1.x = u_xlat1.x * u_xlat13 + u_xlat7.x;
#else
    u_xlat6.x = (-in_COLOR0.w) + 1.0;
    u_xlat6.xy = vec2(_IsRightEyeClose, _IsLeftEyeClose) * u_xlat6.xx + in_COLOR0.ww;
    u_xlat11 = (-u_xlat6.x) + u_xlat6.y;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6.x;
#endif
#else
    u_xlat6.x = (-in_COLOR0.w) + 1.0;
    u_xlat6.xy = vec2(_IsRightEyeClose, _IsLeftEyeClose) * u_xlat6.xx + in_COLOR0.ww;
    u_xlat11 = (-u_xlat6.x) + u_xlat6.y;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6.x;
#endif
    u_xlat16_3 = (-_EyelashFaceCameraEdge2) + _EyelashFaceCameraEdge1;
    u_xlat16_3 = float(1.0) / u_xlat16_3;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat7.x = dot(u_xlat4.xyz, vec3(_FaceFront.x, _FaceFront.y, _FaceFront.z));
    u_xlat16_9 = u_xlat7.x + (-_EyelashFaceCameraEdge2);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_9;
#else
    u_xlat6.x = dot(u_xlat4.xyz, vec3(_FaceFront.x, _FaceFront.y, _FaceFront.z));
    u_xlat16_8 = u_xlat6.x + (-_EyelashFaceCameraEdge2);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
#endif
#else
    u_xlat6.x = dot(u_xlat4.xyz, vec3(_FaceFront.x, _FaceFront.y, _FaceFront.z));
    u_xlat16_8 = u_xlat6.x + (-_EyelashFaceCameraEdge2);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
#endif
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat16_9 = u_xlat16_3 * -2.0 + 3.0;
#else
    u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
#endif
#else
    u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
#endif
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat16_3 = u_xlat16_3 * u_xlat16_9;
#else
    u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
#endif
#else
    u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
#endif
    u_xlat1.x = u_xlat1.x * u_xlat16_3;
    vs_TEXCOORD2 = u_xlat1.x * _EyelashTransparent;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = max(u_xlat19, 1.17549435e-38);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_NORMAL0.xyz = u_xlat1.xyz;
#endif
#else
#if defined(_HAIR_SHADOW)
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = max(u_xlat16, 1.17549435e-38);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_NORMAL0.xyz = u_xlat1.xyz;
#endif
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat2;
#if !defined(USE_DITHER_ALPHA)
    vs_TEXCOORD7 = u_xlat2.z;
#endif
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat5.xyz = u_xlat0.xyz + (-vec3(_HeadPosition.x, _HeadPosition.y, _HeadPosition.z));
    u_xlat19 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat19) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(_HeadNormalBlend) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    vs_TEXCOORD3.xyz = vec3(u_xlat19) * u_xlat1.xyz;
#endif
#else
#if defined(_HAIR_SHADOW)
    u_xlat2.xyz = u_xlat0.xyz + (-vec3(_HeadPosition.x, _HeadPosition.y, _HeadPosition.z));
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat16) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(_HeadNormalBlend) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD3.xyz = vec3(u_xlat16) * u_xlat1.xyz;
#endif
#endif
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlatb0 = unity_OrthoParams.w==0.0;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat1.xxx;
#if defined(USE_DITHER_ALPHA)
    vs_TEXCOORD7 = u_xlat2.z;
#endif
    u_xlat0.x = _ProjectionParams.y + _ProjectionParams.z;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
    u_xlat0.x = u_xlat18 / u_xlat0.x;
#else
    u_xlat0.x = u_xlat15 / u_xlat0.x;
#endif
#else
    u_xlat0.x = u_xlat15 / u_xlat0.x;
#endif
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD6 = u_xlat0.x;
#if defined(USE_DITHER_ALPHA)
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat2.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
#endif
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
uniform 	vec2 _GlobalMipBias;
uniform 	vec4 _ProjectionParams;
#if defined(USE_DITHER_ALPHA)
uniform 	vec4 _ScreenParams;
#endif
uniform 	vec4 _SekaiDirectionalLight;
uniform 	mediump vec4 _SekaiShadowColor;
uniform 	mediump float _SekaiShadowThreshold;
uniform 	mediump vec4 _SekaiCharacterSpecularColorArray[10];
#if defined(USE_DITHER_ALPHA)
uniform 	mediump float _DitherAlpha;
#endif
uniform 	vec4 _CoCParams;
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiCharacterAmbientLightIntensityArray[12];
uniform 	vec4 _SekaiCharacterAmbientLightColorArray[12];
uniform 	vec4 _SekaiRimLightArray[12];
uniform 	vec4 _SekaiRimLightColorArray[12];
uniform 	vec4 _SekaiShadowRimLightColorArray[12];
uniform 	mediump vec4 _SekaiRimLightFactor[12];
uniform 	mediump float _SekaiRimLightShadowSharpnessArray[12];
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
uniform 	vec4 _SekaiFogColor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_FaceShadowTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineOffset;
	UNITY_UNIFORM float                _SpecularPower;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM mediump float                _HeadNormalBlend;
#else
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HeadNormalBlend;
#endif
	UNITY_UNIFORM mediump float                _EyelashTransparent;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump float                _IsLeftEyeClose;
	UNITY_UNIFORM mediump float                _IsRightEyeClose;
	UNITY_UNIFORM int                _CharacterReflectionOff;
	UNITY_UNIFORM vec3                _FaceFront;
	UNITY_UNIFORM int                _CharacterId;
#if defined(_HAIR_SHADOW)
	UNITY_UNIFORM vec3                _HeadPosition;
#else
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_HeadPosition;
#endif
	UNITY_UNIFORM float Xhlslcc_UnusedX_RangeLimit;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HeadDotDirectionalLightValues;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Cutoff;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowThreshold;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ValueTex;
#if defined(USE_DITHER_ALPHA)
UNITY_LOCATION(3) uniform mediump sampler2D _DitherTex;
#endif
in highp vec3 vs_NORMAL0;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in mediump float vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD5;
#if defined(USE_DITHER_ALPHA)
in highp vec4 vs_TEXCOORD9;
#endif
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
#if defined(USE_DITHER_ALPHA)
vec2 u_xlat0;
#endif
mediump vec4 u_xlat16_0;
#if defined(USE_DITHER_ALPHA)
bool u_xlatb0;
mediump vec3 u_xlat16_1;
#if defined(_LAMBERT)
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
#else
vec4 u_xlat2;
mediump float u_xlat16_2;
#endif
bool u_xlatb2;
#else
#if defined(_LAMBERT)
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
#else
vec4 u_xlat1;
mediump float u_xlat16_1;
#endif
bool u_xlatb1;
mediump vec3 u_xlat16_2;
#endif
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec4 u_xlatb3;
vec3 u_xlat4;
int u_xlati4;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
vec3 u_xlat13;
#else
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat10;
int u_xlati10;
float u_xlat12;
#endif
mediump vec3 u_xlat16_14;
#if !defined(_LAMBERT)
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
int u_xlati19;
#endif
#else
vec3 u_xlat5;
#if defined(_LAMBERT)
vec3 u_xlat6;
#else
mediump vec3 u_xlat16_6;
#endif
mediump vec3 u_xlat16_7;
#if defined(_LAMBERT)
mediump vec3 u_xlat16_8;
float u_xlat11;
float u_xlat13;
mediump vec3 u_xlat16_16;
#else
float u_xlat10;
int u_xlati10;
float u_xlat12;
mediump vec3 u_xlat16_14;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
int u_xlati19;
#endif
#endif
float u_xlat20;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
mediump float u_xlat16_28;
float u_xlat29;
int u_xlati29;
float u_xlat31;
mediump float u_xlat16_32;
#else
mediump float u_xlat16_25;
float u_xlat26;
float u_xlat28;
mediump float u_xlat16_30;
#endif
#else
#if defined(_LAMBERT)
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
mediump float u_xlat16_28;
float u_xlat29;
int u_xlati29;
float u_xlat31;
mediump float u_xlat16_34;
#else
mediump float u_xlat16_25;
float u_xlat26;
float u_xlat28;
mediump float u_xlat16_30;
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat10;
vec3 u_xlat13;
#else
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat9;
int u_xlati9;
float u_xlat12;
#endif
mediump vec3 u_xlat16_14;
#if !defined(_LAMBERT)
float u_xlat17;
bool u_xlatb17;
#endif
#else
vec3 u_xlat5;
#if defined(_LAMBERT)
vec3 u_xlat6;
#else
mediump vec3 u_xlat16_6;
#endif
mediump vec3 u_xlat16_7;
#if defined(_LAMBERT)
mediump vec3 u_xlat16_8;
float u_xlat10;
float u_xlat13;
mediump vec3 u_xlat16_16;
#else
float u_xlat9;
int u_xlati9;
float u_xlat12;
mediump vec3 u_xlat16_14;
float u_xlat17;
bool u_xlatb17;
#endif
#endif
float u_xlat19;
#if defined(_LAMBERT)
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
#else
int u_xlati19;
float u_xlat20;
float u_xlat25;
mediump float u_xlat16_26;
#endif
float u_xlat28;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
int u_xlati28;
mediump float u_xlat16_29;
float u_xlat31;
mediump float u_xlat16_32;
#else
mediump float u_xlat16_30;
#endif
#else
#if defined(_LAMBERT)
int u_xlati28;
mediump float u_xlat16_29;
float u_xlat31;
mediump float u_xlat16_34;
#else
mediump float u_xlat16_30;
#endif
#endif
#endif
void main()
{
#if defined(USE_DITHER_ALPHA)
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat16_0.x = texture(_DitherTex, u_xlat0.xy, _GlobalMipBias.x).x;
    u_xlat16_1.x = (-u_xlat16_0.x) + _DitherAlpha;
    u_xlatb0 = u_xlat16_1.x<0.0;
    if(u_xlatb0){discard;}
#endif
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat16_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlati29 = _CharacterId;
    u_xlat16_1.xyz = _SekaiCharacterSpecularColorArray[u_xlati29].www * _SekaiCharacterSpecularColorArray[u_xlati29].xyz;
#else
    u_xlat16_2 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
    u_xlati10 = _CharacterId;
    u_xlat16_1.xyz = _SekaiCharacterSpecularColorArray[u_xlati10].www * _SekaiCharacterSpecularColorArray[u_xlati10].xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlati28 = _CharacterId;
    u_xlat16_2.xyz = _SekaiCharacterSpecularColorArray[u_xlati28].www * _SekaiCharacterSpecularColorArray[u_xlati28].xyz;
#else
    u_xlat16_1 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
    u_xlati9 = _CharacterId;
    u_xlat16_2.xyz = _SekaiCharacterSpecularColorArray[u_xlati9].www * _SekaiCharacterSpecularColorArray[u_xlati9].xyz;
#endif
#endif
    u_xlat16_3 = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_28 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat4.x = u_xlat16_28 + u_xlat21;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlatb4 = u_xlat4.x>=_SekaiShadowThreshold;
    u_xlat4.x = (u_xlatb4) ? 0.0 : 1.0;
    u_xlat21 = u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = _SekaiShadowThreshold>=u_xlat21;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat16_5.xyz = (-u_xlat16_0.xyz) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = vec3(u_xlat21) * u_xlat16_5.xyz + u_xlat16_0.xyz;
    u_xlat13.xyz = u_xlat16_5.xyz * _SekaiShadowColor.xyz + (-u_xlat16_0.xyz);
    u_xlat13.xyz = u_xlat4.xxx * u_xlat13.xyz + u_xlat16_0.xyz;
    u_xlat2.x = (-u_xlat16_0.x) + u_xlat16_2.x;
    u_xlat2.x = u_xlat4.x * u_xlat2.x + u_xlat16_0.x;
    u_xlat6.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat7.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_28 = u_xlat2.x + u_xlat2.x;
    u_xlat16_5.x = u_xlat2.x * 2.0 + -1.0;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#else
    u_xlat16_25 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat18 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = u_xlat18 * 0.5 + 0.5;
    u_xlat18 = u_xlat16_25 + u_xlat18;
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlatb18 = u_xlat18>=_SekaiShadowThreshold;
    u_xlat18 = (u_xlatb18) ? 0.0 : 1.0;
    u_xlat2.x = (-u_xlat16_0.x) + u_xlat16_2;
    u_xlat2.x = u_xlat18 * u_xlat2.x + u_xlat16_0.x;
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_25 = u_xlat2.x + u_xlat2.x;
    u_xlat16_6.x = u_xlat2.x * 2.0 + -1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
#if defined(_LAMBERT)
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz + u_xlat6.xyz;
    u_xlat16_28 = u_xlat16_28;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_5.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz + u_xlat7.xyz;
#else
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz + u_xlat4.xyz;
    u_xlat16_25 = u_xlat16_25;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_6.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz + u_xlat5.xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_28 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat21 = u_xlat16_28 + u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = u_xlat21>=_SekaiShadowThreshold;
    u_xlat21 = (u_xlatb21) ? 0.0 : 1.0;
    u_xlat4.xyz = u_xlat16_2.xyz * _SekaiShadowColor.xyz + (-u_xlat16_0.xyz);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz + u_xlat16_0.xyz;
    u_xlat2.x = (-u_xlat16_0.x) + u_xlat16_2.x;
    u_xlat2.x = u_xlat21 * u_xlat2.x + u_xlat16_0.x;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat6.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_28 = u_xlat2.x + u_xlat2.x;
    u_xlat16_7.x = u_xlat2.x * 2.0 + -1.0;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_16.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_16.xyz + u_xlat5.xyz;
    u_xlat16_28 = u_xlat16_28;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_7.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz + u_xlat6.xyz;
#else
    u_xlat16_25 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat18 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = u_xlat18 * 0.5 + 0.5;
    u_xlat18 = u_xlat16_25 + u_xlat18;
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlatb18 = u_xlat18>=_SekaiShadowThreshold;
    u_xlat18 = (u_xlatb18) ? 0.0 : 1.0;
    u_xlat2.x = (-u_xlat16_0.x) + u_xlat16_2;
    u_xlat2.x = u_xlat18 * u_xlat2.x + u_xlat16_0.x;
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_25 = u_xlat2.x + u_xlat2.x;
    u_xlat16_6.x = u_xlat2.x * 2.0 + -1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
    u_xlat16_14.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz + u_xlat4.xyz;
    u_xlat16_25 = u_xlat16_25;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_6.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz + u_xlat5.xyz;
#endif
#endif
    u_xlatb2 = u_xlat16_3.x>=0.5;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_28 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_5.xyz = (-u_xlat13.xyz) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz + u_xlat13.xyz;
    u_xlat2.xyz = _SekaiRimLightColorArray[u_xlati29].www * _SekaiRimLightColorArray[u_xlati29].xyz;
#else
    u_xlat16_25 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_6.xyz = (-u_xlat16_0.xyz) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat2.xzw = _SekaiRimLightColorArray[u_xlati10].www * _SekaiRimLightColorArray[u_xlati10].xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_28 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_7.xyz = (-u_xlat4.xyz) + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz + u_xlat4.xyz;
    u_xlat2.xyz = _SekaiRimLightColorArray[u_xlati29].www * _SekaiRimLightColorArray[u_xlati29].xyz;
#else
    u_xlat16_25 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_6.xyz = (-u_xlat16_0.xyz) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat2.xzw = _SekaiRimLightColorArray[u_xlati10].www * _SekaiRimLightColorArray[u_xlati10].xyz;
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_29 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat4.x = u_xlat16_29 + u_xlat21;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlatb4 = u_xlat4.x>=_SekaiShadowThreshold;
    u_xlat4.x = (u_xlatb4) ? 0.0 : 1.0;
    u_xlat21 = u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = _SekaiShadowThreshold>=u_xlat21;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat16_5.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat21) * u_xlat16_5.xyz + u_xlat16_0.xyz;
    u_xlat13.xyz = u_xlat16_5.xyz * _SekaiShadowColor.xyz + (-u_xlat16_0.xyz);
    u_xlat13.xyz = u_xlat4.xxx * u_xlat13.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat1.x = u_xlat4.x * u_xlat1.x + u_xlat16_0.x;
    u_xlat6.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat7.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_29 = u_xlat1.x + u_xlat1.x;
    u_xlat16_5.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#else
    u_xlat16_26 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat17 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat17 = u_xlat17 * 0.5 + 0.5;
    u_xlat17 = u_xlat16_26 + u_xlat17;
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
    u_xlatb17 = u_xlat17>=_SekaiShadowThreshold;
    u_xlat17 = (u_xlatb17) ? 0.0 : 1.0;
    u_xlat1.x = (-u_xlat16_0.x) + u_xlat16_1;
    u_xlat1.x = u_xlat17 * u_xlat1.x + u_xlat16_0.x;
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_26 = u_xlat1.x + u_xlat1.x;
    u_xlat16_6.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
#if defined(_LAMBERT)
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz + u_xlat6.xyz;
    u_xlat16_29 = u_xlat16_29;
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_5.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_29) * u_xlat16_5.xyz + u_xlat7.xyz;
#else
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz + u_xlat4.xyz;
    u_xlat16_26 = u_xlat16_26;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_6.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat5.xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_29 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat21 = u_xlat16_29 + u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = u_xlat21>=_SekaiShadowThreshold;
    u_xlat21 = (u_xlatb21) ? 0.0 : 1.0;
    u_xlat4.xyz = u_xlat16_1.xyz * _SekaiShadowColor.xyz + (-u_xlat16_0.xyz);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat1.x = u_xlat21 * u_xlat1.x + u_xlat16_0.x;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat6.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_29 = u_xlat1.x + u_xlat1.x;
    u_xlat16_7.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_16.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_16.xyz + u_xlat5.xyz;
    u_xlat16_29 = u_xlat16_29;
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_7.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat6.xyz;
#else
    u_xlat16_26 = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat17 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat17 = u_xlat17 * 0.5 + 0.5;
    u_xlat17 = u_xlat16_26 + u_xlat17;
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
    u_xlatb17 = u_xlat17>=_SekaiShadowThreshold;
    u_xlat17 = (u_xlatb17) ? 0.0 : 1.0;
    u_xlat1.x = (-u_xlat16_0.x) + u_xlat16_1;
    u_xlat1.x = u_xlat17 * u_xlat1.x + u_xlat16_0.x;
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_26 = u_xlat1.x + u_xlat1.x;
    u_xlat16_6.x = u_xlat1.x * 2.0 + -1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
    u_xlat16_14.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz + u_xlat4.xyz;
    u_xlat16_26 = u_xlat16_26;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_6.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat5.xyz;
#endif
#endif
    u_xlatb1 = u_xlat16_3.x>=0.5;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_29 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_5.xyz = (-u_xlat13.xyz) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_29) * u_xlat16_5.xyz + u_xlat13.xyz;
    u_xlat1.xyz = _SekaiRimLightColorArray[u_xlati28].www * _SekaiRimLightColorArray[u_xlati28].xyz;
#else
    u_xlat16_26 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_6.xyz = (-u_xlat16_0.xyz) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat1.xzw = _SekaiRimLightColorArray[u_xlati9].www * _SekaiRimLightColorArray[u_xlati9].xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_29 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_7.xyz = (-u_xlat4.xyz) + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat4.xyz;
    u_xlat1.xyz = _SekaiRimLightColorArray[u_xlati28].www * _SekaiRimLightColorArray[u_xlati28].xyz;
#else
    u_xlat16_26 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_6.xyz = (-u_xlat16_0.xyz) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat1.xzw = _SekaiRimLightColorArray[u_xlati9].www * _SekaiRimLightColorArray[u_xlati9].xyz;
#endif
#endif
#endif
    u_xlat3.x = dot(vs_NORMAL0.xyz, vs_TEXCOORD4.xyz);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat3.z = dot(vs_TEXCOORD4.xyz, _SekaiRimLightArray[u_xlati29].xyz);
#else
    u_xlat3.z = dot(vs_TEXCOORD4.xyz, _SekaiRimLightArray[u_xlati10].xyz);
#endif
#else
#if defined(_LAMBERT)
    u_xlat3.z = dot(vs_TEXCOORD4.xyz, _SekaiRimLightArray[u_xlati28].xyz);
#else
    u_xlat3.z = dot(vs_TEXCOORD4.xyz, _SekaiRimLightArray[u_xlati9].xyz);
#endif
#endif
    u_xlat4.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_NORMAL0.xyz;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati29].xyz, _SekaiRimLightArray[u_xlati29].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat6.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati29].xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat16_28 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati29];
    u_xlat16_32 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati29]);
    u_xlat13.x = (-u_xlat16_28) + u_xlat16_32;
    u_xlat22 = (-u_xlat16_28) + u_xlat4.x;
    u_xlat13.x = float(1.0) / u_xlat13.x;
    u_xlat13.x = u_xlat13.x * u_xlat22;
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
    u_xlat22 = u_xlat13.x * -2.0 + 3.0;
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat13.x = u_xlat13.x * u_xlat22;
    u_xlat6.xyz = _SekaiShadowRimLightColorArray[u_xlati29].xyz * _SekaiShadowRimLightColorArray[u_xlati29].www + (-u_xlat2.xyz);
    u_xlat2.xyz = u_xlat13.xxx * u_xlat6.xyz + u_xlat2.xyz;
#else
    u_xlat28 = dot(_SekaiRimLightArray[u_xlati10].xyz, _SekaiRimLightArray[u_xlati10].xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = vec3(u_xlat28) * _SekaiRimLightArray[u_xlati10].xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat16_25 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati10];
    u_xlat16_30 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati10]);
    u_xlat12 = (-u_xlat16_25) + u_xlat16_30;
    u_xlat20 = (-u_xlat16_25) + u_xlat4.x;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat20 = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati10].xyz * _SekaiShadowRimLightColorArray[u_xlati10].www + (-u_xlat2.xzw);
    u_xlat2.xzw = vec3(u_xlat12) * u_xlat5.xyz + u_xlat2.xzw;
#endif
#else
#if defined(_LAMBERT)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati29].xyz, _SekaiRimLightArray[u_xlati29].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat5.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati29].xyz;
#else
    u_xlat28 = dot(_SekaiRimLightArray[u_xlati10].xyz, _SekaiRimLightArray[u_xlati10].xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = vec3(u_xlat28) * _SekaiRimLightArray[u_xlati10].xyz;
#endif
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat5.xyz);
#if defined(_LAMBERT)
    u_xlat16_28 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati29];
    u_xlat16_34 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati29]);
    u_xlat13 = (-u_xlat16_28) + u_xlat16_34;
    u_xlat22 = (-u_xlat16_28) + u_xlat4.x;
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22;
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
    u_xlat22 = u_xlat13 * -2.0 + 3.0;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati29].xyz * _SekaiShadowRimLightColorArray[u_xlati29].www + (-u_xlat2.xyz);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat5.xyz + u_xlat2.xyz;
#else
    u_xlat16_25 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati10];
    u_xlat16_30 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati10]);
    u_xlat12 = (-u_xlat16_25) + u_xlat16_30;
    u_xlat20 = (-u_xlat16_25) + u_xlat4.x;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat20 = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati10].xyz * _SekaiShadowRimLightColorArray[u_xlati10].www + (-u_xlat2.xzw);
    u_xlat2.xzw = vec3(u_xlat12) * u_xlat5.xyz + u_xlat2.xzw;
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati28].xyz, _SekaiRimLightArray[u_xlati28].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat6.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati28].xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat16_29 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati28];
    u_xlat16_32 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati28]);
    u_xlat13.x = (-u_xlat16_29) + u_xlat16_32;
    u_xlat22 = (-u_xlat16_29) + u_xlat4.x;
    u_xlat13.x = float(1.0) / u_xlat13.x;
    u_xlat13.x = u_xlat13.x * u_xlat22;
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
    u_xlat22 = u_xlat13.x * -2.0 + 3.0;
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat13.x = u_xlat13.x * u_xlat22;
    u_xlat6.xyz = _SekaiShadowRimLightColorArray[u_xlati28].xyz * _SekaiShadowRimLightColorArray[u_xlati28].www + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat13.xxx * u_xlat6.xyz + u_xlat1.xyz;
#else
    u_xlat28 = dot(_SekaiRimLightArray[u_xlati9].xyz, _SekaiRimLightArray[u_xlati9].xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = vec3(u_xlat28) * _SekaiRimLightArray[u_xlati9].xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat16_26 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati9];
    u_xlat16_30 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati9]);
    u_xlat12 = (-u_xlat16_26) + u_xlat16_30;
    u_xlat20 = (-u_xlat16_26) + u_xlat4.x;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat20 = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati9].xyz * _SekaiShadowRimLightColorArray[u_xlati9].www + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat12) * u_xlat5.xyz + u_xlat1.xzw;
#endif
#else
#if defined(_LAMBERT)
    u_xlat31 = dot(_SekaiRimLightArray[u_xlati28].xyz, _SekaiRimLightArray[u_xlati28].xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat5.xyz = vec3(u_xlat31) * _SekaiRimLightArray[u_xlati28].xyz;
#else
    u_xlat28 = dot(_SekaiRimLightArray[u_xlati9].xyz, _SekaiRimLightArray[u_xlati9].xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = vec3(u_xlat28) * _SekaiRimLightArray[u_xlati9].xyz;
#endif
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat5.xyz);
#if defined(_LAMBERT)
    u_xlat16_29 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati28];
    u_xlat16_34 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati28]);
    u_xlat13 = (-u_xlat16_29) + u_xlat16_34;
    u_xlat22 = (-u_xlat16_29) + u_xlat4.x;
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22;
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
    u_xlat22 = u_xlat13 * -2.0 + 3.0;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat22;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati28].xyz * _SekaiShadowRimLightColorArray[u_xlati28].www + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat5.xyz + u_xlat1.xyz;
#else
    u_xlat16_26 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati9];
    u_xlat16_30 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati9]);
    u_xlat12 = (-u_xlat16_26) + u_xlat16_30;
    u_xlat20 = (-u_xlat16_26) + u_xlat4.x;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat20 = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat20;
    u_xlat5.xyz = _SekaiShadowRimLightColorArray[u_xlati9].xyz * _SekaiShadowRimLightColorArray[u_xlati9].www + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat12) * u_xlat5.xyz + u_xlat1.xzw;
#endif
#endif
#endif
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlat3.x = (-u_xlat3.x) + 1.0;
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat16_28 = 10.0 + (-_SekaiRimLightFactor[u_xlati29].x);
#else
    u_xlat16_25 = 10.0 + (-_SekaiRimLightFactor[u_xlati10].x);
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_29 = 10.0 + (-_SekaiRimLightFactor[u_xlati28].x);
#else
    u_xlat16_26 = 10.0 + (-_SekaiRimLightFactor[u_xlati9].x);
#endif
#endif
    u_xlat3.x = log2(u_xlat3.x);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat16_28 * u_xlat3.x;
#else
    u_xlat3.x = u_xlat16_25 * u_xlat3.x;
#endif
#else
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat16_29 * u_xlat3.x;
#else
    u_xlat3.x = u_xlat16_26 * u_xlat3.x;
#endif
#endif
    u_xlat3.x = exp2(u_xlat3.x);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat21 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati29].w * u_xlat21 + u_xlat3.x;
    u_xlat21 = (-u_xlat4.x) + 0.0500000007;
    u_xlati4 = int((0.0<u_xlat21) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = int((u_xlat21<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = (-u_xlati4) + u_xlati21;
    u_xlat21 = float(u_xlati21);
    u_xlat21 = u_xlat3.x * u_xlat21 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati29].w * u_xlat21 + u_xlat3.x;
#else
    u_xlat19 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati10].w * u_xlat19 + u_xlat3.x;
    u_xlat19 = (-u_xlat4.x) + 0.0500000007;
    u_xlati4 = int((0.0<u_xlat19) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = int((u_xlat19<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = (-u_xlati4) + u_xlati19;
    u_xlat19 = float(u_xlati19);
    u_xlat19 = u_xlat3.x * u_xlat19 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati10].w * u_xlat19 + u_xlat3.x;
#endif
#else
#if defined(_LAMBERT)
    u_xlat21 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati28].w * u_xlat21 + u_xlat3.x;
    u_xlat21 = (-u_xlat4.x) + 0.0500000007;
    u_xlati4 = int((0.0<u_xlat21) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = int((u_xlat21<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati21 = (-u_xlati4) + u_xlati21;
    u_xlat21 = float(u_xlati21);
    u_xlat21 = u_xlat3.x * u_xlat21 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati28].w * u_xlat21 + u_xlat3.x;
#else
    u_xlat19 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati9].w * u_xlat19 + u_xlat3.x;
    u_xlat19 = (-u_xlat4.x) + 0.0500000007;
    u_xlati4 = int((0.0<u_xlat19) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = int((u_xlat19<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = (-u_xlati4) + u_xlati19;
    u_xlat19 = float(u_xlati19);
    u_xlat19 = u_xlat3.x * u_xlat19 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati9].w * u_xlat19 + u_xlat3.x;
#endif
#endif
    u_xlat3.x = u_xlat3.x + (-_RimThreshold);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat21 = float(1.0) / _SekaiRimLightFactor[u_xlati29].z;
    u_xlat3.x = u_xlat21 * u_xlat3.x;
#else
    u_xlat19 = float(1.0) / _SekaiRimLightFactor[u_xlati10].z;
    u_xlat3.x = u_xlat19 * u_xlat3.x;
#endif
#else
#if defined(_LAMBERT)
    u_xlat21 = float(1.0) / _SekaiRimLightFactor[u_xlati28].z;
    u_xlat3.x = u_xlat21 * u_xlat3.x;
#else
    u_xlat19 = float(1.0) / _SekaiRimLightFactor[u_xlati9].z;
    u_xlat3.x = u_xlat19 * u_xlat3.x;
#endif
#endif
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#if defined(_LAMBERT)
    u_xlat21 = u_xlat3.x * -2.0 + 3.0;
#else
    u_xlat19 = u_xlat3.x * -2.0 + 3.0;
#endif
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
#if defined(USE_DITHER_ALPHA)
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat3.x * u_xlat21;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat2.xyz * vs_COLOR0.yyy;
    u_xlat16_5.xyz = u_xlat2.xyz * vs_COLOR0.yyy + u_xlat16_5.xyz;
    u_xlat2.xyz = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
#else
    u_xlat3.x = u_xlat3.x * u_xlat19;
    u_xlat2.xzw = u_xlat2.xzw * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat2.xzw * vs_COLOR0.yyy;
    u_xlat16_6.xyz = u_xlat2.xzw * vs_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat2.xzw = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat2.xzw, u_xlat2.xzw);
#endif
#else
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat3.x * u_xlat21;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat2.xyz * vs_COLOR0.yyy;
    u_xlat16_7.xyz = u_xlat2.xyz * vs_COLOR0.yyy + u_xlat16_7.xyz;
    u_xlat2.xyz = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
#else
    u_xlat3.x = u_xlat3.x * u_xlat19;
    u_xlat2.xzw = u_xlat2.xzw * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat2.xzw * vs_COLOR0.yyy;
    u_xlat16_6.xyz = u_xlat2.xzw * vs_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat2.xzw = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat2.xzw, u_xlat2.xzw);
#endif
#endif
#else
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat3.x * u_xlat21;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat16_5.xyz = u_xlat1.xyz * vs_COLOR0.yyy + u_xlat16_5.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
#else
    u_xlat3.x = u_xlat3.x * u_xlat19;
    u_xlat1.xzw = u_xlat1.xzw * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat1.xzw * vs_COLOR0.yyy;
    u_xlat16_6.xyz = u_xlat1.xzw * vs_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat1.xzw = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat1.xzw, u_xlat1.xzw);
#endif
#else
#if defined(_LAMBERT)
    u_xlat3.x = u_xlat3.x * u_xlat21;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat16_7.xyz = u_xlat1.xyz * vs_COLOR0.yyy + u_xlat16_7.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
#else
    u_xlat3.x = u_xlat3.x * u_xlat19;
    u_xlat1.xzw = u_xlat1.xzw * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat1.xzw * vs_COLOR0.yyy;
    u_xlat16_6.xyz = u_xlat1.xzw * vs_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat1.xzw = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat3.x = dot(u_xlat1.xzw, u_xlat1.xzw);
#endif
#endif
#endif
    u_xlat3.x = inversesqrt(u_xlat3.x);
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xxx;
    u_xlat2.x = dot(u_xlat2.xyz, vs_NORMAL0.xyz);
#else
    u_xlat2.xzw = u_xlat2.xzw * u_xlat3.xxx;
    u_xlat2.x = dot(u_xlat2.xzw, vs_NORMAL0.xyz);
#endif
    u_xlat2.x = max(u_xlat2.x, 0.0);
#if defined(_LAMBERT)
    u_xlat11 = 10.0 / _SpecularPower;
#else
    u_xlat18 = 10.0 / _SpecularPower;
#endif
    u_xlat2.x = log2(u_xlat2.x);
#if defined(_LAMBERT)
    u_xlat2.x = u_xlat2.x * u_xlat11;
#else
    u_xlat2.x = u_xlat2.x * u_xlat18;
#endif
    u_xlat2.x = exp2(u_xlat2.x);
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xxx;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat16_3.www + u_xlat16_5.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat2.xxyz, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#else
    u_xlat2.xzw = u_xlat16_1.xyz * u_xlat2.xxx;
    u_xlat2.xzw = u_xlat2.xzw * u_xlat16_3.www + u_xlat16_6.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat2.xxzw, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#endif
#else
#if defined(_LAMBERT)
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xxx;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat16_3.www + u_xlat16_7.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat2.xxyz, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#else
    u_xlat2.xzw = u_xlat16_1.xyz * u_xlat2.xxx;
    u_xlat2.xzw = u_xlat2.xzw * u_xlat16_3.www + u_xlat16_6.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat2.xxzw, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#endif
#endif
    u_xlat16_1.x = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_1.y = (u_xlatb3.z) ? float(1.0) : float(0.0);
    u_xlat16_1.z = (u_xlatb3.w) ? float(1.0) : float(0.0);
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_5.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xzw = u_xlat16_5.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati29].xyz;
    u_xlat16_8.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati29].xyz);
    u_xlat2.xyz = (-u_xlat16_8.xyz) * u_xlat2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati29].xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + u_xlat3.xzw;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati29]);
    u_xlat3.xzw = u_xlat2.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat2.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#else
    u_xlat16_6.xyz = u_xlat2.xzw + u_xlat2.xzw;
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz;
    u_xlat16_7.xyz = (-u_xlat2.xzw) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_7.xyz;
    u_xlat2.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati10].xyz);
    u_xlat2.xzw = (-u_xlat16_7.xyz) * u_xlat2.xzw + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz + u_xlat2.xzw;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + u_xlat3.xzw;
    u_xlat2.xzw = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati10]);
    u_xlat3.xzw = u_xlat2.xzw * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat2.xzw) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_7.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xzw = u_xlat16_7.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati29].xyz;
    u_xlat16_8.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati29].xyz);
    u_xlat2.xyz = (-u_xlat16_8.xyz) * u_xlat2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati29].xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat3.xzw;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati29]);
    u_xlat3.xzw = u_xlat2.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat2.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#else
    u_xlat16_6.xyz = u_xlat2.xzw + u_xlat2.xzw;
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz;
    u_xlat16_7.xyz = (-u_xlat2.xzw) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_7.xyz;
    u_xlat2.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati10].xyz);
    u_xlat2.xzw = (-u_xlat16_7.xyz) * u_xlat2.xzw + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati10].xyz + u_xlat2.xzw;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + u_xlat3.xzw;
    u_xlat2.xzw = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati10]);
    u_xlat3.xzw = u_xlat2.xzw * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat2.xzw) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#endif
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_5.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
#else
    u_xlat16_6.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_6.xyz + u_xlat16_1.xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_7.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_7.xyz + u_xlat16_1.xyz;
#else
    u_xlat16_6.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_6.xyz + u_xlat16_1.xyz;
#endif
#endif
    u_xlatb2 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb2){
#if defined(_LAMBERT)
        u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat2.xy = u_xlat2.xy * u_xlat2.xy;
        u_xlat2.x = u_xlat2.y + u_xlat2.x;
        u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
        u_xlat11 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat2.xzw = (-vs_TEXCOORD5.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat2.xz = u_xlat2.xz * u_xlat2.xz;
        u_xlat2.x = u_xlat2.z + u_xlat2.x;
        u_xlat2.x = u_xlat2.w * u_xlat2.w + u_xlat2.x;
        u_xlat18 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
        u_xlat2.x = u_xlat2.x + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(_LAMBERT)
        u_xlat11 = float(1.0) / u_xlat11;
        u_xlat2.x = u_xlat11 * u_xlat2.x;
#else
        u_xlat18 = float(1.0) / u_xlat18;
        u_xlat2.x = u_xlat18 * u_xlat2.x;
#endif
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#if defined(_LAMBERT)
        u_xlat11 = u_xlat2.x * -2.0 + 3.0;
#else
        u_xlat18 = u_xlat2.x * -2.0 + 3.0;
#endif
        u_xlat2.x = u_xlat2.x * u_xlat2.x;
#if defined(_LAMBERT)
        u_xlat20 = u_xlat2.x * u_xlat11;
        u_xlat2.x = (-u_xlat11) * u_xlat2.x + 1.0;
        u_xlat3.xzw = u_xlat16_1.xyz * vec3(u_xlat20);
#else
        u_xlat26 = u_xlat2.x * u_xlat18;
        u_xlat2.x = (-u_xlat18) * u_xlat2.x + 1.0;
        u_xlat3.xzw = u_xlat16_1.xyz * vec3(u_xlat26);
#endif
#else
#if defined(_LAMBERT)
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat1.x = dot(u_xlat1.xyz, vs_NORMAL0.xyz);
#else
    u_xlat1.xzw = u_xlat1.xzw * u_xlat3.xxx;
    u_xlat1.x = dot(u_xlat1.xzw, vs_NORMAL0.xyz);
#endif
    u_xlat1.x = max(u_xlat1.x, 0.0);
#if defined(_LAMBERT)
    u_xlat10 = 10.0 / _SpecularPower;
#else
    u_xlat17 = 10.0 / _SpecularPower;
#endif
    u_xlat1.x = log2(u_xlat1.x);
#if defined(_LAMBERT)
    u_xlat1.x = u_xlat1.x * u_xlat10;
#else
    u_xlat1.x = u_xlat1.x * u_xlat17;
#endif
    u_xlat1.x = exp2(u_xlat1.x);
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat1.xyz = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_3.www + u_xlat16_5.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat1.xxyz, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#else
    u_xlat1.xzw = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat1.xzw = u_xlat1.xzw * u_xlat16_3.www + u_xlat16_6.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat1.xxzw, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#endif
#else
#if defined(_LAMBERT)
    u_xlat1.xyz = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_3.www + u_xlat16_7.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat1.xxyz, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#else
    u_xlat1.xzw = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat1.xzw = u_xlat1.xzw * u_xlat16_3.www + u_xlat16_6.xyz;
    u_xlatb3.xzw = greaterThanEqual(u_xlat1.xxzw, vec4(0.5, 0.0, 0.5, 0.5)).xzw;
#endif
#endif
    u_xlat16_2.x = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb3.z) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb3.w) ? float(1.0) : float(0.0);
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_5.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat3.xzw = u_xlat16_5.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati28].xyz;
    u_xlat16_8.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_8.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati28].xyz);
    u_xlat1.xyz = (-u_xlat16_8.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati28].xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + u_xlat3.xzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati28]);
    u_xlat3.xzw = u_xlat1.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat1.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#else
    u_xlat16_6.xyz = u_xlat1.xzw + u_xlat1.xzw;
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati9].xyz;
    u_xlat16_7.xyz = (-u_xlat1.xzw) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_7.xyz;
    u_xlat1.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati9].xyz);
    u_xlat1.xzw = (-u_xlat16_7.xyz) * u_xlat1.xzw + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati9].xyz + u_xlat1.xzw;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz + u_xlat3.xzw;
    u_xlat1.xzw = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati9]);
    u_xlat3.xzw = u_xlat1.xzw * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat1.xzw) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_7.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat3.xzw = u_xlat16_7.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati28].xyz;
    u_xlat16_8.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_8.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati28].xyz);
    u_xlat1.xyz = (-u_xlat16_8.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati28].xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz + u_xlat3.xzw;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati28]);
    u_xlat3.xzw = u_xlat1.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat1.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#else
    u_xlat16_6.xyz = u_xlat1.xzw + u_xlat1.xzw;
    u_xlat3.xzw = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati9].xyz;
    u_xlat16_7.xyz = (-u_xlat1.xzw) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_7.xyz;
    u_xlat1.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati9].xyz);
    u_xlat1.xzw = (-u_xlat16_7.xyz) * u_xlat1.xzw + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati9].xyz + u_xlat1.xzw;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz + u_xlat3.xzw;
    u_xlat1.xzw = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati9]);
    u_xlat3.xzw = u_xlat1.xzw * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat1.xzw) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
#endif
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
#if defined(_HAIR_SHADOW)
#if defined(_LAMBERT)
    u_xlat16_5.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_5.xyz + u_xlat16_2.xyz;
#else
    u_xlat16_6.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_6.xyz + u_xlat16_2.xyz;
#endif
#else
#if defined(_LAMBERT)
    u_xlat16_7.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_7.xyz + u_xlat16_2.xyz;
#else
    u_xlat16_6.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat3.xzw * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_6.xyz + u_xlat16_2.xyz;
#endif
#endif
    u_xlatb1 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb1){
#if defined(_LAMBERT)
        u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xy = u_xlat1.xy * u_xlat1.xy;
        u_xlat1.x = u_xlat1.y + u_xlat1.x;
        u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
        u_xlat10 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat1.xzw = (-vs_TEXCOORD5.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xz = u_xlat1.xz * u_xlat1.xz;
        u_xlat1.x = u_xlat1.z + u_xlat1.x;
        u_xlat1.x = u_xlat1.w * u_xlat1.w + u_xlat1.x;
        u_xlat17 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
        u_xlat1.x = u_xlat1.x + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(_LAMBERT)
        u_xlat10 = float(1.0) / u_xlat10;
        u_xlat1.x = u_xlat10 * u_xlat1.x;
#else
        u_xlat17 = float(1.0) / u_xlat17;
        u_xlat1.x = u_xlat17 * u_xlat1.x;
#endif
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#if defined(_LAMBERT)
        u_xlat10 = u_xlat1.x * -2.0 + 3.0;
#else
        u_xlat17 = u_xlat1.x * -2.0 + 3.0;
#endif
        u_xlat1.x = u_xlat1.x * u_xlat1.x;
#if defined(_LAMBERT)
        u_xlat19 = u_xlat1.x * u_xlat10;
        u_xlat1.x = (-u_xlat10) * u_xlat1.x + 1.0;
        u_xlat3.xzw = u_xlat16_2.xyz * vec3(u_xlat19);
#else
        u_xlat25 = u_xlat1.x * u_xlat17;
        u_xlat1.x = (-u_xlat17) * u_xlat1.x + 1.0;
        u_xlat3.xzw = u_xlat16_2.xyz * vec3(u_xlat25);
#endif
#endif
        u_xlat3.xzw = u_xlat3.xzw * _SekaiGlobalSpotLightColor.xyz;
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
        u_xlat2.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat3.xzw;
#else
        u_xlat2.xzw = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat3.xzw;
#endif
#else
#if defined(_LAMBERT)
        u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat3.xzw;
#else
        u_xlat1.xzw = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat3.xzw;
#endif
#endif
    } else {
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
        u_xlat2.xyz = u_xlat16_1.xyz;
#else
        u_xlat2.xzw = u_xlat16_1.xyz;
#endif
#else
#if defined(_LAMBERT)
        u_xlat1.xyz = u_xlat16_2.xyz;
#else
        u_xlat1.xzw = u_xlat16_2.xyz;
#endif
#endif
    }
#if defined(USE_DITHER_ALPHA)
#if defined(_LAMBERT)
    u_xlat3.xzw = u_xlat4.xyz * _SekaiRimLightFactor[u_xlati29].yyy;
    u_xlat3.xyz = u_xlat2.xyz * u_xlat16_3.yyy + u_xlat3.xzw;
#else
    u_xlat3.xzw = u_xlat4.xyz * _SekaiRimLightFactor[u_xlati10].yyy;
    u_xlat3.xyz = u_xlat2.xzw * u_xlat16_3.yyy + u_xlat3.xzw;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD6) + 1.0;
#if defined(_LAMBERT)
    u_xlat29 = u_xlat16_1.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat2.xyz) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat29) * u_xlat4.xyz + u_xlat2.xyz;
#else
    u_xlat10 = u_xlat16_1.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat2.xzw) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat10) * u_xlat4.xyz + u_xlat2.xzw;
#endif
    u_xlat2.x = vs_TEXCOORD7 / vs_TEXCOORD0.w;
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
#if defined(_LAMBERT)
    u_xlat11 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat11 = u_xlat11 + -1.0;
    u_xlat11 = u_xlat11 * _ProjectionParams.w;
    u_xlat2.x = u_xlat11 * u_xlat2.x + _ProjectionParams.w;
#else
    u_xlat10 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat10 = u_xlat10 + -1.0;
    u_xlat10 = u_xlat10 * _ProjectionParams.w;
    u_xlat2.x = u_xlat10 * u_xlat2.x + _ProjectionParams.w;
#endif
    u_xlat2.x = (-_CoCParams.x) * u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * _CoCParams.y;
#if defined(_LAMBERT)
    u_xlat11 = u_xlat2.x;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#else
    u_xlat10 = u_xlat2.x;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat2.x = max(u_xlat2.x, -1.0);
    u_xlat2.x = min(u_xlat2.x, 0.0);
#if defined(_LAMBERT)
    u_xlat2.x = u_xlat2.x + u_xlat11;
#else
    u_xlat2.x = u_xlat2.x + u_xlat10;
#endif
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
#else
#if defined(_LAMBERT)
    u_xlat3.xzw = u_xlat4.xyz * _SekaiRimLightFactor[u_xlati28].yyy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat16_3.yyy + u_xlat3.xzw;
#else
    u_xlat3.xzw = u_xlat4.xyz * _SekaiRimLightFactor[u_xlati9].yyy;
    u_xlat3.xyz = u_xlat1.xzw * u_xlat16_3.yyy + u_xlat3.xzw;
#endif
    u_xlat16_2.x = (-vs_TEXCOORD6) + 1.0;
#if defined(_LAMBERT)
    u_xlat28 = u_xlat16_2.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat1.xyz) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat28) * u_xlat4.xyz + u_xlat1.xyz;
#else
    u_xlat9 = u_xlat16_2.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat1.xzw) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat9) * u_xlat4.xyz + u_xlat1.xzw;
#endif
    u_xlat1.x = vs_TEXCOORD7 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
#if defined(_LAMBERT)
    u_xlat10 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat10 = u_xlat10 + -1.0;
    u_xlat10 = u_xlat10 * _ProjectionParams.w;
    u_xlat1.x = u_xlat10 * u_xlat1.x + _ProjectionParams.w;
#else
    u_xlat9 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9 = u_xlat9 + -1.0;
    u_xlat9 = u_xlat9 * _ProjectionParams.w;
    u_xlat1.x = u_xlat9 * u_xlat1.x + _ProjectionParams.w;
#endif
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
#if defined(_LAMBERT)
    u_xlat10 = u_xlat1.x;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#else
    u_xlat9 = u_xlat1.x;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, -1.0);
    u_xlat1.x = min(u_xlat1.x, 0.0);
#if defined(_LAMBERT)
    u_xlat1.x = u_xlat1.x + u_xlat10;
#else
    u_xlat1.x = u_xlat1.x + u_xlat9;
#endif
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * 0.5;
#endif
    SV_Target0 = u_xlat16_0;
#if defined(USE_DITHER_ALPHA)
    SV_Target1.x = u_xlat2.x;
#else
    SV_Target1.x = u_xlat1.x;
#endif
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2.xyz = u_xlat3.xyz;
    SV_Target2.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "Eyelash"
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="SekaiEyelash" "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
			Blend SrcAlpha OneMinusSrcAlpha, Zero One
			ZTest Always
			ZWrite Off
			Stencil
			{
				Ref [_EyelashStencil]
				ReadMask [_EyelashReadMask]
				WriteMask [_EyelashWriteMask]
				Comp [_EyelashStencilComp]
				Pass [_EyelashStencilOp]
				Fail [_EyelashStencilFail]
				ZFail [_EyelashStencilZFail]
			}
			GLSLPROGRAM
#pragma multi_compile _ USE_DITHER_ALPHA
#pragma multi_compile _ _FACE_SHADOW_RANGE_LIMIT
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
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_FaceShadowTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineOffset;
	UNITY_UNIFORM float                _SpecularPower;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HeadNormalBlend;
	UNITY_UNIFORM mediump float                _EyelashTransparent;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump float                _IsLeftEyeClose;
	UNITY_UNIFORM mediump float                _IsRightEyeClose;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM vec3                _FaceFront;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_HeadPosition;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RangeLimit;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HeadDotDirectionalLightValues;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Cutoff;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowThreshold;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out mediump float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD4;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD5;
#if defined(USE_DITHER_ALPHA)
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
#else
vec3 u_xlat0;
#endif
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
#if defined(USE_DITHER_ALPHA)
vec3 u_xlat4;
float u_xlat5;
float u_xlat7;
mediump float u_xlat16_8;
float u_xlat15;
bool u_xlatb15;
float u_xlat17;
#else
float u_xlat4;
float u_xlat6;
mediump float u_xlat16_7;
float u_xlat12;
bool u_xlatb12;
float u_xlat14;
#endif
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat1;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
#if defined(USE_DITHER_ALPHA)
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = max(u_xlat15, 1.17549435e-38);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
#else
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = max(u_xlat12, 1.17549435e-38);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
#endif
    vs_NORMAL0.xyz = u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlatb15 = 0.0>=in_POSITION0.y;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
#else
    u_xlatb12 = 0.0>=in_POSITION0.y;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
#endif
    u_xlat2.x = (-in_COLOR0.w) + 1.0;
    u_xlat2.xy = vec2(_IsRightEyeClose, _IsLeftEyeClose) * u_xlat2.xx + in_COLOR0.ww;
#if defined(USE_DITHER_ALPHA)
    u_xlat7 = (-u_xlat2.x) + u_xlat2.y;
    u_xlat15 = u_xlat15 * u_xlat7 + u_xlat2.x;
#else
    u_xlat6 = (-u_xlat2.x) + u_xlat2.y;
    u_xlat12 = u_xlat12 * u_xlat6 + u_xlat2.x;
#endif
    u_xlat16_3 = (-_EyelashFaceCameraEdge2) + _EyelashFaceCameraEdge1;
    u_xlat16_3 = float(1.0) / u_xlat16_3;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
#if defined(USE_DITHER_ALPHA)
    u_xlat17 = dot(u_xlat2.xyz, vec3(_FaceFront.x, _FaceFront.y, _FaceFront.z));
    u_xlat16_8 = u_xlat17 + (-_EyelashFaceCameraEdge2);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
#else
    u_xlat14 = dot(u_xlat2.xyz, vec3(_FaceFront.x, _FaceFront.y, _FaceFront.z));
    u_xlat16_7 = u_xlat14 + (-_EyelashFaceCameraEdge2);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
#endif
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
#else
    u_xlat16_7 = u_xlat16_3 * -2.0 + 3.0;
#endif
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
    u_xlat15 = u_xlat15 * u_xlat16_3;
    vs_TEXCOORD2 = u_xlat15 * _EyelashTransparent;
#else
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat12 = u_xlat12 * u_xlat16_3;
    vs_TEXCOORD2 = u_xlat12 * _EyelashTransparent;
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy;
#if defined(USE_DITHER_ALPHA)
    u_xlat4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
#else
    u_xlat1.xyw = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlatb0 = unity_OrthoParams.w==0.0;
#if defined(USE_DITHER_ALPHA)
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat4.xyz : u_xlat2.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.xyz = vec3(u_xlat15) * u_xlat0.xyz;
#else
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat1.xyw : u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat0.xyz;
#endif
    vs_TEXCOORD7 = u_xlat1.z;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
#if defined(USE_DITHER_ALPHA)
    u_xlat5 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat5;
#else
    u_xlat4 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat4;
#endif
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD6 = u_xlat0.x;
#if defined(USE_DITHER_ALPHA)
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
#endif
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
uniform 	vec2 _GlobalMipBias;
#if defined(USE_DITHER_ALPHA)
uniform 	vec4 _ScreenParams;
#endif
uniform 	vec4 _SekaiDirectionalLight;
uniform 	mediump vec4 _SekaiShadowColor;
uniform 	mediump float _SekaiShadowThreshold;
uniform 	mediump vec4 _SekaiCharacterSpecularColorArray[10];
#if defined(USE_DITHER_ALPHA)
uniform 	mediump float _DitherAlpha;
#endif
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiCharacterAmbientLightIntensityArray[12];
uniform 	vec4 _SekaiCharacterAmbientLightColorArray[12];
uniform 	vec4 _SekaiRimLightArray[12];
uniform 	vec4 _SekaiRimLightColorArray[12];
uniform 	vec4 _SekaiShadowRimLightColorArray[12];
uniform 	mediump vec4 _SekaiRimLightFactor[12];
uniform 	mediump float _SekaiRimLightShadowSharpnessArray[12];
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
uniform 	vec4 _SekaiFogColor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_FaceShadowTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineOffset;
	UNITY_UNIFORM float                _SpecularPower;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HeadNormalBlend;
	UNITY_UNIFORM mediump float                _EyelashTransparent;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump float                _IsLeftEyeClose;
	UNITY_UNIFORM mediump float                _IsRightEyeClose;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM vec3                _FaceFront;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_HeadPosition;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RangeLimit;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HeadDotDirectionalLightValues;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Cutoff;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowThreshold;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ValueTex;
UNITY_LOCATION(3) uniform mediump sampler2D _EyelashMaskTex;
#if defined(USE_DITHER_ALPHA)
UNITY_LOCATION(4) uniform mediump sampler2D _DitherTex;
#endif
in highp vec3 vs_NORMAL0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in mediump float vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
#if defined(USE_DITHER_ALPHA)
in highp vec4 vs_TEXCOORD9;
#endif
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
#if defined(USE_DITHER_ALPHA)
mediump float u_xlat16_1;
#endif
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
int u_xlati3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
int u_xlati11;
bvec3 u_xlatb11;
vec3 u_xlat12;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat19;
int u_xlati19;
bool u_xlatb19;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
mediump float u_xlat16_26;
mediump float u_xlat16_30;
void main()
{
#if defined(USE_DITHER_ALPHA)
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat16_0.x = texture(_DitherTex, u_xlat0.xy, _GlobalMipBias.x).x;
    u_xlat16_1 = (-u_xlat16_0.x) + _DitherAlpha;
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
#endif
    u_xlat16_0.x = texture(_EyelashMaskTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
    u_xlat1.w = u_xlat16_0.x * vs_TEXCOORD2;
    u_xlat16_2.x = vs_TEXCOORD2 * u_xlat16_0.x + -0.00100000005;
    u_xlatb0 = u_xlat16_2.x<0.0;
    if(u_xlatb0){discard;}
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_24 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
    u_xlati3 = _CharacterId;
    u_xlat16_2.xyz = _SekaiCharacterSpecularColorArray[u_xlati3].www * _SekaiCharacterSpecularColorArray[u_xlati3].xyz;
    u_xlat16_11.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xzw;
    u_xlat16_26 = u_xlat16_11.y * 2.0 + -1.0;
    u_xlat19 = dot(_SekaiDirectionalLight.xyz, vs_TEXCOORD3.xyz);
    u_xlat19 = u_xlat19 * 0.5 + 0.5;
    u_xlat19 = u_xlat16_26 + u_xlat19;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlatb19 = u_xlat19>=_SekaiShadowThreshold;
    u_xlat19 = (u_xlatb19) ? 0.0 : 1.0;
    u_xlat24 = (-u_xlat16_0.x) + u_xlat16_24;
    u_xlat24 = u_xlat19 * u_xlat24 + u_xlat16_0.x;
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat5.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_26 = u_xlat24 + u_xlat24;
    u_xlat16_6.x = u_xlat24 * 2.0 + -1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
    u_xlat16_14.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz + u_xlat4.xyz;
    u_xlat16_26 = u_xlat16_26;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_6.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlatb24 = u_xlat16_11.x>=0.5;
    u_xlat16_26 = (u_xlatb24) ? 1.0 : 0.0;
    u_xlat16_6.xyz = (-u_xlat16_0.xyz) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat0.xyz = _SekaiRimLightColorArray[u_xlati3].www * _SekaiRimLightColorArray[u_xlati3].xyz;
    u_xlat24 = dot(vs_NORMAL0.xyz, vs_TEXCOORD4.xyz);
    u_xlat11.x = dot(vs_TEXCOORD4.xyz, _SekaiRimLightArray[u_xlati3].xyz);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlat19 = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * vs_NORMAL0.xyz;
    u_xlat19 = dot(_SekaiRimLightArray[u_xlati3].xyz, _SekaiRimLightArray[u_xlati3].xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat5.xyz = vec3(u_xlat19) * _SekaiRimLightArray[u_xlati3].xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat16_26 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati3];
    u_xlat16_30 = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati3]);
    u_xlat4.x = (-u_xlat16_26) + u_xlat16_30;
    u_xlat12.x = (-u_xlat16_26) + u_xlat19;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat12.x;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat12.x = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat12.x;
    u_xlat12.xyz = _SekaiShadowRimLightColorArray[u_xlati3].xyz * _SekaiShadowRimLightColorArray[u_xlati3].www + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat4.xxx * u_xlat12.xyz + u_xlat0.xyz;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat16_26 = 10.0 + (-_SekaiRimLightFactor[u_xlati3].x);
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * u_xlat16_26;
    u_xlat24 = exp2(u_xlat24);
    u_xlat11.x = u_xlat24 * u_xlat11.x + (-u_xlat24);
    u_xlat24 = _SekaiRimLightFactor[u_xlati3].w * u_xlat11.x + u_xlat24;
    u_xlat11.x = (-u_xlat19) + 0.0500000007;
    u_xlati19 = int((0.0<u_xlat11.x) ? 0xFFFFFFFFu : uint(0));
    u_xlati11 = int((u_xlat11.x<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati11 = (-u_xlati19) + u_xlati11;
    u_xlat11.x = float(u_xlati11);
    u_xlat11.x = u_xlat24 * u_xlat11.x + (-u_xlat24);
    u_xlat24 = _SekaiRimLightFactor[u_xlati3].w * u_xlat11.x + u_xlat24;
    u_xlat24 = u_xlat24 + (-_RimThreshold);
    u_xlat11.x = float(1.0) / _SekaiRimLightFactor[u_xlati3].z;
    u_xlat24 = u_xlat24 * u_xlat11.x;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat11.x = u_xlat24 * -2.0 + 3.0;
    u_xlat24 = u_xlat24 * u_xlat24;
    u_xlat24 = u_xlat24 * u_xlat11.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24);
    u_xlat16_6.xyz = u_xlat0.xyz * vs_COLOR0.yyy + u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz + _SekaiDirectionalLight.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_NORMAL0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat8.x = 10.0 / _SpecularPower;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_11.zzz + u_xlat16_6.xyz;
    u_xlatb11.xyz = greaterThanEqual(u_xlat0.xyzz, vec4(0.5, 0.5, 0.5, 0.5)).xyz;
    u_xlat16_2.x = (u_xlatb11.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb11.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb11.z) ? float(1.0) : float(0.0);
    u_xlat16_6.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat11.xyz = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati3].xyz;
    u_xlat16_7.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati3].xyz);
    u_xlat0.xyz = (-u_xlat16_7.xyz) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati3].xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz + u_xlat11.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati3]);
    u_xlat3.xyz = u_xlat0.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat0.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat3.xyz * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlatb0 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb0){
        u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
        u_xlat0.x = u_xlat0.y + u_xlat0.x;
        u_xlat0.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
        u_xlat8.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat0.x = u_xlat0.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat8.x = float(1.0) / u_xlat8.x;
        u_xlat0.x = u_xlat8.x * u_xlat0.x;
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
        u_xlat8.x = u_xlat0.x * -2.0 + 3.0;
        u_xlat0.x = u_xlat0.x * u_xlat0.x;
        u_xlat16 = u_xlat0.x * u_xlat8.x;
        u_xlat0.x = (-u_xlat8.x) * u_xlat0.x + 1.0;
        u_xlat8.xyz = u_xlat16_2.xyz * vec3(u_xlat16);
        u_xlat8.xyz = u_xlat8.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + u_xlat8.xyz;
    } else {
        u_xlat0.xyz = u_xlat16_2.xyz;
    }
    u_xlat16_2.x = (-vs_TEXCOORD6) + 1.0;
    u_xlat24 = u_xlat16_2.x * _SekaiFogColor.w;
    u_xlat3.xyz = (-u_xlat0.xyz) + _SekaiFogColor.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "BASE-RP"
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="SekaiBase" "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
			Cull [_Culling]
			GLSLPROGRAM
#pragma multi_compile _ ENABLE_ALPHA_CLIP
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 rp_FogFactor;
uniform 	mediump vec4 rp_FogColor;
uniform 	vec2 rp_HeightFogFactor;
uniform 	mediump vec4 rp_HeightFogColor;
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
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_FaceShadowTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineOffset;
	UNITY_UNIFORM float Xhlslcc_UnusedX_SpecularPower;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DefaultSkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow1SkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow2SkinColor;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HeadNormalBlend;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashTransparent;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsLeftEyeClose;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsRightEyeClose;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_FaceFront;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_HeadPosition;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RangeLimit;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HeadDotDirectionalLightValues;
#if defined(ENABLE_ALPHA_CLIP)
	UNITY_UNIFORM mediump float                _Cutoff;
#else
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Cutoff;
#endif
	UNITY_UNIFORM float                _ShadowThreshold;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = u_xlat2.z / u_xlat2.w;
    u_xlat12 = _ZBufferParams.x * u_xlat12 + _ZBufferParams.y;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat13 = u_xlat2.z * unity_OrthoParams.w;
    u_xlat3.x = (-unity_OrthoParams.w) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat3.x + u_xlat13;
    u_xlat7 = u_xlat12 * _ZBufferParams.x;
    u_xlat12 = (-_ZBufferParams.y) * u_xlat12 + 1.0;
    u_xlat12 = u_xlat12 / u_xlat7;
    u_xlat12 = u_xlat2.w * u_xlat12;
    gl_Position.z = u_xlat12 * u_xlat3.x + u_xlat13;
    gl_Position.xyw = u_xlat2.xyw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = max(u_xlat12, 1.17549435e-38);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_NORMAL0.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    vs_TEXCOORD0 = u_xlat2;
    u_xlat12 = u_xlat2.z + _ProjectionParams.y;
    vs_COLOR0 = in_COLOR0;
    u_xlat13 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat12 = u_xlat12 / u_xlat13;
    u_xlat12 = u_xlat12 * _ProjectionParams.z;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat12 = (-rp_FogFactor.xxxy.w) * u_xlat12 + rp_FogFactor.xxxy.z;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat12 = (-u_xlat12) + 1.0;
    vs_TEXCOORD4.x = u_xlat12 * rp_FogColor.w;
    u_xlat12 = u_xlat1.y + (-rp_HeightFogFactor.x);
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat12 * rp_HeightFogFactor.y;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    vs_TEXCOORD4.y = u_xlat12 * rp_HeightFogColor.w;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlatb12 = unity_OrthoParams.w==0.0;
    u_xlat1.x = (u_xlatb12) ? u_xlat0.x : hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = (u_xlatb12) ? u_xlat0.y : hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = (u_xlatb12) ? u_xlat0.z : hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
uniform 	vec2 _GlobalMipBias;
uniform 	float rp_GlobalIntensity;
uniform 	vec4 rp_DirectionalLightVector;
uniform 	mediump vec4 rp_CharacterAmbientLightColorArray[10];
uniform 	float rp_CharacterAmbientLightIntensityArray[10];
uniform 	float rp_CharacterAmbientLightBrightnessArray[10];
uniform 	mediump vec4 rp_CharacterRimColor;
uniform 	vec4 rp_CharacterRimVector;
uniform 	float rp_CharacterRimIntensity;
uniform 	float rp_CharacterRimBrightness;
uniform 	mediump vec4 rp_FogColor;
uniform 	mediump vec4 rp_HeightFogColor;
uniform 	mediump vec4 _EmissionColor;
uniform 	float _Emission;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_FaceShadowTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineOffset;
	UNITY_UNIFORM float Xhlslcc_UnusedX_SpecularPower;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DefaultSkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow1SkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow2SkinColor;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HeadNormalBlend;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashTransparent;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsLeftEyeClose;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsRightEyeClose;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_FaceFront;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_HeadPosition;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RangeLimit;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HeadDotDirectionalLightValues;
#if defined(ENABLE_ALPHA_CLIP)
	UNITY_UNIFORM mediump float                _Cutoff;
#else
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Cutoff;
#endif
	UNITY_UNIFORM float                _ShadowThreshold;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ShadowTex;
in highp vec3 vs_NORMAL0;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
#if defined(ENABLE_ALPHA_CLIP)
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
#else
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
#endif
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
#if defined(ENABLE_ALPHA_CLIP)
int u_xlati2;
#else
mediump vec4 u_xlat16_2;
#endif
bvec3 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
#if defined(ENABLE_ALPHA_CLIP)
vec3 u_xlat8;
vec3 u_xlat11;
float u_xlat34;
#else
float u_xlat8;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
#endif
void main()
{
#if defined(ENABLE_ALPHA_CLIP)
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat16_1.x = u_xlat16_0.w + (-_Cutoff);
    u_xlatb2.x = u_xlat16_1.x<0.0;
    if(u_xlatb2.x){discard;}
    u_xlat2.x = dot(rp_DirectionalLightVector.xyz, vs_NORMAL0.xyz);
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = _ShadowThreshold * 2.0 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlatb2.x = u_xlat2.x>=0.40625;
    u_xlat2.x = u_xlatb2.x ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat0 = u_xlat16_0 + (-u_xlat16_1);
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat16_1;
    u_xlatb2.xyz = greaterThanEqual(u_xlat0.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
#else
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat8 = (-rp_CharacterRimIntensity) * 0.899999976 + 10.0;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat8 = dot(vs_TEXCOORD2.xyz, rp_CharacterRimVector.xyz);
    u_xlat8 = max(u_xlat8, 0.0);
    u_xlat0.x = u_xlat8 * u_xlat0.x;
    u_xlat8 = dot(rp_CharacterRimVector.xyz, vs_NORMAL0.xyz);
    u_xlat0.x = u_xlat8 * u_xlat0.x;
    u_xlatb0 = u_xlat0.x>=_RimThreshold;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.y;
    u_xlat0.xyz = u_xlat0.xxx * rp_CharacterRimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(rp_GlobalIntensity);
    u_xlat24 = dot(rp_DirectionalLightVector.xyz, vs_NORMAL0.xyz);
    u_xlat24 = u_xlat24 * 0.5 + 0.5;
    u_xlat24 = _ShadowThreshold * 2.0 + u_xlat24;
    u_xlat24 = u_xlat24 + -1.0;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlatb24 = u_xlat24>=0.40625;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat16_2 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat1 = u_xlat16_1 + (-u_xlat16_2);
    u_xlat1 = vec4(u_xlat24) * u_xlat1 + u_xlat16_2;
    u_xlatb2.xyz = greaterThanEqual(u_xlat1.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
#endif
    u_xlat16_3.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_3.y = (u_xlatb2.y) ? float(1.0) : float(0.0);
    u_xlat16_3.z = (u_xlatb2.z) ? float(1.0) : float(0.0);
#if defined(ENABLE_ALPHA_CLIP)
    u_xlat16_4.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
#else
    u_xlat16_4.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_5.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
#if defined(ENABLE_ALPHA_CLIP)
    u_xlati2 = _CharacterId;
    u_xlat16_6.xyz = vec3(1.0, 1.0, 1.0) + (-rp_CharacterAmbientLightColorArray[u_xlati2].xyz);
#else
    u_xlati24 = _CharacterId;
    u_xlat16_6.xyz = vec3(1.0, 1.0, 1.0) + (-rp_CharacterAmbientLightColorArray[u_xlati24].xyz);
#endif
    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
#if defined(ENABLE_ALPHA_CLIP)
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) * rp_CharacterAmbientLightColorArray[u_xlati2].xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * rp_CharacterAmbientLightColorArray[u_xlati2].xyz;
#else
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) * rp_CharacterAmbientLightColorArray[u_xlati24].xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * rp_CharacterAmbientLightColorArray[u_xlati24].xyz;
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
#if defined(ENABLE_ALPHA_CLIP)
    u_xlat11.xyz = u_xlat16_3.xyz * vec3(rp_CharacterAmbientLightIntensityArray[u_xlati2]);
    u_xlat7.xyz = rp_CharacterAmbientLightColorArray[u_xlati2].xyz * vec3(rp_CharacterAmbientLightBrightnessArray[u_xlati2]);
#else
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(rp_CharacterAmbientLightIntensityArray[u_xlati24]);
    u_xlat7.xyz = rp_CharacterAmbientLightColorArray[u_xlati24].xyz * vec3(rp_CharacterAmbientLightBrightnessArray[u_xlati24]);
#endif
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.200000003, 0.200000003, 0.200000003);
#if defined(ENABLE_ALPHA_CLIP)
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat34 = (-rp_CharacterRimIntensity) * 0.899999976 + 10.0;
    u_xlat2.x = u_xlat2.x * u_xlat34;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat34 = dot(vs_TEXCOORD2.xyz, rp_CharacterRimVector.xyz);
    u_xlat34 = max(u_xlat34, 0.0);
    u_xlat2.x = u_xlat2.x * u_xlat34;
    u_xlat34 = dot(rp_CharacterRimVector.xyz, vs_NORMAL0.xyz);
    u_xlat2.x = u_xlat2.x * u_xlat34;
    u_xlatb2.x = u_xlat2.x>=_RimThreshold;
    u_xlat2.x = u_xlatb2.x ? 1.0 : float(0.0);
    u_xlat2.x = u_xlat2.x * vs_COLOR0.y;
    u_xlat8.xyz = u_xlat2.xxx * rp_CharacterRimColor.xyz;
    u_xlat8.xyz = u_xlat8.xyz * vec3(rp_GlobalIntensity);
    u_xlat16_3.xyz = u_xlat11.xyz * vec3(rp_GlobalIntensity) + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat8.xyz * vec3(vec3(rp_CharacterRimBrightness, rp_CharacterRimBrightness, rp_CharacterRimBrightness)) + u_xlat7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(rp_GlobalIntensity);
    u_xlat7.xyz = (-u_xlat16_3.xyz) + rp_FogColor.xyz;
    u_xlat7.xyz = vs_TEXCOORD4.xxx * u_xlat7.xyz + u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + rp_HeightFogColor.xyz;
    u_xlat7.xyz = vs_TEXCOORD4.yyy * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EmissionColor.xyz;
    u_xlat0.xyz = vec3(_Emission) * u_xlat8.xyz + u_xlat7.xyz;
    SV_Target0 = u_xlat0;
    u_xlat0.xyz = _EmissionColor.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + (-u_xlat2.xyz);
    u_xlat0.xyz = vec3(_Emission) * u_xlat0.xyz + u_xlat2.xyz;
#else
    u_xlat7.xyz = u_xlat0.xyz * vec3(vec3(rp_CharacterRimBrightness, rp_CharacterRimBrightness, rp_CharacterRimBrightness)) + u_xlat7.xyz;
    u_xlat16_3.xyz = u_xlat2.xyz * vec3(rp_GlobalIntensity) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat7.xyz * vec3(rp_GlobalIntensity);
    u_xlat2.xyz = (-u_xlat16_3.xyz) + rp_FogColor.xyz;
    u_xlat2.xyz = vs_TEXCOORD4.xxx * u_xlat2.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = (-u_xlat2.xyz) + rp_HeightFogColor.xyz;
    u_xlat2.xyz = vs_TEXCOORD4.yyy * u_xlat7.xyz + u_xlat2.xyz;
    u_xlat7.xyz = (-u_xlat2.xyz) + _EmissionColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * u_xlat7.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat1;
    u_xlat1.xyz = _EmissionColor.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + (-u_xlat0.xyz);
    u_xlat0.xyz = vec3(_Emission) * u_xlat1.xyz + u_xlat0.xyz;
#endif
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "BASE-RP-OVER"
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="SekaiBaseOver" "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
			Blend One One, One One
			Cull [_Culling]
			GLSLPROGRAM
#pragma multi_compile _ ENABLE_ALPHA_CLIP
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 rp_FogFactor;
uniform 	mediump vec4 rp_FogColor;
uniform 	vec2 rp_HeightFogFactor;
uniform 	mediump vec4 rp_HeightFogColor;
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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_FaceShadowTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineOffset;
	UNITY_UNIFORM float Xhlslcc_UnusedX_SpecularPower;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DefaultSkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow1SkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow2SkinColor;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HeadNormalBlend;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashTransparent;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsLeftEyeClose;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsRightEyeClose;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_FaceFront;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterId;
	UNITY_UNIFORM vec3 Xhlslcc_UnusedX_HeadPosition;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RangeLimit;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_HeadDotDirectionalLightValues;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Cutoff;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowThreshold;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = u_xlat2.z / u_xlat2.w;
    u_xlat12 = _ZBufferParams.x * u_xlat12 + _ZBufferParams.y;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat13 = u_xlat2.z * unity_OrthoParams.w;
    u_xlat3.x = (-unity_OrthoParams.w) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat3.x + u_xlat13;
    u_xlat7 = u_xlat12 * _ZBufferParams.x;
    u_xlat12 = (-_ZBufferParams.y) * u_xlat12 + 1.0;
    u_xlat12 = u_xlat12 / u_xlat7;
    u_xlat12 = u_xlat2.w * u_xlat12;
    gl_Position.z = u_xlat12 * u_xlat3.x + u_xlat13;
    gl_Position.xyw = u_xlat2.xyw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = max(u_xlat12, 1.17549435e-38);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_NORMAL0.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    vs_TEXCOORD0 = u_xlat2;
    u_xlat12 = u_xlat2.z + _ProjectionParams.y;
    vs_COLOR0 = in_COLOR0;
    u_xlat13 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat12 = u_xlat12 / u_xlat13;
    u_xlat12 = u_xlat12 * _ProjectionParams.z;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat12 = (-rp_FogFactor.xxxy.w) * u_xlat12 + rp_FogFactor.xxxy.z;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat12 = (-u_xlat12) + 1.0;
    vs_TEXCOORD4.x = u_xlat12 * rp_FogColor.w;
    u_xlat12 = u_xlat1.y + (-rp_HeightFogFactor.x);
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat12 = u_xlat12 * rp_HeightFogFactor.y;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    vs_TEXCOORD4.y = u_xlat12 * rp_HeightFogColor.w;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlatb12 = unity_OrthoParams.w==0.0;
    u_xlat1.x = (u_xlatb12) ? u_xlat0.x : hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = (u_xlatb12) ? u_xlat0.y : hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = (u_xlatb12) ? u_xlat0.z : hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat1.xyz;
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 1.0);
    return;
}
#endif
			ENDGLSL
		}
	}
}
