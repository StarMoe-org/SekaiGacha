// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Hidden/SekaiRP/PostEffect/Bloom"
{
	SubShader
	{
		Pass
		{
			Name "BASE"
			ZTest Always
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 _BloomTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
flat out highp int vs_TEXCOORD1;
vec4 u_xlat0;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BloomTex_ST.xy + _BloomTex_ST.zw;
    vs_TEXCOORD2 = in_TEXCOORD1.y;
    vs_TEXCOORD1 = int(in_TEXCOORD1.x);
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
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
UNITY_LOCATION(0) uniform mediump sampler2D _BloomTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
flat in highp int vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = float(vs_TEXCOORD1);
    u_xlat16_0 = textureLod(_BloomTex, vs_TEXCOORD0.xy, u_xlat0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vs_TEXCOORD2);
    SV_Target0 = u_xlat16_0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "Blur1"
			ZTest Always
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
uniform 	vec4 _BlitScaleBias;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
uvec3 u_xlatu0;
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = uint(~(int(~0) << uint(bits)) << uint(offset));
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}
void main()
{
    u_xlatu0.x =  uint(int(int_bitfieldInsert(0, gl_VertexID, 1 & int(0x1F), 1)));
    u_xlatu0.z = uint(uint(gl_VertexID) & 2u);
    u_xlat0.xy = vec2(u_xlatu0.xz);
    gl_Position.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
    gl_Position.zw = vec2(-1.0, 1.0);
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
vec4 ImmCB_0[3];
uniform 	vec2 _GlobalMipBias;
uniform 	vec4 _BlitTexture_TexelSize;
UNITY_LOCATION(0) uniform mediump sampler2D _BlitTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
int u_xlati10;
bool u_xlatb15;
void main()
{
ImmCB_0[0] = vec4(0.649999976,0.203999996,0.0,0.0);
ImmCB_0[1] = vec4(2.43000007,0.197999999,0.0,0.0);
ImmCB_0[2] = vec4(4.36999989,0.0979999974,0.0,0.0);
    u_xlat0.xy = _BlitTexture_TexelSize.xy * vec2(1.0, 0.0);
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<3 ; u_xlati_loop_1++)
    {
        u_xlat2.xy = u_xlat0.xy * ImmCB_0[u_xlati_loop_1].xx + vs_TEXCOORD0.xy;
        u_xlat16_2.xyz = texture(_BlitTexture, u_xlat2.xy, _GlobalMipBias.x).xyz;
        u_xlat3.xy = (-u_xlat0.xy) * ImmCB_0[u_xlati_loop_1].xx + vs_TEXCOORD0.xy;
        u_xlat16_3.xyz = texture(_BlitTexture, u_xlat3.xy, _GlobalMipBias.x).xyz;
        u_xlat16_4.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
        u_xlat16_1.xyz = u_xlat16_4.xyz * ImmCB_0[u_xlati_loop_1].yyy + u_xlat16_1.xyz;
    }
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "Blur2"
			ZTest Always
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
uniform 	vec4 _BlitScaleBias;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
uvec3 u_xlatu0;
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = uint(~(int(~0) << uint(bits)) << uint(offset));
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}
void main()
{
    u_xlatu0.x =  uint(int(int_bitfieldInsert(0, gl_VertexID, 1 & int(0x1F), 1)));
    u_xlatu0.z = uint(uint(gl_VertexID) & 2u);
    u_xlat0.xy = vec2(u_xlatu0.xz);
    gl_Position.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
    gl_Position.zw = vec2(-1.0, 1.0);
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
vec4 ImmCB_0[3];
uniform 	vec2 _GlobalMipBias;
uniform 	vec4 _BlitTexture_TexelSize;
UNITY_LOCATION(0) uniform mediump sampler2D _BlitTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
int u_xlati10;
bool u_xlatb15;
void main()
{
ImmCB_0[0] = vec4(0.649999976,0.203999996,0.0,0.0);
ImmCB_0[1] = vec4(2.43000007,0.197999999,0.0,0.0);
ImmCB_0[2] = vec4(4.36999989,0.0979999974,0.0,0.0);
    u_xlat0.xy = _BlitTexture_TexelSize.xy * vec2(0.0, 1.0);
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<3 ; u_xlati_loop_1++)
    {
        u_xlat2.xy = u_xlat0.xy * ImmCB_0[u_xlati_loop_1].xx + vs_TEXCOORD0.xy;
        u_xlat16_2.xyz = texture(_BlitTexture, u_xlat2.xy, _GlobalMipBias.x).xyz;
        u_xlat3.xy = (-u_xlat0.xy) * ImmCB_0[u_xlati_loop_1].xx + vs_TEXCOORD0.xy;
        u_xlat16_3.xyz = texture(_BlitTexture, u_xlat3.xy, _GlobalMipBias.x).xyz;
        u_xlat16_4.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
        u_xlat16_1.xyz = u_xlat16_4.xyz * ImmCB_0[u_xlati_loop_1].yyy + u_xlat16_1.xyz;
    }
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "Conbine"
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ZTest Always
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 _BloomTex_ST;
uniform 	float _BloomIntensity;
uniform 	float _BloomScatter;
uniform 	float _BloomScatterWeight;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.x = log2(_BloomScatter);
    u_xlat0.x = u_xlat0.x * in_TEXCOORD1.x;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _BloomScatterWeight;
    vs_TEXCOORD1 = u_xlat0.x * _BloomIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BloomTex_ST.xy + _BloomTex_ST.zw;
    vs_TEXCOORD2 = in_TEXCOORD1.y;
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
UNITY_LOCATION(0) uniform mediump sampler2D _BloomTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = texture(_BloomTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vs_TEXCOORD1);
    u_xlat3 = (-vs_TEXCOORD2) + 1.0;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    u_xlat0.w = vs_TEXCOORD2;
    SV_Target0 = u_xlat0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "ConbineURP"
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ZTest Always
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 _BloomTex_ST;
uniform 	float _BloomIntensity;
uniform 	float _BloomScatter;
uniform 	float _BloomScatterWeight;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.x = log2(_BloomScatter);
    u_xlat0.x = u_xlat0.x * in_TEXCOORD1.x;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _BloomScatterWeight;
    vs_TEXCOORD1 = u_xlat0.x * _BloomIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BloomTex_ST.xy + _BloomTex_ST.zw;
    vs_TEXCOORD2 = in_TEXCOORD1.y;
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
UNITY_LOCATION(0) uniform mediump sampler2D _BloomTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = texture(_BloomTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vs_TEXCOORD1);
    u_xlat3 = (-vs_TEXCOORD2) + 1.0;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat0.w = vs_TEXCOORD2;
    SV_Target0 = u_xlat0;
    return;
}
#endif
			ENDGLSL
		}
		UsePass "Hidden/Sekai/PostEffect/Copy/BASE"
	}
}
