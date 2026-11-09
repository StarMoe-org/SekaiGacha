// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Stage/LightMap-Emission"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_EmissionTex("EmissionTex", 2D) = "white" {}
		_LightMapTex("LightMapTex", 2D) = "white" {}
		_LightIntensityMin("LightIntensityMin", Range(0, 1)) = 0
		_LightIntensityMax("LightIntensityMax", Range(0, 1)) = 0
	}
	SubShader
	{
		Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
		LOD 100
		Pass
		{
			Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _SekaiFogFactor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _LightMapTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump float vs_TEXCOORD4;
out highp float vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * _LightMapTex_ST.xy + _LightMapTex_ST.zw;
    u_xlat0.x = (-_SekaiFogFactor.y) * u_xlat0.z + _SekaiFogFactor.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD5 = u_xlat0.z;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _CoCParams;
uniform 	float _SekaiAllLightIntensity;
uniform 	float _SekaiLightIntensity;
uniform 	vec4 _SekaiAmbientLightColor;
uniform 	vec3 _SekaiGlobalSpotLightPos;
uniform 	vec4 _SekaiGlobalSpotLightColor;
uniform 	float _SekaiGlobalSpotLightRadiusNear;
uniform 	float _SekaiGlobalSpotLightRadiusFar;
uniform 	int _SekaiGlobalSpotLightEnabled;
uniform 	vec4 _SekaiFogColor;
uniform 	float _LightIntensityMin;
uniform 	float _LightIntensityMax;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _EmissionTex;
UNITY_LOCATION(2) uniform mediump sampler2D _LightMapTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp float vs_TEXCOORD5;
layout(location = 0) out highp vec4 SV_Target0;
layout(location = 1) out highp vec4 SV_Target1;
layout(location = 2) out highp vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
float u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
bvec3 u_xlatb10;
float u_xlat14;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = texture(_EmissionTex, vs_TEXCOORD1.xy);
    u_xlat16_2 = texture(_LightMapTex, vs_TEXCOORD2.xy);
    u_xlat3 = (-_LightIntensityMin) + _LightIntensityMax;
    u_xlat10.x = _SekaiLightIntensity * _SekaiAllLightIntensity + (-_LightIntensityMin);
    u_xlat3 = u_xlat10.x / u_xlat3;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat0 = u_xlat0 * u_xlat16_2;
    u_xlat2.w = u_xlat0.w + u_xlat0.w;
    u_xlatb10.xyz = greaterThanEqual(u_xlat0.xyzz, vec4(0.25, 0.25, 0.25, 0.25)).xyz;
    u_xlat16_4.x = (u_xlatb10.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb10.y) ? float(1.0) : float(0.0);
    u_xlat16_4.z = (u_xlatb10.z) ? float(1.0) : float(0.0);
    u_xlat16_5.xyz = u_xlat0.xyz * vec3(4.0, 4.0, 4.0);
    u_xlat10.xyz = u_xlat16_5.xyz * _SekaiAmbientLightColor.xyz;
    u_xlat16_6.xyz = (-u_xlat0.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = (-_SekaiAmbientLightColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_6.xyz) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * _SekaiAmbientLightColor.xyz + u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + u_xlat10.xyz;
    u_xlat0.xyz = u_xlat16_4.xyz * vec3(vec3(_SekaiLightIntensity, _SekaiLightIntensity, _SekaiLightIntensity));
    u_xlat2.xyz = u_xlat0.xyz * vec3(_SekaiAllLightIntensity);
    u_xlatb0 = 0<_SekaiGlobalSpotLightEnabled;
    if(u_xlatb0){
        u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _SekaiGlobalSpotLightPos.xyz;
        u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
        u_xlat0.x = u_xlat0.y + u_xlat0.x;
        u_xlat0.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
        u_xlat7.x = (-_SekaiGlobalSpotLightRadiusNear) + _SekaiGlobalSpotLightRadiusFar;
        u_xlat0.x = u_xlat0.x + (-_SekaiGlobalSpotLightRadiusNear);
        u_xlat7.x = float(1.0) / u_xlat7.x;
        u_xlat0.x = u_xlat7.x * u_xlat0.x;
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
        u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
        u_xlat0.x = u_xlat0.x * u_xlat0.x;
        u_xlat14 = u_xlat0.x * u_xlat7.x;
        u_xlat0.x = (-u_xlat7.x) * u_xlat0.x + 1.0;
        u_xlat7.xyz = u_xlat2.xyz * vec3(u_xlat14);
        u_xlat7.xyz = u_xlat7.xyz * _SekaiGlobalSpotLightColor.xyz;
        u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat7.xyz;
    }
    u_xlat0.x = (-u_xlat3) + 1.0;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat2;
    u_xlat16_4.x = (-vs_TEXCOORD0.z) + 1.0;
    u_xlat1 = u_xlat16_4.x * _SekaiFogColor.w;
    u_xlat8.xyz = (-u_xlat0.xyz) + _SekaiFogColor.xyz;
    SV_Target0.xyz = vec3(u_xlat1) * u_xlat8.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD5 / vs_TEXCOORD0.w;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat7.x = _ProjectionParams.z / _ProjectionParams.y;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = u_xlat7.x * _ProjectionParams.w;
    u_xlat0.x = u_xlat7.x * u_xlat0.x + _ProjectionParams.w;
    u_xlat0.x = (-_CoCParams.x) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _CoCParams.y;
    u_xlat7.x = u_xlat0.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat0.x = max(u_xlat0.x, -1.0);
    u_xlat0.x = min(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    SV_Target1.x = u_xlat0.x * 0.5;
    SV_Target0.w = u_xlat0.w;
    SV_Target1.yzw = vec3(0.0, 0.0, 1.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}
#endif
			ENDGLSL
		}
	}
}
