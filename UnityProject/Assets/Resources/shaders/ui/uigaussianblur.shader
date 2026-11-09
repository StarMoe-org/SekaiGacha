// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/UI/UIGaussianBlur"
{
	Properties
	{
		[PerRendererData] _MainTex("Sprite Texture", 2D) = "white" {}
		[PerRendererData] _Color("Tint", Color) = (1, 1, 1, 1)
		_SamplingDistance("Sampling Distance", Float) = 2.8
	}
	SubShader
	{
		Tags { "CanUseSpriteAtlas"="true" "IGNOREPROJECTOR"="true" "PreviewType"="Plane" "QUEUE"="Transparent" "RenderType"="Transparent" }
		Pass
		{
			Tags { "CanUseSpriteAtlas"="true" "IGNOREPROJECTOR"="true" "PreviewType"="Plane" "QUEUE"="Transparent" "RenderType"="Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZTest [unity_GUIZTestMode]
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	float _SamplingDistance;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat6;
vec2 u_xlat8;
void main()
{
    u_xlat0.x = _SamplingDistance;
    u_xlat16_1 = _MainTex_TexelSize.xyxy * vec4(0.0, 1.0, 1.0, 0.0);
    u_xlat1 = u_xlat16_1 * vec4(_SamplingDistance);
    u_xlat0.y = u_xlat1.y;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(0.0, 3.0) + u_xlat6.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _Color.ww;
    u_xlat8.x = u_xlat1.z * 3.0;
    phase0_Output0_2 = u_xlat1;
    u_xlat8.y = 0.0;
    u_xlat0.xy = u_xlat6.xy + (-u_xlat8.xy);
    vs_TEXCOORD1.xy = u_xlat0.xy * _Color.ww;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0 * _Color;
vs_TEXCOORD2 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.zw;
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
vec4 ImmCB_0[7];
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
int u_xlati8;
bool u_xlatb12;
void main()
{
ImmCB_0[0] = vec4(0.0359999985,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.112999998,0.0,0.0,0.0);
ImmCB_0[2] = vec4(0.216000006,0.0,0.0,0.0);
ImmCB_0[3] = vec4(0.268999994,0.0,0.0,0.0);
ImmCB_0[4] = vec4(0.216000006,0.0,0.0,0.0);
ImmCB_0[5] = vec4(0.112999998,0.0,0.0,0.0);
ImmCB_0[6] = vec4(0.0359999985,0.0,0.0,0.0);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlati8 = 0;
    while(true){
        u_xlatb12 = u_xlati8>=7;
        if(u_xlatb12){break;}
        u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
        u_xlat2 = u_xlat16_2 * vs_COLOR0;
        u_xlat2 = u_xlat2 * ImmCB_0[u_xlati8].xxxx;
        u_xlat1 = u_xlat2 * vec4(0.5, 0.5, 0.5, 0.5) + u_xlat16_1;
        u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD2.xy;
        u_xlati8 = u_xlati8 + 1;
        u_xlat16_1 = u_xlat1;
    }
    u_xlat0.xy = vs_TEXCOORD1.xy;
    u_xlat16_2 = u_xlat16_1;
    u_xlati8 = 0;
    while(true){
        u_xlatb12 = u_xlati8>=7;
        if(u_xlatb12){break;}
        u_xlat16_3 = texture(_MainTex, u_xlat0.xy);
        u_xlat3 = u_xlat16_3 * vs_COLOR0;
        u_xlat3 = u_xlat3 * ImmCB_0[u_xlati8].xxxx;
        u_xlat2 = u_xlat3 * vec4(0.5, 0.5, 0.5, 0.5) + u_xlat16_2;
        u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD3.xy;
        u_xlati8 = u_xlati8 + 1;
        u_xlat16_2 = u_xlat2;
    }
    SV_Target0 = u_xlat16_2;
    return;
}
#endif
			ENDGLSL
		}
	}
}
