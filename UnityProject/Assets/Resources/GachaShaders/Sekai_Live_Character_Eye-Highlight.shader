// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Character/Eye-Highlight"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Threshold("Threshold", Range(0, 1)) = 0.5
		_LightInfluence("Light Influence", Range(0, 1)) = 1
		_EmissionColor("Emission Color", Color) = (0, 0, 0, 1)
		[Header(DISTORTION)] [Space] _DistortionTex("Distortion Map", 2D) = "black" {}
		_DistortionTexTilingX("DistortionTex Tiling X", Float) = 1
		_DistortionTexTilingY("DistortionTex Tiling Y", Float) = 1
		[Space] _DistortionScrollSpeed("Distortion Speed", Float) = 1
		_DistortionScrollX("Distortion Speed X", Float) = 0.5
		_DistortionScrollY("Distortion Speed Y", Float) = 0.5
		_DistortionFPS("Distortion FPS", Float) = 12
		[Space] _DistortionIntensity("Distortion Intensity", Float) = 1
		_DistortionIntensityX("Distortion Intensity X", Float) = 1
		_DistortionIntensityY("Distortion Intensity Y", Float) = 1
		[Space] _DistortionOffsetX("Distortion Offset X", Range(-1, 1)) = 0
		_DistortionOffsetY("Distortion Offset Y", Range(-1, 1)) = 0
		[HideInInspector] _PartsAmbientColor("Parts Ambient Color", Color) = (1, 1, 1, 1)
		[Header(Stencil)] _Stencil("Stencil ID [0;255]", Float) = 1
		_ReadMask("ReadMask [0;255]", Float) = 255
		_WriteMask("WriteMask [0;255]", Float) = 255
		[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp("Stencil Comparison", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp("Stencil Operation", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilFail("Stencil Fail", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilZFail("Stencil ZFail", Float) = 0
		_FaceFront("FaceFront", Vector) = (0, 0, 1, 0)
		[Header(Overlay)] _EyelashTransparent("Eyelash Transparent", Range(0, 1)) = 0
		_EyelashFaceCameraEdge1("フェードがかかり始める角度 (1:顔の正面, 0:顔の真横)", Range(0, 1)) = 0.5
		_EyelashFaceCameraEdge2("フェードがかかり終わる角度 (1:顔の正面, 0:顔の真横)", Range(0, 1)) = 0
		[Space] _EyelashStencil("Stencil ID [0;255]", Float) = 1
		_EyelashReadMask("ReadMask [0;255]", Float) = 255
		_EyelashWriteMask("WriteMask [0;255]", Float) = 255
		[Enum(UnityEngine.Rendering.CompareFunction)] _EyelashStencilComp("Stencil Comparison", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _EyelashStencilOp("Stencil Operation", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _EyelashStencilFail("Stencil Fail", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _EyelashStencilZFail("Stencil ZFail", Float) = 0
		[HideInInspector] _CharacterId("CharacterId", Float) = 0
		[HideInInspector] _TintColor("Tint Color", Color) = (1, 1, 1, 1)
		[HideInInspector] _LightInfluenceForEyeHighlight("Light Influence For Highlight", Range(0, 1)) = 1
	}
	SubShader
	{
		Tags { "QUEUE"="AlphaTest" "RenderType"="Opaque" }
		LOD 100
		Pass
		{
			Name "Base"
			Tags { "QUEUE"="AlphaTest" "RenderType"="Opaque" }
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _SekaiFogFactor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_WorldToObject[4];
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
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_EyeFlipbookTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_SheetValue;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookCurrentFrame;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookEnabled;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetX;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetY;
	UNITY_UNIFORM mediump float                _Threshold;
	UNITY_UNIFORM mediump float                _LightInfluenceForEyeHighlight;
	UNITY_UNIFORM mediump vec4                _EmissionColor;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_LightInfluence;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashTransparent;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_TintColor;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_FaceFront;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DistortionTex_ST;
	UNITY_UNIFORM float                _DistortionTexTilingX;
	UNITY_UNIFORM float                _DistortionTexTilingY;
	UNITY_UNIFORM float                _DistortionIntensity;
	UNITY_UNIFORM float                _DistortionIntensityX;
	UNITY_UNIFORM float                _DistortionIntensityY;
	UNITY_UNIFORM float                _DistortionOffsetX;
	UNITY_UNIFORM float                _DistortionOffsetY;
	UNITY_UNIFORM float                _DistortionScrollX;
	UNITY_UNIFORM float                _DistortionScrollY;
	UNITY_UNIFORM float                _DistortionScrollSpeed;
	UNITY_UNIFORM float                _DistortionFPS;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec2 vs_TEXCOORD5;
out mediump float vs_TEXCOORD6;
#if defined(USE_DITHER_ALPHA)
out highp vec4 vs_TEXCOORD7;
#endif
vec4 u_xlat0;
vec4 u_xlat1;
#if defined(USE_DITHER_ALPHA)
float u_xlat3;
#endif
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD2 = u_xlat0.z;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z + _ProjectionParams.y;
#if defined(USE_DITHER_ALPHA)
    u_xlat3 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat1.x = u_xlat1.x / u_xlat3;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = (-_SekaiFogFactor.y) * u_xlat1.x + _SekaiFogFactor.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    vs_TEXCOORD1 = u_xlat1.x;
#endif
    vs_TEXCOORD3 = u_xlat0;
#if !defined(USE_DITHER_ALPHA)
    u_xlat0.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD1 = u_xlat0.x;
#endif
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * vec2(_DistortionTexTilingX, _DistortionTexTilingY);
    vs_TEXCOORD6 = 0.0;
#if defined(USE_DITHER_ALPHA)
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _SekaiGlobalEyeTime;
uniform 	vec4 _CoCParams;
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiCharacterAmbientLightIntensityArray[12];
uniform 	vec4 _SekaiCharacterAmbientLightColorArray[12];
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
#if defined(USE_DITHER_ALPHA)
uniform 	mediump float _DitherAlpha;
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_EyeFlipbookTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_SheetValue;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookCurrentFrame;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookEnabled;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetX;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetY;
	UNITY_UNIFORM mediump float                _Threshold;
	UNITY_UNIFORM mediump float                _LightInfluenceForEyeHighlight;
	UNITY_UNIFORM mediump vec4                _EmissionColor;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_LightInfluence;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashTransparent;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_TintColor;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_FaceFront;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DistortionTex_ST;
	UNITY_UNIFORM float                _DistortionTexTilingX;
	UNITY_UNIFORM float                _DistortionTexTilingY;
	UNITY_UNIFORM float                _DistortionIntensity;
	UNITY_UNIFORM float                _DistortionIntensityX;
	UNITY_UNIFORM float                _DistortionIntensityY;
	UNITY_UNIFORM float                _DistortionOffsetX;
	UNITY_UNIFORM float                _DistortionOffsetY;
	UNITY_UNIFORM float                _DistortionScrollX;
	UNITY_UNIFORM float                _DistortionScrollY;
	UNITY_UNIFORM float                _DistortionScrollSpeed;
	UNITY_UNIFORM float                _DistortionFPS;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistortionTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
#if defined(USE_DITHER_ALPHA)
UNITY_LOCATION(2) uniform mediump sampler2D _DitherTex;
#endif
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec2 vs_TEXCOORD5;
#if defined(USE_DITHER_ALPHA)
in highp vec4 vs_TEXCOORD7;
#endif
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
#if defined(USE_DITHER_ALPHA)
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec3 u_xlatb2;
#else
vec3 u_xlat1;
bvec3 u_xlatb1;
mediump vec3 u_xlat16_2;
#endif
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
#if defined(USE_DITHER_ALPHA)
float u_xlat8;
#else
float u_xlat7;
#endif
float u_xlat12;
float u_xlat18;
int u_xlati18;
bool u_xlatb18;
void main()
{
#if defined(USE_DITHER_ALPHA)
    u_xlat0.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat16_0.x = texture(_DitherTex, u_xlat0.xy, _GlobalMipBias.x).x;
    u_xlat16_1.x = (-u_xlat16_0.x) + _DitherAlpha;
    u_xlatb0 = u_xlat16_1.x<0.0;
    if(u_xlatb0){discard;}
#endif
    u_xlat0.x = _SekaiGlobalEyeTime * _DistortionFPS;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _DistortionFPS;
#if defined(USE_DITHER_ALPHA)
    u_xlat2.x = u_xlat0.x * _DistortionScrollX;
    u_xlat2.y = u_xlat0.x * _DistortionScrollY;
    u_xlat0.xy = (-u_xlat2.xy) * vec2(vec2(_DistortionScrollSpeed, _DistortionScrollSpeed)) + vs_TEXCOORD5.xy;
#else
    u_xlat1.x = u_xlat0.x * _DistortionScrollX;
    u_xlat1.y = u_xlat0.x * _DistortionScrollY;
    u_xlat0.xy = (-u_xlat1.xy) * vec2(vec2(_DistortionScrollSpeed, _DistortionScrollSpeed)) + vs_TEXCOORD5.xy;
#endif
    u_xlat16_0.xy = texture(_DistortionTex, u_xlat0.xy).xy;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat16_1.xy + vec2(_DistortionOffsetX, _DistortionOffsetY);
    u_xlat2.x = _DistortionIntensity * _DistortionIntensityX;
    u_xlat2.y = _DistortionIntensity * _DistortionIntensityY;
    u_xlat0.xy = u_xlat0.xy * u_xlat2.xy + vs_TEXCOORD0.xy;
#else
    u_xlat16_2.xy = u_xlat16_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat16_2.xy + vec2(_DistortionOffsetX, _DistortionOffsetY);
    u_xlat1.x = _DistortionIntensity * _DistortionIntensityX;
    u_xlat1.y = _DistortionIntensity * _DistortionIntensityY;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy + vs_TEXCOORD0.xy;
#endif
    u_xlat0.xyz = texture(_MainTex, u_xlat0.xy, _GlobalMipBias.x).xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.x = u_xlat0.x + (-_Threshold);
    u_xlatb18 = u_xlat16_1.x<0.0;
#else
    u_xlat16_2.x = u_xlat0.x + (-_Threshold);
    u_xlatb18 = u_xlat16_2.x<0.0;
#endif
    if(u_xlatb18){discard;}
#if defined(USE_DITHER_ALPHA)
    u_xlatb2.xyz = greaterThanEqual(u_xlat0.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_1.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_1.y = (u_xlatb2.y) ? float(1.0) : float(0.0);
    u_xlat16_1.z = (u_xlatb2.z) ? float(1.0) : float(0.0);
#else
    u_xlatb1.xyz = greaterThanEqual(u_xlat0.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_2.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlati18 = _CharacterId;
#if defined(USE_DITHER_ALPHA)
    u_xlat2.xyz = u_xlat16_3.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati18].xyz;
#else
    u_xlat1.xyz = u_xlat16_3.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati18].xyz;
#endif
    u_xlat16_4.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat5.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati18].xyz);
    u_xlat5.xyz = (-u_xlat16_4.xyz) * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati18].xyz + u_xlat5.xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati18]);
    u_xlat5.xyz = u_xlat2.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat2.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
#else
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati18]);
    u_xlat5.xyz = u_xlat1.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat1.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
#endif
    u_xlat16_3.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat5.xyz * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
#else
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat5.xyz * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
#endif
    u_xlatb18 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb18){
#if defined(USE_DITHER_ALPHA)
        u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat2.xy = u_xlat2.xy * u_xlat2.xy;
        u_xlat18 = u_xlat2.y + u_xlat2.x;
        u_xlat18 = u_xlat2.z * u_xlat2.z + u_xlat18;
        u_xlat2.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xy = u_xlat1.xy * u_xlat1.xy;
        u_xlat18 = u_xlat1.y + u_xlat1.x;
        u_xlat18 = u_xlat1.z * u_xlat1.z + u_xlat18;
        u_xlat1.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
        u_xlat18 = u_xlat18 + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(USE_DITHER_ALPHA)
        u_xlat2.x = float(1.0) / u_xlat2.x;
        u_xlat18 = u_xlat18 * u_xlat2.x;
#else
        u_xlat1.x = float(1.0) / u_xlat1.x;
        u_xlat18 = u_xlat18 * u_xlat1.x;
#endif
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#if defined(USE_DITHER_ALPHA)
        u_xlat2.x = u_xlat18 * -2.0 + 3.0;
#else
        u_xlat1.x = u_xlat18 * -2.0 + 3.0;
#endif
        u_xlat18 = u_xlat18 * u_xlat18;
#if defined(USE_DITHER_ALPHA)
        u_xlat8 = u_xlat18 * u_xlat2.x;
        u_xlat18 = (-u_xlat2.x) * u_xlat18 + 1.0;
        u_xlat2.xyz = u_xlat16_1.xyz * vec3(u_xlat8);
        u_xlat2.xyz = u_xlat2.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat2.xyz = vec3(u_xlat18) * u_xlat16_1.xyz + u_xlat2.xyz;
#else
        u_xlat7 = u_xlat18 * u_xlat1.x;
        u_xlat18 = (-u_xlat1.x) * u_xlat18 + 1.0;
        u_xlat1.xyz = u_xlat16_2.xyz * vec3(u_xlat7);
        u_xlat1.xyz = u_xlat1.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat1.xyz = vec3(u_xlat18) * u_xlat16_2.xyz + u_xlat1.xyz;
#endif
    } else {
#if defined(USE_DITHER_ALPHA)
        u_xlat2.xyz = u_xlat16_1.xyz;
#else
        u_xlat1.xyz = u_xlat16_2.xyz;
#endif
    }
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    SV_Target0.xyz = vec3(vec3(_LightInfluenceForEyeHighlight, _LightInfluenceForEyeHighlight, _LightInfluenceForEyeHighlight)) * u_xlat16_1.xyz + u_xlat0.xyz;
#else
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(vec3(_LightInfluenceForEyeHighlight, _LightInfluenceForEyeHighlight, _LightInfluenceForEyeHighlight)) * u_xlat16_2.xyz + u_xlat0.xyz;
#endif
    u_xlat6 = vs_TEXCOORD2 / vs_TEXCOORD3.w;
    u_xlat6 = u_xlat6 * 0.5 + 0.5;
    u_xlat6 = (-u_xlat6) + 1.0;
    u_xlat12 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat12 = u_xlat12 + -1.0;
    u_xlat12 = u_xlat12 * _ProjectionParams.w;
    u_xlat6 = u_xlat12 * u_xlat6 + _ProjectionParams.w;
    u_xlat6 = (-_CoCParams.x) * u_xlat6 + 1.0;
    u_xlat6 = u_xlat6 * _CoCParams.y;
    u_xlat12 = u_xlat6;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat6 = max(u_xlat6, -1.0);
    u_xlat6 = min(u_xlat6, 0.0);
    u_xlat6 = u_xlat6 + u_xlat12;
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = u_xlat6 * 0.5;
    SV_Target0.w = u_xlat0.x;
    SV_Target1.x = u_xlat6;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2 = _EmissionColor;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Tags { "LIGHTMODE"="SekaiMonitor" "QUEUE"="AlphaTest" "RenderType"="Opaque" }
			GLSLPROGRAM
#pragma multi_compile _ USE_DITHER_ALPHA
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _SekaiFogFactor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_WorldToObject[4];
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
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_EyeFlipbookTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_SheetValue;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookCurrentFrame;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookEnabled;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetX;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetY;
	UNITY_UNIFORM mediump float                _Threshold;
	UNITY_UNIFORM mediump float                _LightInfluenceForEyeHighlight;
	UNITY_UNIFORM mediump vec4                _EmissionColor;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_LightInfluence;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashTransparent;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_TintColor;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_FaceFront;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DistortionTex_ST;
	UNITY_UNIFORM float                _DistortionTexTilingX;
	UNITY_UNIFORM float                _DistortionTexTilingY;
	UNITY_UNIFORM float                _DistortionIntensity;
	UNITY_UNIFORM float                _DistortionIntensityX;
	UNITY_UNIFORM float                _DistortionIntensityY;
	UNITY_UNIFORM float                _DistortionOffsetX;
	UNITY_UNIFORM float                _DistortionOffsetY;
	UNITY_UNIFORM float                _DistortionScrollX;
	UNITY_UNIFORM float                _DistortionScrollY;
	UNITY_UNIFORM float                _DistortionScrollSpeed;
	UNITY_UNIFORM float                _DistortionFPS;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec2 vs_TEXCOORD5;
out mediump float vs_TEXCOORD6;
#if defined(USE_DITHER_ALPHA)
out highp vec4 vs_TEXCOORD7;
#endif
vec4 u_xlat0;
vec4 u_xlat1;
#if defined(USE_DITHER_ALPHA)
float u_xlat3;
#endif
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD2 = u_xlat0.z;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z + _ProjectionParams.y;
#if defined(USE_DITHER_ALPHA)
    u_xlat3 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat1.x = u_xlat1.x / u_xlat3;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = (-_SekaiFogFactor.y) * u_xlat1.x + _SekaiFogFactor.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    vs_TEXCOORD1 = u_xlat1.x;
#endif
    vs_TEXCOORD3 = u_xlat0;
#if !defined(USE_DITHER_ALPHA)
    u_xlat0.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD1 = u_xlat0.x;
#endif
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * vec2(_DistortionTexTilingX, _DistortionTexTilingY);
    vs_TEXCOORD6 = 0.0;
#if defined(USE_DITHER_ALPHA)
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _SekaiGlobalEyeTime;
uniform 	vec4 _CoCParams;
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiCharacterAmbientLightIntensityArray[12];
uniform 	vec4 _SekaiCharacterAmbientLightColorArray[12];
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
#if defined(USE_DITHER_ALPHA)
uniform 	mediump float _DitherAlpha;
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_EyeFlipbookTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_SheetValue;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookCurrentFrame;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookEnabled;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetX;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetY;
	UNITY_UNIFORM mediump float                _Threshold;
	UNITY_UNIFORM mediump float                _LightInfluenceForEyeHighlight;
	UNITY_UNIFORM mediump vec4                _EmissionColor;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_LightInfluence;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashTransparent;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_TintColor;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_FaceFront;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DistortionTex_ST;
	UNITY_UNIFORM float                _DistortionTexTilingX;
	UNITY_UNIFORM float                _DistortionTexTilingY;
	UNITY_UNIFORM float                _DistortionIntensity;
	UNITY_UNIFORM float                _DistortionIntensityX;
	UNITY_UNIFORM float                _DistortionIntensityY;
	UNITY_UNIFORM float                _DistortionOffsetX;
	UNITY_UNIFORM float                _DistortionOffsetY;
	UNITY_UNIFORM float                _DistortionScrollX;
	UNITY_UNIFORM float                _DistortionScrollY;
	UNITY_UNIFORM float                _DistortionScrollSpeed;
	UNITY_UNIFORM float                _DistortionFPS;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistortionTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
#if defined(USE_DITHER_ALPHA)
UNITY_LOCATION(2) uniform mediump sampler2D _DitherTex;
#endif
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec2 vs_TEXCOORD5;
#if defined(USE_DITHER_ALPHA)
in highp vec4 vs_TEXCOORD7;
#endif
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
#if defined(USE_DITHER_ALPHA)
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec3 u_xlatb2;
#else
vec3 u_xlat1;
bvec3 u_xlatb1;
mediump vec3 u_xlat16_2;
#endif
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
#if defined(USE_DITHER_ALPHA)
float u_xlat8;
#else
float u_xlat7;
#endif
float u_xlat12;
float u_xlat18;
int u_xlati18;
bool u_xlatb18;
void main()
{
#if defined(USE_DITHER_ALPHA)
    u_xlat0.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat16_0.x = texture(_DitherTex, u_xlat0.xy, _GlobalMipBias.x).x;
    u_xlat16_1.x = (-u_xlat16_0.x) + _DitherAlpha;
    u_xlatb0 = u_xlat16_1.x<0.0;
    if(u_xlatb0){discard;}
#endif
    u_xlat0.x = _SekaiGlobalEyeTime * _DistortionFPS;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _DistortionFPS;
#if defined(USE_DITHER_ALPHA)
    u_xlat2.x = u_xlat0.x * _DistortionScrollX;
    u_xlat2.y = u_xlat0.x * _DistortionScrollY;
    u_xlat0.xy = (-u_xlat2.xy) * vec2(vec2(_DistortionScrollSpeed, _DistortionScrollSpeed)) + vs_TEXCOORD5.xy;
#else
    u_xlat1.x = u_xlat0.x * _DistortionScrollX;
    u_xlat1.y = u_xlat0.x * _DistortionScrollY;
    u_xlat0.xy = (-u_xlat1.xy) * vec2(vec2(_DistortionScrollSpeed, _DistortionScrollSpeed)) + vs_TEXCOORD5.xy;
#endif
    u_xlat16_0.xy = texture(_DistortionTex, u_xlat0.xy).xy;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat16_1.xy + vec2(_DistortionOffsetX, _DistortionOffsetY);
    u_xlat2.x = _DistortionIntensity * _DistortionIntensityX;
    u_xlat2.y = _DistortionIntensity * _DistortionIntensityY;
    u_xlat0.xy = u_xlat0.xy * u_xlat2.xy + vs_TEXCOORD0.xy;
#else
    u_xlat16_2.xy = u_xlat16_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat16_2.xy + vec2(_DistortionOffsetX, _DistortionOffsetY);
    u_xlat1.x = _DistortionIntensity * _DistortionIntensityX;
    u_xlat1.y = _DistortionIntensity * _DistortionIntensityY;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy + vs_TEXCOORD0.xy;
#endif
    u_xlat0.xyz = texture(_MainTex, u_xlat0.xy, _GlobalMipBias.x).xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.x = u_xlat0.x + (-_Threshold);
    u_xlatb18 = u_xlat16_1.x<0.0;
#else
    u_xlat16_2.x = u_xlat0.x + (-_Threshold);
    u_xlatb18 = u_xlat16_2.x<0.0;
#endif
    if(u_xlatb18){discard;}
#if defined(USE_DITHER_ALPHA)
    u_xlatb2.xyz = greaterThanEqual(u_xlat0.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_1.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_1.y = (u_xlatb2.y) ? float(1.0) : float(0.0);
    u_xlat16_1.z = (u_xlatb2.z) ? float(1.0) : float(0.0);
#else
    u_xlatb1.xyz = greaterThanEqual(u_xlat0.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_2.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlati18 = _CharacterId;
#if defined(USE_DITHER_ALPHA)
    u_xlat2.xyz = u_xlat16_3.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati18].xyz;
#else
    u_xlat1.xyz = u_xlat16_3.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati18].xyz;
#endif
    u_xlat16_4.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat5.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati18].xyz);
    u_xlat5.xyz = (-u_xlat16_4.xyz) * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati18].xyz + u_xlat5.xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati18]);
    u_xlat5.xyz = u_xlat2.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat2.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
#else
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati18]);
    u_xlat5.xyz = u_xlat1.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat1.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
#endif
    u_xlat16_3.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat5.xyz * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
#else
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat5.xyz * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
#endif
    u_xlatb18 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb18){
#if defined(USE_DITHER_ALPHA)
        u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat2.xy = u_xlat2.xy * u_xlat2.xy;
        u_xlat18 = u_xlat2.y + u_xlat2.x;
        u_xlat18 = u_xlat2.z * u_xlat2.z + u_xlat18;
        u_xlat2.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xy = u_xlat1.xy * u_xlat1.xy;
        u_xlat18 = u_xlat1.y + u_xlat1.x;
        u_xlat18 = u_xlat1.z * u_xlat1.z + u_xlat18;
        u_xlat1.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
        u_xlat18 = u_xlat18 + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(USE_DITHER_ALPHA)
        u_xlat2.x = float(1.0) / u_xlat2.x;
        u_xlat18 = u_xlat18 * u_xlat2.x;
#else
        u_xlat1.x = float(1.0) / u_xlat1.x;
        u_xlat18 = u_xlat18 * u_xlat1.x;
#endif
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#if defined(USE_DITHER_ALPHA)
        u_xlat2.x = u_xlat18 * -2.0 + 3.0;
#else
        u_xlat1.x = u_xlat18 * -2.0 + 3.0;
#endif
        u_xlat18 = u_xlat18 * u_xlat18;
#if defined(USE_DITHER_ALPHA)
        u_xlat8 = u_xlat18 * u_xlat2.x;
        u_xlat18 = (-u_xlat2.x) * u_xlat18 + 1.0;
        u_xlat2.xyz = u_xlat16_1.xyz * vec3(u_xlat8);
        u_xlat2.xyz = u_xlat2.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat2.xyz = vec3(u_xlat18) * u_xlat16_1.xyz + u_xlat2.xyz;
#else
        u_xlat7 = u_xlat18 * u_xlat1.x;
        u_xlat18 = (-u_xlat1.x) * u_xlat18 + 1.0;
        u_xlat1.xyz = u_xlat16_2.xyz * vec3(u_xlat7);
        u_xlat1.xyz = u_xlat1.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat1.xyz = vec3(u_xlat18) * u_xlat16_2.xyz + u_xlat1.xyz;
#endif
    } else {
#if defined(USE_DITHER_ALPHA)
        u_xlat2.xyz = u_xlat16_1.xyz;
#else
        u_xlat1.xyz = u_xlat16_2.xyz;
#endif
    }
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    SV_Target0.xyz = vec3(vec3(_LightInfluenceForEyeHighlight, _LightInfluenceForEyeHighlight, _LightInfluenceForEyeHighlight)) * u_xlat16_1.xyz + u_xlat0.xyz;
#else
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(vec3(_LightInfluenceForEyeHighlight, _LightInfluenceForEyeHighlight, _LightInfluenceForEyeHighlight)) * u_xlat16_2.xyz + u_xlat0.xyz;
#endif
    u_xlat6 = vs_TEXCOORD2 / vs_TEXCOORD3.w;
    u_xlat6 = u_xlat6 * 0.5 + 0.5;
    u_xlat6 = (-u_xlat6) + 1.0;
    u_xlat12 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat12 = u_xlat12 + -1.0;
    u_xlat12 = u_xlat12 * _ProjectionParams.w;
    u_xlat6 = u_xlat12 * u_xlat6 + _ProjectionParams.w;
    u_xlat6 = (-_CoCParams.x) * u_xlat6 + 1.0;
    u_xlat6 = u_xlat6 * _CoCParams.y;
    u_xlat12 = u_xlat6;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat6 = max(u_xlat6, -1.0);
    u_xlat6 = min(u_xlat6, 0.0);
    u_xlat6 = u_xlat6 + u_xlat12;
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = u_xlat6 * 0.5;
    SV_Target0.w = u_xlat0.x;
    SV_Target1.x = u_xlat6;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2 = _EmissionColor;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "Eyelash"
			Tags { "LIGHTMODE"="SekaiEyelash" "QUEUE"="AlphaTest" "RenderType"="Opaque" }
			Blend SrcAlpha OneMinusSrcAlpha, Zero One
			ZTest Always
			ZWrite Off
			Cull Off
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _SekaiFogFactor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_WorldToObject[4];
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
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_EyeFlipbookTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_SheetValue;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookCurrentFrame;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookEnabled;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetX;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetY;
	UNITY_UNIFORM mediump float                _Threshold;
	UNITY_UNIFORM mediump float                _LightInfluenceForEyeHighlight;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_EmissionColor;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_LightInfluence;
	UNITY_UNIFORM mediump float                _EyelashTransparent;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_TintColor;
	UNITY_UNIFORM mediump vec3                _FaceFront;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DistortionTex_ST;
	UNITY_UNIFORM float                _DistortionTexTilingX;
	UNITY_UNIFORM float                _DistortionTexTilingY;
	UNITY_UNIFORM float                _DistortionIntensity;
	UNITY_UNIFORM float                _DistortionIntensityX;
	UNITY_UNIFORM float                _DistortionIntensityY;
	UNITY_UNIFORM float                _DistortionOffsetX;
	UNITY_UNIFORM float                _DistortionOffsetY;
	UNITY_UNIFORM float                _DistortionScrollX;
	UNITY_UNIFORM float                _DistortionScrollY;
	UNITY_UNIFORM float                _DistortionScrollSpeed;
	UNITY_UNIFORM float                _DistortionFPS;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec2 vs_TEXCOORD5;
out mediump float vs_TEXCOORD6;
#if defined(USE_DITHER_ALPHA)
out highp vec4 vs_TEXCOORD7;
#endif
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
#if defined(USE_DITHER_ALPHA)
float u_xlat4;
#endif
mediump float u_xlat16_5;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD2 = u_xlat0.z;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z + _ProjectionParams.y;
#if defined(USE_DITHER_ALPHA)
    u_xlat4 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat1.x = u_xlat1.x / u_xlat4;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = (-_SekaiFogFactor.y) * u_xlat1.x + _SekaiFogFactor.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    vs_TEXCOORD1 = u_xlat1.x;
#endif
    vs_TEXCOORD3 = u_xlat0;
#if !defined(USE_DITHER_ALPHA)
    u_xlat0.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD1 = u_xlat0.x;
#endif
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * vec2(_DistortionTexTilingX, _DistortionTexTilingY);
#if defined(USE_DITHER_ALPHA)
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, _FaceFront.xyz);
    u_xlat16_2 = u_xlat1.x + (-_EyelashFaceCameraEdge2);
#else
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xyz, _FaceFront.xyz);
    u_xlat16_2 = u_xlat0.x + (-_EyelashFaceCameraEdge2);
#endif
    u_xlat16_5 = (-_EyelashFaceCameraEdge2) + _EyelashFaceCameraEdge1;
    u_xlat16_5 = float(1.0) / u_xlat16_5;
    u_xlat16_2 = u_xlat16_5 * u_xlat16_2;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = u_xlat16_2 * -2.0 + 3.0;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD6 = u_xlat16_2 * _EyelashTransparent;
#if defined(USE_DITHER_ALPHA)
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _SekaiGlobalEyeTime;
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiCharacterAmbientLightIntensityArray[12];
uniform 	vec4 _SekaiCharacterAmbientLightColorArray[12];
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
#if defined(USE_DITHER_ALPHA)
uniform 	mediump float _DitherAlpha;
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_EyeFlipbookTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_SheetValue;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookCurrentFrame;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookEnabled;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetX;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetY;
	UNITY_UNIFORM mediump float                _Threshold;
	UNITY_UNIFORM mediump float                _LightInfluenceForEyeHighlight;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_EmissionColor;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_LightInfluence;
	UNITY_UNIFORM mediump float                _EyelashTransparent;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float                _EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_TintColor;
	UNITY_UNIFORM mediump vec3                _FaceFront;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DistortionTex_ST;
	UNITY_UNIFORM float                _DistortionTexTilingX;
	UNITY_UNIFORM float                _DistortionTexTilingY;
	UNITY_UNIFORM float                _DistortionIntensity;
	UNITY_UNIFORM float                _DistortionIntensityX;
	UNITY_UNIFORM float                _DistortionIntensityY;
	UNITY_UNIFORM float                _DistortionOffsetX;
	UNITY_UNIFORM float                _DistortionOffsetY;
	UNITY_UNIFORM float                _DistortionScrollX;
	UNITY_UNIFORM float                _DistortionScrollY;
	UNITY_UNIFORM float                _DistortionScrollSpeed;
	UNITY_UNIFORM float                _DistortionFPS;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistortionTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
#if defined(USE_DITHER_ALPHA)
UNITY_LOCATION(2) uniform mediump sampler2D _DitherTex;
#endif
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD4;
in highp vec2 vs_TEXCOORD5;
in mediump float vs_TEXCOORD6;
#if defined(USE_DITHER_ALPHA)
in highp vec4 vs_TEXCOORD7;
#endif
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
#if defined(USE_DITHER_ALPHA)
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec3 u_xlatb2;
#else
vec3 u_xlat1;
bvec3 u_xlatb1;
mediump vec3 u_xlat16_2;
#endif
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
#if defined(USE_DITHER_ALPHA)
float u_xlat8;
#else
float u_xlat7;
#endif
float u_xlat18;
int u_xlati18;
bool u_xlatb18;
void main()
{
#if defined(USE_DITHER_ALPHA)
    u_xlat0.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat16_0.x = texture(_DitherTex, u_xlat0.xy, _GlobalMipBias.x).x;
    u_xlat16_1.x = (-u_xlat16_0.x) + _DitherAlpha;
    u_xlatb0 = u_xlat16_1.x<0.0;
    if(u_xlatb0){discard;}
#endif
    u_xlat0.x = _SekaiGlobalEyeTime * _DistortionFPS;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _DistortionFPS;
#if defined(USE_DITHER_ALPHA)
    u_xlat2.x = u_xlat0.x * _DistortionScrollX;
    u_xlat2.y = u_xlat0.x * _DistortionScrollY;
    u_xlat0.xy = (-u_xlat2.xy) * vec2(vec2(_DistortionScrollSpeed, _DistortionScrollSpeed)) + vs_TEXCOORD5.xy;
#else
    u_xlat1.x = u_xlat0.x * _DistortionScrollX;
    u_xlat1.y = u_xlat0.x * _DistortionScrollY;
    u_xlat0.xy = (-u_xlat1.xy) * vec2(vec2(_DistortionScrollSpeed, _DistortionScrollSpeed)) + vs_TEXCOORD5.xy;
#endif
    u_xlat16_0.xy = texture(_DistortionTex, u_xlat0.xy).xy;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat16_1.xy + vec2(_DistortionOffsetX, _DistortionOffsetY);
    u_xlat2.x = _DistortionIntensity * _DistortionIntensityX;
    u_xlat2.y = _DistortionIntensity * _DistortionIntensityY;
    u_xlat0.xy = u_xlat0.xy * u_xlat2.xy + vs_TEXCOORD0.xy;
#else
    u_xlat16_2.xy = u_xlat16_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat16_2.xy + vec2(_DistortionOffsetX, _DistortionOffsetY);
    u_xlat1.x = _DistortionIntensity * _DistortionIntensityX;
    u_xlat1.y = _DistortionIntensity * _DistortionIntensityY;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy + vs_TEXCOORD0.xy;
#endif
    u_xlat0.xyz = texture(_MainTex, u_xlat0.xy, _GlobalMipBias.x).xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.x = u_xlat0.x + (-_Threshold);
    u_xlatb18 = u_xlat16_1.x<0.0;
#else
    u_xlat16_2.x = u_xlat0.x + (-_Threshold);
    u_xlatb18 = u_xlat16_2.x<0.0;
#endif
    if(u_xlatb18){discard;}
#if defined(USE_DITHER_ALPHA)
    u_xlatb2.xyz = greaterThanEqual(u_xlat0.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_1.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_1.y = (u_xlatb2.y) ? float(1.0) : float(0.0);
    u_xlat16_1.z = (u_xlatb2.z) ? float(1.0) : float(0.0);
#else
    u_xlatb1.xyz = greaterThanEqual(u_xlat0.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_2.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlati18 = _CharacterId;
#if defined(USE_DITHER_ALPHA)
    u_xlat2.xyz = u_xlat16_3.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati18].xyz;
#else
    u_xlat1.xyz = u_xlat16_3.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati18].xyz;
#endif
    u_xlat16_4.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat5.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati18].xyz);
    u_xlat5.xyz = (-u_xlat16_4.xyz) * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati18].xyz + u_xlat5.xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati18]);
    u_xlat5.xyz = u_xlat2.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat2.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
#else
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati18]);
    u_xlat5.xyz = u_xlat1.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_2.xyz = (-u_xlat1.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
#endif
    u_xlat16_3.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat5.xyz * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
#else
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat5.xyz * _PartsAmbientColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = _PartsAmbientColor.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
#endif
    u_xlatb18 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb18){
#if defined(USE_DITHER_ALPHA)
        u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat2.xy = u_xlat2.xy * u_xlat2.xy;
        u_xlat18 = u_xlat2.y + u_xlat2.x;
        u_xlat18 = u_xlat2.z * u_xlat2.z + u_xlat18;
        u_xlat2.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#else
        u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xy = u_xlat1.xy * u_xlat1.xy;
        u_xlat18 = u_xlat1.y + u_xlat1.x;
        u_xlat18 = u_xlat1.z * u_xlat1.z + u_xlat18;
        u_xlat1.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
#endif
        u_xlat18 = u_xlat18 + (-_SekaiGlobalSpotLightRadiusNear);
#if defined(USE_DITHER_ALPHA)
        u_xlat2.x = float(1.0) / u_xlat2.x;
        u_xlat18 = u_xlat18 * u_xlat2.x;
#else
        u_xlat1.x = float(1.0) / u_xlat1.x;
        u_xlat18 = u_xlat18 * u_xlat1.x;
#endif
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#if defined(USE_DITHER_ALPHA)
        u_xlat2.x = u_xlat18 * -2.0 + 3.0;
#else
        u_xlat1.x = u_xlat18 * -2.0 + 3.0;
#endif
        u_xlat18 = u_xlat18 * u_xlat18;
#if defined(USE_DITHER_ALPHA)
        u_xlat8 = u_xlat18 * u_xlat2.x;
        u_xlat18 = (-u_xlat2.x) * u_xlat18 + 1.0;
        u_xlat2.xyz = u_xlat16_1.xyz * vec3(u_xlat8);
        u_xlat2.xyz = u_xlat2.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat2.xyz = vec3(u_xlat18) * u_xlat16_1.xyz + u_xlat2.xyz;
#else
        u_xlat7 = u_xlat18 * u_xlat1.x;
        u_xlat18 = (-u_xlat1.x) * u_xlat18 + 1.0;
        u_xlat1.xyz = u_xlat16_2.xyz * vec3(u_xlat7);
        u_xlat1.xyz = u_xlat1.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat1.xyz = vec3(u_xlat18) * u_xlat16_2.xyz + u_xlat1.xyz;
#endif
    } else {
#if defined(USE_DITHER_ALPHA)
        u_xlat2.xyz = u_xlat16_1.xyz;
#else
        u_xlat1.xyz = u_xlat16_2.xyz;
#endif
    }
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    SV_Target0.xyz = vec3(vec3(_LightInfluenceForEyeHighlight, _LightInfluenceForEyeHighlight, _LightInfluenceForEyeHighlight)) * u_xlat16_1.xyz + u_xlat0.xyz;
#else
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(vec3(_LightInfluenceForEyeHighlight, _LightInfluenceForEyeHighlight, _LightInfluenceForEyeHighlight)) * u_xlat16_2.xyz + u_xlat0.xyz;
#endif
    SV_Target0.w = u_xlat0.x * vs_TEXCOORD6;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "EYEHIGHLIGHT-RP"
			Tags { "LIGHTMODE"="SekaiBase" "QUEUE"="AlphaTest" "RenderType"="Opaque" }
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 rp_FogFactor;
uniform 	mediump vec4 rp_FogColor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_WorldToObject[4];
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
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_EyeFlipbookTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_SheetValue;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookCurrentFrame;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookEnabled;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetX;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetY;
	UNITY_UNIFORM mediump float                _Threshold;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_LightInfluenceForEyeHighlight;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_EmissionColor;
	UNITY_UNIFORM mediump float                _LightInfluence;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashTransparent;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump vec4                _TintColor;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_FaceFront;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DistortionTex_ST;
	UNITY_UNIFORM float                _DistortionTexTilingX;
	UNITY_UNIFORM float                _DistortionTexTilingY;
	UNITY_UNIFORM float                _DistortionIntensity;
	UNITY_UNIFORM float                _DistortionIntensityX;
	UNITY_UNIFORM float                _DistortionIntensityY;
	UNITY_UNIFORM float                _DistortionOffsetX;
	UNITY_UNIFORM float                _DistortionOffsetY;
	UNITY_UNIFORM float                _DistortionScrollX;
	UNITY_UNIFORM float                _DistortionScrollY;
	UNITY_UNIFORM float                _DistortionScrollSpeed;
	UNITY_UNIFORM float                _DistortionFPS;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.z + _ProjectionParams.y;
    vs_TEXCOORD2 = u_xlat0;
    u_xlat0.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-rp_FogFactor.xxxy.w) * u_xlat0.x + rp_FogFactor.xxxy.z;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * rp_FogColor.w;
    vs_TEXCOORD1 = u_xlat0.x;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * vec2(_DistortionTexTilingX, _DistortionTexTilingY);
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
uniform 	mediump vec4 rp_CharacterAmbientLightColorArray[10];
uniform 	float rp_CharacterAmbientLightIntensityArray[10];
uniform 	mediump vec4 rp_FogColor;
uniform 	mediump vec4 rp_HeightFogColor;
uniform 	float _SekaiGlobalEyeTime;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_EyeFlipbookTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_SheetValue;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookCurrentFrame;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookEnabled;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetX;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetY;
	UNITY_UNIFORM mediump float                _Threshold;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_LightInfluenceForEyeHighlight;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_EmissionColor;
	UNITY_UNIFORM mediump float                _LightInfluence;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashTransparent;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump vec4                _TintColor;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_FaceFront;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DistortionTex_ST;
	UNITY_UNIFORM float                _DistortionTexTilingX;
	UNITY_UNIFORM float                _DistortionTexTilingY;
	UNITY_UNIFORM float                _DistortionIntensity;
	UNITY_UNIFORM float                _DistortionIntensityX;
	UNITY_UNIFORM float                _DistortionIntensityY;
	UNITY_UNIFORM float                _DistortionOffsetX;
	UNITY_UNIFORM float                _DistortionOffsetY;
	UNITY_UNIFORM float                _DistortionScrollX;
	UNITY_UNIFORM float                _DistortionScrollY;
	UNITY_UNIFORM float                _DistortionScrollSpeed;
	UNITY_UNIFORM float                _DistortionFPS;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistortionTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
layout(location = 1) out highp vec4 SV_Target1;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bvec3 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
int u_xlati18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = _SekaiGlobalEyeTime * _DistortionFPS;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _DistortionFPS;
    u_xlat1.x = u_xlat0.x * _DistortionScrollX;
    u_xlat1.y = u_xlat0.x * _DistortionScrollY;
    u_xlat0.xy = (-u_xlat1.xy) * vec2(vec2(_DistortionScrollSpeed, _DistortionScrollSpeed)) + vs_TEXCOORD4.xy;
    u_xlat16_0.xy = texture(_DistortionTex, u_xlat0.xy).xy;
    u_xlat16_2.xy = u_xlat16_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat16_2.xy + vec2(_DistortionOffsetX, _DistortionOffsetY);
    u_xlat1.x = _DistortionIntensity * _DistortionIntensityX;
    u_xlat1.y = _DistortionIntensity * _DistortionIntensityY;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_0.xyz = texture(_MainTex, u_xlat0.xy, _GlobalMipBias.x).xyz;
    u_xlat16_2.x = u_xlat16_0.x + (-_Threshold);
    u_xlatb18 = u_xlat16_2.x<0.0;
    if(u_xlatb18){discard;}
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) * _TintColor.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    u_xlati18 = _CharacterId;
    u_xlat16_3.xyz = vec3(1.0, 1.0, 1.0) + (-rp_CharacterAmbientLightColorArray[u_xlati18].xyz);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_0.xyz * _TintColor.xyz;
    SV_Target0.w = u_xlat16_0.x;
    u_xlat16_4.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) * rp_CharacterAmbientLightColorArray[u_xlati18].xyz + u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * rp_CharacterAmbientLightColorArray[u_xlati18].xyz;
    u_xlatb0.xyz = greaterThanEqual(u_xlat16_3.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_5.x = (u_xlatb0.x) ? float(1.0) : float(0.0);
    u_xlat16_5.y = (u_xlatb0.y) ? float(1.0) : float(0.0);
    u_xlat16_5.z = (u_xlatb0.z) ? float(1.0) : float(0.0);
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(rp_CharacterAmbientLightIntensityArray[u_xlati18]);
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(rp_GlobalIntensity) + (-u_xlat16_3.xyz);
    u_xlat16_2.xyz = vec3(_LightInfluence) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = (-u_xlat16_2.xyz) + rp_FogColor.xyz;
    u_xlat0.xyz = vec3(vs_TEXCOORD1) * u_xlat0.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + rp_HeightFogColor.xyz;
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "EYEHIGHLIGHT-RP-OVER"
			Tags { "LIGHTMODE"="SekaiBaseOver" "QUEUE"="AlphaTest" "RenderType"="Opaque" }
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 rp_FogFactor;
uniform 	mediump vec4 rp_FogColor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_WorldToObject[4];
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
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_EyeFlipbookTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_SheetValue;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookCurrentFrame;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookEnabled;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetX;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetY;
	UNITY_UNIFORM mediump float                _Threshold;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_LightInfluenceForEyeHighlight;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_EmissionColor;
	UNITY_UNIFORM mediump float                _LightInfluence;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashTransparent;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump vec4                _TintColor;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_FaceFront;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DistortionTex_ST;
	UNITY_UNIFORM float                _DistortionTexTilingX;
	UNITY_UNIFORM float                _DistortionTexTilingY;
	UNITY_UNIFORM float                _DistortionIntensity;
	UNITY_UNIFORM float                _DistortionIntensityX;
	UNITY_UNIFORM float                _DistortionIntensityY;
	UNITY_UNIFORM float                _DistortionOffsetX;
	UNITY_UNIFORM float                _DistortionOffsetY;
	UNITY_UNIFORM float                _DistortionScrollX;
	UNITY_UNIFORM float                _DistortionScrollY;
	UNITY_UNIFORM float                _DistortionScrollSpeed;
	UNITY_UNIFORM float                _DistortionFPS;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.z + _ProjectionParams.y;
    vs_TEXCOORD2 = u_xlat0;
    u_xlat0.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-rp_FogFactor.xxxy.w) * u_xlat0.x + rp_FogFactor.xxxy.z;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * rp_FogColor.w;
    vs_TEXCOORD1 = u_xlat0.x;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * vec2(_DistortionTexTilingX, _DistortionTexTilingY);
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
uniform 	mediump vec4 rp_CharacterAmbientLightColorArray[10];
uniform 	float rp_CharacterAmbientLightIntensityArray[10];
uniform 	mediump vec4 rp_FogColor;
uniform 	mediump vec4 rp_HeightFogColor;
uniform 	float _SekaiGlobalEyeTime;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_EyeFlipbookTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_SheetValue;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookCurrentFrame;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookEnabled;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetX;
	UNITY_UNIFORM float Xhlslcc_UnusedX_EyeFlipbookOffsetY;
	UNITY_UNIFORM mediump float                _Threshold;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_LightInfluenceForEyeHighlight;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_EmissionColor;
	UNITY_UNIFORM mediump float                _LightInfluence;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashTransparent;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge1;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_EyelashFaceCameraEdge2;
	UNITY_UNIFORM mediump vec4                _TintColor;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_FaceFront;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_PartsAmbientColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DistortionTex_ST;
	UNITY_UNIFORM float                _DistortionTexTilingX;
	UNITY_UNIFORM float                _DistortionTexTilingY;
	UNITY_UNIFORM float                _DistortionIntensity;
	UNITY_UNIFORM float                _DistortionIntensityX;
	UNITY_UNIFORM float                _DistortionIntensityY;
	UNITY_UNIFORM float                _DistortionOffsetX;
	UNITY_UNIFORM float                _DistortionOffsetY;
	UNITY_UNIFORM float                _DistortionScrollX;
	UNITY_UNIFORM float                _DistortionScrollY;
	UNITY_UNIFORM float                _DistortionScrollSpeed;
	UNITY_UNIFORM float                _DistortionFPS;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistortionTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
layout(location = 1) out highp vec4 SV_Target1;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bvec3 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
int u_xlati18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = _SekaiGlobalEyeTime * _DistortionFPS;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _DistortionFPS;
    u_xlat1.x = u_xlat0.x * _DistortionScrollX;
    u_xlat1.y = u_xlat0.x * _DistortionScrollY;
    u_xlat0.xy = (-u_xlat1.xy) * vec2(vec2(_DistortionScrollSpeed, _DistortionScrollSpeed)) + vs_TEXCOORD4.xy;
    u_xlat16_0.xy = texture(_DistortionTex, u_xlat0.xy).xy;
    u_xlat16_2.xy = u_xlat16_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat16_2.xy + vec2(_DistortionOffsetX, _DistortionOffsetY);
    u_xlat1.x = _DistortionIntensity * _DistortionIntensityX;
    u_xlat1.y = _DistortionIntensity * _DistortionIntensityY;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_0.xyz = texture(_MainTex, u_xlat0.xy, _GlobalMipBias.x).xyz;
    u_xlat16_2.x = u_xlat16_0.x + (-_Threshold);
    u_xlatb18 = u_xlat16_2.x<0.0;
    if(u_xlatb18){discard;}
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) * _TintColor.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    u_xlati18 = _CharacterId;
    u_xlat16_3.xyz = vec3(1.0, 1.0, 1.0) + (-rp_CharacterAmbientLightColorArray[u_xlati18].xyz);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_0.xyz * _TintColor.xyz;
    SV_Target0.w = u_xlat16_0.x;
    u_xlat16_4.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) * rp_CharacterAmbientLightColorArray[u_xlati18].xyz + u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * rp_CharacterAmbientLightColorArray[u_xlati18].xyz;
    u_xlatb0.xyz = greaterThanEqual(u_xlat16_3.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_5.x = (u_xlatb0.x) ? float(1.0) : float(0.0);
    u_xlat16_5.y = (u_xlatb0.y) ? float(1.0) : float(0.0);
    u_xlat16_5.z = (u_xlatb0.z) ? float(1.0) : float(0.0);
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(rp_CharacterAmbientLightIntensityArray[u_xlati18]);
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(rp_GlobalIntensity) + (-u_xlat16_3.xyz);
    u_xlat16_2.xyz = vec3(_LightInfluence) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = (-u_xlat16_2.xyz) + rp_FogColor.xyz;
    u_xlat0.xyz = vec3(vs_TEXCOORD1) * u_xlat0.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + rp_HeightFogColor.xyz;
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}
#endif
			ENDGLSL
		}
	}
}
