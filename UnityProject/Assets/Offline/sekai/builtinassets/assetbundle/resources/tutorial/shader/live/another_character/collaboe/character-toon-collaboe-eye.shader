// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Character/Toon-CollaboE-Eye"
{
	Properties
	{
		[HideInInspector] _Color("Base Color", Color) = (1, 1, 1, 1)
		[Header(Textures)] [NoScaleOffset] DiffuseSampler_PupWH("White", 2D) = "white" {}
		[NoScaleOffset] DiffuseSampler_Pup("Iris", 2D) = "white" {}
		[NoScaleOffset] DiffuseSampler_PupHI("Highlight", 2D) = "white" {}
		[Header(Specular)] [Toggle(ENABLE_SPECULAR)] _EnableSpecularMap("Enable Specular", Float) = 0
		[NoScaleOffset] SpecularSampler_Pup("Specular", 2D) = "white" {}
		_SpecularPower("Specular Power", Float) = 10
		[Header(Properties)] _ScleraKeyColorAlpha("Eye White Ambient", Range(0, 1)) = 1
		_IrisKeyColorAlpha("Iris Ambient", Range(0, 1)) = 1
		[Header(Key Light)] _KeyLightInfluence("Key Light Influence", Range(0, 1)) = 1
		[Header(Highlights)] [Toggle(MIRROR_HIGHLIGHT)] _MirrorHighlight("Mirror Highlight", Float) = 0
		_HighlightColor("Highlight Color", Color) = (1, 1, 1, 1)
		_HighlightGlow("Highlight Glow", Float) = 1
		_HighlightUScale("Highlight Offset U Scale", Float) = 0
		_HighlightVScale("Highlight Offset V Scale", Float) = 0
		[Header(Color)] _GlowFactor("Glow Factor", Range(0, 2)) = 1
		_GlowRatio("Glow Blend", Range(0, 1)) = 0
		[HDR] _ChangeColor("Change Color", Color) = (0, 0, 0, 0)
		[Header(UV Scroll)] g_UVOffsetScale("UV Offset & Scale", Vector) = (0, 0, 1, 1)
		g_UVHighlightOffset("UV Highlight Offset", Vector) = (0, 0, 1, 1)
		g_UVRotation("UV Rotation", Vector) = (0, 0, 0, 0)
		_IrisOriginAndExtents("Iris Origin & Extents", Vector) = (0.5, 0.5, 0.25, 0.25)
		[Header(Shadows)] _MaterialId("Material ID", Float) = 1
		[Toggle] _CastOffsetShadow("Cast Offset Shadow", Float) = 1
	}
	SubShader
	{
		Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
		LOD 100
		Pass
		{
			Tags { "LIGHTMODE"="SekaiBase" "QUEUE"="Geometry" "RenderType"="Opaque" }
			GLSLPROGRAM
#pragma multi_compile _ ENABLE_SPECULAR
#pragma multi_compile _ MIRROR_HIGHLIGHT
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 rp_FogFactor;
uniform 	mediump vec4 rp_FogColor;
uniform 	vec2 rp_HeightFogFactor;
uniform 	mediump vec4 rp_HeightFogColor;
uniform 	vec4 g_UVOffsetScale;
uniform 	vec4 g_UVHighlightOffset;
uniform 	vec4 g_UVRotation;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
float u_xlat12;
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
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat12 = (-rp_FogFactor.xxxy.w) * u_xlat0.y + rp_FogFactor.xxxy.z;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat12 = (-u_xlat12) + 1.0;
    vs_TEXCOORD6.x = u_xlat12 * rp_FogColor.w;
    u_xlat12 = u_xlat0.y + (-rp_HeightFogFactor.x);
    u_xlat12 = u_xlat12 * rp_HeightFogFactor.y;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    vs_TEXCOORD6.y = u_xlat12 * rp_HeightFogColor.w;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    u_xlat1.xy = in_TEXCOORD0.xy + (-g_UVOffsetScale.xy);
    u_xlat1.zw = u_xlat1.xy + (-g_UVHighlightOffset.xy);
    u_xlat1 = u_xlat1 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat12 = g_UVRotation.x * 0.0174532924;
    u_xlat2.x = sin(u_xlat12);
    u_xlat3 = cos(u_xlat12);
    u_xlat2.xy = u_xlat1.wz * u_xlat2.xx;
    u_xlat1.z = u_xlat1.z * u_xlat3 + (-u_xlat2.x);
    u_xlat1.w = u_xlat1.w * u_xlat3 + u_xlat2.y;
    vs_TEXCOORD3 = u_xlat1 * g_UVOffsetScale.zwzw + vec4(0.5, 0.5, 0.5, 0.5);
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat0.xyz;
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
#if defined(ENABLE_SPECULAR)
uniform 	vec3 _WorldSpaceCameraPos;
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
#if defined(ENABLE_SPECULAR)
uniform 	vec4 _SpecularLightDir;
uniform 	vec4 _SpecularLightColorScale;
uniform 	vec4 _SpecularLightColorOffset;
uniform 	vec4 _SpecularLightColorPostClampScale;
#endif
uniform 	vec4 _DirectionalLightColor1;
uniform 	vec4 _PointLightPos1;
uniform 	vec4 _PointLightColor1;
uniform 	vec4 _SpotLightPos1;
uniform 	vec4 _SpotLightDir1;
uniform 	vec4 _SpotLightColor1;
uniform 	float rp_GlobalIntensity;
uniform 	mediump vec4 rp_CharacterAmbientLightColorArray[10];
uniform 	float rp_CharacterAmbientLightIntensityArray[10];
uniform 	float rp_CharacterAmbientLightBrightnessArray[10];
uniform 	mediump vec4 rp_FogColor;
uniform 	mediump vec4 rp_HeightFogColor;
uniform 	int _CharacterId;
uniform 	mediump vec4 _EmissionColor;
uniform 	float _Emission;
uniform 	float _BaseHeight;
uniform 	float _HighlightKeyColorAlpha;
uniform 	float _HighlightFade;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _AdditiveColorData;
uniform 	mediump vec4 _Color;
uniform 	float _ScleraKeyColorAlpha;
uniform 	float _IrisKeyColorAlpha;
uniform 	float _HighlightUScale;
uniform 	float _HighlightVScale;
uniform 	float _HighlightGlow;
uniform 	vec4 _HighlightColor;
uniform 	float _KeyLightInfluence;
#if defined(ENABLE_SPECULAR)
uniform 	float _SpecularPower;
uniform 	float _SpecularBrightness;
#endif
uniform 	float _GlowRatio;
uniform 	float _GlowFactor;
uniform 	vec4 _ChangeColor;
uniform 	int _RenderOutlineOnly;
uniform 	int _RenderAsSolidColor;
UNITY_LOCATION(0) uniform mediump sampler2D DiffuseSampler_Pup;
UNITY_LOCATION(1) uniform mediump sampler2D DiffuseSampler_PupWH;
#if defined(ENABLE_SPECULAR)
UNITY_LOCATION(2) uniform mediump sampler2D SpecularSampler_Pup;
UNITY_LOCATION(3) uniform mediump sampler2D DiffuseSampler_PupHI;
#else
UNITY_LOCATION(2) uniform mediump sampler2D DiffuseSampler_PupHI;
#endif
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
int u_xlati1;
bvec3 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
#if defined(ENABLE_SPECULAR)
mediump vec3 u_xlat16_6;
#endif
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
mediump float u_xlat16_18;
mediump float u_xlat16_27;
float u_xlat28;
#if defined(ENABLE_SPECULAR)
float u_xlat32;
#endif
void main()
{
    u_xlat16_0.xyz = (-vs_TEXCOORD4.xyz) + _SpotLightPos1.xyz;
    u_xlat16_27 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, _SpotLightDir1.xyz);
    u_xlat1.x = u_xlat16_0.x + (-_SpotLightDir1.w);
    u_xlat10.x = (-_SpotLightDir1.w) + 1.0;
    u_xlat10.x = float(1.0) / u_xlat10.x;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat10.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat10.x;
    u_xlat16_0.xyz = u_xlat1.xxx * _SpotLightColor1.xyz;
    u_xlat16_2.xyz = (-vs_TEXCOORD4.xyz) + _PointLightPos1.xyz;
    u_xlat16_27 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = u_xlat16_27 * _PointLightPos1.w;
    u_xlat1.x = u_xlat16_27 + 1.0;
    u_xlat10.x = (-u_xlat16_2.x) * u_xlat16_2.x + 1.0;
    u_xlat10.x = max(u_xlat10.x, 0.0);
    u_xlat16_27 = u_xlat10.x * 4.0;
    u_xlat16_27 = u_xlat10.x * u_xlat16_27;
    u_xlat1.x = u_xlat16_27 / u_xlat1.x;
    u_xlat16_2.xyz = u_xlat1.xxx * _PointLightColor1.xyz;
    u_xlat16_1.xyz = texture(DiffuseSampler_PupWH, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3 = texture(DiffuseSampler_Pup, vs_TEXCOORD3.xy);
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_3.www * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _DirectionalLightColor1.xyz + (-u_xlat16_4.xyz);
    u_xlat28 = (-_ScleraKeyColorAlpha) + _IrisKeyColorAlpha;
    u_xlat28 = u_xlat16_3.w * u_xlat28 + _ScleraKeyColorAlpha;
    u_xlat28 = u_xlat28 * _KeyLightInfluence;
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat5.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat6.xyz = _PointLightColor1.www * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat6.xyz * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _SpotLightColor1.www * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = _AdditiveColor.www * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * _AdditiveColor.xyz;
    u_xlat16_0.xyz = u_xlat1.xyz * u_xlat16_0.xyz + u_xlat16_2.xyz;
#if defined(ENABLE_SPECULAR)
    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat28) + _SpecularLightDir.xyz;
    u_xlat16_27 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyz = vec3(u_xlat16_27) * u_xlat16_2.xyz;
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_27 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat28 = log2(u_xlat16_27);
    u_xlat28 = u_xlat28 * _SpecularPower;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _SpecularBrightness;
    u_xlat16_6.xyz = texture(SpecularSampler_Pup, vs_TEXCOORD3.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_6.xyz * _SpecularLightColorScale.xyz + _SpecularLightColorOffset.xyz;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * _SpecularLightColorPostClampScale.www;
    u_xlat16_2.xyz = _SpecularLightColorPostClampScale.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(u_xlat28) + u_xlat16_0.xyz;
#endif
    u_xlat16_27 = dot(u_xlat16_0.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
#if defined(ENABLE_SPECULAR)
    u_xlat28 = dFdx(u_xlat16_3.w);
    u_xlat32 = dFdy(u_xlat16_3.w);
    u_xlat28 = abs(u_xlat28) + abs(u_xlat32);
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat28 = u_xlat28 * u_xlat16_3.w;
#else
    u_xlat1.x = dFdx(u_xlat16_3.w);
    u_xlat10.x = dFdy(u_xlat16_3.w);
    u_xlat1.x = abs(u_xlat10.x) + abs(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_3.w;
#endif
    u_xlat16_2.x = dot(u_xlat16_3.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
#if defined(ENABLE_SPECULAR)
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat16_3.xyz;
    u_xlat28 = u_xlat28 * u_xlat16_2.x;
    u_xlat28 = u_xlat28 * _GlowFactor;
    u_xlat6.xyz = vec3(u_xlat28) * _ChangeColor.xyz + vec3(u_xlat16_27);
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlowFactor, _GlowFactor, _GlowFactor));
    u_xlat3.xyz = u_xlat3.xyz * vec3(_GlowRatio) + u_xlat16_0.xyz;
    u_xlat6.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
    u_xlat3.xyz = _ChangeColor.www * u_xlat6.xyz + u_xlat3.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat28 = dot(u_xlat6.xyz, u_xlat6.xyz);
#else
    u_xlat10.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = u_xlat1.x * _GlowFactor;
    u_xlat3.xyz = u_xlat1.xxx * _ChangeColor.xyz + vec3(u_xlat16_27);
    u_xlat1.xyz = u_xlat10.xyz * vec3(vec3(_GlowFactor, _GlowFactor, _GlowFactor));
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlowRatio) + u_xlat16_0.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + u_xlat3.xyz;
    u_xlat1.xyz = _ChangeColor.www * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
#endif
    u_xlat28 = inversesqrt(u_xlat28);
#if defined(ENABLE_SPECULAR)
    u_xlat6.xyz = vec3(u_xlat28) * u_xlat6.xyz;
    u_xlat16_0.x = dot(u_xlat1.xyz, u_xlat6.xyz);
#else
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat6.xyz = vec3(u_xlat28) * vs_TEXCOORD0.xyz;
    u_xlat16_0.x = dot(u_xlat6.xyz, u_xlat3.xyz);
#endif
    u_xlat16_0.x = u_xlat16_0.x * _HighlightUScale;
#if defined(ENABLE_SPECULAR)
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat28 = dot(u_xlat6.xyz, u_xlat6.xyz);
#else
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
#endif
    u_xlat28 = inversesqrt(u_xlat28);
#if defined(ENABLE_SPECULAR)
    u_xlat6.xyz = vec3(u_xlat28) * u_xlat6.xyz;
    u_xlat16_18 = dot(u_xlat1.xyz, u_xlat6.xyz);
#else
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat16_18 = dot(u_xlat6.xyz, u_xlat3.xyz);
#endif
    u_xlat16_0.y = u_xlat16_18 * _HighlightVScale;
    u_xlat16_0.xy = u_xlat16_0.xy + vs_TEXCOORD3.zw;
#if defined(ENABLE_SPECULAR)
#if defined(MIRROR_HIGHLIGHT)
    u_xlat1.x = (-u_xlat16_0.x) + 1.0;
    u_xlat1.y = u_xlat16_0.y;
    u_xlat16_0 = texture(DiffuseSampler_PupHI, u_xlat1.xy);
#else
    u_xlat16_0 = texture(DiffuseSampler_PupHI, u_xlat16_0.xy);
#endif
    u_xlat1.xyz = u_xlat16_0.xyz * _DirectionalLightColor1.xyz + (-u_xlat16_0.xyz);
#else
#if defined(MIRROR_HIGHLIGHT)
    u_xlat3.x = (-u_xlat16_0.x) + 1.0;
    u_xlat3.y = u_xlat16_0.y;
    u_xlat16_0 = texture(DiffuseSampler_PupHI, u_xlat3.xy);
#else
    u_xlat16_0 = texture(DiffuseSampler_PupHI, u_xlat16_0.xy);
#endif
    u_xlat3.xyz = u_xlat16_0.xyz * _DirectionalLightColor1.xyz + (-u_xlat16_0.xyz);
#endif
    u_xlat28 = _HighlightKeyColorAlpha * _KeyLightInfluence;
#if defined(ENABLE_SPECULAR)
    u_xlat16_0.xyz = vec3(u_xlat28) * u_xlat1.xyz + u_xlat16_0.xyz;
#else
    u_xlat16_0.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat16_0.xyz;
#endif
    u_xlat0 = u_xlat16_0 * _HighlightColor;
#if defined(ENABLE_SPECULAR)
    u_xlat1.xyz = _DirectionalLightColor1.xyz * u_xlat0.xyz + (-u_xlat3.xyz);
#else
    u_xlat3.xyz = _DirectionalLightColor1.xyz * u_xlat0.xyz + (-u_xlat1.xyz);
#endif
    u_xlat28 = (-u_xlat0.w) * _HighlightFade + u_xlat0.w;
#if defined(ENABLE_SPECULAR)
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat28) + u_xlat3.xyz;
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz + u_xlat3.xyz;
#else
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat28) + u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
#endif
    u_xlat3.xyz = (-u_xlat1.xyz) + u_xlat16_2.xyz;
    u_xlat1.xyz = vec3(vec3(_HighlightGlow, _HighlightGlow, _HighlightGlow)) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = vs_TEXCOORD4.y + (-_BaseHeight);
    u_xlat28 = u_xlat28 + (-_AdditiveColorData.z);
    u_xlat28 = u_xlat28 * _AdditiveColorData.w + 0.5;
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat1.xyz;
    u_xlat16_2.xyz = (_RenderOutlineOnly != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat1.xyz;
    u_xlat16_2.xyz = (int(_RenderAsSolidColor) != 0) ? _Color.xyz : u_xlat16_2.xyz;
    u_xlatb1.xyz = greaterThanEqual(u_xlat16_2.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_4.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_4.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_7.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    u_xlati1 = _CharacterId;
    u_xlat16_8.xyz = vec3(1.0, 1.0, 1.0) + (-rp_CharacterAmbientLightColorArray[u_xlati1].xyz);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) * rp_CharacterAmbientLightColorArray[u_xlati1].xyz + u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * rp_CharacterAmbientLightColorArray[u_xlati1].xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat10.xyz = u_xlat16_2.xyz * vec3(rp_CharacterAmbientLightIntensityArray[u_xlati1]);
    u_xlat3.xyz = rp_CharacterAmbientLightColorArray[u_xlati1].xyz * vec3(rp_CharacterAmbientLightBrightnessArray[u_xlati1]);
    u_xlat0.xyz = u_xlat3.xyz * vec3(rp_GlobalIntensity);
    u_xlat3.xyz = u_xlat10.xyz * vec3(rp_GlobalIntensity);
    u_xlat1.xyz = (-u_xlat10.xyz) * vec3(rp_GlobalIntensity) + rp_FogColor.xyz;
    u_xlat1.xyz = vs_TEXCOORD6.xxx * u_xlat1.xyz + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + rp_HeightFogColor.xyz;
    u_xlat1.xyz = vs_TEXCOORD6.yyy * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _EmissionColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * u_xlat3.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    u_xlat0.w = rp_GlobalIntensity;
    u_xlat0 = u_xlat0 * vec4(0.200000003, 0.200000003, 0.200000003, 1.0);
    u_xlat1.xyz = _EmissionColor.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + (-u_xlat0.xyz);
    u_xlat0.xyz = vec3(_Emission) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target1 = u_xlat0;
    return;
}
#endif
			ENDGLSL
		}
	}
	Fallback "Legacy Shaders/VertexLit"
}
