// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/MusicItem/Toon"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ShadowTex("Shadow", 2D) = "white" {}
		_ValueTex("Value", 2D) = "black" {}
		_OutlineWidth("OutlineWidth", Float) = 0.001
		_OutlineL("OutlineL", Range(0, 1)) = 0.5
		_RimThreshold("RimThreshold", Range(0.01, 1)) = 0.2
		[HideInInspector] _Transparency("Transparency", Range(0, 1)) = 1
		[HideInInspector] _CharacterId("CharacterId", Float) = 0
		[HideInInspector] _DefaultSkinColor("DefaultSkinColor", Color) = (0.9921875, 0.9609375, 0.921875, 1)
		[HideInInspector] _Shadow1SkinColor("Shadow1SkinColor", Color) = (0.890625, 0.76953125, 0.796875, 1)
		[HideInInspector] _Shadow2SkinColor("Shadow2SkinColor", Color) = (0.796875, 0.59375, 0.63671875, 1)
		[HideInInspector] _CharacterReflectionOff("CharacterReflectionOff", Float) = 0
	}
	SubShader
	{
		LOD 500
		UsePass "Hidden/Sekai/Live/MusicItem/Toon/BASE TRANSPARENT"
		UsePass "Hidden/Sekai/Live/MusicItem/Toon/OUTLINE TRANSPARENT"
		UsePass "Hidden/Sekai/Live/MusicItem/Toon/REFLECTION TRANSPARENT"
		UsePass "Hidden/Sekai/Live/MusicItem/Toon/BASE-RP"
		UsePass "Hidden/Sekai/Live/MusicItem/Toon/BASE-RP-OVER"
	}
	SubShader
	{
		LOD 300
		UsePass "Hidden/Sekai/Live/MusicItem/Toon/BASE TRANSPARENT"
		UsePass "Hidden/Sekai/Live/MusicItem/Toon/OUTLINE TRANSPARENT"
		UsePass "Hidden/Sekai/Live/MusicItem/Toon/BASE-RP"
		UsePass "Hidden/Sekai/Live/MusicItem/Toon/BASE-RP-OVER"
	}
	SubShader
	{
		LOD 100
		UsePass "Hidden/Sekai/Live/MusicItem/Toon/BASE TRANSPARENT"
		UsePass "Hidden/Sekai/Live/MusicItem/Toon/BASE-RP"
		UsePass "Hidden/Sekai/Live/MusicItem/Toon/BASE-RP-OVER"
	}
	Fallback "Legacy Shaders/VertexLit"
}
