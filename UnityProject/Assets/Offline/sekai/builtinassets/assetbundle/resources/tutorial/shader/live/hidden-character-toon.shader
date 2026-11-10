// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Hidden/Sekai/Live/Character/Toon"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ShadowTex("Shadow", 2D) = "white" {}
		_ValueTex("Value", 2D) = "black" {}
		_OutlineWidth("OutlineWidth", Float) = 0.001
		_RimThreshold("RimThreshold", Range(0.01, 1)) = 0.2
		[HideInInspector] _PartsAmbientColor("Parts Ambient Color", Color) = (1, 1, 1, 1)
		[HideInInspector] _CharacterId("CharacterId", Float) = 0
		[HideInInspector] _DefaultSkinColor("DefaultSkinColor", Color) = (0.9921875, 0.9609375, 0.921875, 1)
		[HideInInspector] _Shadow1SkinColor("Shadow1SkinColor", Color) = (0.890625, 0.76953125, 0.796875, 1)
		[HideInInspector] _Shadow2SkinColor("Shadow2SkinColor", Color) = (0.796875, 0.59375, 0.63671875, 1)
		[HideInInspector] _CharacterReflectionOff("CharacterReflectionOff", Float) = 0
		[HideInInspector] _ShadowTexWeight("ShadowTexWeight", Range(0, 1)) = 1
		[Enum(FadeOut,0, Spread,1)] [HideInInspector] _FadeMode("FadeMode", Float) = 0
		[HideInInspector] _ShadowWidth("Shadow Width", Range(0, 1)) = 0
		[HideInInspector] _HueCosAngle("Hue Cos Angle", Float) = 1
		[HideInInspector] _HueSinAngle("Hue Sin Angle", Float) = 0
		[HideInInspector] _Saturation("Saturation", Range(0, 1)) = 0.5
		[HideInInspector] _Value("Value", Range(0, 1)) = 0.5
		[HideInInspector] _Contrast("Contrast", Range(0, 1)) = 0.5
	}
	SubShader
	{
		Tags { "QUEUE"="AlphaTest" "RenderType"="Opaque" }
		Pass
		{
			Name "BASE"
			Tags { "QUEUE"="AlphaTest" "RenderType"="Opaque" }
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
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM float                _ShadowTexWeight;
	UNITY_UNIFORM int                _FadeMode;
	UNITY_UNIFORM float                _ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_NORMAL0;
out highp float vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
#if defined(USE_DITHER_ALPHA)
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
#else
vec3 u_xlat0;
#endif
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
#if defined(USE_DITHER_ALPHA)
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
#else
float u_xlat9;
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
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = max(u_xlat12, 1.17549435e-38);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_NORMAL0.xyz = vec3(u_xlat12) * u_xlat2.xyz;
#else
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = max(u_xlat9, 1.17549435e-38);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat2.xyz;
#endif
    vs_TEXCOORD5 = u_xlat1.z;
    vs_TEXCOORD0 = u_xlat1;
#if !defined(USE_DITHER_ALPHA)
    u_xlat9 = u_xlat1.z + _ProjectionParams.y;
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#if defined(USE_DITHER_ALPHA)
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
#else
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
#endif
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlatb0 = unity_OrthoParams.w==0.0;
#if defined(USE_DITHER_ALPHA)
    u_xlat3.x = (u_xlatb0) ? u_xlat2.x : hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = (u_xlatb0) ? u_xlat2.y : hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = (u_xlatb0) ? u_xlat2.z : hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
#else
    u_xlat2.x = (u_xlatb0) ? u_xlat1.x : hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = (u_xlatb0) ? u_xlat1.y : hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = (u_xlatb0) ? u_xlat1.z : hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
#endif
    u_xlat0.x = inversesqrt(u_xlat0.x);
#if defined(USE_DITHER_ALPHA)
    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = u_xlat1.z + _ProjectionParams.y;
    u_xlat4 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat4;
#else
    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat9 / u_xlat0.x;
#endif
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD4 = u_xlat0.x;
#if defined(USE_DITHER_ALPHA)
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
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
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM float                _ShadowTexWeight;
	UNITY_UNIFORM int                _FadeMode;
	UNITY_UNIFORM float                _ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
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
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
#if defined(USE_DITHER_ALPHA)
in highp vec4 vs_TEXCOORD6;
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
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
#else
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec4 u_xlat2;
#endif
mediump vec3 u_xlat16_2;
#if defined(USE_DITHER_ALPHA)
int u_xlati2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
#else
mediump vec4 u_xlat16_3;
#endif
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
#if defined(USE_DITHER_ALPHA)
mediump float u_xlat16_9;
vec3 u_xlat10;
bvec3 u_xlatb10;
#else
vec3 u_xlat9;
bvec3 u_xlatb9;
mediump float u_xlat16_11;
#endif
vec3 u_xlat12;
mediump vec3 u_xlat16_13;
#if defined(USE_DITHER_ALPHA)
mediump float u_xlat16_17;
#else
float u_xlat17;
#endif
float u_xlat18;
#if defined(USE_DITHER_ALPHA)
float u_xlat19;
int u_xlati19;
mediump float u_xlat16_25;
#else
int u_xlati18;
mediump float u_xlat16_19;
float u_xlat25;
bool u_xlatb25;
#endif
float u_xlat26;
#if defined(USE_DITHER_ALPHA)
bool u_xlatb26;
float u_xlat27;
int u_xlati27;
#else
int u_xlati26;
mediump float u_xlat16_27;
#endif
void main()
{
#if defined(USE_DITHER_ALPHA)
    u_xlat0.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat16_0.x = texture(_DitherTex, u_xlat0.xy, _GlobalMipBias.x).x;
    u_xlat16_1.x = (-u_xlat16_0.x) + _DitherAlpha;
    u_xlatb0 = u_xlat16_1.x<0.0;
    if(u_xlatb0){discard;}
#endif
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat2.xyz = (-u_xlat16_0.xyz) + u_xlat16_2.xyz;
    u_xlat26 = u_xlat2.x * _ShadowTexWeight;
    u_xlat2.xyz = vec3(_ShadowTexWeight) * u_xlat2.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_1.x = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat16_9 = _Saturation + _Saturation;
    u_xlat16_17 = _Value * 2.0 + -1.0;
    u_xlat16_25 = _Contrast + _Contrast;
#else
    u_xlat16_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat1.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    u_xlat25 = u_xlat1.x * _ShadowTexWeight;
    u_xlat1.xyz = vec3(_ShadowTexWeight) * u_xlat1.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_3.x = u_xlat16_2.z * 2.0 + -1.0;
    u_xlat16_11 = _Saturation + _Saturation;
    u_xlat16_19 = _Value * 2.0 + -1.0;
    u_xlat16_27 = _Contrast + _Contrast;
#endif
    u_xlat4.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat4.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat4.zxy);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_HueSinAngle);
    u_xlat4.xyz = u_xlat16_0.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat4.xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat19 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat19 = u_xlat19 * 0.57735002;
#else
    u_xlat18 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat18 = u_xlat18 * 0.57735002;
#endif
    u_xlat16_5.x = (-_HueCosAngle) + 1.0;
#if defined(USE_DITHER_ALPHA)
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat16_5.xxx + u_xlat4.xyz;
#else
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat16_5.xxx + u_xlat4.xyz;
#endif
    u_xlat16_13.xyz = u_xlat4.xyz + vec3(-0.5, -0.5, -0.5);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_13.xyz = u_xlat16_13.xyz * vec3(u_xlat16_25) + vec3(u_xlat16_17);
#else
    u_xlat16_13.xyz = u_xlat16_13.xyz * vec3(u_xlat16_27) + vec3(u_xlat16_19);
#endif
    u_xlat16_13.xyz = u_xlat16_13.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_6.x = dot(u_xlat16_13.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_13.xyz = u_xlat16_13.xyz + (-u_xlat16_6.xxx);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_13.xyz = vec3(u_xlat16_9) * u_xlat16_13.xyz + u_xlat16_6.xxx;
    u_xlat19 = dot(_SekaiDirectionalLight.xyz, vs_NORMAL0.xyz);
    u_xlat19 = u_xlat19 * 0.5 + 0.5;
#else
    u_xlat16_13.xyz = vec3(u_xlat16_11) * u_xlat16_13.xyz + u_xlat16_6.xxx;
    u_xlat18 = dot(_SekaiDirectionalLight.xyz, vs_NORMAL0.xyz);
    u_xlat18 = u_xlat18 * 0.5 + 0.5;
#endif
    switch(_FadeMode){
        case 0:
            u_xlat4.x = _ShadowWidth * (-_SekaiShadowThreshold) + _SekaiShadowThreshold;
#if defined(USE_DITHER_ALPHA)
            u_xlat12.x = u_xlat16_1.x + u_xlat19;
#else
            u_xlat12.x = u_xlat16_3.x + u_xlat18;
#endif
            u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
            u_xlat12.x = (-u_xlat4.x) + u_xlat12.x;
            u_xlat4.x = (-u_xlat4.x) + _SekaiShadowThreshold;
            u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
            u_xlat4.x = u_xlat12.x / u_xlat4.x;
            u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
            u_xlat12.x = u_xlat4.x * u_xlat4.x;
            u_xlat4.x = (-u_xlat4.x) * 2.0 + 3.0;
#if defined(USE_DITHER_ALPHA)
            u_xlat27 = (-u_xlat12.x) * u_xlat4.x + 1.0;
#else
            u_xlat26 = (-u_xlat12.x) * u_xlat4.x + 1.0;
#endif
            break;
        case 1:
            u_xlat4.x = (-_SekaiShadowThreshold) + 1.0;
            u_xlat4.x = u_xlat4.x * _ShadowWidth;
#if defined(USE_DITHER_ALPHA)
            u_xlat19 = u_xlat16_1.x + u_xlat19;
            u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
            u_xlat19 = u_xlat19 + (-_SekaiShadowThreshold);
#else
            u_xlat18 = u_xlat16_3.x + u_xlat18;
            u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
            u_xlat18 = u_xlat18 + (-_SekaiShadowThreshold);
#endif
            u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
#if defined(USE_DITHER_ALPHA)
            u_xlat19 = u_xlat19 / u_xlat4.x;
            u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
            u_xlat4.x = u_xlat19 * u_xlat19;
            u_xlat19 = (-u_xlat19) * 2.0 + 3.0;
            u_xlat27 = (-u_xlat4.x) * u_xlat19 + 1.0;
#else
            u_xlat18 = u_xlat18 / u_xlat4.x;
            u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
            u_xlat4.x = u_xlat18 * u_xlat18;
            u_xlat18 = (-u_xlat18) * 2.0 + 3.0;
            u_xlat26 = (-u_xlat4.x) * u_xlat18 + 1.0;
#endif
            break;
        default:
            break;
    }
#if defined(USE_DITHER_ALPHA)
    u_xlat2.xyz = u_xlat2.xyz * _SekaiShadowColor.xyz + (-u_xlat16_13.xyz);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz + u_xlat16_13.xyz;
    u_xlat26 = u_xlat27 * u_xlat26 + u_xlat16_0.x;
#else
    u_xlat1.xyz = u_xlat1.xyz * _SekaiShadowColor.xyz + (-u_xlat16_13.xyz);
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat1.xyz + u_xlat16_13.xyz;
    u_xlat25 = u_xlat26 * u_xlat25 + u_xlat16_0.x;
#endif
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat7.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.x = u_xlat26 + u_xlat26;
    u_xlat16_13.x = u_xlat26 * 2.0 + -1.0;
#else
    u_xlat16_3.x = u_xlat25 + u_xlat25;
    u_xlat16_13.x = u_xlat25 * 2.0 + -1.0;
#endif
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
    u_xlat16_6.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_13.xyz = u_xlat16_13.xxx * u_xlat16_6.xyz + u_xlat4.xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.x = u_xlat16_1.x;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#else
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_13.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_13.xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_13.xyz = u_xlat16_1.xxx * u_xlat16_13.xyz + u_xlat7.xyz;
#else
    u_xlat16_13.xyz = u_xlat16_3.xxx * u_xlat16_13.xyz + u_xlat7.xyz;
#endif
    u_xlat4.xyz = u_xlat16_13.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat4.xyz = u_xlat16_13.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat4.zxy);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_HueSinAngle);
    u_xlat4.xyz = u_xlat16_13.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat4.xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat26 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_13.xyz);
    u_xlat26 = u_xlat26 * 0.57735002;
    u_xlat4.xyz = vec3(u_xlat26) * u_xlat16_5.xxx + u_xlat4.xyz;
#else
    u_xlat25 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_13.xyz);
    u_xlat25 = u_xlat25 * 0.57735002;
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat16_5.xxx + u_xlat4.xyz;
#endif
    u_xlat16_5.xyz = u_xlat4.xyz + vec3(-0.5, -0.5, -0.5);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xzw = u_xlat16_5.xyz * vec3(u_xlat16_25) + vec3(u_xlat16_17);
    u_xlat16_1.xzw = u_xlat16_1.xzw + vec3(0.5, 0.5, 0.5);
    u_xlat16_5.x = dot(u_xlat16_1.xzw, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_1.xzw = u_xlat16_1.xzw + (-u_xlat16_5.xxx);
    u_xlat16_1.xyz = vec3(u_xlat16_9) * u_xlat16_1.xzw + u_xlat16_5.xxx;
    u_xlatb26 = u_xlat16_3.x>=0.5;
    u_xlat16_25 = (u_xlatb26) ? 1.0 : 0.0;
    u_xlat16_1.xyz = (-u_xlat2.xyz) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz + u_xlat2.xyz;
    u_xlati2 = _CharacterId;
    u_xlat10.xyz = _SekaiRimLightColorArray[u_xlati2].www * _SekaiRimLightColorArray[u_xlati2].xyz;
    u_xlat3.x = dot(vs_NORMAL0.xyz, vs_TEXCOORD2.xyz);
    u_xlat3.z = dot(vs_TEXCOORD2.xyz, _SekaiRimLightArray[u_xlati2].xyz);
    u_xlat27 = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_NORMAL0.xyz;
    u_xlat27 = dot(_SekaiRimLightArray[u_xlati2].xyz, _SekaiRimLightArray[u_xlati2].xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.xyz = vec3(u_xlat27) * _SekaiRimLightArray[u_xlati2].xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat7.xyz);
    u_xlat16_25 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati2];
    u_xlat16_5.x = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati2]);
    u_xlat4.x = (-u_xlat16_25) + u_xlat16_5.x;
    u_xlat12.x = (-u_xlat16_25) + u_xlat27;
#else
    u_xlat16_3.xzw = u_xlat16_5.xyz * vec3(u_xlat16_27) + vec3(u_xlat16_19);
    u_xlat16_3.xzw = u_xlat16_3.xzw + vec3(0.5, 0.5, 0.5);
    u_xlat16_5.x = dot(u_xlat16_3.xzw, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.xzw = u_xlat16_3.xzw + (-u_xlat16_5.xxx);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * u_xlat16_3.xzw + u_xlat16_5.xxx;
    u_xlatb25 = u_xlat16_2.x>=0.5;
    u_xlat16_27 = (u_xlatb25) ? 1.0 : 0.0;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_27) * u_xlat16_3.xyz + u_xlat1.xyz;
    u_xlati1 = _CharacterId;
    u_xlat9.xyz = _SekaiRimLightColorArray[u_xlati1].www * _SekaiRimLightColorArray[u_xlati1].xyz;
    u_xlat2.x = dot(vs_NORMAL0.xyz, vs_TEXCOORD2.xyz);
    u_xlat2.z = dot(vs_TEXCOORD2.xyz, _SekaiRimLightArray[u_xlati1].xyz);
    u_xlat26 = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat4.xyz = vec3(u_xlat26) * vs_NORMAL0.xyz;
    u_xlat26 = dot(_SekaiRimLightArray[u_xlati1].xyz, _SekaiRimLightArray[u_xlati1].xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat7.xyz = vec3(u_xlat26) * _SekaiRimLightArray[u_xlati1].xyz;
    u_xlat26 = dot(u_xlat4.xyz, u_xlat7.xyz);
    u_xlat16_27 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati1];
    u_xlat16_5.x = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati1]);
    u_xlat4.x = (-u_xlat16_27) + u_xlat16_5.x;
    u_xlat12.x = u_xlat26 + (-u_xlat16_27);
#endif
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat12.x;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat12.x = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat12.x;
#if defined(USE_DITHER_ALPHA)
    u_xlat12.xyz = _SekaiShadowRimLightColorArray[u_xlati2].xyz * _SekaiShadowRimLightColorArray[u_xlati2].www + (-u_xlat10.xyz);
    u_xlat10.xyz = u_xlat4.xxx * u_xlat12.xyz + u_xlat10.xyz;
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_25 = 10.0 + (-_SekaiRimLightFactor[u_xlati2].x);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat16_25 * u_xlat3.x;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat19 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati2].w * u_xlat19 + u_xlat3.x;
    u_xlat19 = (-u_xlat27) + 0.0500000007;
    u_xlati27 = int((0.0<u_xlat19) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = int((u_xlat19<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = (-u_xlati27) + u_xlati19;
    u_xlat19 = float(u_xlati19);
    u_xlat19 = u_xlat3.x * u_xlat19 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati2].w * u_xlat19 + u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-_RimThreshold);
    u_xlat19 = float(1.0) / _SekaiRimLightFactor[u_xlati2].z;
    u_xlat3.x = u_xlat19 * u_xlat3.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat19 = u_xlat3.x * -2.0 + 3.0;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat19;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.xzw = u_xlat10.xyz * vs_COLOR0.yyy;
    u_xlat16_1.xyz = u_xlat10.xyz * vs_COLOR0.yyy + u_xlat16_1.xyz;
    u_xlatb10.xyz = greaterThanEqual(u_xlat16_1.xyzz, vec4(0.5, 0.5, 0.5, 0.5)).xyz;
    u_xlat16_5.x = (u_xlatb10.x) ? float(1.0) : float(0.0);
    u_xlat16_5.y = (u_xlatb10.y) ? float(1.0) : float(0.0);
    u_xlat16_5.z = (u_xlatb10.z) ? float(1.0) : float(0.0);
    u_xlat16_6.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat10.xyz = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati2].xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati2].xyz);
    u_xlat4.xyz = (-u_xlat16_1.xyz) * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati2].xyz + u_xlat4.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati2]);
    u_xlat4.xyz = u_xlat10.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat10.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
#else
    u_xlat12.xyz = _SekaiShadowRimLightColorArray[u_xlati1].xyz * _SekaiShadowRimLightColorArray[u_xlati1].www + (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat4.xxx * u_xlat12.xyz + u_xlat9.xyz;
    u_xlat2.xz = max(u_xlat2.xz, vec2(0.0, 0.0));
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat16_27 = 10.0 + (-_SekaiRimLightFactor[u_xlati1].x);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * u_xlat16_27;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat18 = u_xlat2.x * u_xlat2.z + (-u_xlat2.x);
    u_xlat2.x = _SekaiRimLightFactor[u_xlati1].w * u_xlat18 + u_xlat2.x;
    u_xlat18 = (-u_xlat26) + 0.0500000007;
    u_xlati26 = int((0.0<u_xlat18) ? 0xFFFFFFFFu : uint(0));
    u_xlati18 = int((u_xlat18<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati18 = (-u_xlati26) + u_xlati18;
    u_xlat18 = float(u_xlati18);
    u_xlat18 = u_xlat2.x * u_xlat18 + (-u_xlat2.x);
    u_xlat2.x = _SekaiRimLightFactor[u_xlati1].w * u_xlat18 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x + (-_RimThreshold);
    u_xlat18 = float(1.0) / _SekaiRimLightFactor[u_xlati1].z;
    u_xlat2.x = u_xlat18 * u_xlat2.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat18 = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat18;
    u_xlat9.xyz = u_xlat9.xyz * u_xlat2.xxx;
    u_xlat2.xzw = u_xlat9.xyz * vs_COLOR0.yyy;
    u_xlat16_3.xyz = u_xlat9.xyz * vs_COLOR0.yyy + u_xlat16_3.xyz;
    u_xlatb9.xyz = greaterThanEqual(u_xlat16_3.xyzz, vec4(0.5, 0.5, 0.5, 0.5)).xyz;
    u_xlat16_5.x = (u_xlatb9.x) ? float(1.0) : float(0.0);
    u_xlat16_5.y = (u_xlatb9.y) ? float(1.0) : float(0.0);
    u_xlat16_5.z = (u_xlatb9.z) ? float(1.0) : float(0.0);
    u_xlat16_6.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat9.xyz = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati1].xyz;
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat4.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati1].xyz);
    u_xlat4.xyz = (-u_xlat16_3.xyz) * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati1].xyz + u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati1]);
    u_xlat4.xyz = u_xlat9.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_3.xyz = (-u_xlat9.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
#endif
    u_xlat16_5.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat4.xyz * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlatb10.x = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb10.x){
        u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat10.xy = u_xlat10.xy * u_xlat10.xy;
        u_xlat10.x = u_xlat10.y + u_xlat10.x;
        u_xlat10.x = u_xlat10.z * u_xlat10.z + u_xlat10.x;
        u_xlat18 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat10.x = u_xlat10.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat18 = float(1.0) / u_xlat18;
        u_xlat10.x = u_xlat18 * u_xlat10.x;
        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
        u_xlat18 = u_xlat10.x * -2.0 + 3.0;
        u_xlat10.x = u_xlat10.x * u_xlat10.x;
        u_xlat26 = u_xlat10.x * u_xlat18;
        u_xlat10.x = (-u_xlat18) * u_xlat10.x + 1.0;
        u_xlat4.xyz = u_xlat16_1.xyz * vec3(u_xlat26);
#else
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat4.xyz * _PartsAmbientColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = _PartsAmbientColor.www * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlatb9.x = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb9.x){
        u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat9.xy = u_xlat9.xy * u_xlat9.xy;
        u_xlat9.x = u_xlat9.y + u_xlat9.x;
        u_xlat9.x = u_xlat9.z * u_xlat9.z + u_xlat9.x;
        u_xlat17 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat9.x = u_xlat9.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat17 = float(1.0) / u_xlat17;
        u_xlat9.x = u_xlat17 * u_xlat9.x;
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
        u_xlat17 = u_xlat9.x * -2.0 + 3.0;
        u_xlat9.x = u_xlat9.x * u_xlat9.x;
        u_xlat25 = u_xlat9.x * u_xlat17;
        u_xlat9.x = (-u_xlat17) * u_xlat9.x + 1.0;
        u_xlat4.xyz = u_xlat16_3.xyz * vec3(u_xlat25);
#endif
        u_xlat4.xyz = u_xlat4.xyz * _SekaiGlobalSpotLightColor.xyz;
#if defined(USE_DITHER_ALPHA)
        u_xlat10.xyz = u_xlat10.xxx * u_xlat16_1.xyz + u_xlat4.xyz;
#else
        u_xlat9.xyz = u_xlat9.xxx * u_xlat16_3.xyz + u_xlat4.xyz;
#endif
    } else {
#if defined(USE_DITHER_ALPHA)
        u_xlat10.xyz = u_xlat16_1.xyz;
#else
        u_xlat9.xyz = u_xlat16_3.xyz;
#endif
    }
#if defined(USE_DITHER_ALPHA)
    u_xlat3.xzw = u_xlat3.xzw * _SekaiRimLightFactor[u_xlati2].yyy;
    u_xlat3.xyz = u_xlat10.xyz * u_xlat16_3.yyy + u_xlat3.xzw;
    u_xlat16_1.x = (-vs_TEXCOORD4) + 1.0;
    u_xlat2.x = u_xlat16_1.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat10.xyz) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = u_xlat2.xxx * u_xlat4.xyz + u_xlat10.xyz;
    u_xlat2.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat10.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat10.x = u_xlat10.x + -1.0;
    u_xlat10.x = u_xlat10.x * _ProjectionParams.w;
    u_xlat2.x = u_xlat10.x * u_xlat2.x + _ProjectionParams.w;
    u_xlat2.x = (-_CoCParams.x) * u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * _CoCParams.y;
    u_xlat10.x = u_xlat2.x;
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, -1.0);
    u_xlat2.x = min(u_xlat2.x, 0.0);
    u_xlat2.x = u_xlat2.x + u_xlat10.x;
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
#else
    u_xlat2.xzw = u_xlat2.xzw * _SekaiRimLightFactor[u_xlati1].yyy;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat16_2.yyy + u_xlat2.xzw;
    u_xlat16_3.x = (-vs_TEXCOORD4) + 1.0;
    u_xlat1.x = u_xlat16_3.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat9.xyz) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = u_xlat1.xxx * u_xlat4.xyz + u_xlat9.xyz;
    u_xlat1.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat9.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9.x = u_xlat9.x + -1.0;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.w;
    u_xlat1.x = u_xlat9.x * u_xlat1.x + _ProjectionParams.w;
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
    u_xlat9.x = u_xlat1.x;
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
    u_xlat1.x = max(u_xlat1.x, -1.0);
    u_xlat1.x = min(u_xlat1.x, 0.0);
    u_xlat1.x = u_xlat1.x + u_xlat9.x;
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
#if defined(USE_DITHER_ALPHA)
    SV_Target2.xyz = u_xlat3.xyz;
#else
    SV_Target2.xyz = u_xlat2.xyz;
#endif
    SV_Target2.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "MONITOR"
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MonitorObjectPositionArray[12];
uniform 	vec4 _MonitorAccessoryPositionArray[10];
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
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM float                _ShadowTexWeight;
	UNITY_UNIFORM int                _FadeMode;
	UNITY_UNIFORM float                _ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float                _IsAccessory;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_NORMAL0;
out highp float vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
#if defined(USE_DITHER_ALPHA)
out highp vec4 vs_TEXCOORD6;
#endif
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
int u_xlati3;
#if defined(USE_DITHER_ALPHA)
float u_xlat6;
#endif
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlatb0 = 0.5<_IsAccessory;
    if(u_xlatb0){
        u_xlati0 = _CharacterId;
        u_xlat0.xyz = _MonitorObjectPositionArray[u_xlati0].zxy + _MonitorAccessoryPositionArray[u_xlati0].zxy;
        u_xlat1.x = u_xlat0.y;
        u_xlat2.x = u_xlat0.z;
    } else {
        u_xlati3 = _CharacterId;
        u_xlat1.x = _MonitorObjectPositionArray[u_xlati3].x;
        u_xlat2.x = _MonitorObjectPositionArray[u_xlati3].y;
        u_xlat0.x = _MonitorObjectPositionArray[u_xlati3].z;
    }
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat1.w = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat3.xyz = in_POSITION0.xyz;
    u_xlat3.w = 1.0;
    u_xlat1.x = dot(u_xlat1.yzwx, u_xlat3);
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.w = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat1.y = dot(u_xlat2.yzwx, u_xlat3);
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat0.w = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat1.z = dot(u_xlat0.yzwx, u_xlat3);
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_NORMAL0.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlatb13 = unity_OrthoParams.w==0.0;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = (u_xlatb13) ? u_xlat2.x : hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = (u_xlatb13) ? u_xlat2.y : hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = (u_xlatb13) ? u_xlat2.z : hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD2.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat13 = u_xlat0.z + _ProjectionParams.y;
    u_xlat2.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat13 = u_xlat13 / u_xlat2.x;
    u_xlat13 = u_xlat13 * _ProjectionParams.z;
    u_xlat13 = max(u_xlat13, 0.0);
    u_xlat13 = (-_SekaiFogFactor.y) * u_xlat13 + _SekaiFogFactor.x;
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#if defined(USE_DITHER_ALPHA)
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6 = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat6 * 0.5;
    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
#endif
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    vs_TEXCOORD4 = u_xlat13;
#if defined(USE_DITHER_ALPHA)
    vs_TEXCOORD6.zw = u_xlat0.zw;
#endif
    vs_TEXCOORD5 = u_xlat0.z;
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
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM float                _ShadowTexWeight;
	UNITY_UNIFORM int                _FadeMode;
	UNITY_UNIFORM float                _ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float                _IsAccessory;
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
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
#if defined(USE_DITHER_ALPHA)
in highp vec4 vs_TEXCOORD6;
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
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
#else
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec4 u_xlat2;
#endif
mediump vec3 u_xlat16_2;
#if defined(USE_DITHER_ALPHA)
int u_xlati2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
#else
mediump vec4 u_xlat16_3;
#endif
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
#if defined(USE_DITHER_ALPHA)
mediump float u_xlat16_9;
vec3 u_xlat10;
bvec3 u_xlatb10;
#else
vec3 u_xlat9;
bvec3 u_xlatb9;
mediump float u_xlat16_11;
#endif
vec3 u_xlat12;
mediump vec3 u_xlat16_13;
#if defined(USE_DITHER_ALPHA)
mediump float u_xlat16_17;
#else
float u_xlat17;
#endif
float u_xlat18;
#if defined(USE_DITHER_ALPHA)
float u_xlat19;
int u_xlati19;
mediump float u_xlat16_25;
#else
int u_xlati18;
mediump float u_xlat16_19;
float u_xlat25;
bool u_xlatb25;
#endif
float u_xlat26;
#if defined(USE_DITHER_ALPHA)
bool u_xlatb26;
float u_xlat27;
int u_xlati27;
#else
int u_xlati26;
mediump float u_xlat16_27;
#endif
void main()
{
#if defined(USE_DITHER_ALPHA)
    u_xlat0.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
    u_xlat16_0.x = texture(_DitherTex, u_xlat0.xy, _GlobalMipBias.x).x;
    u_xlat16_1.x = (-u_xlat16_0.x) + _DitherAlpha;
    u_xlatb0 = u_xlat16_1.x<0.0;
    if(u_xlatb0){discard;}
#endif
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat2.xyz = (-u_xlat16_0.xyz) + u_xlat16_2.xyz;
    u_xlat26 = u_xlat2.x * _ShadowTexWeight;
    u_xlat2.xyz = vec3(_ShadowTexWeight) * u_xlat2.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_1.x = u_xlat16_3.z * 2.0 + -1.0;
    u_xlat16_9 = _Saturation + _Saturation;
    u_xlat16_17 = _Value * 2.0 + -1.0;
    u_xlat16_25 = _Contrast + _Contrast;
#else
    u_xlat16_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat1.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    u_xlat25 = u_xlat1.x * _ShadowTexWeight;
    u_xlat1.xyz = vec3(_ShadowTexWeight) * u_xlat1.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_3.x = u_xlat16_2.z * 2.0 + -1.0;
    u_xlat16_11 = _Saturation + _Saturation;
    u_xlat16_19 = _Value * 2.0 + -1.0;
    u_xlat16_27 = _Contrast + _Contrast;
#endif
    u_xlat4.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat4.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat4.zxy);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_HueSinAngle);
    u_xlat4.xyz = u_xlat16_0.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat4.xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat19 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat19 = u_xlat19 * 0.57735002;
#else
    u_xlat18 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat18 = u_xlat18 * 0.57735002;
#endif
    u_xlat16_5.x = (-_HueCosAngle) + 1.0;
#if defined(USE_DITHER_ALPHA)
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat16_5.xxx + u_xlat4.xyz;
#else
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat16_5.xxx + u_xlat4.xyz;
#endif
    u_xlat16_13.xyz = u_xlat4.xyz + vec3(-0.5, -0.5, -0.5);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_13.xyz = u_xlat16_13.xyz * vec3(u_xlat16_25) + vec3(u_xlat16_17);
#else
    u_xlat16_13.xyz = u_xlat16_13.xyz * vec3(u_xlat16_27) + vec3(u_xlat16_19);
#endif
    u_xlat16_13.xyz = u_xlat16_13.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_6.x = dot(u_xlat16_13.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_13.xyz = u_xlat16_13.xyz + (-u_xlat16_6.xxx);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_13.xyz = vec3(u_xlat16_9) * u_xlat16_13.xyz + u_xlat16_6.xxx;
    u_xlat19 = dot(_SekaiDirectionalLight.xyz, vs_NORMAL0.xyz);
    u_xlat19 = u_xlat19 * 0.5 + 0.5;
#else
    u_xlat16_13.xyz = vec3(u_xlat16_11) * u_xlat16_13.xyz + u_xlat16_6.xxx;
    u_xlat18 = dot(_SekaiDirectionalLight.xyz, vs_NORMAL0.xyz);
    u_xlat18 = u_xlat18 * 0.5 + 0.5;
#endif
    switch(_FadeMode){
        case 0:
            u_xlat4.x = _ShadowWidth * (-_SekaiShadowThreshold) + _SekaiShadowThreshold;
#if defined(USE_DITHER_ALPHA)
            u_xlat12.x = u_xlat16_1.x + u_xlat19;
#else
            u_xlat12.x = u_xlat16_3.x + u_xlat18;
#endif
            u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
            u_xlat12.x = (-u_xlat4.x) + u_xlat12.x;
            u_xlat4.x = (-u_xlat4.x) + _SekaiShadowThreshold;
            u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
            u_xlat4.x = u_xlat12.x / u_xlat4.x;
            u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
            u_xlat12.x = u_xlat4.x * u_xlat4.x;
            u_xlat4.x = (-u_xlat4.x) * 2.0 + 3.0;
#if defined(USE_DITHER_ALPHA)
            u_xlat27 = (-u_xlat12.x) * u_xlat4.x + 1.0;
#else
            u_xlat26 = (-u_xlat12.x) * u_xlat4.x + 1.0;
#endif
            break;
        case 1:
            u_xlat4.x = (-_SekaiShadowThreshold) + 1.0;
            u_xlat4.x = u_xlat4.x * _ShadowWidth;
#if defined(USE_DITHER_ALPHA)
            u_xlat19 = u_xlat16_1.x + u_xlat19;
            u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
            u_xlat19 = u_xlat19 + (-_SekaiShadowThreshold);
#else
            u_xlat18 = u_xlat16_3.x + u_xlat18;
            u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
            u_xlat18 = u_xlat18 + (-_SekaiShadowThreshold);
#endif
            u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
#if defined(USE_DITHER_ALPHA)
            u_xlat19 = u_xlat19 / u_xlat4.x;
            u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
            u_xlat4.x = u_xlat19 * u_xlat19;
            u_xlat19 = (-u_xlat19) * 2.0 + 3.0;
            u_xlat27 = (-u_xlat4.x) * u_xlat19 + 1.0;
#else
            u_xlat18 = u_xlat18 / u_xlat4.x;
            u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
            u_xlat4.x = u_xlat18 * u_xlat18;
            u_xlat18 = (-u_xlat18) * 2.0 + 3.0;
            u_xlat26 = (-u_xlat4.x) * u_xlat18 + 1.0;
#endif
            break;
        default:
            break;
    }
#if defined(USE_DITHER_ALPHA)
    u_xlat2.xyz = u_xlat2.xyz * _SekaiShadowColor.xyz + (-u_xlat16_13.xyz);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz + u_xlat16_13.xyz;
    u_xlat26 = u_xlat27 * u_xlat26 + u_xlat16_0.x;
#else
    u_xlat1.xyz = u_xlat1.xyz * _SekaiShadowColor.xyz + (-u_xlat16_13.xyz);
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat1.xyz + u_xlat16_13.xyz;
    u_xlat25 = u_xlat26 * u_xlat25 + u_xlat16_0.x;
#endif
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat7.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.x = u_xlat26 + u_xlat26;
    u_xlat16_13.x = u_xlat26 * 2.0 + -1.0;
#else
    u_xlat16_3.x = u_xlat25 + u_xlat25;
    u_xlat16_13.x = u_xlat25 * 2.0 + -1.0;
#endif
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
    u_xlat16_6.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_13.xyz = u_xlat16_13.xxx * u_xlat16_6.xyz + u_xlat4.xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.x = u_xlat16_1.x;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#else
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_13.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_13.xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat16_13.xyz = u_xlat16_1.xxx * u_xlat16_13.xyz + u_xlat7.xyz;
#else
    u_xlat16_13.xyz = u_xlat16_3.xxx * u_xlat16_13.xyz + u_xlat7.xyz;
#endif
    u_xlat4.xyz = u_xlat16_13.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat4.xyz = u_xlat16_13.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat4.zxy);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_HueSinAngle);
    u_xlat4.xyz = u_xlat16_13.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat4.xyz;
#if defined(USE_DITHER_ALPHA)
    u_xlat26 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_13.xyz);
    u_xlat26 = u_xlat26 * 0.57735002;
    u_xlat4.xyz = vec3(u_xlat26) * u_xlat16_5.xxx + u_xlat4.xyz;
#else
    u_xlat25 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_13.xyz);
    u_xlat25 = u_xlat25 * 0.57735002;
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat16_5.xxx + u_xlat4.xyz;
#endif
    u_xlat16_5.xyz = u_xlat4.xyz + vec3(-0.5, -0.5, -0.5);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xzw = u_xlat16_5.xyz * vec3(u_xlat16_25) + vec3(u_xlat16_17);
    u_xlat16_1.xzw = u_xlat16_1.xzw + vec3(0.5, 0.5, 0.5);
    u_xlat16_5.x = dot(u_xlat16_1.xzw, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_1.xzw = u_xlat16_1.xzw + (-u_xlat16_5.xxx);
    u_xlat16_1.xyz = vec3(u_xlat16_9) * u_xlat16_1.xzw + u_xlat16_5.xxx;
    u_xlatb26 = u_xlat16_3.x>=0.5;
    u_xlat16_25 = (u_xlatb26) ? 1.0 : 0.0;
    u_xlat16_1.xyz = (-u_xlat2.xyz) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz + u_xlat2.xyz;
    u_xlati2 = _CharacterId;
    u_xlat10.xyz = _SekaiRimLightColorArray[u_xlati2].www * _SekaiRimLightColorArray[u_xlati2].xyz;
    u_xlat3.x = dot(vs_NORMAL0.xyz, vs_TEXCOORD2.xyz);
    u_xlat3.z = dot(vs_TEXCOORD2.xyz, _SekaiRimLightArray[u_xlati2].xyz);
    u_xlat27 = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_NORMAL0.xyz;
    u_xlat27 = dot(_SekaiRimLightArray[u_xlati2].xyz, _SekaiRimLightArray[u_xlati2].xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.xyz = vec3(u_xlat27) * _SekaiRimLightArray[u_xlati2].xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat7.xyz);
    u_xlat16_25 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati2];
    u_xlat16_5.x = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati2]);
    u_xlat4.x = (-u_xlat16_25) + u_xlat16_5.x;
    u_xlat12.x = (-u_xlat16_25) + u_xlat27;
#else
    u_xlat16_3.xzw = u_xlat16_5.xyz * vec3(u_xlat16_27) + vec3(u_xlat16_19);
    u_xlat16_3.xzw = u_xlat16_3.xzw + vec3(0.5, 0.5, 0.5);
    u_xlat16_5.x = dot(u_xlat16_3.xzw, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.xzw = u_xlat16_3.xzw + (-u_xlat16_5.xxx);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * u_xlat16_3.xzw + u_xlat16_5.xxx;
    u_xlatb25 = u_xlat16_2.x>=0.5;
    u_xlat16_27 = (u_xlatb25) ? 1.0 : 0.0;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_27) * u_xlat16_3.xyz + u_xlat1.xyz;
    u_xlati1 = _CharacterId;
    u_xlat9.xyz = _SekaiRimLightColorArray[u_xlati1].www * _SekaiRimLightColorArray[u_xlati1].xyz;
    u_xlat2.x = dot(vs_NORMAL0.xyz, vs_TEXCOORD2.xyz);
    u_xlat2.z = dot(vs_TEXCOORD2.xyz, _SekaiRimLightArray[u_xlati1].xyz);
    u_xlat26 = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat4.xyz = vec3(u_xlat26) * vs_NORMAL0.xyz;
    u_xlat26 = dot(_SekaiRimLightArray[u_xlati1].xyz, _SekaiRimLightArray[u_xlati1].xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat7.xyz = vec3(u_xlat26) * _SekaiRimLightArray[u_xlati1].xyz;
    u_xlat26 = dot(u_xlat4.xyz, u_xlat7.xyz);
    u_xlat16_27 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati1];
    u_xlat16_5.x = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati1]);
    u_xlat4.x = (-u_xlat16_27) + u_xlat16_5.x;
    u_xlat12.x = u_xlat26 + (-u_xlat16_27);
#endif
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat12.x;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat12.x = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat12.x;
#if defined(USE_DITHER_ALPHA)
    u_xlat12.xyz = _SekaiShadowRimLightColorArray[u_xlati2].xyz * _SekaiShadowRimLightColorArray[u_xlati2].www + (-u_xlat10.xyz);
    u_xlat10.xyz = u_xlat4.xxx * u_xlat12.xyz + u_xlat10.xyz;
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_25 = 10.0 + (-_SekaiRimLightFactor[u_xlati2].x);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat16_25 * u_xlat3.x;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat19 = u_xlat3.x * u_xlat3.z + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati2].w * u_xlat19 + u_xlat3.x;
    u_xlat19 = (-u_xlat27) + 0.0500000007;
    u_xlati27 = int((0.0<u_xlat19) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = int((u_xlat19<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati19 = (-u_xlati27) + u_xlati19;
    u_xlat19 = float(u_xlati19);
    u_xlat19 = u_xlat3.x * u_xlat19 + (-u_xlat3.x);
    u_xlat3.x = _SekaiRimLightFactor[u_xlati2].w * u_xlat19 + u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-_RimThreshold);
    u_xlat19 = float(1.0) / _SekaiRimLightFactor[u_xlati2].z;
    u_xlat3.x = u_xlat19 * u_xlat3.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat19 = u_xlat3.x * -2.0 + 3.0;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat19;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.xzw = u_xlat10.xyz * vs_COLOR0.yyy;
    u_xlat16_1.xyz = u_xlat10.xyz * vs_COLOR0.yyy + u_xlat16_1.xyz;
    u_xlatb10.xyz = greaterThanEqual(u_xlat16_1.xyzz, vec4(0.5, 0.5, 0.5, 0.5)).xyz;
    u_xlat16_5.x = (u_xlatb10.x) ? float(1.0) : float(0.0);
    u_xlat16_5.y = (u_xlatb10.y) ? float(1.0) : float(0.0);
    u_xlat16_5.z = (u_xlatb10.z) ? float(1.0) : float(0.0);
    u_xlat16_6.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat10.xyz = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati2].xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati2].xyz);
    u_xlat4.xyz = (-u_xlat16_1.xyz) * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati2].xyz + u_xlat4.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat16_1.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati2]);
    u_xlat4.xyz = u_xlat10.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_1.xyz = (-u_xlat10.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
#else
    u_xlat12.xyz = _SekaiShadowRimLightColorArray[u_xlati1].xyz * _SekaiShadowRimLightColorArray[u_xlati1].www + (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat4.xxx * u_xlat12.xyz + u_xlat9.xyz;
    u_xlat2.xz = max(u_xlat2.xz, vec2(0.0, 0.0));
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat16_27 = 10.0 + (-_SekaiRimLightFactor[u_xlati1].x);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * u_xlat16_27;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat18 = u_xlat2.x * u_xlat2.z + (-u_xlat2.x);
    u_xlat2.x = _SekaiRimLightFactor[u_xlati1].w * u_xlat18 + u_xlat2.x;
    u_xlat18 = (-u_xlat26) + 0.0500000007;
    u_xlati26 = int((0.0<u_xlat18) ? 0xFFFFFFFFu : uint(0));
    u_xlati18 = int((u_xlat18<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati18 = (-u_xlati26) + u_xlati18;
    u_xlat18 = float(u_xlati18);
    u_xlat18 = u_xlat2.x * u_xlat18 + (-u_xlat2.x);
    u_xlat2.x = _SekaiRimLightFactor[u_xlati1].w * u_xlat18 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x + (-_RimThreshold);
    u_xlat18 = float(1.0) / _SekaiRimLightFactor[u_xlati1].z;
    u_xlat2.x = u_xlat18 * u_xlat2.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat18 = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat18;
    u_xlat9.xyz = u_xlat9.xyz * u_xlat2.xxx;
    u_xlat2.xzw = u_xlat9.xyz * vs_COLOR0.yyy;
    u_xlat16_3.xyz = u_xlat9.xyz * vs_COLOR0.yyy + u_xlat16_3.xyz;
    u_xlatb9.xyz = greaterThanEqual(u_xlat16_3.xyzz, vec4(0.5, 0.5, 0.5, 0.5)).xyz;
    u_xlat16_5.x = (u_xlatb9.x) ? float(1.0) : float(0.0);
    u_xlat16_5.y = (u_xlatb9.y) ? float(1.0) : float(0.0);
    u_xlat16_5.z = (u_xlatb9.z) ? float(1.0) : float(0.0);
    u_xlat16_6.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat9.xyz = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati1].xyz;
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat4.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati1].xyz);
    u_xlat4.xyz = (-u_xlat16_3.xyz) * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati1].xyz + u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati1]);
    u_xlat4.xyz = u_xlat9.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_3.xyz = (-u_xlat9.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
#endif
    u_xlat16_5.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
#if defined(USE_DITHER_ALPHA)
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat4.xyz * _PartsAmbientColor.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = _PartsAmbientColor.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlatb10.x = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb10.x){
        u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat10.xy = u_xlat10.xy * u_xlat10.xy;
        u_xlat10.x = u_xlat10.y + u_xlat10.x;
        u_xlat10.x = u_xlat10.z * u_xlat10.z + u_xlat10.x;
        u_xlat18 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat10.x = u_xlat10.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat18 = float(1.0) / u_xlat18;
        u_xlat10.x = u_xlat18 * u_xlat10.x;
        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
        u_xlat18 = u_xlat10.x * -2.0 + 3.0;
        u_xlat10.x = u_xlat10.x * u_xlat10.x;
        u_xlat26 = u_xlat10.x * u_xlat18;
        u_xlat10.x = (-u_xlat18) * u_xlat10.x + 1.0;
        u_xlat4.xyz = u_xlat16_1.xyz * vec3(u_xlat26);
#else
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat4.xyz * _PartsAmbientColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = _PartsAmbientColor.www * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlatb9.x = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb9.x){
        u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat9.xy = u_xlat9.xy * u_xlat9.xy;
        u_xlat9.x = u_xlat9.y + u_xlat9.x;
        u_xlat9.x = u_xlat9.z * u_xlat9.z + u_xlat9.x;
        u_xlat17 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat9.x = u_xlat9.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat17 = float(1.0) / u_xlat17;
        u_xlat9.x = u_xlat17 * u_xlat9.x;
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
        u_xlat17 = u_xlat9.x * -2.0 + 3.0;
        u_xlat9.x = u_xlat9.x * u_xlat9.x;
        u_xlat25 = u_xlat9.x * u_xlat17;
        u_xlat9.x = (-u_xlat17) * u_xlat9.x + 1.0;
        u_xlat4.xyz = u_xlat16_3.xyz * vec3(u_xlat25);
#endif
        u_xlat4.xyz = u_xlat4.xyz * _SekaiGlobalSpotLightColor.xyz;
#if defined(USE_DITHER_ALPHA)
        u_xlat10.xyz = u_xlat10.xxx * u_xlat16_1.xyz + u_xlat4.xyz;
#else
        u_xlat9.xyz = u_xlat9.xxx * u_xlat16_3.xyz + u_xlat4.xyz;
#endif
    } else {
#if defined(USE_DITHER_ALPHA)
        u_xlat10.xyz = u_xlat16_1.xyz;
#else
        u_xlat9.xyz = u_xlat16_3.xyz;
#endif
    }
#if defined(USE_DITHER_ALPHA)
    u_xlat3.xzw = u_xlat3.xzw * _SekaiRimLightFactor[u_xlati2].yyy;
    u_xlat3.xyz = u_xlat10.xyz * u_xlat16_3.yyy + u_xlat3.xzw;
    u_xlat16_1.x = (-vs_TEXCOORD4) + 1.0;
    u_xlat2.x = u_xlat16_1.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat10.xyz) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = u_xlat2.xxx * u_xlat4.xyz + u_xlat10.xyz;
    u_xlat2.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat10.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat10.x = u_xlat10.x + -1.0;
    u_xlat10.x = u_xlat10.x * _ProjectionParams.w;
    u_xlat2.x = u_xlat10.x * u_xlat2.x + _ProjectionParams.w;
    u_xlat2.x = (-_CoCParams.x) * u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * _CoCParams.y;
    u_xlat10.x = u_xlat2.x;
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, -1.0);
    u_xlat2.x = min(u_xlat2.x, 0.0);
    u_xlat2.x = u_xlat2.x + u_xlat10.x;
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
#else
    u_xlat2.xzw = u_xlat2.xzw * _SekaiRimLightFactor[u_xlati1].yyy;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat16_2.yyy + u_xlat2.xzw;
    u_xlat16_3.x = (-vs_TEXCOORD4) + 1.0;
    u_xlat1.x = u_xlat16_3.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat9.xyz) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = u_xlat1.xxx * u_xlat4.xyz + u_xlat9.xyz;
    u_xlat1.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat9.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9.x = u_xlat9.x + -1.0;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.w;
    u_xlat1.x = u_xlat9.x * u_xlat1.x + _ProjectionParams.w;
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
    u_xlat9.x = u_xlat1.x;
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
    u_xlat1.x = max(u_xlat1.x, -1.0);
    u_xlat1.x = min(u_xlat1.x, 0.0);
    u_xlat1.x = u_xlat1.x + u_xlat9.x;
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
#if defined(USE_DITHER_ALPHA)
    SV_Target2.xyz = u_xlat3.xyz;
#else
    SV_Target2.xyz = u_xlat2.xyz;
#endif
    SV_Target2.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "OUTLINE"
			Tags { "LIGHTMODE"="SekaiOutline" "QUEUE"="AlphaTest" "RenderType"="Opaque" }
			ZTest Less
			Cull Front
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SekaiOutlineWidth;
uniform 	vec4 _SekaiOutlineFactor;
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
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowTexWeight;
	UNITY_UNIFORM int Xhlslcc_UnusedX_FadeMode;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD3;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_SekaiOutlineFactor.x);
    u_xlat0.x = u_xlat0.x * _SekaiOutlineFactor.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * _SekaiOutlineFactor.z;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat2.x = (-_SekaiOutlineWidth.x) + _SekaiOutlineWidth.y;
    u_xlat0.x = u_xlat0.x * u_xlat2.x + _SekaiOutlineWidth.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_COLOR0.xxx + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4 = u_xlat0.z;
    u_xlat0.x = u_xlat0.z + _ProjectionParams.y;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2.x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD3 = u_xlat0.x;
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
uniform 	vec4 _CoCParams;
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiCharacterAmbientLightIntensityArray[12];
uniform 	vec4 _SekaiCharacterAmbientLightColorArray[12];
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
uniform 	vec4 _SekaiFogColor;
uniform 	mediump vec4 _SekaiShadowColor;
uniform 	mediump vec4 _SekaiCharacterOutlineColorArray[12];
uniform 	float _SekaiCharacterOutlineBlendingArray[12];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowTexWeight;
	UNITY_UNIFORM int Xhlslcc_UnusedX_FadeMode;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ValueTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD3;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
int u_xlati1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat9;
bvec3 u_xlatb9;
mediump float u_xlat16_11;
float u_xlat17;
mediump float u_xlat16_19;
float u_xlat25;
mediump float u_xlat16_26;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
void main()
{
    u_xlat16_0 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlati1 = _CharacterId;
    u_xlat16_2.xyz = _SekaiCharacterOutlineColorArray[u_xlati1].www * _SekaiCharacterOutlineColorArray[u_xlati1].xyz;
    u_xlat9.x = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
    u_xlat16_26 = _Saturation + _Saturation;
    u_xlat16_3.x = _Value * 2.0 + -1.0;
    u_xlat16_11 = _Contrast + _Contrast;
    u_xlat4.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat4.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat4.zxy);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_HueSinAngle);
    u_xlat4.xyz = u_xlat16_0.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat4.xyz;
    u_xlat17 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat17 = u_xlat17 * 0.57735002;
    u_xlat16_19 = (-_HueCosAngle) + 1.0;
    u_xlat4.xyz = vec3(u_xlat17) * vec3(u_xlat16_19) + u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_11) + u_xlat16_3.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_27 = dot(u_xlat16_5.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_5.xyz = (-vec3(u_xlat16_27)) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz + vec3(u_xlat16_27);
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat6.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_27 = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_29 = u_xlat16_5.x * 2.0 + -1.0;
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_7.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat4.xyz;
    u_xlat16_27 = u_xlat16_27;
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat16_7.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat16_7.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat4.xyz = u_xlat16_7.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat4.zxy);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_HueSinAngle);
    u_xlat4.xyz = u_xlat16_7.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat4.xyz;
    u_xlat17 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_7.xyz);
    u_xlat17 = u_xlat17 * 0.57735002;
    u_xlat4.xyz = vec3(u_xlat17) * vec3(u_xlat16_19) + u_xlat4.xyz;
    u_xlat16_7.xyz = u_xlat4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat16_7.xyz * vec3(u_xlat16_11) + u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_27 = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.xyz = (-vec3(u_xlat16_27)) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz + vec3(u_xlat16_27);
    u_xlatb9.x = u_xlat9.x>=0.5;
    u_xlat16_26 = (u_xlatb9.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = (-u_xlat16_5.xyz) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlatb9.xyz = greaterThanEqual(u_xlat16_3.xyzz, vec4(0.5, 0.5, 0.5, 0.5)).xyz;
    u_xlat16_5.x = (u_xlatb9.x) ? float(1.0) : float(0.0);
    u_xlat16_5.y = (u_xlatb9.y) ? float(1.0) : float(0.0);
    u_xlat16_5.z = (u_xlatb9.z) ? float(1.0) : float(0.0);
    u_xlat16_7.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat9.xyz = u_xlat16_7.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati1].xyz;
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat4.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati1].xyz);
    u_xlat4.xyz = (-u_xlat16_3.xyz) * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati1].xyz + u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati1]);
    u_xlat4.xyz = u_xlat9.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_3.xyz = (-u_xlat9.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat4.xyz * _PartsAmbientColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = _PartsAmbientColor.www * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlatb9.x = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb9.x){
        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat9.xy = u_xlat9.xy * u_xlat9.xy;
        u_xlat9.x = u_xlat9.y + u_xlat9.x;
        u_xlat9.x = u_xlat9.z * u_xlat9.z + u_xlat9.x;
        u_xlat17 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat9.x = u_xlat9.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat17 = float(1.0) / u_xlat17;
        u_xlat9.x = u_xlat17 * u_xlat9.x;
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
        u_xlat17 = u_xlat9.x * -2.0 + 3.0;
        u_xlat9.x = u_xlat9.x * u_xlat9.x;
        u_xlat25 = u_xlat9.x * u_xlat17;
        u_xlat9.x = (-u_xlat17) * u_xlat9.x + 1.0;
        u_xlat4.xyz = u_xlat16_3.xyz * vec3(u_xlat25);
        u_xlat4.xyz = u_xlat4.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat9.xyz = u_xlat9.xxx * u_xlat16_3.xyz + u_xlat4.xyz;
    } else {
        u_xlat9.xyz = u_xlat16_3.xyz;
    }
    u_xlat9.xyz = (-_SekaiCharacterOutlineColorArray[u_xlati1].xyz) * _SekaiCharacterOutlineColorArray[u_xlati1].www + u_xlat9.xyz;
    u_xlat1.xyz = vec3(_SekaiCharacterOutlineBlendingArray[u_xlati1]) * u_xlat9.xyz + u_xlat16_2.xyz;
    u_xlat16_2.x = (-vs_TEXCOORD3) + 1.0;
    u_xlat25 = u_xlat16_2.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat1.xyz) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat25) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD4 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat9.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9.x = u_xlat9.x + -1.0;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.w;
    u_xlat1.x = u_xlat9.x * u_xlat1.x + _ProjectionParams.w;
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
    u_xlat9.x = u_xlat1.x;
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
    u_xlat1.x = max(u_xlat1.x, -1.0);
    u_xlat1.x = min(u_xlat1.x, 0.0);
    u_xlat1.x = u_xlat1.x + u_xlat9.x;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * 0.5;
    SV_Target0 = u_xlat16_0;
    SV_Target1.x = u_xlat1.x;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "REFLECTION"
			Tags { "LIGHTMODE"="SekaiReflection" "QUEUE"="AlphaTest" "RenderType"="Opaque" }
			Cull Front
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
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM int                _CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM float                _ShadowTexWeight;
	UNITY_UNIFORM int                _FadeMode;
	UNITY_UNIFORM float                _ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_NORMAL0;
out highp float vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
float u_xlat10;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = (-u_xlat0.yyyy) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlati9 = (-_CharacterReflectionOff) + 1;
    u_xlat9 = float(u_xlati9);
    u_xlat2 = u_xlat1 * vec4(u_xlat9);
    u_xlat9 = u_xlat9 * u_xlat1.z + _ProjectionParams.y;
    gl_Position = u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = max(u_xlat10, 1.17549435e-38);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_NORMAL0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD5 = u_xlat2.z;
    vs_TEXCOORD0 = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlatb0 = unity_OrthoParams.w==0.0;
    u_xlat2.x = (u_xlatb0) ? u_xlat1.x : hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = (u_xlatb0) ? u_xlat1.y : hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = (u_xlatb0) ? u_xlat1.z : hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat9 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD4 = u_xlat0.x;
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
uniform 	vec4 _SekaiDirectionalLight;
uniform 	mediump vec4 _SekaiShadowColor;
uniform 	mediump float _SekaiShadowThreshold;
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
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM int                _CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM float                _ShadowTexWeight;
	UNITY_UNIFORM int                _FadeMode;
	UNITY_UNIFORM float                _ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ValueTex;
in highp vec3 vs_NORMAL0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
bvec3 u_xlatb9;
mediump float u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_13;
float u_xlat17;
float u_xlat18;
int u_xlati18;
mediump float u_xlat16_19;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
int u_xlati26;
mediump float u_xlat16_27;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat16_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat1.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    u_xlat25 = u_xlat1.x * _ShadowTexWeight;
    u_xlat1.xyz = vec3(_ShadowTexWeight) * u_xlat1.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_3.x = u_xlat16_2.z * 2.0 + -1.0;
    u_xlat16_11 = _Saturation + _Saturation;
    u_xlat16_19 = _Value * 2.0 + -1.0;
    u_xlat16_27 = _Contrast + _Contrast;
    u_xlat4.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat4.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat4.zxy);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_HueSinAngle);
    u_xlat4.xyz = u_xlat16_0.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat4.xyz;
    u_xlat18 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat18 = u_xlat18 * 0.57735002;
    u_xlat16_5.x = (-_HueCosAngle) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat16_5.xxx + u_xlat4.xyz;
    u_xlat16_13.xyz = u_xlat4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_13.xyz = u_xlat16_13.xyz * vec3(u_xlat16_27) + vec3(u_xlat16_19);
    u_xlat16_13.xyz = u_xlat16_13.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_6.x = dot(u_xlat16_13.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_13.xyz = u_xlat16_13.xyz + (-u_xlat16_6.xxx);
    u_xlat16_13.xyz = vec3(u_xlat16_11) * u_xlat16_13.xyz + u_xlat16_6.xxx;
    u_xlat18 = dot(_SekaiDirectionalLight.xyz, vs_NORMAL0.xyz);
    u_xlat18 = u_xlat18 * 0.5 + 0.5;
    switch(_FadeMode){
        case 0:
            u_xlat4.x = _ShadowWidth * (-_SekaiShadowThreshold) + _SekaiShadowThreshold;
            u_xlat12.x = u_xlat16_3.x + u_xlat18;
            u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
            u_xlat12.x = (-u_xlat4.x) + u_xlat12.x;
            u_xlat4.x = (-u_xlat4.x) + _SekaiShadowThreshold;
            u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
            u_xlat4.x = u_xlat12.x / u_xlat4.x;
            u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
            u_xlat12.x = u_xlat4.x * u_xlat4.x;
            u_xlat4.x = (-u_xlat4.x) * 2.0 + 3.0;
            u_xlat26 = (-u_xlat12.x) * u_xlat4.x + 1.0;
            break;
        case 1:
            u_xlat4.x = (-_SekaiShadowThreshold) + 1.0;
            u_xlat4.x = u_xlat4.x * _ShadowWidth;
            u_xlat18 = u_xlat16_3.x + u_xlat18;
            u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
            u_xlat18 = u_xlat18 + (-_SekaiShadowThreshold);
            u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
            u_xlat18 = u_xlat18 / u_xlat4.x;
            u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
            u_xlat4.x = u_xlat18 * u_xlat18;
            u_xlat18 = (-u_xlat18) * 2.0 + 3.0;
            u_xlat26 = (-u_xlat4.x) * u_xlat18 + 1.0;
            break;
        default:
            break;
    }
    u_xlat1.xyz = u_xlat1.xyz * _SekaiShadowColor.xyz + (-u_xlat16_13.xyz);
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat1.xyz + u_xlat16_13.xyz;
    u_xlat25 = u_xlat26 * u_xlat25 + u_xlat16_0.x;
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat7.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_3.x = u_xlat25 + u_xlat25;
    u_xlat16_13.x = u_xlat25 * 2.0 + -1.0;
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
    u_xlat16_6.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_13.xyz = u_xlat16_13.xxx * u_xlat16_6.xyz + u_xlat4.xyz;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_13.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_3.xxx * u_xlat16_13.xyz + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat16_13.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat4.xyz = u_xlat16_13.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat4.zxy);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_HueSinAngle);
    u_xlat4.xyz = u_xlat16_13.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat4.xyz;
    u_xlat25 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_13.xyz);
    u_xlat25 = u_xlat25 * 0.57735002;
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat16_5.xxx + u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xzw = u_xlat16_5.xyz * vec3(u_xlat16_27) + vec3(u_xlat16_19);
    u_xlat16_3.xzw = u_xlat16_3.xzw + vec3(0.5, 0.5, 0.5);
    u_xlat16_5.x = dot(u_xlat16_3.xzw, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.xzw = u_xlat16_3.xzw + (-u_xlat16_5.xxx);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * u_xlat16_3.xzw + u_xlat16_5.xxx;
    u_xlatb25 = u_xlat16_2.x>=0.5;
    u_xlat16_27 = (u_xlatb25) ? 1.0 : 0.0;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_27) * u_xlat16_3.xyz + u_xlat1.xyz;
    u_xlati1 = _CharacterId;
    u_xlat9.xyz = _SekaiRimLightColorArray[u_xlati1].www * _SekaiRimLightColorArray[u_xlati1].xyz;
    u_xlat2.x = dot(vs_NORMAL0.xyz, vs_TEXCOORD2.xyz);
    u_xlat2.z = dot(vs_TEXCOORD2.xyz, _SekaiRimLightArray[u_xlati1].xyz);
    u_xlat26 = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat4.xyz = vec3(u_xlat26) * vs_NORMAL0.xyz;
    u_xlat26 = dot(_SekaiRimLightArray[u_xlati1].xyz, _SekaiRimLightArray[u_xlati1].xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat7.xyz = vec3(u_xlat26) * _SekaiRimLightArray[u_xlati1].xyz;
    u_xlat26 = dot(u_xlat4.xyz, u_xlat7.xyz);
    u_xlat16_27 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati1];
    u_xlat16_5.x = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati1]);
    u_xlat4.x = (-u_xlat16_27) + u_xlat16_5.x;
    u_xlat12.x = u_xlat26 + (-u_xlat16_27);
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat12.x;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat12.x = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat12.x;
    u_xlat12.xyz = _SekaiShadowRimLightColorArray[u_xlati1].xyz * _SekaiShadowRimLightColorArray[u_xlati1].www + (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat4.xxx * u_xlat12.xyz + u_xlat9.xyz;
    u_xlat2.xz = max(u_xlat2.xz, vec2(0.0, 0.0));
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat16_27 = 10.0 + (-_SekaiRimLightFactor[u_xlati1].x);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * u_xlat16_27;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat18 = u_xlat2.x * u_xlat2.z + (-u_xlat2.x);
    u_xlat2.x = _SekaiRimLightFactor[u_xlati1].w * u_xlat18 + u_xlat2.x;
    u_xlat18 = (-u_xlat26) + 0.0500000007;
    u_xlati26 = int((0.0<u_xlat18) ? 0xFFFFFFFFu : uint(0));
    u_xlati18 = int((u_xlat18<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati18 = (-u_xlati26) + u_xlati18;
    u_xlat18 = float(u_xlati18);
    u_xlat18 = u_xlat2.x * u_xlat18 + (-u_xlat2.x);
    u_xlat2.x = _SekaiRimLightFactor[u_xlati1].w * u_xlat18 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x + (-_RimThreshold);
    u_xlat18 = float(1.0) / _SekaiRimLightFactor[u_xlati1].z;
    u_xlat2.x = u_xlat18 * u_xlat2.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat18 = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat18;
    u_xlat9.xyz = u_xlat9.xyz * u_xlat2.xxx;
    u_xlat2.xzw = u_xlat9.xyz * vs_COLOR0.yyy;
    u_xlat16_3.xyz = u_xlat9.xyz * vs_COLOR0.yyy + u_xlat16_3.xyz;
    u_xlatb9.xyz = greaterThanEqual(u_xlat16_3.xyzz, vec4(0.5, 0.5, 0.5, 0.5)).xyz;
    u_xlat16_5.x = (u_xlatb9.x) ? float(1.0) : float(0.0);
    u_xlat16_5.y = (u_xlatb9.y) ? float(1.0) : float(0.0);
    u_xlat16_5.z = (u_xlatb9.z) ? float(1.0) : float(0.0);
    u_xlat16_6.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat9.xyz = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati1].xyz;
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat4.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati1].xyz);
    u_xlat4.xyz = (-u_xlat16_3.xyz) * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati1].xyz + u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati1]);
    u_xlat4.xyz = u_xlat9.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_3.xyz = (-u_xlat9.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat4.xyz * _PartsAmbientColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = _PartsAmbientColor.www * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlatb9.x = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb9.x){
        u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat9.xy = u_xlat9.xy * u_xlat9.xy;
        u_xlat9.x = u_xlat9.y + u_xlat9.x;
        u_xlat9.x = u_xlat9.z * u_xlat9.z + u_xlat9.x;
        u_xlat17 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat9.x = u_xlat9.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat17 = float(1.0) / u_xlat17;
        u_xlat9.x = u_xlat17 * u_xlat9.x;
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
        u_xlat17 = u_xlat9.x * -2.0 + 3.0;
        u_xlat9.x = u_xlat9.x * u_xlat9.x;
        u_xlat25 = u_xlat9.x * u_xlat17;
        u_xlat9.x = (-u_xlat17) * u_xlat9.x + 1.0;
        u_xlat4.xyz = u_xlat16_3.xyz * vec3(u_xlat25);
        u_xlat4.xyz = u_xlat4.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat9.xyz = u_xlat9.xxx * u_xlat16_3.xyz + u_xlat4.xyz;
    } else {
        u_xlat9.xyz = u_xlat16_3.xyz;
    }
    u_xlat2.xzw = u_xlat2.xzw * _SekaiRimLightFactor[u_xlati1].yyy;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat16_2.yyy + u_xlat2.xzw;
    u_xlat16_3.x = (-vs_TEXCOORD4) + 1.0;
    u_xlat1.x = u_xlat16_3.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat9.xyz) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = u_xlat1.xxx * u_xlat4.xyz + u_xlat9.xyz;
    u_xlat1.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat9.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9.x = u_xlat9.x + -1.0;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.w;
    u_xlat1.x = u_xlat9.x * u_xlat1.x + _ProjectionParams.w;
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
    u_xlat9.x = u_xlat1.x;
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
    u_xlat1.x = max(u_xlat1.x, -1.0);
    u_xlat1.x = min(u_xlat1.x, 0.0);
    u_xlat1.x = u_xlat1.x + u_xlat9.x;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * 0.5;
    SV_Target0 = u_xlat16_0;
    SV_Target1.x = u_xlat1.x;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2.xyz = u_xlat2.xyz;
    SV_Target2.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "BASE-RP"
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
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_PartsAmbientColor;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowTexWeight;
	UNITY_UNIFORM int Xhlslcc_UnusedX_FadeMode;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowWidth;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HueSinAngle;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HueCosAngle;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Saturation;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Value;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
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
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat7;
float u_xlat14;
void main()
{
    u_xlat0 = in_COLOR0.z * 0.100000001;
    u_xlat4.x = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat0 = u_xlat0 / u_xlat4.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat4.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat14 = u_xlat1.z / u_xlat1.w;
    u_xlat14 = _ZBufferParams.x * u_xlat14 + _ZBufferParams.y;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat3.x = (-unity_OrthoParams.w) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat3.x;
    u_xlat14 = u_xlat1.z * unity_OrthoParams.w + u_xlat14;
    u_xlat14 = (-u_xlat0) * 0.5 + u_xlat14;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = (-u_xlat0) * _ProjectionParams.x + u_xlat1.z;
    u_xlat7 = u_xlat14 * _ZBufferParams.x;
    u_xlat14 = (-_ZBufferParams.y) * u_xlat14 + 1.0;
    u_xlat14 = u_xlat14 / u_xlat7;
    u_xlat14 = u_xlat1.w * u_xlat14;
    u_xlat14 = u_xlat3.x * u_xlat14;
    gl_Position.z = u_xlat0 * unity_OrthoParams.w + u_xlat14;
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = max(u_xlat0, 1.17549435e-38);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_NORMAL0.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD0 = u_xlat1;
    u_xlat0 = u_xlat1.z + _ProjectionParams.y;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0 = u_xlat0 / u_xlat1.x;
    u_xlat0 = u_xlat0 * _ProjectionParams.z;
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlat0 = (-rp_FogFactor.xxxy.w) * u_xlat0 + rp_FogFactor.xxxy.z;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat0 = (-u_xlat0) + 1.0;
    vs_TEXCOORD4.x = u_xlat0 * rp_FogColor.w;
    u_xlat0 = u_xlat2.y + (-rp_HeightFogFactor.x);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat0 = u_xlat0 * rp_HeightFogFactor.y;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    vs_TEXCOORD4.y = u_xlat0 * rp_HeightFogColor.w;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlatb0 = unity_OrthoParams.w==0.0;
    u_xlat1.x = (u_xlatb0) ? u_xlat4.x : hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = (u_xlatb0) ? u_xlat4.y : hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = (u_xlatb0) ? u_xlat4.z : hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD2.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	float rp_UseCharacterHsvc;
uniform 	float rp_CharacterHueSinAngle;
uniform 	float rp_CharacterHueCosAngle;
uniform 	float rp_CharacterSaturation;
uniform 	float rp_CharacterValue;
uniform 	float rp_CharacterContrast;
uniform 	mediump vec4 _EmissionColor;
uniform 	float _Emission;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_PartsAmbientColor;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowTexWeight;
	UNITY_UNIFORM int Xhlslcc_UnusedX_FadeMode;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowWidth;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HueSinAngle;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HueCosAngle;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Saturation;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Value;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ValueTex;
in highp vec3 vs_NORMAL0;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat27;
bool u_xlatb27;
float u_xlat30;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.xyz = _DefaultSkinColor.xyz + (-_Shadow1SkinColor.xyz);
    u_xlat27 = dot(rp_DirectionalLightVector.xyz, vs_NORMAL0.xyz);
    u_xlat27 = u_xlat27 * 0.5 + 0.5;
    u_xlat16_1.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_2.x = u_xlat16_1.z * 2.0 + -1.0;
    u_xlat27 = u_xlat27 + u_xlat16_2.x;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlatb27 = u_xlat27>=0.40625;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat16_3 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat2 = u_xlat16_2 + (-u_xlat16_3);
    u_xlat2 = vec4(u_xlat27) * u_xlat2 + u_xlat16_3;
    u_xlat16_4.x = u_xlat2.x * 2.0 + -1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_4.xxx * u_xlat0.xyz + _Shadow1SkinColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_Shadow2SkinColor.xyz);
    u_xlat16_4.x = u_xlat2.x + u_xlat2.x;
    u_xlat16_4.x = u_xlat16_4.x;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_4.xxx * u_xlat0.xyz + _Shadow2SkinColor.xyz;
    u_xlat16_4.xyz = (-u_xlat2.xyz) + u_xlat0.xyz;
    u_xlatb0 = u_xlat16_1.x>=0.5;
    u_xlat16_31 = u_xlat16_1.y * u_xlat2.w;
    u_xlat1.w = u_xlat16_31 * rp_GlobalIntensity;
    u_xlat16_31 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat16_4.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat0.xyz = u_xlat16_4.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat0.zxy);
    u_xlat0.xyz = u_xlat0.xyz * vec3(rp_CharacterHueSinAngle);
    u_xlat0.xyz = u_xlat16_4.xyz * vec3(vec3(rp_CharacterHueCosAngle, rp_CharacterHueCosAngle, rp_CharacterHueCosAngle)) + u_xlat0.xyz;
    u_xlat27 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_4.xyz);
    u_xlat27 = u_xlat27 * 0.57735002;
    u_xlat16_31 = (-rp_CharacterHueCosAngle) + 1.0;
    u_xlat0.xyz = vec3(u_xlat27) * vec3(u_xlat16_31) + u_xlat0.xyz;
    u_xlat16_5.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_31 = rp_CharacterValue * 2.0 + -1.0;
    u_xlat16_32 = rp_CharacterContrast + rp_CharacterContrast;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32) + vec3(u_xlat16_31);
    u_xlat16_5.xyz = u_xlat16_5.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_31 = dot(u_xlat16_5.xyz, vec3(0.212599993, 0.715200007, 0.0722000003));
    u_xlat16_5.xyz = (-vec3(u_xlat16_31)) + u_xlat16_5.xyz;
    u_xlat16_32 = rp_CharacterSaturation + rp_CharacterSaturation;
    u_xlat16_5.xyz = vec3(u_xlat16_32) * u_xlat16_5.xyz + vec3(u_xlat16_31);
    u_xlat0.xyz = (-u_xlat16_4.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(vec3(rp_UseCharacterHsvc, rp_UseCharacterHsvc, rp_UseCharacterHsvc)) * u_xlat0.xyz + u_xlat16_4.xyz;
    u_xlatb3.xyz = greaterThanEqual(u_xlat0.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_4.x = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb3.y) ? float(1.0) : float(0.0);
    u_xlat16_4.z = (u_xlatb3.z) ? float(1.0) : float(0.0);
    u_xlat16_5.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_6.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_6.xyz;
    u_xlati0 = _CharacterId;
    u_xlat16_7.xyz = vec3(1.0, 1.0, 1.0) + (-rp_CharacterAmbientLightColorArray[u_xlati0].xyz);
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) * rp_CharacterAmbientLightColorArray[u_xlati0].xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * rp_CharacterAmbientLightColorArray[u_xlati0].xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat9.xyz = u_xlat16_4.xyz * vec3(rp_CharacterAmbientLightIntensityArray[u_xlati0]);
    u_xlat3.xyz = rp_CharacterAmbientLightColorArray[u_xlati0].xyz * vec3(rp_CharacterAmbientLightBrightnessArray[u_xlati0]);
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.200000003, 0.200000003, 0.200000003);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat30 = (-rp_CharacterRimIntensity) + 10.0;
    u_xlat0.x = u_xlat0.x * u_xlat30;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, rp_CharacterRimVector.xyz);
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat0.x = u_xlat0.x * u_xlat30;
    u_xlat30 = dot(rp_CharacterRimVector.xyz, vs_NORMAL0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat30;
    u_xlatb0 = u_xlat0.x>=_RimThreshold;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.y;
    u_xlat8.xyz = u_xlat0.xxx * rp_CharacterRimColor.xyz;
    u_xlat8.xyz = u_xlat8.xyz * vec3(rp_GlobalIntensity);
    u_xlat16_4.xyz = u_xlat9.xyz * vec3(rp_GlobalIntensity) + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat8.xyz * vec3(vec3(rp_CharacterRimBrightness, rp_CharacterRimBrightness, rp_CharacterRimBrightness)) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(rp_GlobalIntensity);
    u_xlat3.xyz = (-u_xlat16_4.xyz) + rp_FogColor.xyz;
    u_xlat3.xyz = vs_TEXCOORD4.xxx * u_xlat3.xyz + u_xlat16_4.xyz;
    u_xlat8.xyz = (-u_xlat3.xyz) + rp_HeightFogColor.xyz;
    u_xlat3.xyz = vs_TEXCOORD4.yyy * u_xlat8.xyz + u_xlat3.xyz;
    u_xlat8.xyz = (-u_xlat3.xyz) + _EmissionColor.xyz;
    u_xlat2.xyz = vec3(_Emission) * u_xlat8.xyz + u_xlat3.xyz;
    SV_Target0 = u_xlat2;
    u_xlat3.xyz = _EmissionColor.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + (-u_xlat0.xyz);
    u_xlat1.xyz = vec3(_Emission) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target1 = u_xlat1;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "BASE-RP-OVER"
			Tags { "LIGHTMODE"="SekaiBaseOver" "QUEUE"="AlphaTest" "RenderType"="Opaque" }
			Blend One One, One One
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
	UNITY_UNIFORM float Xhlslcc_UnusedX_RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DefaultSkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow1SkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow2SkinColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterId;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_PartsAmbientColor;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowTexWeight;
	UNITY_UNIFORM int Xhlslcc_UnusedX_FadeMode;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowWidth;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HueSinAngle;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_HueCosAngle;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Saturation;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Value;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
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
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat7;
float u_xlat14;
void main()
{
    u_xlat0 = in_COLOR0.z * 0.100000001;
    u_xlat4.x = (-_ProjectionParams.y) + _ProjectionParams.z;
    u_xlat0 = u_xlat0 / u_xlat4.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat4.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat14 = u_xlat1.z / u_xlat1.w;
    u_xlat14 = _ZBufferParams.x * u_xlat14 + _ZBufferParams.y;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat3.x = (-unity_OrthoParams.w) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat3.x;
    u_xlat14 = u_xlat1.z * unity_OrthoParams.w + u_xlat14;
    u_xlat14 = (-u_xlat0) * 0.5 + u_xlat14;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = (-u_xlat0) * _ProjectionParams.x + u_xlat1.z;
    u_xlat7 = u_xlat14 * _ZBufferParams.x;
    u_xlat14 = (-_ZBufferParams.y) * u_xlat14 + 1.0;
    u_xlat14 = u_xlat14 / u_xlat7;
    u_xlat14 = u_xlat1.w * u_xlat14;
    u_xlat14 = u_xlat3.x * u_xlat14;
    gl_Position.z = u_xlat0 * unity_OrthoParams.w + u_xlat14;
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = max(u_xlat0, 1.17549435e-38);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_NORMAL0.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD0 = u_xlat1;
    u_xlat0 = u_xlat1.z + _ProjectionParams.y;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0 = u_xlat0 / u_xlat1.x;
    u_xlat0 = u_xlat0 * _ProjectionParams.z;
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlat0 = (-rp_FogFactor.xxxy.w) * u_xlat0 + rp_FogFactor.xxxy.z;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat0 = (-u_xlat0) + 1.0;
    vs_TEXCOORD4.x = u_xlat0 * rp_FogColor.w;
    u_xlat0 = u_xlat2.y + (-rp_HeightFogFactor.x);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat0 = u_xlat0 * rp_HeightFogFactor.y;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    vs_TEXCOORD4.y = u_xlat0 * rp_HeightFogColor.w;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlatb0 = unity_OrthoParams.w==0.0;
    u_xlat1.x = (u_xlatb0) ? u_xlat4.x : hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = (u_xlatb0) ? u_xlat4.y : hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = (u_xlatb0) ? u_xlat4.z : hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD2.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
		Pass
		{
			Name "OUTLINE-RP"
			Tags { "LIGHTMODE"="SekaiAdd1" "QUEUE"="AlphaTest" "RenderType"="Opaque" }
			ZTest Less
			Cull Front
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SekaiOutlineWidth;
uniform 	vec4 _SekaiOutlineFactor;
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
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowTexWeight;
	UNITY_UNIFORM int Xhlslcc_UnusedX_FadeMode;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD3;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_SekaiOutlineFactor.x);
    u_xlat0.x = u_xlat0.x * _SekaiOutlineFactor.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * _SekaiOutlineFactor.z;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat2.x = (-_SekaiOutlineWidth.x) + _SekaiOutlineWidth.y;
    u_xlat0.x = u_xlat0.x * u_xlat2.x + _SekaiOutlineWidth.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_COLOR0.xxx + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4 = u_xlat0.z;
    u_xlat0.x = u_xlat0.z + _ProjectionParams.y;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2.x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD3 = u_xlat0.x;
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
uniform 	vec4 _CoCParams;
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiCharacterAmbientLightIntensityArray[12];
uniform 	vec4 _SekaiCharacterAmbientLightColorArray[12];
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
uniform 	vec4 _SekaiFogColor;
uniform 	mediump vec4 _SekaiShadowColor;
uniform 	mediump vec4 _SekaiCharacterOutlineColorArray[12];
uniform 	float _SekaiCharacterOutlineBlendingArray[12];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowTexWeight;
	UNITY_UNIFORM int Xhlslcc_UnusedX_FadeMode;
	UNITY_UNIFORM float Xhlslcc_UnusedX_ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ValueTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD3;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
int u_xlati1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat9;
bvec3 u_xlatb9;
mediump float u_xlat16_11;
float u_xlat17;
mediump float u_xlat16_19;
float u_xlat25;
mediump float u_xlat16_26;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
void main()
{
    u_xlat16_0 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlati1 = _CharacterId;
    u_xlat16_2.xyz = _SekaiCharacterOutlineColorArray[u_xlati1].www * _SekaiCharacterOutlineColorArray[u_xlati1].xyz;
    u_xlat9.x = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).x;
    u_xlat16_26 = _Saturation + _Saturation;
    u_xlat16_3.x = _Value * 2.0 + -1.0;
    u_xlat16_11 = _Contrast + _Contrast;
    u_xlat4.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat4.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat4.zxy);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_HueSinAngle);
    u_xlat4.xyz = u_xlat16_0.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat4.xyz;
    u_xlat17 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat17 = u_xlat17 * 0.57735002;
    u_xlat16_19 = (-_HueCosAngle) + 1.0;
    u_xlat4.xyz = vec3(u_xlat17) * vec3(u_xlat16_19) + u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_11) + u_xlat16_3.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_27 = dot(u_xlat16_5.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_5.xyz = (-vec3(u_xlat16_27)) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz + vec3(u_xlat16_27);
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat6.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_27 = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_29 = u_xlat16_5.x * 2.0 + -1.0;
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_7.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat4.xyz;
    u_xlat16_27 = u_xlat16_27;
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat16_7.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat16_7.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat4.xyz = u_xlat16_7.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat4.zxy);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_HueSinAngle);
    u_xlat4.xyz = u_xlat16_7.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat4.xyz;
    u_xlat17 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_7.xyz);
    u_xlat17 = u_xlat17 * 0.57735002;
    u_xlat4.xyz = vec3(u_xlat17) * vec3(u_xlat16_19) + u_xlat4.xyz;
    u_xlat16_7.xyz = u_xlat4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat16_7.xyz * vec3(u_xlat16_11) + u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_27 = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.xyz = (-vec3(u_xlat16_27)) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz + vec3(u_xlat16_27);
    u_xlatb9.x = u_xlat9.x>=0.5;
    u_xlat16_26 = (u_xlatb9.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = (-u_xlat16_5.xyz) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlatb9.xyz = greaterThanEqual(u_xlat16_3.xyzz, vec4(0.5, 0.5, 0.5, 0.5)).xyz;
    u_xlat16_5.x = (u_xlatb9.x) ? float(1.0) : float(0.0);
    u_xlat16_5.y = (u_xlatb9.y) ? float(1.0) : float(0.0);
    u_xlat16_5.z = (u_xlatb9.z) ? float(1.0) : float(0.0);
    u_xlat16_7.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat9.xyz = u_xlat16_7.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati1].xyz;
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat4.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati1].xyz);
    u_xlat4.xyz = (-u_xlat16_3.xyz) * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati1].xyz + u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati1]);
    u_xlat4.xyz = u_xlat9.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_3.xyz = (-u_xlat9.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat4.xyz * _PartsAmbientColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = _PartsAmbientColor.www * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlatb9.x = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb9.x){
        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat9.xy = u_xlat9.xy * u_xlat9.xy;
        u_xlat9.x = u_xlat9.y + u_xlat9.x;
        u_xlat9.x = u_xlat9.z * u_xlat9.z + u_xlat9.x;
        u_xlat17 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat9.x = u_xlat9.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat17 = float(1.0) / u_xlat17;
        u_xlat9.x = u_xlat17 * u_xlat9.x;
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
        u_xlat17 = u_xlat9.x * -2.0 + 3.0;
        u_xlat9.x = u_xlat9.x * u_xlat9.x;
        u_xlat25 = u_xlat9.x * u_xlat17;
        u_xlat9.x = (-u_xlat17) * u_xlat9.x + 1.0;
        u_xlat4.xyz = u_xlat16_3.xyz * vec3(u_xlat25);
        u_xlat4.xyz = u_xlat4.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat9.xyz = u_xlat9.xxx * u_xlat16_3.xyz + u_xlat4.xyz;
    } else {
        u_xlat9.xyz = u_xlat16_3.xyz;
    }
    u_xlat9.xyz = (-_SekaiCharacterOutlineColorArray[u_xlati1].xyz) * _SekaiCharacterOutlineColorArray[u_xlati1].www + u_xlat9.xyz;
    u_xlat1.xyz = vec3(_SekaiCharacterOutlineBlendingArray[u_xlati1]) * u_xlat9.xyz + u_xlat16_2.xyz;
    u_xlat16_2.x = (-vs_TEXCOORD3) + 1.0;
    u_xlat25 = u_xlat16_2.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat1.xyz) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat25) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD4 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat9.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9.x = u_xlat9.x + -1.0;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.w;
    u_xlat1.x = u_xlat9.x * u_xlat1.x + _ProjectionParams.w;
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
    u_xlat9.x = u_xlat1.x;
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
    u_xlat1.x = max(u_xlat1.x, -1.0);
    u_xlat1.x = min(u_xlat1.x, 0.0);
    u_xlat1.x = u_xlat1.x + u_xlat9.x;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * 0.5;
    SV_Target0 = u_xlat16_0;
    SV_Target1.x = u_xlat1.x;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "REFLECTION-RP"
			Tags { "LIGHTMODE"="SekaiAdd2" "QUEUE"="AlphaTest" "RenderType"="Opaque" }
			Cull Front
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
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM int                _CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM float                _ShadowTexWeight;
	UNITY_UNIFORM int                _FadeMode;
	UNITY_UNIFORM float                _ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_NORMAL0;
out highp float vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
float u_xlat10;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = (-u_xlat0.yyyy) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlati9 = (-_CharacterReflectionOff) + 1;
    u_xlat9 = float(u_xlati9);
    u_xlat2 = u_xlat1 * vec4(u_xlat9);
    u_xlat9 = u_xlat9 * u_xlat1.z + _ProjectionParams.y;
    gl_Position = u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = max(u_xlat10, 1.17549435e-38);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_NORMAL0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD5 = u_xlat2.z;
    vs_TEXCOORD0 = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlatb0 = unity_OrthoParams.w==0.0;
    u_xlat2.x = (u_xlatb0) ? u_xlat1.x : hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = (u_xlatb0) ? u_xlat1.y : hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = (u_xlatb0) ? u_xlat1.z : hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat9 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.x + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD4 = u_xlat0.x;
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
uniform 	vec4 _SekaiDirectionalLight;
uniform 	mediump vec4 _SekaiShadowColor;
uniform 	mediump float _SekaiShadowThreshold;
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
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4                _DefaultSkinColor;
	UNITY_UNIFORM vec4                _Shadow1SkinColor;
	UNITY_UNIFORM vec4                _Shadow2SkinColor;
	UNITY_UNIFORM int                _CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM mediump vec4                _PartsAmbientColor;
	UNITY_UNIFORM float                _ShadowTexWeight;
	UNITY_UNIFORM int                _FadeMode;
	UNITY_UNIFORM float                _ShadowWidth;
	UNITY_UNIFORM mediump float                _HueSinAngle;
	UNITY_UNIFORM mediump float                _HueCosAngle;
	UNITY_UNIFORM mediump float                _Saturation;
	UNITY_UNIFORM mediump float                _Value;
	UNITY_UNIFORM mediump float                _Contrast;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_IsAccessory;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ValueTex;
in highp vec3 vs_NORMAL0;
in highp float vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
bvec3 u_xlatb9;
mediump float u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_13;
float u_xlat17;
float u_xlat18;
int u_xlati18;
mediump float u_xlat16_19;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
int u_xlati26;
mediump float u_xlat16_27;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat16_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat1.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    u_xlat25 = u_xlat1.x * _ShadowTexWeight;
    u_xlat1.xyz = vec3(_ShadowTexWeight) * u_xlat1.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_3.x = u_xlat16_2.z * 2.0 + -1.0;
    u_xlat16_11 = _Saturation + _Saturation;
    u_xlat16_19 = _Value * 2.0 + -1.0;
    u_xlat16_27 = _Contrast + _Contrast;
    u_xlat4.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat4.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat4.zxy);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_HueSinAngle);
    u_xlat4.xyz = u_xlat16_0.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat4.xyz;
    u_xlat18 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat18 = u_xlat18 * 0.57735002;
    u_xlat16_5.x = (-_HueCosAngle) + 1.0;
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat16_5.xxx + u_xlat4.xyz;
    u_xlat16_13.xyz = u_xlat4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_13.xyz = u_xlat16_13.xyz * vec3(u_xlat16_27) + vec3(u_xlat16_19);
    u_xlat16_13.xyz = u_xlat16_13.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_6.x = dot(u_xlat16_13.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_13.xyz = u_xlat16_13.xyz + (-u_xlat16_6.xxx);
    u_xlat16_13.xyz = vec3(u_xlat16_11) * u_xlat16_13.xyz + u_xlat16_6.xxx;
    u_xlat18 = dot(_SekaiDirectionalLight.xyz, vs_NORMAL0.xyz);
    u_xlat18 = u_xlat18 * 0.5 + 0.5;
    switch(_FadeMode){
        case 0:
            u_xlat4.x = _ShadowWidth * (-_SekaiShadowThreshold) + _SekaiShadowThreshold;
            u_xlat12.x = u_xlat16_3.x + u_xlat18;
            u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
            u_xlat12.x = (-u_xlat4.x) + u_xlat12.x;
            u_xlat4.x = (-u_xlat4.x) + _SekaiShadowThreshold;
            u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
            u_xlat4.x = u_xlat12.x / u_xlat4.x;
            u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
            u_xlat12.x = u_xlat4.x * u_xlat4.x;
            u_xlat4.x = (-u_xlat4.x) * 2.0 + 3.0;
            u_xlat26 = (-u_xlat12.x) * u_xlat4.x + 1.0;
            break;
        case 1:
            u_xlat4.x = (-_SekaiShadowThreshold) + 1.0;
            u_xlat4.x = u_xlat4.x * _ShadowWidth;
            u_xlat18 = u_xlat16_3.x + u_xlat18;
            u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
            u_xlat18 = u_xlat18 + (-_SekaiShadowThreshold);
            u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
            u_xlat18 = u_xlat18 / u_xlat4.x;
            u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
            u_xlat4.x = u_xlat18 * u_xlat18;
            u_xlat18 = (-u_xlat18) * 2.0 + 3.0;
            u_xlat26 = (-u_xlat4.x) * u_xlat18 + 1.0;
            break;
        default:
            break;
    }
    u_xlat1.xyz = u_xlat1.xyz * _SekaiShadowColor.xyz + (-u_xlat16_13.xyz);
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat1.xyz + u_xlat16_13.xyz;
    u_xlat25 = u_xlat26 * u_xlat25 + u_xlat16_0.x;
    u_xlat4.xyz = _SekaiShadowColor.xyz * _Shadow1SkinColor.xyz;
    u_xlat7.xyz = _SekaiShadowColor.xyz * _Shadow2SkinColor.xyz;
    u_xlat16_3.x = u_xlat25 + u_xlat25;
    u_xlat16_13.x = u_xlat25 * 2.0 + -1.0;
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
    u_xlat16_6.xyz = (-_Shadow1SkinColor.xyz) * _SekaiShadowColor.xyz + _DefaultSkinColor.xyz;
    u_xlat16_13.xyz = u_xlat16_13.xxx * u_xlat16_6.xyz + u_xlat4.xyz;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_13.xyz = (-_Shadow2SkinColor.xyz) * _SekaiShadowColor.xyz + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_3.xxx * u_xlat16_13.xyz + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat16_13.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat4.xyz = u_xlat16_13.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat4.zxy);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_HueSinAngle);
    u_xlat4.xyz = u_xlat16_13.xyz * vec3(vec3(_HueCosAngle, _HueCosAngle, _HueCosAngle)) + u_xlat4.xyz;
    u_xlat25 = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_13.xyz);
    u_xlat25 = u_xlat25 * 0.57735002;
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat16_5.xxx + u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xzw = u_xlat16_5.xyz * vec3(u_xlat16_27) + vec3(u_xlat16_19);
    u_xlat16_3.xzw = u_xlat16_3.xzw + vec3(0.5, 0.5, 0.5);
    u_xlat16_5.x = dot(u_xlat16_3.xzw, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.xzw = u_xlat16_3.xzw + (-u_xlat16_5.xxx);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * u_xlat16_3.xzw + u_xlat16_5.xxx;
    u_xlatb25 = u_xlat16_2.x>=0.5;
    u_xlat16_27 = (u_xlatb25) ? 1.0 : 0.0;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_27) * u_xlat16_3.xyz + u_xlat1.xyz;
    u_xlati1 = _CharacterId;
    u_xlat9.xyz = _SekaiRimLightColorArray[u_xlati1].www * _SekaiRimLightColorArray[u_xlati1].xyz;
    u_xlat2.x = dot(vs_NORMAL0.xyz, vs_TEXCOORD2.xyz);
    u_xlat2.z = dot(vs_TEXCOORD2.xyz, _SekaiRimLightArray[u_xlati1].xyz);
    u_xlat26 = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat4.xyz = vec3(u_xlat26) * vs_NORMAL0.xyz;
    u_xlat26 = dot(_SekaiRimLightArray[u_xlati1].xyz, _SekaiRimLightArray[u_xlati1].xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat7.xyz = vec3(u_xlat26) * _SekaiRimLightArray[u_xlati1].xyz;
    u_xlat26 = dot(u_xlat4.xyz, u_xlat7.xyz);
    u_xlat16_27 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati1];
    u_xlat16_5.x = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati1]);
    u_xlat4.x = (-u_xlat16_27) + u_xlat16_5.x;
    u_xlat12.x = u_xlat26 + (-u_xlat16_27);
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat12.x;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat12.x = u_xlat4.x * -2.0 + 3.0;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat12.x;
    u_xlat12.xyz = _SekaiShadowRimLightColorArray[u_xlati1].xyz * _SekaiShadowRimLightColorArray[u_xlati1].www + (-u_xlat9.xyz);
    u_xlat9.xyz = u_xlat4.xxx * u_xlat12.xyz + u_xlat9.xyz;
    u_xlat2.xz = max(u_xlat2.xz, vec2(0.0, 0.0));
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat16_27 = 10.0 + (-_SekaiRimLightFactor[u_xlati1].x);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * u_xlat16_27;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat18 = u_xlat2.x * u_xlat2.z + (-u_xlat2.x);
    u_xlat2.x = _SekaiRimLightFactor[u_xlati1].w * u_xlat18 + u_xlat2.x;
    u_xlat18 = (-u_xlat26) + 0.0500000007;
    u_xlati26 = int((0.0<u_xlat18) ? 0xFFFFFFFFu : uint(0));
    u_xlati18 = int((u_xlat18<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati18 = (-u_xlati26) + u_xlati18;
    u_xlat18 = float(u_xlati18);
    u_xlat18 = u_xlat2.x * u_xlat18 + (-u_xlat2.x);
    u_xlat2.x = _SekaiRimLightFactor[u_xlati1].w * u_xlat18 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x + (-_RimThreshold);
    u_xlat18 = float(1.0) / _SekaiRimLightFactor[u_xlati1].z;
    u_xlat2.x = u_xlat18 * u_xlat2.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat18 = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat18;
    u_xlat9.xyz = u_xlat9.xyz * u_xlat2.xxx;
    u_xlat2.xzw = u_xlat9.xyz * vs_COLOR0.yyy;
    u_xlat16_3.xyz = u_xlat9.xyz * vs_COLOR0.yyy + u_xlat16_3.xyz;
    u_xlatb9.xyz = greaterThanEqual(u_xlat16_3.xyzz, vec4(0.5, 0.5, 0.5, 0.5)).xyz;
    u_xlat16_5.x = (u_xlatb9.x) ? float(1.0) : float(0.0);
    u_xlat16_5.y = (u_xlatb9.y) ? float(1.0) : float(0.0);
    u_xlat16_5.z = (u_xlatb9.z) ? float(1.0) : float(0.0);
    u_xlat16_6.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat9.xyz = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati1].xyz;
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat4.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati1].xyz);
    u_xlat4.xyz = (-u_xlat16_3.xyz) * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati1].xyz + u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati1]);
    u_xlat4.xyz = u_xlat9.xyz * vec3(_SekaiAllLightIntensity);
    u_xlat16_3.xyz = (-u_xlat9.xyz) * vec3(_SekaiAllLightIntensity) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = (-_PartsAmbientColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat4.xyz * _PartsAmbientColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = _PartsAmbientColor.www * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlatb9.x = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb9.x){
        u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat9.xy = u_xlat9.xy * u_xlat9.xy;
        u_xlat9.x = u_xlat9.y + u_xlat9.x;
        u_xlat9.x = u_xlat9.z * u_xlat9.z + u_xlat9.x;
        u_xlat17 = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat9.x = u_xlat9.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat17 = float(1.0) / u_xlat17;
        u_xlat9.x = u_xlat17 * u_xlat9.x;
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
        u_xlat17 = u_xlat9.x * -2.0 + 3.0;
        u_xlat9.x = u_xlat9.x * u_xlat9.x;
        u_xlat25 = u_xlat9.x * u_xlat17;
        u_xlat9.x = (-u_xlat17) * u_xlat9.x + 1.0;
        u_xlat4.xyz = u_xlat16_3.xyz * vec3(u_xlat25);
        u_xlat4.xyz = u_xlat4.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat9.xyz = u_xlat9.xxx * u_xlat16_3.xyz + u_xlat4.xyz;
    } else {
        u_xlat9.xyz = u_xlat16_3.xyz;
    }
    u_xlat2.xzw = u_xlat2.xzw * _SekaiRimLightFactor[u_xlati1].yyy;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat16_2.yyy + u_xlat2.xzw;
    u_xlat16_3.x = (-vs_TEXCOORD4) + 1.0;
    u_xlat1.x = u_xlat16_3.x * _SekaiFogColor.w;
    u_xlat4.xyz = (-u_xlat9.xyz) + _SekaiFogColor.xyz;
    u_xlat16_0.xyz = u_xlat1.xxx * u_xlat4.xyz + u_xlat9.xyz;
    u_xlat1.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat9.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9.x = u_xlat9.x + -1.0;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.w;
    u_xlat1.x = u_xlat9.x * u_xlat1.x + _ProjectionParams.w;
    u_xlat1.x = (-_CoCParams.x) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * _CoCParams.y;
    u_xlat9.x = u_xlat1.x;
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
    u_xlat1.x = max(u_xlat1.x, -1.0);
    u_xlat1.x = min(u_xlat1.x, 0.0);
    u_xlat1.x = u_xlat1.x + u_xlat9.x;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.x * 0.5;
    SV_Target0 = u_xlat16_0;
    SV_Target1.x = u_xlat1.x;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2.xyz = u_xlat2.xyz;
    SV_Target2.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
	}
	Fallback "Legacy Shaders/VertexLit"
}
