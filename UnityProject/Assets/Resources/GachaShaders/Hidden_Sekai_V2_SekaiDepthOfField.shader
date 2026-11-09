// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Hidden/Sekai/V2/SekaiDepthOfField"
{
	SubShader
	{
		Tags { "RenderPipeline"="UniversalPipeline" }
		LOD 100
		Pass
		{
			Name "SekaiDoF Alpha CoC"
			Tags { "RenderPipeline"="UniversalPipeline" }
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
uniform 	vec2 _GlobalMipBias;
UNITY_LOCATION(0) uniform mediump sampler2D _BlitTexture;
UNITY_LOCATION(1) uniform mediump sampler2D _DepthTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = texture(_BlitTexture, vs_TEXCOORD0.xy, _GlobalMipBias.x).xyz;
    u_xlat16_0.w = texture(_DepthTexture, vs_TEXCOORD0.xy, _GlobalMipBias.x).x;
    SV_Target0 = u_xlat16_0;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "SekaiDoF MidDownSampleMRT"
			Tags { "RenderPipeline"="UniversalPipeline" }
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
uniform 	vec2 _InvRenderTargetSize;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec2 u_xlat0;
uvec3 u_xlatu0;
vec2 u_xlat2;
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
    u_xlat0.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
    gl_Position.zw = vec2(-1.0, 1.0);
    u_xlat2.x = 0.0;
    u_xlat2.y = _InvRenderTargetSize.y;
    vs_TEXCOORD3.xy = u_xlat2.xy + u_xlat2.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy + (-_InvRenderTargetSize.xy);
    vs_TEXCOORD2.xy = _InvRenderTargetSize.xy * vec2(1.0, -1.0) + u_xlat0.xy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _BlitTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump float u_xlat16_5;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
mediump float u_xlat16_13;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_BlitTexture, u_xlat0.xy, _GlobalMipBias.x);
    u_xlat16_1.x = u_xlat16_0.w * 2.0 + -1.0;
    u_xlat2.xy = vs_TEXCOORD3.xy + vs_TEXCOORD2.xy;
    u_xlat16_2 = texture(_BlitTexture, u_xlat2.xy, _GlobalMipBias.x);
    u_xlat16_7 = u_xlat16_2.w * 2.0 + -1.0;
    u_xlat16_1.x = max(u_xlat16_7, u_xlat16_1.x);
    u_xlat16_3 = texture(_BlitTexture, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat16_7 = u_xlat16_3.w * 2.0 + -1.0;
    u_xlat16_4 = texture(_BlitTexture, vs_TEXCOORD2.xy, _GlobalMipBias.x);
    u_xlat16_13 = u_xlat16_4.w * 2.0 + -1.0;
    u_xlat16_7 = max(u_xlat16_13, u_xlat16_7);
    SV_Target0.w = max(u_xlat16_1.x, u_xlat16_7);
    u_xlat16_1.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_19 = (-u_xlat16_3.w) + 1.0;
    u_xlat16_19 = u_xlat16_19 * 2.0 + -1.0;
    u_xlat16_5 = (-u_xlat16_4.w) + 1.0;
    u_xlat16_5 = u_xlat16_5 * 2.0 + -1.0;
    u_xlat16_19 = max(u_xlat16_19, u_xlat16_5);
    u_xlat16_1.xyz = u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_5 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_5 = u_xlat16_5 * 2.0 + -1.0;
    u_xlat16_1.xyz = u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_11 = (-u_xlat16_2.w) + 1.0;
    u_xlat16_11 = u_xlat16_11 * 2.0 + -1.0;
    u_xlat16_5 = max(u_xlat16_11, u_xlat16_5);
    SV_Target1.w = max(u_xlat16_19, u_xlat16_5);
    u_xlat16_0.xyz = texture(_BlitTexture, vs_TEXCOORD0.xy, _GlobalMipBias.x).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.200000003, 0.200000003, 0.200000003);
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target1.xyz = u_xlat16_1.xyz;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "SekaiDoF Blur Mid Bg"
			Tags { "RenderPipeline"="UniversalPipeline" }
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
uniform 	mediump vec2 _Offsets;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
    gl_Position.zw = vec2(-1.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1 = _Offsets.xyxy * vec4(1.0, 1.0, -1.0, -1.0) + u_xlat0.xyxy;
    vs_TEXCOORD2 = _Offsets.xyxy * vec4(2.0, 2.0, -2.0, -2.0) + u_xlat0.xyxy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _BlitTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.xyz = texture(_BlitTexture, vs_TEXCOORD1.zw, _GlobalMipBias.x).xyz;
    u_xlat16_1.xyz = texture(_BlitTexture, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_2 = texture(_BlitTexture, vs_TEXCOORD0.xy, _GlobalMipBias.x);
    u_xlat16_3.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    SV_Target0.w = u_xlat16_2.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = texture(_BlitTexture, vs_TEXCOORD2.xy, _GlobalMipBias.x).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = texture(_BlitTexture, vs_TEXCOORD2.zw, _GlobalMipBias.x).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(0.200000003, 0.200000003, 0.200000003);
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "SekaiDoF Blur Low Bg"
			Tags { "RenderPipeline"="UniversalPipeline" }
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
uniform 	mediump vec2 _Offsets;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
    gl_Position.zw = vec2(-1.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1 = _Offsets.xyxy * vec4(1.0, 1.0, -1.0, -1.0) + u_xlat0.xyxy;
    vs_TEXCOORD2 = _Offsets.xyxy * vec4(2.0, 2.0, -2.0, -2.0) + u_xlat0.xyxy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _BlitTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.xyz = texture(_BlitTexture, vs_TEXCOORD1.zw, _GlobalMipBias.x).xyz;
    u_xlat16_1.xyz = texture(_BlitTexture, vs_TEXCOORD1.xy, _GlobalMipBias.x).xyz;
    u_xlat16_2 = texture(_BlitTexture, vs_TEXCOORD0.xy, _GlobalMipBias.x);
    u_xlat16_3.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    SV_Target0.w = u_xlat16_2.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = texture(_BlitTexture, vs_TEXCOORD2.xy, _GlobalMipBias.x).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = texture(_BlitTexture, vs_TEXCOORD2.zw, _GlobalMipBias.x).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(0.200000003, 0.200000003, 0.200000003);
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "SekaiDoF Downsample With Coc Conserve"
			Tags { "RenderPipeline"="UniversalPipeline" }
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
uniform 	vec2 _InvRenderTargetSize;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec2 u_xlat0;
uvec3 u_xlatu0;
vec2 u_xlat2;
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
    u_xlat0.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
    gl_Position.zw = vec2(-1.0, 1.0);
    u_xlat2.x = 0.0;
    u_xlat2.y = _InvRenderTargetSize.y;
    vs_TEXCOORD3.xy = u_xlat2.xy + u_xlat2.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy + (-_InvRenderTargetSize.xy);
    vs_TEXCOORD2.xy = _InvRenderTargetSize.xy * vec2(1.0, -1.0) + u_xlat0.xy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _BlitTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_5;
mediump float u_xlat16_22;
void main()
{
    u_xlat16_0.xyz = texture(_BlitTexture, vs_TEXCOORD0.xy, _GlobalMipBias.x).xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy + vs_TEXCOORD1.xy;
    u_xlat16_1 = texture(_BlitTexture, u_xlat1.xy, _GlobalMipBias.x);
    u_xlat16_2 = texture(_BlitTexture, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat16_3 = texture(_BlitTexture, vs_TEXCOORD2.xy, _GlobalMipBias.x);
    u_xlat16_4.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_22 = max(u_xlat16_2.w, u_xlat16_3.w);
    u_xlat16_4.xyz = u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy + vs_TEXCOORD2.xy;
    u_xlat16_2 = texture(_BlitTexture, u_xlat1.xy, _GlobalMipBias.x);
    u_xlat16_4.xyz = u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_5 = max(u_xlat16_1.w, u_xlat16_2.w);
    SV_Target0.w = max(u_xlat16_22, u_xlat16_5);
    u_xlat16_4.xyz = u_xlat16_0.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(0.200000003, 0.200000003, 0.200000003);
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "SekaiDoF Blur Mid Fg"
			Tags { "RenderPipeline"="UniversalPipeline" }
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
uniform 	mediump vec2 _Offsets;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
    gl_Position.zw = vec2(-1.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1 = _Offsets.xyxy * vec4(1.0, 1.0, -1.0, -1.0) + u_xlat0.xyxy;
    vs_TEXCOORD2 = _Offsets.xyxy * vec4(2.0, 2.0, -2.0, -2.0) + u_xlat0.xyxy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _BlitTexture;
UNITY_LOCATION(1) uniform mediump sampler2D _BlurFgMidTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_BlitTexture, vs_TEXCOORD0.xy, _GlobalMipBias.x);
    u_xlat16_1 = texture(_BlitTexture, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat16_0 = u_xlat16_1 * vec4(0.75, 0.75, 0.75, 0.75) + u_xlat16_0;
    u_xlat16_1 = texture(_BlitTexture, vs_TEXCOORD1.zw, _GlobalMipBias.x);
    u_xlat16_0 = u_xlat16_1 * vec4(0.75, 0.75, 0.75, 0.75) + u_xlat16_0;
    u_xlat16_1 = texture(_BlitTexture, vs_TEXCOORD2.xy, _GlobalMipBias.x);
    u_xlat16_0 = u_xlat16_1 * vec4(0.5, 0.5, 0.5, 0.5) + u_xlat16_0;
    u_xlat16_1 = texture(_BlitTexture, vs_TEXCOORD2.zw, _GlobalMipBias.x);
    u_xlat16_0 = u_xlat16_1 * vec4(0.5, 0.5, 0.5, 0.5) + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vec4(0.285714298, 0.285714298, 0.285714298, 0.285714298);
    u_xlat16_1.x = texture(_BlurFgMidTex, vs_TEXCOORD0.xy, _GlobalMipBias.x).w;
    SV_Target0.w = max(u_xlat16_0.w, u_xlat16_1.x);
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "SekaiDoF Blur Low Fg"
			Tags { "RenderPipeline"="UniversalPipeline" }
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
uniform 	mediump vec2 _Offsets;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
    gl_Position.zw = vec2(-1.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1 = _Offsets.xyxy * vec4(1.0, 1.0, -1.0, -1.0) + u_xlat0.xyxy;
    vs_TEXCOORD2 = _Offsets.xyxy * vec4(2.0, 2.0, -2.0, -2.0) + u_xlat0.xyxy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _BlitTexture;
UNITY_LOCATION(1) uniform mediump sampler2D _BlurFgLowTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_BlitTexture, vs_TEXCOORD0.xy, _GlobalMipBias.x);
    u_xlat16_1 = texture(_BlitTexture, vs_TEXCOORD1.xy, _GlobalMipBias.x);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = texture(_BlitTexture, vs_TEXCOORD1.zw, _GlobalMipBias.x);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = texture(_BlitTexture, vs_TEXCOORD2.xy, _GlobalMipBias.x);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = texture(_BlitTexture, vs_TEXCOORD2.zw, _GlobalMipBias.x);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003);
    u_xlat16_1.x = texture(_BlurFgLowTex, vs_TEXCOORD0.xy, _GlobalMipBias.x).w;
    SV_Target0.w = max(u_xlat16_0.w, u_xlat16_1.x);
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "SekaiDoF Dof Apply Source Bg Fg"
			Tags { "RenderPipeline"="UniversalPipeline" }
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
vec2 u_xlat2;
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = uint(~(int(~0) << uint(bits)) << uint(offset));
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}
void main()
{
    u_xlatu0.x =  uint(int(int_bitfieldInsert(0, gl_VertexID, 1 & int(0x1F), 1)));
    u_xlatu0.z = uint(uint(gl_VertexID) & 2u);
    u_xlat0.xy = vec2(u_xlatu0.xz);
    u_xlat2.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
    gl_Position.xy = u_xlat2.xy;
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
uniform 	vec2 _GlobalMipBias;
UNITY_LOCATION(0) uniform mediump sampler2D _BlitTexture;
UNITY_LOCATION(1) uniform mediump sampler2D _BlurBgLowTex;
UNITY_LOCATION(2) uniform mediump sampler2D _BlurFgLowTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat16_0 = texture(_BlitTexture, vs_TEXCOORD0.xy, _GlobalMipBias.x);
    u_xlat16_1.x = u_xlat16_0.w * 2.0 + -1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_2 = texture(_BlurBgLowTex, vs_TEXCOORD0.xy, _GlobalMipBias.x);
    u_xlat16_2 = (-u_xlat16_0) + u_xlat16_2;
    u_xlat16_1 = u_xlat16_1.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_3 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_3 = u_xlat16_3 * 2.0 + -1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_0 = texture(_BlurFgLowTex, vs_TEXCOORD0.xy, _GlobalMipBias.x);
    u_xlat4 = u_xlat16_0.w * 1.14999998;
    u_xlat4 = max(u_xlat16_3, u_xlat4);
    u_xlat16_0.w = min(u_xlat4, 1.0);
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_0;
    SV_Target0 = u_xlat16_0.wwww * u_xlat16_2 + u_xlat16_1;
    return;
}
#endif
			ENDGLSL
		}
		Pass
		{
			Name "SekaiDoF Dof Apply Source Bg"
			Tags { "RenderPipeline"="UniversalPipeline" }
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
vec2 u_xlat2;
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = uint(~(int(~0) << uint(bits)) << uint(offset));
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}
void main()
{
    u_xlatu0.x =  uint(int(int_bitfieldInsert(0, gl_VertexID, 1 & int(0x1F), 1)));
    u_xlatu0.z = uint(uint(gl_VertexID) & 2u);
    u_xlat0.xy = vec2(u_xlatu0.xz);
    u_xlat2.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
    gl_Position.xy = u_xlat2.xy;
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
uniform 	vec2 _GlobalMipBias;
UNITY_LOCATION(0) uniform mediump sampler2D _BlitTexture;
UNITY_LOCATION(1) uniform mediump sampler2D _BlurBgLowTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_BlitTexture, vs_TEXCOORD0.xy, _GlobalMipBias.x);
    u_xlat16_1 = u_xlat16_0.w * 2.0 + -1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_2 = texture(_BlurBgLowTex, vs_TEXCOORD0.xy, _GlobalMipBias.x);
    u_xlat16_2 = (-u_xlat16_0) + u_xlat16_2;
    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_2 + u_xlat16_0;
    return;
}
#endif
			ENDGLSL
		}
	}
}
