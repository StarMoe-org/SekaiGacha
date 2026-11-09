Shader "Legacy Shaders/Particles/Additive"
{
    Properties { _MainTex("Texture", 2D) = "white" {} _TintColor("Tint", Color) = (.5,.5,.5,.5) }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        Pass
        {
            Tags { "LightMode"="SRPDefaultUnlit" }
            Blend SrcAlpha One
            ZWrite Off
            Cull Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            sampler2D _MainTex; float4 _MainTex_ST; fixed4 _TintColor;
            struct V { float4 vertex:POSITION; fixed4 color:COLOR; float2 uv:TEXCOORD0; };
            struct F { float4 vertex:SV_POSITION; fixed4 color:COLOR; float2 uv:TEXCOORD0; };
            F vert(V v) { F o; o.vertex=UnityObjectToClipPos(v.vertex); o.color=v.color; o.uv=TRANSFORM_TEX(v.uv,_MainTex); return o; }
            fixed4 frag(F i):SV_Target { return 2 * _TintColor * i.color * tex2D(_MainTex,i.uv); }
            ENDCG
        }
    }
}
