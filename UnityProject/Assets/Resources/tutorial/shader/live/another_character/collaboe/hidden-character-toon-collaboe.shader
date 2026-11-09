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
		}
		Pass
		{
			Name "Monitor"
			Tags { "IGNOREPROJECTOR"="true" "LIGHTMODE"="SekaiMonitor" "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
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
