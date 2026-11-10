// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Brightness/FixedPenlight"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		_LightMask("Light Mask", 2D) = "black" {}
		_Intensity("Intensity", Range(0, 2)) = 0.1
		_BloomSat("BloomSatMultiplier", Range(0, 5)) = 1
		_ViewThreshold("View Threshold", Range(0, 1)) = 1
		_PatternTex("Pattern Texture", 2D) = "white" {}
		[HideInInspector] _Bounds("Bounds", Vector) = (0, 0, 1, 1)
		[HideInInspector] _PatternAnimation("Pattern Animation", Range(0, 1)) = 0
		[HideInInspector] _PatternThreshold("Pattern Threshold", Range(0, 1)) = 0
		[HideInInspector] _PatternFade("Pattern Fade", Range(0, 1)) = 0
		[HideInInspector] _PatternFadePreset("Pattern Fade Preset", Float) = 0
		[HideInInspector] _PatternAnimationOffset("Pattern Animation Offset", Vector) = (0, 0, 0, 0)
		[HideInInspector] _PatternColorOffset("Pattern Color Offset", Vector) = (0, 0, 0, 0)
		[HideInInspector] _PatternAnimationUVRotation("Pattern Animation UV Rotation", Range(0, 360)) = 0
		[HideInInspector] _PatternColorUVRotation("Pattern Color UV Rotation", Range(0, 360)) = 0
		[HideInInspector] _PolarPatternColor("Polar Pattern Color", Float) = 0
		[HideInInspector] _PolarPatternAnimation("Polar Pattern Animation", Float) = 0
		[HideInInspector] _UsePatternMask("Use Pattern Mask", Float) = 0
		[HideInInspector] _PatternMaskThreshold("Pattern Mask Threshold", Range(0, 1)) = 0
	}
	SubShader
	{
		Tags { "QUEUE"="Geometry+1" "RenderType"="Opaque" }
		Pass
		{
			Tags { "QUEUE"="Geometry+1" "RenderType"="Opaque" }
			GLSLPROGRAM
#pragma multi_compile _ _USE_PATTERN_TEXTURE
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
uniform 	vec4 _ColorArray[128];
uniform 	vec4 hlslcc_mtx4x4_AnimationKey[32];
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
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_LightMask_ST;
	UNITY_UNIFORM float                _Intensity;
	UNITY_UNIFORM float                _BloomSat;
	UNITY_UNIFORM float                _ViewThreshold;
	UNITY_UNIFORM float                _ConsolidationRateY;
#if defined(_USE_PATTERN_TEXTURE)
	UNITY_UNIFORM vec4                _Bounds;
	UNITY_UNIFORM float                _PatternAnimation;
	UNITY_UNIFORM float                _PatternThreshold;
	UNITY_UNIFORM float                _PatternFade;
	UNITY_UNIFORM int                _PatternFadePreset;
	UNITY_UNIFORM vec2                _PatternAnimationOffset;
	UNITY_UNIFORM vec2                _PatternColorOffset;
	UNITY_UNIFORM float                _PatternAnimationUVRotation;
	UNITY_UNIFORM float                _PatternColorUVRotation;
	UNITY_UNIFORM int                _UsePatternMask;
	UNITY_UNIFORM float                _PatternMaskThreshold;
	UNITY_UNIFORM int                _PolarPatternColor;
	UNITY_UNIFORM int                _PolarPatternAnimation;
#else
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Bounds;
	UNITY_UNIFORM float Xhlslcc_UnusedX_PatternAnimation;
	UNITY_UNIFORM float Xhlslcc_UnusedX_PatternThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_PatternFade;
	UNITY_UNIFORM int Xhlslcc_UnusedX_PatternFadePreset;
	UNITY_UNIFORM vec2 Xhlslcc_UnusedX_PatternAnimationOffset;
	UNITY_UNIFORM vec2 Xhlslcc_UnusedX_PatternColorOffset;
	UNITY_UNIFORM float Xhlslcc_UnusedX_PatternAnimationUVRotation;
	UNITY_UNIFORM float Xhlslcc_UnusedX_PatternColorUVRotation;
	UNITY_UNIFORM int Xhlslcc_UnusedX_UsePatternMask;
	UNITY_UNIFORM float Xhlslcc_UnusedX_PatternMaskThreshold;
	UNITY_UNIFORM int Xhlslcc_UnusedX_PolarPatternColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_PolarPatternAnimation;
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if defined(_USE_PATTERN_TEXTURE)
UNITY_LOCATION(2) uniform mediump sampler2D _PatternTex;
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD3;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
#if !defined(_USE_PATTERN_TEXTURE)
mediump vec3 u_xlat16_0;
#endif
vec4 u_xlat1;
#if defined(_USE_PATTERN_TEXTURE)
bvec4 u_xlatb1;
#else
int u_xlati1;
uvec2 u_xlatu1;
bool u_xlatb1;
#endif
vec4 u_xlat2;
#if defined(_USE_PATTERN_TEXTURE)
mediump vec3 u_xlat16_2;
#else
bool u_xlatb2;
#endif
vec3 u_xlat3;
#if defined(_USE_PATTERN_TEXTURE)
uvec2 u_xlatu3;
bool u_xlatb3;
vec2 u_xlat4;
#else
vec4 u_xlat4;
#endif
vec3 u_xlat5;
#if defined(_USE_PATTERN_TEXTURE)
vec3 u_xlat6;
#else
vec2 u_xlat6;
#endif
vec3 u_xlat7;
#if defined(_USE_PATTERN_TEXTURE)
float u_xlat9;
bool u_xlatb9;
float u_xlat11;
bool u_xlatb13;
vec2 u_xlat17;
int u_xlati17;
bool u_xlatb17;
vec2 u_xlat19;
bool u_xlatb19;
vec2 u_xlat20;
bool u_xlatb20;
float u_xlat24;
int u_xlati24;
uint u_xlatu24;
bool u_xlatb24;
float u_xlat25;
int u_xlati25;
bool u_xlatb25;
float u_xlat27;
bool u_xlatb27;
#else
mediump float u_xlat16_8;
vec3 u_xlat9;
float u_xlat10;
bool u_xlatb10;
bool u_xlatb11;
float u_xlat18;
float u_xlat19;
float u_xlat26;
bool u_xlatb26;
#endif
void main()
{
#if defined(_USE_PATTERN_TEXTURE)
    u_xlat0.xyz = in_POSITION0.xyz + (-in_NORMAL0.xyz);
    u_xlat1.yzw = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat16_2.xyz = in_COLOR0.wxz * vec3(128.0, 6.28299999, 128.0);
    u_xlatu3.xy = uvec2(u_xlat16_2.xz);
    u_xlatu3.xy = min(u_xlatu3.xy, uvec2(127u, 127u));
    u_xlat16_2.x = 255.0 * _ColorArray[int(u_xlatu3.x)].w;
    u_xlatu24 = uint(u_xlat16_2.x);
    u_xlati24 = int(int(u_xlatu24) << (2 & int(0x1F)));
    u_xlat1.x = u_xlat1.z + hlslcc_mtx4x4_AnimationKey[(u_xlati24 + 1)].z;
    u_xlat16_2.x = in_COLOR0.x + -0.5;
    u_xlat17.x = u_xlat16_2.x * hlslcc_mtx4x4_AnimationKey[(u_xlati24 + 2)].w + hlslcc_mtx4x4_AnimationKey[(u_xlati24 + 2)].x;
    u_xlat17.x = sin(u_xlat17.x);
    u_xlat3.x = sin(u_xlat17.x);
    u_xlat4.x = cos(u_xlat17.x);
    u_xlat5.x = sin((-u_xlat17.x));
    u_xlat5.y = u_xlat4.x;
    u_xlat4.y = dot(u_xlat5.yx, u_xlat1.xw);
#else
    u_xlat16_0.xyz = in_COLOR0.wxz * vec3(128.0, 6.28299999, 128.0);
    u_xlatu1.xy = uvec2(u_xlat16_0.xz);
    u_xlat16_0.x = sin(u_xlat16_0.y);
    u_xlatu1.xy = min(u_xlatu1.xy, uvec2(127u, 127u));
    u_xlat16_8 = 255.0 * _ColorArray[int(u_xlatu1.x)].w;
    vs_TEXCOORD2 = _ColorArray[int(u_xlatu1.y)];
    u_xlatu1.x = uint(u_xlat16_8);
    u_xlati1 = int(int(u_xlatu1.x) << (2 & int(0x1F)));
    u_xlat9.xyz = in_POSITION0.xyz + (-in_NORMAL0.xyz);
    u_xlat2.x = (-u_xlat9.x) + (-hlslcc_mtx4x4_AnimationKey[(u_xlati1 + 2)].z);
    u_xlat10 = (-u_xlat9.z) + (-hlslcc_mtx4x4_AnimationKey[(u_xlati1 + 3)].z);
    u_xlat18 = max(abs(u_xlat10), abs(u_xlat2.x));
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat26 = min(abs(u_xlat10), abs(u_xlat2.x));
    u_xlat18 = u_xlat18 * u_xlat26;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat3.x = u_xlat26 * 0.0208350997 + -0.0851330012;
    u_xlat3.x = u_xlat26 * u_xlat3.x + 0.180141002;
    u_xlat3.x = u_xlat26 * u_xlat3.x + -0.330299497;
    u_xlat26 = u_xlat26 * u_xlat3.x + 0.999866009;
    u_xlat3.x = u_xlat26 * u_xlat18;
    u_xlat3.x = u_xlat3.x * -2.0 + 1.57079637;
    u_xlatb11 = abs(u_xlat10)<abs(u_xlat2.x);
    u_xlat3.x = u_xlatb11 ? u_xlat3.x : float(0.0);
    u_xlat18 = u_xlat18 * u_xlat26 + u_xlat3.x;
    u_xlatb26 = u_xlat10<(-u_xlat10);
    u_xlat26 = u_xlatb26 ? -3.14159274 : float(0.0);
    u_xlat18 = u_xlat26 + u_xlat18;
    u_xlat26 = min(u_xlat10, u_xlat2.x);
    u_xlat2.x = max(u_xlat10, u_xlat2.x);
    u_xlatb2 = u_xlat2.x>=(-u_xlat2.x);
    u_xlatb10 = u_xlat26<(-u_xlat26);
    u_xlatb2 = u_xlatb2 && u_xlatb10;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat18) : u_xlat18;
    u_xlatb10 = u_xlat2.x<0.0;
    u_xlat18 = u_xlat2.x + 6.28299999;
    u_xlat2.x = (u_xlatb10) ? u_xlat18 : u_xlat2.x;
    u_xlat16_8 = in_COLOR0.x + -0.5;
    u_xlat10 = u_xlat16_8 * hlslcc_mtx4x4_AnimationKey[(u_xlati1 + 3)].y + hlslcc_mtx4x4_AnimationKey[u_xlati1].y;
    u_xlat2.x = u_xlat10 * 6.28299999 + u_xlat2.x;
    u_xlat3.x = sin(u_xlat2.x);
    u_xlat4.x = cos(u_xlat2.x);
    u_xlat2.x = sin((-u_xlat2.x));
    u_xlat2.z = u_xlat3.x;
    u_xlat2.y = u_xlat4.x;
    u_xlat26 = u_xlat16_8 * hlslcc_mtx4x4_AnimationKey[(u_xlati1 + 2)].w + hlslcc_mtx4x4_AnimationKey[(u_xlati1 + 2)].x;
    u_xlat26 = sin(u_xlat26);
    u_xlat3.x = sin((-u_xlat26));
    u_xlat4.x = sin(u_xlat26);
    u_xlat5.x = cos(u_xlat26);
    u_xlat3.y = u_xlat5.x;
    u_xlat3.z = u_xlat4.x;
    u_xlat4.yzw = (-u_xlat9.xyz) + in_POSITION0.xyz;
    u_xlat4.x = u_xlat4.z + hlslcc_mtx4x4_AnimationKey[(u_xlati1 + 1)].z;
    u_xlat5.y = dot(u_xlat3.yx, u_xlat4.xw);
    u_xlat3.y = dot(u_xlat3.zy, u_xlat4.xw);
    u_xlat5.x = u_xlat4.y;
    u_xlat26 = u_xlat16_8 * hlslcc_mtx4x4_AnimationKey[(u_xlati1 + 3)].w + hlslcc_mtx4x4_AnimationKey[(u_xlati1 + 3)].x;
    u_xlat26 = sin(u_xlat26);
    u_xlat4.x = sin(u_xlat26);
    u_xlat6.x = cos(u_xlat26);
    u_xlat7.x = sin((-u_xlat26));
    u_xlat7.z = u_xlat4.x;
    u_xlat7.y = u_xlat6.x;
    u_xlat26 = dot(u_xlat7.zy, u_xlat5.xy);
    u_xlat4.x = dot(u_xlat7.yx, u_xlat5.xy);
    u_xlat19 = hlslcc_mtx4x4_AnimationKey[u_xlati1].z + (-hlslcc_mtx4x4_AnimationKey[(u_xlati1 + 1)].z);
    u_xlat3.x = u_xlat26 + u_xlat19;
    u_xlat26 = u_xlat16_8 * hlslcc_mtx4x4_AnimationKey[u_xlati1].w + hlslcc_mtx4x4_AnimationKey[u_xlati1].x;
    u_xlat19 = u_xlat16_8 * hlslcc_mtx4x4_AnimationKey[(u_xlati1 + 1)].w + hlslcc_mtx4x4_AnimationKey[(u_xlati1 + 1)].x;
    u_xlat19 = sin(u_xlat19);
    u_xlat26 = sin(u_xlat26);
    u_xlat5.x = sin((-u_xlat26));
    u_xlat6.x = sin(u_xlat26);
    u_xlat7.x = cos(u_xlat26);
    u_xlat5.y = u_xlat7.x;
    u_xlat5.z = u_xlat6.x;
    u_xlat6.y = dot(u_xlat5.zy, u_xlat3.xy);
    u_xlat4.y = dot(u_xlat5.yx, u_xlat3.xy);
    u_xlat5.x = sin((-u_xlat19));
    u_xlat3.x = sin(u_xlat19);
    u_xlat7.x = cos(u_xlat19);
    u_xlat5.y = u_xlat7.x;
#endif
    u_xlat5.z = u_xlat3.x;
#if defined(_USE_PATTERN_TEXTURE)
    u_xlat5.y = dot(u_xlat5.zy, u_xlat1.xw);
    u_xlat1.x = u_xlat16_2.x * hlslcc_mtx4x4_AnimationKey[(u_xlati24 + 3)].w + hlslcc_mtx4x4_AnimationKey[(u_xlati24 + 3)].x;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat3.x = sin(u_xlat1.x);
    u_xlat6.x = cos(u_xlat1.x);
    u_xlat7.x = sin((-u_xlat1.x));
    u_xlat7.y = u_xlat6.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat1.x = dot(u_xlat7.yx, u_xlat4.xy);
    u_xlat7.z = u_xlat3.x;
    u_xlat17.x = dot(u_xlat7.zy, u_xlat4.xy);
    u_xlat25 = hlslcc_mtx4x4_AnimationKey[u_xlati24].z + (-hlslcc_mtx4x4_AnimationKey[(u_xlati24 + 1)].z);
    u_xlat5.x = u_xlat25 + u_xlat17.x;
    u_xlat17.x = u_xlat16_2.x * hlslcc_mtx4x4_AnimationKey[u_xlati24].w + hlslcc_mtx4x4_AnimationKey[u_xlati24].x;
    u_xlat17.x = sin(u_xlat17.x);
    u_xlat3.x = sin(u_xlat17.x);
    u_xlat4.x = cos(u_xlat17.x);
    u_xlat6.x = sin((-u_xlat17.x));
    u_xlat6.y = u_xlat4.x;
    u_xlat1.y = dot(u_xlat6.yx, u_xlat5.xy);
    u_xlat6.z = u_xlat3.x;
    u_xlat4.y = dot(u_xlat6.zy, u_xlat5.xy);
    u_xlat17.x = u_xlat16_2.x * hlslcc_mtx4x4_AnimationKey[(u_xlati24 + 1)].w + hlslcc_mtx4x4_AnimationKey[(u_xlati24 + 1)].x;
    u_xlat17.x = sin(u_xlat17.x);
    u_xlat3.x = sin(u_xlat17.x);
    u_xlat5.x = cos(u_xlat17.x);
    u_xlat6.x = sin((-u_xlat17.x));
    u_xlat6.y = u_xlat5.x;
    u_xlat4.x = dot(u_xlat6.yx, u_xlat1.xy);
    u_xlat6.z = u_xlat3.x;
    u_xlat1.x = dot(u_xlat6.zy, u_xlat1.xy);
    u_xlat9 = (-u_xlat0.x) + (-hlslcc_mtx4x4_AnimationKey[(u_xlati24 + 2)].z);
    u_xlat17.x = (-u_xlat0.z) + (-hlslcc_mtx4x4_AnimationKey[(u_xlati24 + 3)].z);
    u_xlat25 = min(abs(u_xlat17.x), abs(u_xlat9));
    u_xlat3.x = max(abs(u_xlat17.x), abs(u_xlat9));
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat25 = u_xlat25 * u_xlat3.x;
    u_xlat3.x = u_xlat25 * u_xlat25;
    u_xlat19.x = u_xlat3.x * 0.0208350997 + -0.0851330012;
    u_xlat19.x = u_xlat3.x * u_xlat19.x + 0.180141002;
    u_xlat19.x = u_xlat3.x * u_xlat19.x + -0.330299497;
    u_xlat3.x = u_xlat3.x * u_xlat19.x + 0.999866009;
    u_xlat19.x = u_xlat25 * u_xlat3.x;
    u_xlatb27 = abs(u_xlat17.x)<abs(u_xlat9);
    u_xlat19.x = u_xlat19.x * -2.0 + 1.57079637;
    u_xlat19.x = u_xlatb27 ? u_xlat19.x : float(0.0);
    u_xlat25 = u_xlat25 * u_xlat3.x + u_xlat19.x;
    u_xlatb3 = u_xlat17.x<(-u_xlat17.x);
    u_xlat3.x = u_xlatb3 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat3.x;
    u_xlat3.x = min(u_xlat17.x, u_xlat9);
    u_xlat9 = max(u_xlat17.x, u_xlat9);
    u_xlatb17 = u_xlat3.x<(-u_xlat3.x);
    u_xlatb9 = u_xlat9>=(-u_xlat9);
    u_xlatb9 = u_xlatb9 && u_xlatb17;
    u_xlat9 = (u_xlatb9) ? (-u_xlat25) : u_xlat25;
    u_xlatb17 = u_xlat9<0.0;
    u_xlat25 = u_xlat9 + 6.28299999;
    u_xlat9 = (u_xlatb17) ? u_xlat25 : u_xlat9;
    u_xlat17.x = u_xlat16_2.x * hlslcc_mtx4x4_AnimationKey[(u_xlati24 + 3)].y + hlslcc_mtx4x4_AnimationKey[u_xlati24].y;
    u_xlat9 = u_xlat17.x * 6.28299999 + u_xlat9;
    u_xlat3.x = sin(u_xlat9);
    u_xlat5.x = cos(u_xlat9);
    u_xlat6.x = sin((-u_xlat9));
    u_xlat6.y = u_xlat5.x;
    u_xlat6.z = u_xlat3.x;
    u_xlat5.x = dot(u_xlat6.yz, u_xlat4.xy);
    u_xlat5.z = dot(u_xlat6.xy, u_xlat4.xy);
    u_xlat5.y = u_xlat1.x + (-hlslcc_mtx4x4_AnimationKey[u_xlati24].z);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat9 = u_xlat1.x + (-hlslcc_mtx4x4_AnimationKey[(u_xlati24 + 2)].y);
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat24 = u_xlat1.y + hlslcc_mtx4x4_AnimationKey[(u_xlati24 + 1)].y;
    u_xlat16_2.x = sin(u_xlat16_2.y);
    u_xlat1.w = u_xlat16_2.x * _ConsolidationRateY + u_xlat24;
    u_xlatb24 = 0.0>=in_COLOR0.y;
    u_xlatb9 = _ViewThreshold>=in_COLOR0.y;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb24) ? 0.0 : u_xlat9;
    u_xlat9 = (-u_xlat24) + 1.0;
    u_xlat1.xzw = vec3(u_xlat24) * u_xlat1.xwz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + u_xlat1.xzw;
    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * u_xlat0.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat24 = max(_Bounds.w, _Bounds.z);
    u_xlat24 = max(u_xlat24, 1.0);
    u_xlat24 = float(1.0) / u_xlat24;
    u_xlat17.x = (-_Bounds.w) + _Bounds.z;
    u_xlat17.x = abs(u_xlat17.x) * 0.5;
    u_xlatb25 = _Bounds.z>=_Bounds.w;
    u_xlat3.x = u_xlatb25 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat1.xy + (-_Bounds.xy);
    u_xlat1.xy = _Bounds.zw * vec2(0.5, 0.5) + u_xlat1.xy;
    u_xlat16_2.x = (u_xlatb25) ? 0.0 : 1.0;
    u_xlat1.x = u_xlat17.x * u_xlat16_2.x + u_xlat1.x;
    u_xlat4.x = u_xlat24 * u_xlat1.x;
    u_xlat1.x = u_xlat17.x * u_xlat3.x + u_xlat1.y;
    u_xlat4.y = u_xlat24 * u_xlat1.x;
    u_xlat1 = vec4(ivec4(_PolarPatternAnimation, _PolarPatternColor, _PolarPatternAnimation, _PolarPatternColor));
    u_xlatb1 = equal(u_xlat1, vec4(0.0, 0.0, 1.0, 1.0));
    u_xlat3.xz = u_xlat4.xy + vec2(-0.5, -0.5);
    u_xlat5.x = sin(_PatternAnimationUVRotation);
    u_xlat6.x = cos(_PatternAnimationUVRotation);
    u_xlat2.xz = sin((-vec2(_PatternAnimationUVRotation, _PatternColorUVRotation)));
    u_xlat2.y = u_xlat6.x;
    u_xlat2.w = u_xlat5.x;
    u_xlat5.x = dot(u_xlat2.yw, u_xlat3.xz);
    u_xlat5.y = dot(u_xlat2.xy, u_xlat3.xz);
    u_xlat20.xy = u_xlat5.xy + vec2(0.5, 0.5);
    u_xlat20.xy = (u_xlatb1.x) ? u_xlat20.xy : u_xlat4.xy;
    u_xlat1.x = sin(_PatternColorUVRotation);
    u_xlat2.x = cos(_PatternColorUVRotation);
    u_xlat2.y = u_xlat1.x;
    u_xlat5.x = dot(u_xlat2.xy, u_xlat3.xz);
    u_xlat5.y = dot(u_xlat2.zx, u_xlat3.xz);
    u_xlat3.xz = u_xlat5.xy + vec2(0.5, 0.5);
    u_xlat1.xy = (u_xlatb1.y) ? u_xlat3.xz : u_xlat4.xy;
    u_xlat3.xz = u_xlat20.xy + vec2(-0.5, -0.5);
    u_xlat24 = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat4.x = u_xlat24 + u_xlat24;
    u_xlat24 = min(abs(u_xlat3.z), abs(u_xlat3.x));
    u_xlat27 = max(abs(u_xlat3.z), abs(u_xlat3.x));
    u_xlat27 = float(1.0) / u_xlat27;
    u_xlat24 = u_xlat24 * u_xlat27;
    u_xlat27 = u_xlat24 * u_xlat24;
    u_xlat5.x = u_xlat27 * 0.0208350997 + -0.0851330012;
    u_xlat5.x = u_xlat27 * u_xlat5.x + 0.180141002;
    u_xlat5.x = u_xlat27 * u_xlat5.x + -0.330299497;
    u_xlat27 = u_xlat27 * u_xlat5.x + 0.999866009;
    u_xlat5.x = u_xlat24 * u_xlat27;
    u_xlatb13 = abs(u_xlat3.z)<abs(u_xlat3.x);
    u_xlat5.x = u_xlat5.x * -2.0 + 1.57079637;
    u_xlat5.x = u_xlatb13 ? u_xlat5.x : float(0.0);
    u_xlat24 = u_xlat24 * u_xlat27 + u_xlat5.x;
    u_xlatb27 = u_xlat3.z<(-u_xlat3.z);
    u_xlat27 = u_xlatb27 ? -3.14159274 : float(0.0);
    u_xlat24 = u_xlat24 + u_xlat27;
    u_xlat27 = min(u_xlat3.z, u_xlat3.x);
    u_xlat3.x = max(u_xlat3.z, u_xlat3.x);
    u_xlatb19 = u_xlat27<(-u_xlat27);
    u_xlatb3 = u_xlat3.x>=(-u_xlat3.x);
    u_xlatb3 = u_xlatb3 && u_xlatb19;
    u_xlat24 = (u_xlatb3) ? (-u_xlat24) : u_xlat24;
    u_xlat4.y = u_xlat24 * 0.159235656;
    u_xlat3.xz = (u_xlatb1.z) ? u_xlat4.xy : u_xlat20.xy;
    u_xlat4.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat24 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat5.x = u_xlat24 + u_xlat24;
    u_xlat24 = min(abs(u_xlat4.y), abs(u_xlat4.x));
    u_xlat17.x = max(abs(u_xlat4.y), abs(u_xlat4.x));
    u_xlat17.x = float(1.0) / u_xlat17.x;
    u_xlat24 = u_xlat24 * u_xlat17.x;
    u_xlat17.x = u_xlat24 * u_xlat24;
    u_xlat27 = u_xlat17.x * 0.0208350997 + -0.0851330012;
    u_xlat27 = u_xlat17.x * u_xlat27 + 0.180141002;
    u_xlat27 = u_xlat17.x * u_xlat27 + -0.330299497;
    u_xlat17.x = u_xlat17.x * u_xlat27 + 0.999866009;
    u_xlat27 = u_xlat24 * u_xlat17.x;
    u_xlatb20 = abs(u_xlat4.y)<abs(u_xlat4.x);
    u_xlat27 = u_xlat27 * -2.0 + 1.57079637;
    u_xlat27 = u_xlatb20 ? u_xlat27 : float(0.0);
    u_xlat24 = u_xlat24 * u_xlat17.x + u_xlat27;
    u_xlatb17 = u_xlat4.y<(-u_xlat4.y);
    u_xlat17.x = u_xlatb17 ? -3.14159274 : float(0.0);
    u_xlat24 = u_xlat24 + u_xlat17.x;
    u_xlat17.x = min(u_xlat4.y, u_xlat4.x);
    u_xlat27 = max(u_xlat4.y, u_xlat4.x);
    u_xlatb17 = u_xlat17.x<(-u_xlat17.x);
    u_xlatb27 = u_xlat27>=(-u_xlat27);
    u_xlatb17 = u_xlatb17 && u_xlatb27;
    u_xlat24 = (u_xlatb17) ? (-u_xlat24) : u_xlat24;
    u_xlat5.y = u_xlat24 * 0.159235656;
    u_xlat1.xy = (u_xlatb1.w) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat17.xy = u_xlat3.xz + (-_PatternAnimationOffset.xy);
    u_xlat1.xy = u_xlat1.xy + (-vec2(_PatternColorOffset.x, _PatternColorOffset.y));
    if(_PatternFadePreset == 0) {
        u_xlat24 = textureLod(_PatternTex, u_xlat17.xy, 0.0).w;
    } else {
        u_xlatb3 = _PatternFadePreset==1;
        u_xlat19.xy = u_xlat17.xy + vec2(-0.5, -0.5);
        u_xlat25 = dot(u_xlat19.xy, u_xlat19.xy);
        u_xlat25 = sqrt(u_xlat25);
        u_xlat25 = u_xlat25 + -1.0;
        u_xlat24 = (u_xlatb3) ? u_xlat25 : u_xlat17.x;
    }
    u_xlat17.x = u_xlat24 + (-_PatternMaskThreshold);
    u_xlat25 = float(_UsePatternMask);
    u_xlat17.x = (-u_xlat25) + u_xlat17.x;
    u_xlat17.x = u_xlat17.x + 1.0;
    u_xlati25 = int((0.0<u_xlat17.x) ? 0xFFFFFFFFu : uint(0));
    u_xlati17 = int((u_xlat17.x<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati17 = (-u_xlati25) + u_xlati17;
    u_xlati17 = max(u_xlati17, 0);
    u_xlat24 = u_xlat24 + (-_PatternAnimation);
    u_xlat24 = fract(u_xlat24);
    if(_PatternFadePreset == 0) {
        u_xlat25 = (-_PatternThreshold) * 0.5 + 0.5;
        u_xlat3.x = (-_PatternFade) * u_xlat25 + u_xlat24;
        u_xlat19.x = u_xlat24 + (-u_xlat3.x);
        u_xlat3.x = _PatternThreshold * 0.5 + (-u_xlat3.x);
        u_xlat19.x = float(1.0) / u_xlat19.x;
        u_xlat3.x = u_xlat19.x * u_xlat3.x;
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
        u_xlat19.x = u_xlat3.x * -2.0 + 3.0;
        u_xlat3.x = u_xlat3.x * u_xlat3.x;
        u_xlat27 = (-u_xlat24) + 1.0;
        u_xlat25 = (-_PatternFade) * u_xlat25 + u_xlat27;
        u_xlat27 = (-u_xlat25) + u_xlat27;
        u_xlat25 = _PatternThreshold * 0.5 + (-u_xlat25);
        u_xlat27 = float(1.0) / u_xlat27;
        u_xlat25 = u_xlat25 * u_xlat27;
        u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
        u_xlat27 = u_xlat25 * -2.0 + 3.0;
        u_xlat25 = u_xlat25 * u_xlat25;
        u_xlat25 = u_xlat25 * u_xlat27;
        u_xlat25 = u_xlat19.x * u_xlat3.x + u_xlat25;
    } else {
        u_xlat24 = (-u_xlat24) + _PatternThreshold;
        u_xlat3.x = float(1.0) / _PatternFade;
        u_xlat24 = u_xlat24 * u_xlat3.x;
        u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
        u_xlat3.x = u_xlat24 * -2.0 + 3.0;
        u_xlat24 = u_xlat24 * u_xlat24;
        u_xlat25 = u_xlat24 * u_xlat3.x;
    }
    u_xlat24 = float(u_xlati17);
    u_xlat24 = u_xlat24 * u_xlat25;
    u_xlat1.xyz = textureLod(_PatternTex, u_xlat1.xy, 0.0).xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat1.w = u_xlat24 * _ColorArray[int(u_xlatu3.y)].w;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
#else
    u_xlat26 = dot(u_xlat5.zy, u_xlat4.xy);
    u_xlat6.x = dot(u_xlat5.yx, u_xlat4.xy);
    u_xlat3.y = u_xlat26 + (-hlslcc_mtx4x4_AnimationKey[u_xlati1].z);
    u_xlat3.x = dot(u_xlat2.yz, u_xlat6.xy);
    u_xlat3.z = dot(u_xlat2.xy, u_xlat6.xy);
    u_xlat2.xyz = (-u_xlat9.xyz) + u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat10 = u_xlat2.x + (-hlslcc_mtx4x4_AnimationKey[(u_xlati1 + 2)].y);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat10;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat10 = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat10;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat1.x = u_xlat2.y + hlslcc_mtx4x4_AnimationKey[(u_xlati1 + 1)].y;
    u_xlat2.w = u_xlat16_0.x * _ConsolidationRateY + u_xlat1.x;
    u_xlatb1 = _ViewThreshold>=in_COLOR0.y;
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlatb10 = 0.0>=in_COLOR0.y;
    u_xlat1.x = (u_xlatb10) ? 0.0 : u_xlat1.x;
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xwz;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.xyz = u_xlat9.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
#endif
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
#if defined(_USE_PATTERN_TEXTURE)
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.x = u_xlat0.z + _ProjectionParams.y;
    u_xlat11 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat3.x = u_xlat3.x / u_xlat11;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = (-_SekaiFogFactor.y) * u_xlat3.x + _SekaiFogFactor.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#else
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#endif
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat0;
#if defined(_USE_PATTERN_TEXTURE)
    vs_TEXCOORD2 = u_xlat1;
    vs_TEXCOORD3 = u_xlat3.x;
#endif
    vs_TEXCOORD4 = u_xlat0.z;
#if !defined(_USE_PATTERN_TEXTURE)
    u_xlat1.x = u_xlat0.z + _ProjectionParams.y;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.x = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat1.x = u_xlat1.x / u_xlat9.x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = (-_SekaiFogFactor.y) * u_xlat1.x + _SekaiFogFactor.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    vs_TEXCOORD3 = u_xlat1.x;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _CoCParams;
uniform 	vec4 _SekaiFogColor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_LightMask_ST;
	UNITY_UNIFORM float                _Intensity;
	UNITY_UNIFORM float                _BloomSat;
	UNITY_UNIFORM float                _ViewThreshold;
	UNITY_UNIFORM float                _ConsolidationRateY;
#if defined(_USE_PATTERN_TEXTURE)
	UNITY_UNIFORM vec4                _Bounds;
	UNITY_UNIFORM float                _PatternAnimation;
	UNITY_UNIFORM float                _PatternThreshold;
	UNITY_UNIFORM float                _PatternFade;
	UNITY_UNIFORM int                _PatternFadePreset;
	UNITY_UNIFORM vec2                _PatternAnimationOffset;
	UNITY_UNIFORM vec2                _PatternColorOffset;
	UNITY_UNIFORM float                _PatternAnimationUVRotation;
	UNITY_UNIFORM float                _PatternColorUVRotation;
	UNITY_UNIFORM int                _UsePatternMask;
	UNITY_UNIFORM float                _PatternMaskThreshold;
	UNITY_UNIFORM int                _PolarPatternColor;
	UNITY_UNIFORM int                _PolarPatternAnimation;
#else
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Bounds;
	UNITY_UNIFORM float Xhlslcc_UnusedX_PatternAnimation;
	UNITY_UNIFORM float Xhlslcc_UnusedX_PatternThreshold;
	UNITY_UNIFORM float Xhlslcc_UnusedX_PatternFade;
	UNITY_UNIFORM int Xhlslcc_UnusedX_PatternFadePreset;
	UNITY_UNIFORM vec2 Xhlslcc_UnusedX_PatternAnimationOffset;
	UNITY_UNIFORM vec2 Xhlslcc_UnusedX_PatternColorOffset;
	UNITY_UNIFORM float Xhlslcc_UnusedX_PatternAnimationUVRotation;
	UNITY_UNIFORM float Xhlslcc_UnusedX_PatternColorUVRotation;
	UNITY_UNIFORM int Xhlslcc_UnusedX_UsePatternMask;
	UNITY_UNIFORM float Xhlslcc_UnusedX_PatternMaskThreshold;
	UNITY_UNIFORM int Xhlslcc_UnusedX_PolarPatternColor;
	UNITY_UNIFORM int Xhlslcc_UnusedX_PolarPatternAnimation;
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _LightMask;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD3;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat13;
void main()
{
    u_xlat16_0.x = (-vs_TEXCOORD3) + 1.0;
    u_xlat1.x = u_xlat16_0.x * _SekaiFogColor.w;
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat16_0.www * u_xlat16_0.xyz;
    u_xlat16_5.xyz = texture(_LightMask, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat5.xyz = (-u_xlat16_2.xyz) + _SekaiFogColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    u_xlat13 = vs_TEXCOORD4 / vs_TEXCOORD0.w;
    u_xlat13 = u_xlat13 * 0.5 + 0.5;
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat3.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat3.x = u_xlat3.x + -1.0;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.w;
    u_xlat13 = u_xlat3.x * u_xlat13 + _ProjectionParams.w;
    u_xlat13 = (-_CoCParams.x) * u_xlat13 + 1.0;
    u_xlat13 = u_xlat13 * _CoCParams.y;
    u_xlat3.x = max(u_xlat13, -1.0);
    u_xlat13 = u_xlat13;
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
    u_xlat3.x = min(u_xlat3.x, 0.0);
    u_xlat13 = u_xlat13 + u_xlat3.x;
    u_xlat13 = u_xlat13 + 1.0;
    u_xlat13 = u_xlat13 * 0.5;
    SV_Target1.x = u_xlat13;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.xyz * vec3(_Intensity);
    u_xlat13 = dot(u_xlat3.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = u_xlat1.xyz * vec3(_Intensity) + (-vec3(u_xlat13));
    u_xlat1.xyz = vec3(vec3(_BloomSat, _BloomSat, _BloomSat)) * u_xlat1.xyz + vec3(u_xlat13);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
	}
}
