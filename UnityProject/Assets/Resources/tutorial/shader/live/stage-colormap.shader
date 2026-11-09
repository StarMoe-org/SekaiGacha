// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Stage/ColorMap"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ColorTex("ColorMap", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
		LOD 100
		Pass
		{
			Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend One One, One One
			ZWrite Off
			Cull Off
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
UNITY_BINDING(0) uniform UnityPerDraw {
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
UNITY_BINDING(1) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _MainTex_ST;
	UNITY_UNIFORM vec4                _ColorTex_ST;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump float vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0;
    u_xlat0.x = u_xlat0.z + _ProjectionParams.y;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * _ColorTex_ST.xy + _ColorTex_ST.zw;
    u_xlat2 = _ProjectionParams.y + _ProjectionParams.z;
    u_xlat0.x = u_xlat0.x / u_xlat2;
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
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiLightIntensity;
uniform 	vec4 _SekaiAmbientLightColor;
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
uniform 	vec4 _SekaiFogColor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ColorTex;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump float vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
bvec3 u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat8;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = texture(_ColorTex, vs_TEXCOORD2.xy);
    u_xlat2 = u_xlat16_0 * u_xlat16_1;
    u_xlatb3.xyz = greaterThanEqual(u_xlat2.xyzx, vec4(0.5, 0.5, 0.5, 0.0)).xyz;
    u_xlat16_4.x = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb3.y) ? float(1.0) : float(0.0);
    u_xlat16_4.z = (u_xlatb3.z) ? float(1.0) : float(0.0);
    u_xlat16_5.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat16_5.xyz * _SekaiAmbientLightColor.xyz;
    u_xlat16_6.xyz = (-u_xlat16_0.xyz) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = (-_SekaiAmbientLightColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_6.xyz) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * _SekaiAmbientLightColor.xyz + u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat16_4.xyz * vec3(vec3(_SekaiLightIntensity, _SekaiLightIntensity, _SekaiLightIntensity));
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SekaiAllLightIntensity);
    u_xlatb21 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb21){
        u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat1.xy = u_xlat1.xy * u_xlat1.xy;
        u_xlat21 = u_xlat1.y + u_xlat1.x;
        u_xlat21 = u_xlat1.z * u_xlat1.z + u_xlat21;
        u_xlat1.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat21 = u_xlat21 + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat1.x = float(1.0) / u_xlat1.x;
        u_xlat21 = u_xlat21 * u_xlat1.x;
        u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
        u_xlat1.x = u_xlat21 * -2.0 + 3.0;
        u_xlat21 = u_xlat21 * u_xlat21;
        u_xlat8 = u_xlat21 * u_xlat1.x;
        u_xlat21 = (-u_xlat1.x) * u_xlat21 + 1.0;
        u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat8);
        u_xlat1.xyz = u_xlat1.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + u_xlat1.xyz;
    }
    u_xlat16_4.x = (-vs_TEXCOORD4) + 1.0;
    u_xlat21 = u_xlat16_4.x * _SekaiFogColor.w;
    u_xlat1.xyz = (-u_xlat0.xyz) + _SekaiFogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}
#endif
			ENDGLSL
		}
	}
}
