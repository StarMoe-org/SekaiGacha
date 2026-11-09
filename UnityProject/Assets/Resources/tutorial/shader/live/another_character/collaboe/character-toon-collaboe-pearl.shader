// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Character/Toon-CollaboE-Pearl"
{
	Properties
	{
		_Color("Color", Color) = (1, 1, 1, 1)
		[NoScaleOffset] _MainTex("Base Color Map", 2D) = "white" {}
		[NoScaleOffset] _DetailMap("Detail Map", 2D) = "white" {}
		[Toggle(ENABLE_VERTEX_COLOR)] _EnableVertexColor("Enable Vertex Color", Float) = 0
		[Header(Billboard)] _CardScale("Sphere Scale", Float) = 0.015
		_SphereRadius("Sphere Radius", Range(0, 0.5)) = 0.43
		[Toggle] _EnablePositionFix("Fix Position", Float) = 0
		[Header(Toon)] _LightToonCutoff("Light Toon Cutoff", Range(-1, 1)) = 0.6
		_LightToonRange("Light Toon Range", Range(0, 0.5)) = 0.04
		[Header(Shadow ColorMap)] [Toggle(ENABLE_SHADOW_COLOR_MAP)] _EnableShadowColorMap("Enable Shadow Color Map", Float) = 0
		[NoScaleOffset] _ShadowColorMap("Shadow Color Map", 2D) = "black" {}
		[Header(Specular)] [Toggle(ENABLE_SPECULAR)] _EnableSpecular("Enable Specular", Float) = 1
		[Toggle(ENABLE_ADDITIVE_SPECULAR)] _EnableAdditiveSpecular("Additive Specular", Float) = 0
		_SpecularColor("Specular Color", Color) = (0.29, 0.29, 0.29, 1)
		[Toggle(ENABLE_SPECULAR_MAP)] _EnableSpecularMap("Enable Specular Map", Float) = 0
		[NoScaleOffset] _SpecularTexture("Specular Color Map", 2D) = "white" {}
		_SpecularIntensity("Specular Intensity", Range(0, 15)) = 13
		_SpecularPower("Specular Power", Float) = 80
		_SpecularIgnoreAngle("Specular Ignore Angle", Range(0, 1)) = 0
		[Header(Key Light)] _KeyLightInfluence("Key Light Influence", Range(0, 1)) = 1
		[Header(Rim Light)] _RimIntensity("Rim Intensity", Float) = 5
		[Header(Render States)] [Enum(Front, 2, Back, 1, Both, 0)] _Culling("Face Rendering", Float) = 2
		[Header(Other Properties)] _DepthOffset("Depth Offset", Float) = 0
		[Header(Outline)] _OutlineColor("Outline Color", Color) = (0, 0, 0, 1)
		_OutlineCutoff("Outline Cutoff", Range(0, 1)) = 0.7
		_OutlineBlur("Outline Blur", Range(0, 1)) = 0.2
	}
	SubShader
	{
		Tags { "QUEUE"="Geometry" "RenderType"="TransparentCutout" }
		Pass
		{
			Name "Main"
			Tags { "LIGHTMODE"="SekaiBase" "QUEUE"="Geometry" "RenderType"="TransparentCutout" }
			Cull [_Culling]
			GLSLPROGRAM
#pragma multi_compile _ ENABLE_SHADOW_COLOR_MAP
#pragma multi_compile _ ENABLE_SPECULAR
#pragma multi_compile _ ENABLE_SPECULAR_MAP
#pragma multi_compile _ ENABLE_VERTEX_COLOR
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _CardScale;
uniform 	int _EnablePositionFix;
uniform 	float _DepthOffset;
uniform 	vec4 _RimLightDir;
#if defined(ENABLE_SPECULAR)
uniform 	vec4 _SpecularLightDir;
#endif
uniform 	vec4 _DirectionalLightDir1;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
#if defined(ENABLE_VERTEX_COLOR)
in highp vec4 in_COLOR0;
#endif
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
#if defined(ENABLE_SPECULAR)
out highp vec3 vs_TEXCOORD3;
#endif
out highp vec3 vs_TEXCOORD4;
#if defined(ENABLE_VERTEX_COLOR)
out highp vec4 vs_TEXCOORD5;
#endif
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
bvec2 u_xlatb0;
#if defined(ENABLE_SPECULAR)
vec4 u_xlat1;
#else
vec3 u_xlat1;
#endif
vec3 u_xlat2;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlatb0.xy = lessThan(in_TEXCOORD0.xyxx, vec4(0.5, 0.5, 0.0, 0.0)).xy;
    u_xlat6 = _CardScale * 0.5;
    u_xlat1.x = (u_xlatb0.x) ? (-float(u_xlat6)) : float(u_xlat6);
    u_xlat1.y = (u_xlatb0.y) ? (-float(u_xlat6)) : float(u_xlat6);
    u_xlat1.z = (_EnablePositionFix != 0) ? 0.0 : u_xlat6;
    u_xlat0.x = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat9 = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_MatrixV[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_MatrixV[2].xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = vec3(vec3(_DepthOffset, _DepthOffset, _DepthOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * _DirectionalLightDir1.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * _DirectionalLightDir1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * _DirectionalLightDir1.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * _RimLightDir.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * _RimLightDir.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * _RimLightDir.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
#if defined(ENABLE_SPECULAR)
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * _SpecularLightDir.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * _SpecularLightDir.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * _SpecularLightDir.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * u_xlat0.xy;
    u_xlat1.w = u_xlat0.z * u_xlat9 + 1.0;
    u_xlat0.x = dot(u_xlat1.xyw, u_xlat1.xyw);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyw;
#endif
#if defined(ENABLE_VERTEX_COLOR)
    vs_TEXCOORD5 = in_COLOR0;
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
uniform 	mediump vec4 _Color;
uniform 	float _SphereRadius;
uniform 	int _CharacterId;
uniform 	mediump vec4 _EmissionColor;
uniform 	float _Emission;
uniform 	float rp_GlobalIntensity;
uniform 	mediump vec4 rp_CharacterAmbientLightColorArray[10];
uniform 	float rp_CharacterAmbientLightIntensityArray[10];
uniform 	float rp_CharacterAmbientLightBrightnessArray[10];
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailMap;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
int u_xlati1;
bvec3 u_xlatb1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat1.x = _SphereRadius * _SphereRadius;
    u_xlatb1.x = u_xlat16_0.x>=u_xlat1.x;
    if(u_xlatb1.x){discard;}
    u_xlat0.w = (u_xlatb1.x) ? 0.0 : 1.0;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = texture(_DetailMap, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * _Color.xyz;
    u_xlat16_3.xyz = (-_Color.xyz) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlatb1.xyz = greaterThanEqual(u_xlat16_4.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_5.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_5.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_5.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlati1 = _CharacterId;
    u_xlat16_6.xyz = vec3(1.0, 1.0, 1.0) + (-rp_CharacterAmbientLightColorArray[u_xlati1].xyz);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_4.xyz) * rp_CharacterAmbientLightColorArray[u_xlati1].xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * rp_CharacterAmbientLightColorArray[u_xlati1].xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(rp_CharacterAmbientLightIntensityArray[u_xlati1]);
    u_xlat2.xyz = rp_CharacterAmbientLightColorArray[u_xlati1].xyz * vec3(rp_CharacterAmbientLightBrightnessArray[u_xlati1]);
    u_xlat2.xyz = u_xlat2.xyz * vec3(rp_GlobalIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(0.200000003, 0.200000003, 0.200000003);
    u_xlat7.xyz = u_xlat9.xyz * vec3(rp_GlobalIntensity);
    u_xlat1.xyz = (-u_xlat9.xyz) * vec3(rp_GlobalIntensity) + _EmissionColor.xyz;
    u_xlat0.xyz = vec3(_Emission) * u_xlat1.xyz + u_xlat7.xyz;
    SV_Target0 = u_xlat0;
    u_xlat1.xyz = _EmissionColor.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(_Emission) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target1.xyz = u_xlat1.xyz;
    SV_Target1.w = 0.0;
    return;
}
#endif
			ENDGLSL
		}
	}
	Fallback "Legacy Shaders/VertexLit"
}
