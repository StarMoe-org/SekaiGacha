// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Character/Toon"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ShadowTex("Shadow", 2D) = "white" {}
		_ValueTex("Value", 2D) = "black" {}
		[Title(Outline)] _OutlineWidth("OutlineWidth", Float) = 0.001
		[Title(Rim)] _RimThreshold("RimThreshold", Range(0.01, 1)) = 0.2
		[HideInInspector] _PartsAmbientColor("Parts Ambient Color", Color) = (1, 1, 1, 1)
		[HideInInspector] _CharacterId("CharacterId", Float) = 0
		[HideInInspector] _DefaultSkinColor("DefaultSkinColor", Color) = (0.9921875, 0.9609375, 0.921875, 1)
		[HideInInspector] _Shadow1SkinColor("Shadow1SkinColor", Color) = (0.890625, 0.76953125, 0.796875, 1)
		[HideInInspector] _Shadow2SkinColor("Shadow2SkinColor", Color) = (0.796875, 0.59375, 0.63671875, 1)
		[HideInInspector] _CharacterReflectionOff("CharacterReflectionOff", Float) = 0
		[HideInInspector] _StencilPassOperation("StencilPassOperation", Float) = 0
		[HideInInspector] _ReflectionCasterSrcBlend("ReflectionCasterSrcBlend", Float) = 1
		[HideInInspector] _ReflectionCasterDstBlend("ReflectionCasterDstBlend", Float) = 0
		[HideInInspector] _ReflectionBlendColor("ReflectionBlendColor", Color) = (1, 1, 1, 1)
		[HideInInspector] _BlendMode("BlendMode", Float) = 0
		[HideInInspector] _ShadowTexWeight("ShadowTexWeight", Range(0, 1)) = 1
		[Enum(FadeOut,0, Spread,1)] [HideInInspector] _FadeMode("FadeMode", Float) = 0
		[HideInInspector] _ShadowWidth("Shadow Width", Range(0, 1)) = 0
		[HideInInspector] _HueCosAngle("Hue Cos Angle", Float) = 1
		[HideInInspector] _HueSinAngle("Hue Sin Angle", Float) = 0
		[HideInInspector] _Saturation("Saturation", Range(0, 1)) = 0.5
		[HideInInspector] _Value("Value", Range(0, 1)) = 0.5
		[HideInInspector] _Contrast("Contrast", Range(0, 1)) = 0.5
	}
	SubShader
	{
		LOD 500
		UsePass "Hidden/Sekai/Live/Character/Toon/BASE"
		UsePass "Hidden/Sekai/Live/Character/Toon/OUTLINE"
		UsePass "Hidden/Sekai/Live/Character/Toon/REFLECTION"
		UsePass "Hidden/Sekai/Live/Character/Toon/MONITOR"
		UsePass "Hidden/Sekai/Live/Reflection/MusicItem-Caster"
		UsePass "Hidden/Sekai/Live/Character/Toon/BASE-RP"
		UsePass "Hidden/Sekai/Live/Character/Toon/BASE-RP-OVER"
	}
	SubShader
	{
		LOD 300
		UsePass "Hidden/Sekai/Live/Character/Toon/BASE"
		UsePass "Hidden/Sekai/Live/Character/Toon/OUTLINE"
		UsePass "Hidden/Sekai/Live/Character/Toon/MONITOR"
		UsePass "Hidden/Sekai/Live/Reflection/MusicItem-Caster"
		UsePass "Hidden/Sekai/Live/Character/Toon/BASE-RP"
		UsePass "Hidden/Sekai/Live/Character/Toon/BASE-RP-OVER"
	}
	SubShader
	{
		LOD 100
		UsePass "Hidden/Sekai/Live/Character/Toon/BASE"
		UsePass "Hidden/Sekai/Live/Character/Toon/MONITOR"
		UsePass "Hidden/Sekai/Live/Reflection/MusicItem-Caster"
		UsePass "Hidden/Sekai/Live/Character/Toon/BASE-RP"
		UsePass "Hidden/Sekai/Live/Character/Toon/BASE-RP-OVER"
	}
	Fallback "Legacy Shaders/VertexLit"
}
