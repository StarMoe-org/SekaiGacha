// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Hidden/Sekai/Live/MusicItem/Toon"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ShadowTex("Shadow", 2D) = "white" {}
		_ValueTex("Value", 2D) = "black" {}
		_OutlineWidth("OutlineWidth", Float) = 0.001
		_OutlineL("OutlineL", Range(0, 1)) = 0.5
		_RimThreshold("RimThreshold", Range(0.01, 1)) = 0.2
		[HideInInspector] _Transparency("Transparency", Range(0, 1)) = 1
		[HideInInspector] _CharacterId("CharacterId", Float) = 0
		[HideInInspector] _DefaultSkinColor("DefaultSkinColor", Color) = (0.9921875, 0.9609375, 0.921875, 1)
		[HideInInspector] _Shadow1SkinColor("Shadow1SkinColor", Color) = (0.890625, 0.76953125, 0.796875, 1)
		[HideInInspector] _Shadow2SkinColor("Shadow2SkinColor", Color) = (0.796875, 0.59375, 0.63671875, 1)
		[HideInInspector] _CharacterReflectionOff("CharacterReflectionOff", Float) = 0
	}
	SubShader
	{
		Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
		Pass
		{
			Name "BASE TRANSPARENT"
			Tags { "LIGHTMODE"="SekaiTransparentBase" "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
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
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM float                _Transparency;
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
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
void main()
{
    u_xlatb0 = 0.0>=_Transparency;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat1.xyz;
    gl_Position.w = u_xlat1.w;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = max(u_xlat0, 1.17549435e-38);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_NORMAL0.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    vs_TEXCOORD5 = u_xlat1.z;
    vs_TEXCOORD0 = u_xlat1;
    u_xlat0 = u_xlat1.z + _ProjectionParams.y;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    u_xlatb3 = unity_OrthoParams.w==0.0;
    u_xlat2.x = (u_xlatb3) ? u_xlat1.x : hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = (u_xlatb3) ? u_xlat1.y : hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = (u_xlatb3) ? u_xlat1.z : hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD2.xyz = u_xlat3.xxx * u_xlat2.xyz;
    u_xlat3.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0 = u_xlat0 / u_xlat3.x;
    u_xlat0 = u_xlat0 * _ProjectionParams.z;
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlat0 = (-_SekaiFogFactor.y) * u_xlat0 + _SekaiFogFactor.x;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    vs_TEXCOORD4 = u_xlat0;
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
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM float                _Transparency;
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
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
bvec3 u_xlatb7;
float u_xlat8;
int u_xlati8;
float u_xlat9;
mediump vec3 u_xlat16_10;
float u_xlat15;
int u_xlati15;
float u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_24;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_2.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_3.x = u_xlat16_2.z * 2.0 + -1.0;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_NORMAL0.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat21 = u_xlat16_3.x + u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = u_xlat21>=_SekaiShadowThreshold;
    u_xlat21 = (u_xlatb21) ? 0.0 : 1.0;
    u_xlat1.xyz = u_xlat16_1.xyz * _SekaiShadowColor.xyz + (-u_xlat16_0.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat1.xyz + u_xlat16_0.xyz;
    u_xlat16_3.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_10.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
    u_xlat1.xyz = _DefaultSkinColor.xyz + (-_Shadow1SkinColor.xyz);
    u_xlat1.xyz = u_xlat16_10.xxx * u_xlat1.xyz + _Shadow1SkinColor.xyz;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_Shadow2SkinColor.xyz);
    u_xlat1.xyz = u_xlat16_3.xxx * u_xlat1.xyz + _Shadow2SkinColor.xyz;
    u_xlatb21 = u_xlat16_2.x>=0.5;
    u_xlat16_3.x = (u_xlatb21) ? 1.0 : 0.0;
    u_xlat16_10.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlati0 = _CharacterId;
    u_xlat7.xyz = _SekaiRimLightColorArray[u_xlati0].www * _SekaiRimLightColorArray[u_xlati0].xyz;
    u_xlat1.x = dot(vs_NORMAL0.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, _SekaiRimLightArray[u_xlati0].xyz);
    u_xlat15 = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xzw = vec3(u_xlat15) * vs_NORMAL0.xyz;
    u_xlat15 = dot(_SekaiRimLightArray[u_xlati0].xyz, _SekaiRimLightArray[u_xlati0].xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * _SekaiRimLightArray[u_xlati0].xyz;
    u_xlat15 = dot(u_xlat2.xzw, u_xlat4.xyz);
    u_xlat16_24 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati0];
    u_xlat16_5.x = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati0]);
    u_xlat22 = (-u_xlat16_24) + u_xlat16_5.x;
    u_xlat2.x = u_xlat15 + (-u_xlat16_24);
    u_xlat22 = float(1.0) / u_xlat22;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
    u_xlat2.x = u_xlat22 * -2.0 + 3.0;
    u_xlat22 = u_xlat22 * u_xlat22;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.xzw = _SekaiShadowRimLightColorArray[u_xlati0].xyz * _SekaiShadowRimLightColorArray[u_xlati0].www + (-u_xlat7.xyz);
    u_xlat7.xyz = vec3(u_xlat22) * u_xlat2.xzw + u_xlat7.xyz;
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat16_24 = 10.0 + (-_SekaiRimLightFactor[u_xlati0].x);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat16_24;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8 = u_xlat1.x * u_xlat1.y + (-u_xlat1.x);
    u_xlat1.x = _SekaiRimLightFactor[u_xlati0].w * u_xlat8 + u_xlat1.x;
    u_xlat8 = (-u_xlat15) + 0.0500000007;
    u_xlati15 = int((0.0<u_xlat8) ? 0xFFFFFFFFu : uint(0));
    u_xlati8 = int((u_xlat8<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati8 = (-u_xlati15) + u_xlati8;
    u_xlat8 = float(u_xlati8);
    u_xlat8 = u_xlat1.x * u_xlat8 + (-u_xlat1.x);
    u_xlat1.x = _SekaiRimLightFactor[u_xlati0].w * u_xlat8 + u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-_RimThreshold);
    u_xlat8 = float(1.0) / _SekaiRimLightFactor[u_xlati0].z;
    u_xlat1.x = u_xlat8 * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat7.xyz * vs_COLOR0.yyy;
    u_xlat16_3.xyz = u_xlat7.xyz * vs_COLOR0.yyy + u_xlat16_3.xyz;
    u_xlatb7.xyz = greaterThanEqual(u_xlat16_3.xyzz, vec4(0.5, 0.5, 0.5, 0.5)).xyz;
    u_xlat16_5.x = (u_xlatb7.x) ? float(1.0) : float(0.0);
    u_xlat16_5.y = (u_xlatb7.y) ? float(1.0) : float(0.0);
    u_xlat16_5.z = (u_xlatb7.z) ? float(1.0) : float(0.0);
    u_xlat16_6.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati0].xyz;
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat2.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati0].xyz);
    u_xlat2.xzw = (-u_xlat16_3.xyz) * u_xlat2.xzw + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati0].xyz + u_xlat2.xzw;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat16_3.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati0]);
    u_xlat7.xyz = u_xlat7.xyz * vec3(_SekaiAllLightIntensity);
    u_xlatb22 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb22){
        u_xlat2.xzw = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat2.xz = u_xlat2.xz * u_xlat2.xz;
        u_xlat22 = u_xlat2.z + u_xlat2.x;
        u_xlat22 = u_xlat2.w * u_xlat2.w + u_xlat22;
        u_xlat2.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat22 = u_xlat22 + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat2.x = float(1.0) / u_xlat2.x;
        u_xlat22 = u_xlat22 * u_xlat2.x;
        u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
        u_xlat2.x = u_xlat22 * -2.0 + 3.0;
        u_xlat22 = u_xlat22 * u_xlat22;
        u_xlat16 = u_xlat22 * u_xlat2.x;
        u_xlat22 = (-u_xlat2.x) * u_xlat22 + 1.0;
        u_xlat2.xzw = u_xlat7.xyz * vec3(u_xlat16);
        u_xlat2.xzw = u_xlat2.xzw * _SekaiGlobalSpotLightColor.xyz;
        u_xlat7.xyz = vec3(u_xlat22) * u_xlat7.xyz + u_xlat2.xzw;
    }
    u_xlat1.xyz = u_xlat1.xyz * _SekaiRimLightFactor[u_xlati0].yyy;
    u_xlat1.xyz = u_xlat7.xyz * u_xlat16_2.yyy + u_xlat1.xyz;
    u_xlat16_3.x = (-vs_TEXCOORD4) + 1.0;
    u_xlat0.x = u_xlat16_3.x * _SekaiFogColor.w;
    u_xlat2.xyz = (-u_xlat7.xyz) + _SekaiFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat7.xyz;
    u_xlat2.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat9 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9 = u_xlat9 + -1.0;
    u_xlat9 = u_xlat9 * _ProjectionParams.w;
    u_xlat2.x = u_xlat9 * u_xlat2.x + _ProjectionParams.w;
    u_xlat2.x = (-_CoCParams.x) * u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * _CoCParams.y;
    u_xlat9 = u_xlat2.x;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, -1.0);
    u_xlat2.x = min(u_xlat2.x, 0.0);
    u_xlat2.x = u_xlat2.x + u_xlat9;
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
    u_xlat0.w = _Transparency;
    SV_Target0 = u_xlat0;
    SV_Target1.x = u_xlat2.x;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    u_xlat1.w = _Transparency;
    SV_Target2 = u_xlat1;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "OUTLINE TRANSPARENT"
			Tags { "LIGHTMODE"="SekaiTransparentOutline" "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
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
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RimThreshold;
	UNITY_UNIFORM float                _OutlineWidth;
	UNITY_UNIFORM float                _OutlineL;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DefaultSkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow1SkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow2SkinColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM float                _Transparency;
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
bool u_xlatb1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_OutlineWidth, _OutlineWidth, _OutlineWidth));
    u_xlat0.xyz = u_xlat0.xyz * in_COLOR0.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlatb1 = 0.0>=_Transparency;
    gl_Position.xyz = (bool(u_xlatb1)) ? vec3(0.0, 0.0, 0.0) : u_xlat0.xyz;
    gl_Position.w = u_xlat0.w;
    vs_TEXCOORD0 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4 = u_xlat0.z;
    u_xlat0.x = u_xlat0.z + _ProjectionParams.y;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
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
uniform 	mediump vec4 _SekaiCharacterOutlineColorArray[12];
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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ShadowTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_ValueTex_ST;
	UNITY_UNIFORM float Xhlslcc_UnusedX_RimThreshold;
	UNITY_UNIFORM float                _OutlineWidth;
	UNITY_UNIFORM float                _OutlineL;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DefaultSkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow1SkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow2SkinColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM float                _Transparency;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _ShadowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD3;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec3 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat8;
float u_xlat14;
float u_xlat18;
int u_xlati18;
void main()
{
    u_xlat0.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlati18 = _CharacterId;
    u_xlat16_1.xyz = _SekaiCharacterOutlineColorArray[u_xlati18].www * _SekaiCharacterOutlineColorArray[u_xlati18].xyz;
    u_xlatb2.xyz = greaterThanEqual(u_xlat0.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_3.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_3.y = (u_xlatb2.y) ? float(1.0) : float(0.0);
    u_xlat16_3.z = (u_xlatb2.z) ? float(1.0) : float(0.0);
    u_xlat16_4.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati18].xyz;
    u_xlat16_5.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati18].xyz);
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati18].xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati18]);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SekaiAllLightIntensity);
    u_xlatb2.x = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb2.x){
        u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat2.xy = u_xlat2.xy * u_xlat2.xy;
        u_xlat2.x = u_xlat2.y + u_xlat2.x;
        u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
        u_xlat8.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat2.x = u_xlat2.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat8.x = float(1.0) / u_xlat8.x;
        u_xlat2.x = u_xlat8.x * u_xlat2.x;
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
        u_xlat8.x = u_xlat2.x * -2.0 + 3.0;
        u_xlat2.x = u_xlat2.x * u_xlat2.x;
        u_xlat14 = u_xlat2.x * u_xlat8.x;
        u_xlat2.x = (-u_xlat8.x) * u_xlat2.x + 1.0;
        u_xlat8.xyz = u_xlat0.xyz * vec3(u_xlat14);
        u_xlat8.xyz = u_xlat8.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = u_xlat2.xxx * u_xlat0.xyz + u_xlat8.xyz;
    }
    u_xlat0.xyz = (-_SekaiCharacterOutlineColorArray[u_xlati18].xyz) * _SekaiCharacterOutlineColorArray[u_xlati18].www + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_OutlineL, _OutlineL, _OutlineL)) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = (-vs_TEXCOORD3) + 1.0;
    u_xlat18 = u_xlat16_1.x * _SekaiFogColor.w;
    u_xlat2.xyz = (-u_xlat0.xyz) + _SekaiFogColor.xyz;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.x = vs_TEXCOORD4 / vs_TEXCOORD0.w;
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat8.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat8.x = u_xlat8.x + -1.0;
    u_xlat8.x = u_xlat8.x * _ProjectionParams.w;
    u_xlat2.x = u_xlat8.x * u_xlat2.x + _ProjectionParams.w;
    u_xlat2.x = (-_CoCParams.x) * u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * _CoCParams.y;
    u_xlat8.x = u_xlat2.x;
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, -1.0);
    u_xlat2.x = min(u_xlat2.x, 0.0);
    u_xlat2.x = u_xlat2.x + u_xlat8.x;
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
    u_xlat0.w = _Transparency;
    SV_Target0 = u_xlat0;
    SV_Target1.x = u_xlat2.x;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    u_xlat0.x = 0.0;
    u_xlat0.w = _Transparency;
    SV_Target2 = u_xlat0.xxxw;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "REFLECTION TRANSPARENT"
			Tags { "LIGHTMODE"="SekaiTransparentReflection" "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
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
	UNITY_UNIFORM float                _Transparency;
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
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
void main()
{
    u_xlatb0 = 0.0>=_Transparency;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = (-u_xlat4.yyyy) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlati2 = (-_CharacterReflectionOff) + 1;
    u_xlat2.x = float(u_xlati2);
    u_xlat3 = u_xlat1 * u_xlat2.xxxx;
    u_xlat1.x = u_xlat2.x * u_xlat1.z + _ProjectionParams.y;
    gl_Position.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    gl_Position.w = u_xlat3.w;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = max(u_xlat0, 1.17549435e-38);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat5.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat0 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_NORMAL0.xyz = vec3(u_xlat0) * u_xlat5.xyz;
    vs_TEXCOORD5 = u_xlat3.z;
    vs_TEXCOORD0 = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat5.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    u_xlatb0 = unity_OrthoParams.w==0.0;
    u_xlat2.x = (u_xlatb0) ? u_xlat5.x : hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = (u_xlatb0) ? u_xlat5.y : hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = (u_xlatb0) ? u_xlat5.z : hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat0 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0 = u_xlat1.x / u_xlat0;
    u_xlat0 = u_xlat0 * _ProjectionParams.z;
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlat0 = (-_SekaiFogFactor.y) * u_xlat0 + _SekaiFogFactor.x;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    vs_TEXCOORD4 = u_xlat0;
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
	UNITY_UNIFORM float                _Transparency;
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
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
bvec3 u_xlatb7;
float u_xlat8;
int u_xlati8;
float u_xlat9;
mediump vec3 u_xlat16_10;
float u_xlat15;
int u_xlati15;
float u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_24;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_2.xyz = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_3.x = u_xlat16_2.z * 2.0 + -1.0;
    u_xlat21 = dot(_SekaiDirectionalLight.xyz, vs_NORMAL0.xyz);
    u_xlat21 = u_xlat21 * 0.5 + 0.5;
    u_xlat21 = u_xlat16_3.x + u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb21 = u_xlat21>=_SekaiShadowThreshold;
    u_xlat21 = (u_xlatb21) ? 0.0 : 1.0;
    u_xlat1.xyz = u_xlat16_1.xyz * _SekaiShadowColor.xyz + (-u_xlat16_0.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat1.xyz + u_xlat16_0.xyz;
    u_xlat16_3.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_10.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
    u_xlat1.xyz = _DefaultSkinColor.xyz + (-_Shadow1SkinColor.xyz);
    u_xlat1.xyz = u_xlat16_10.xxx * u_xlat1.xyz + _Shadow1SkinColor.xyz;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_Shadow2SkinColor.xyz);
    u_xlat1.xyz = u_xlat16_3.xxx * u_xlat1.xyz + _Shadow2SkinColor.xyz;
    u_xlatb21 = u_xlat16_2.x>=0.5;
    u_xlat16_3.x = (u_xlatb21) ? 1.0 : 0.0;
    u_xlat16_10.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlati0 = _CharacterId;
    u_xlat7.xyz = _SekaiRimLightColorArray[u_xlati0].www * _SekaiRimLightColorArray[u_xlati0].xyz;
    u_xlat1.x = dot(vs_NORMAL0.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, _SekaiRimLightArray[u_xlati0].xyz);
    u_xlat15 = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xzw = vec3(u_xlat15) * vs_NORMAL0.xyz;
    u_xlat15 = dot(_SekaiRimLightArray[u_xlati0].xyz, _SekaiRimLightArray[u_xlati0].xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * _SekaiRimLightArray[u_xlati0].xyz;
    u_xlat15 = dot(u_xlat2.xzw, u_xlat4.xyz);
    u_xlat16_24 = -1.0 + _SekaiRimLightShadowSharpnessArray[u_xlati0];
    u_xlat16_5.x = 1.0 + (-_SekaiRimLightShadowSharpnessArray[u_xlati0]);
    u_xlat22 = (-u_xlat16_24) + u_xlat16_5.x;
    u_xlat2.x = u_xlat15 + (-u_xlat16_24);
    u_xlat22 = float(1.0) / u_xlat22;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
    u_xlat2.x = u_xlat22 * -2.0 + 3.0;
    u_xlat22 = u_xlat22 * u_xlat22;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.xzw = _SekaiShadowRimLightColorArray[u_xlati0].xyz * _SekaiShadowRimLightColorArray[u_xlati0].www + (-u_xlat7.xyz);
    u_xlat7.xyz = vec3(u_xlat22) * u_xlat2.xzw + u_xlat7.xyz;
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat16_24 = 10.0 + (-_SekaiRimLightFactor[u_xlati0].x);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat16_24;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8 = u_xlat1.x * u_xlat1.y + (-u_xlat1.x);
    u_xlat1.x = _SekaiRimLightFactor[u_xlati0].w * u_xlat8 + u_xlat1.x;
    u_xlat8 = (-u_xlat15) + 0.0500000007;
    u_xlati15 = int((0.0<u_xlat8) ? 0xFFFFFFFFu : uint(0));
    u_xlati8 = int((u_xlat8<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati8 = (-u_xlati15) + u_xlati8;
    u_xlat8 = float(u_xlati8);
    u_xlat8 = u_xlat1.x * u_xlat8 + (-u_xlat1.x);
    u_xlat1.x = _SekaiRimLightFactor[u_xlati0].w * u_xlat8 + u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-_RimThreshold);
    u_xlat8 = float(1.0) / _SekaiRimLightFactor[u_xlati0].z;
    u_xlat1.x = u_xlat8 * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat7.xyz * vs_COLOR0.yyy;
    u_xlat16_3.xyz = u_xlat7.xyz * vs_COLOR0.yyy + u_xlat16_3.xyz;
    u_xlatb7.xyz = greaterThanEqual(u_xlat16_3.xyzz, vec4(0.5, 0.5, 0.5, 0.5)).xyz;
    u_xlat16_5.x = (u_xlatb7.x) ? float(1.0) : float(0.0);
    u_xlat16_5.y = (u_xlatb7.y) ? float(1.0) : float(0.0);
    u_xlat16_5.z = (u_xlatb7.z) ? float(1.0) : float(0.0);
    u_xlat16_6.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = u_xlat16_6.xyz * _SekaiCharacterAmbientLightColorArray[u_xlati0].xyz;
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat2.xzw = vec3(1.0, 1.0, 1.0) + (-_SekaiCharacterAmbientLightColorArray[u_xlati0].xyz);
    u_xlat2.xzw = (-u_xlat16_3.xyz) * u_xlat2.xzw + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_6.xyz) * _SekaiCharacterAmbientLightColorArray[u_xlati0].xyz + u_xlat2.xzw;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat16_3.xyz * vec3(_SekaiCharacterAmbientLightIntensityArray[u_xlati0]);
    u_xlat7.xyz = u_xlat7.xyz * vec3(_SekaiAllLightIntensity);
    u_xlatb22 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb22){
        u_xlat2.xzw = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat2.xz = u_xlat2.xz * u_xlat2.xz;
        u_xlat22 = u_xlat2.z + u_xlat2.x;
        u_xlat22 = u_xlat2.w * u_xlat2.w + u_xlat22;
        u_xlat2.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat22 = u_xlat22 + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat2.x = float(1.0) / u_xlat2.x;
        u_xlat22 = u_xlat22 * u_xlat2.x;
        u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
        u_xlat2.x = u_xlat22 * -2.0 + 3.0;
        u_xlat22 = u_xlat22 * u_xlat22;
        u_xlat16 = u_xlat22 * u_xlat2.x;
        u_xlat22 = (-u_xlat2.x) * u_xlat22 + 1.0;
        u_xlat2.xzw = u_xlat7.xyz * vec3(u_xlat16);
        u_xlat2.xzw = u_xlat2.xzw * _SekaiGlobalSpotLightColor.xyz;
        u_xlat7.xyz = vec3(u_xlat22) * u_xlat7.xyz + u_xlat2.xzw;
    }
    u_xlat1.xyz = u_xlat1.xyz * _SekaiRimLightFactor[u_xlati0].yyy;
    u_xlat1.xyz = u_xlat7.xyz * u_xlat16_2.yyy + u_xlat1.xyz;
    u_xlat16_3.x = (-vs_TEXCOORD4) + 1.0;
    u_xlat0.x = u_xlat16_3.x * _SekaiFogColor.w;
    u_xlat2.xyz = (-u_xlat7.xyz) + _SekaiFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat7.xyz;
    u_xlat2.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat9 = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat9 = u_xlat9 + -1.0;
    u_xlat9 = u_xlat9 * _ProjectionParams.w;
    u_xlat2.x = u_xlat9 * u_xlat2.x + _ProjectionParams.w;
    u_xlat2.x = (-_CoCParams.x) * u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * _CoCParams.y;
    u_xlat9 = u_xlat2.x;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, -1.0);
    u_xlat2.x = min(u_xlat2.x, 0.0);
    u_xlat2.x = u_xlat2.x + u_xlat9;
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
    u_xlat0.w = _Transparency;
    SV_Target0 = u_xlat0;
    SV_Target1.x = u_xlat2.x;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    u_xlat1.w = _Transparency;
    SV_Target2 = u_xlat1;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "BASE-RP"
			Tags { "LIGHTMODE"="SekaiBase" "QUEUE"="Transparent" "RenderType"="Transparent" }
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
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DefaultSkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow1SkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow2SkinColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM float Xhlslcc_UnusedX_Transparency;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
	UNITY_UNIFORM float                _RimThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineWidth;
	UNITY_UNIFORM float Xhlslcc_UnusedX_OutlineL;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_DefaultSkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow1SkinColor;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Shadow2SkinColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_CharacterReflectionOff;
	UNITY_UNIFORM int                _CharacterId;
	UNITY_UNIFORM float Xhlslcc_UnusedX_Transparency;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ShadowTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ValueTex;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
vec3 u_xlat6;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat5 = (-rp_CharacterRimIntensity) + 10.0;
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = dot(vs_TEXCOORD2.xyz, rp_CharacterRimVector.xyz);
    u_xlat5 = max(u_xlat5, 0.0);
    u_xlat0.x = u_xlat5 * u_xlat0.x;
    u_xlat5 = dot(rp_CharacterRimVector.xyz, vs_NORMAL0.xyz);
    u_xlat0.x = u_xlat5 * u_xlat0.x;
    u_xlatb0 = u_xlat0.x>=_RimThreshold;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.y;
    u_xlat0.xyz = u_xlat0.xxx * rp_CharacterRimColor.xyz;
    u_xlat15 = dot(rp_DirectionalLightVector.xyz, vs_NORMAL0.xyz);
    u_xlat15 = u_xlat15 * 0.5 + 0.5;
    u_xlat16_1.xy = texture(_ValueTex, vs_TEXCOORD1.xy, _GlobalMipBias.x).yz;
    u_xlat16_2.x = u_xlat16_1.y * 2.0 + -1.0;
    u_xlat15 = u_xlat15 + u_xlat16_2.x;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlatb15 = u_xlat15>=0.40625;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat16_3 = texture(_ShadowTex, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat2 = u_xlat16_2 + (-u_xlat16_3);
    u_xlat2 = vec4(u_xlat15) * u_xlat2 + u_xlat16_3;
    u_xlat16_4.xyz = u_xlat0.xyz * vec3(rp_GlobalIntensity) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(rp_GlobalIntensity);
    u_xlat6.xyz = (-u_xlat16_4.xyz) + rp_FogColor.xyz;
    u_xlat6.xyz = vs_TEXCOORD4.xxx * u_xlat6.xyz + u_xlat16_4.xyz;
    u_xlat3.xyz = (-u_xlat6.xyz) + rp_HeightFogColor.xyz;
    u_xlat6.xyz = vs_TEXCOORD4.yyy * u_xlat3.xyz + u_xlat6.xyz;
    u_xlat3.xyz = (-u_xlat6.xyz) + _EmissionColor.xyz;
    u_xlat2.xyz = vec3(_Emission) * u_xlat3.xyz + u_xlat6.xyz;
    u_xlat16_4.x = u_xlat16_1.x * u_xlat2.w;
    u_xlat1.w = u_xlat16_4.x * rp_GlobalIntensity;
    SV_Target0 = u_xlat2;
    u_xlati15 = _CharacterId;
    u_xlat3.xyz = rp_CharacterAmbientLightColorArray[u_xlati15].xyz * vec3(rp_CharacterAmbientLightBrightnessArray[u_xlati15]);
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.200000003, 0.200000003, 0.200000003);
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(rp_CharacterRimBrightness, rp_CharacterRimBrightness, rp_CharacterRimBrightness)) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(rp_GlobalIntensity);
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
			Tags { "LIGHTMODE"="SekaiBaseOver" "QUEUE"="Transparent" "RenderType"="Transparent" }
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
	UNITY_UNIFORM float Xhlslcc_UnusedX_Transparency;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
	}
	Fallback "Legacy Shaders/VertexLit"
}
