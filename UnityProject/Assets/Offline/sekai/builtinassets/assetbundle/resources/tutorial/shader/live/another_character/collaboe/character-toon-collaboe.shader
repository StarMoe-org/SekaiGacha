// ReSekai：由 GLES3 程序生成，只能在 GL 系图形 API 上运行。
Shader "Sekai/Live/Character/Toon-CollaboE"
{
	Properties
	{
		[Title(Stencil)] _Stencil("Stencil ID [0;255]", Float) = 1
		_ReadMask("ReadMask [0;255]", Float) = 255
		_WriteMask("WriteMask [0;255]", Float) = 255
		[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp("Stencil Comparison", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp("Stencil Operation", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilFail("Stencil Fail", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilZFail("Stencil ZFail", Float) = 0
		[Toggle(_LAMBERT)] _UseLambert("Use Lambert", Float) = 1
		[Title(Textures)] _MainTex("Main", 2D) = "white" {}
		_ShadowTex("Shadow", 2D) = "white" {}
		[Header(MRS)] [Toggle(ENABLE_MRS_MAP)] _EnableMRSMask("Enable MRS Map", Float) = 0
		_MRSTexture("MRS (Mask / Reflection / Specular)", 2D) = "black" {}
		[Title(FaceShadow)] [Toggle(_UseFaceSDF)] _UseFaceSDF("Use Face SDF", Float) = 0
		_RangeLimit("Range Limit", Range(0, 1)) = 0
		[Title(Outline)] _OutlineWidth("Outline Width", Float) = 0.001
		_OutlineOffset("Outline Offset", Float) = 0
		[Toggle(_OUTLINE_SECOND_NORMAL)] _UseOutlineSecondNormal("Use Second Normal", Float) = 0
		[Header(Alpha Clip)] [Toggle(ENABLE_ALPHA_CLIP)] _EnableAlphaClip("Enable Alpha Clip", Float) = 0
		_Cutoff("Alpha Clip", Range(0, 1)) = 0.1
		[Header(Shadow)] _ShadowThreshold("Shadow Threshold", Range(0, 1)) = 0.5
		[Space] [Title(Rim)] _RimThreshold("Rim Threshold", Range(0.01, 1)) = 0.2
		[Title(Specular)] _SpecularPower("Specular Power", Range(0, 5)) = 0
		[Header(Render States)] [Enum(Front, 2, Back, 1, Both, 0)] _Culling("Face Rendering", Float) = 1
		[Title(HairShadow)] _HeadNormalBlend("Head Normal Blend", Range(0, 1)) = 0
		[HideInInspector] _FaceFront("FaceFront", Vector) = (0, 0, 0, 0)
		[HideInInspector] _PartsAmbientColor("Parts Ambient Color", Color) = (1, 1, 1, 1)
		[Title(Eyelash)] _EyelashTransparent("Eyelash Transparent", Range(0, 1)) = 0
		_EyelashFaceCameraEdge1("フェードがかかり始める角度 (1:顔の正面, 0:顔の真横)", Range(0, 1)) = 0.5
		_EyelashFaceCameraEdge2("フェードがかかり終わる角度 (1:顔の正面, 0:顔の真横)", Range(0, 1)) = 0
		_EyelashMaskTex("Eyelash Mask", 2D) = "black" {}
		_EyelashStencil("Stencil ID [0;255]", Float) = 1
		_EyelashReadMask("ReadMask [0;255]", Float) = 255
		_EyelashWriteMask("WriteMask [0;255]", Float) = 255
		_UseEyebrowVertexAlpha("Use Eyebrow Vertex Alpha", Range(0, 1)) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _EyelashStencilComp("Stencil Comparison", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _EyelashStencilOp("Stencil Operation", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _EyelashStencilFail("Stencil Fail", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _EyelashStencilZFail("Stencil ZFail", Float) = 0
		[HideInInspector] _CharacterId("CharacterId", Float) = 0
		[HideInInspector] _DefaultSkinColor("DefaultSkinColor", Color) = (0.9921875, 0.9609375, 0.921875, 1)
		[HideInInspector] _Shadow1SkinColor("Shadow1SkinColor", Color) = (0.890625, 0.76953125, 0.796875, 1)
		[HideInInspector] _Shadow2SkinColor("Shadow2SkinColor", Color) = (0.796875, 0.59375, 0.63671875, 1)
		[HideInInspector] _HeadPosition("HeadPosition", Vector) = (0, 0, 0, 0)
		[HideInInspector] _IsLeftEyeClose("IsLeftEyeClose", Float) = 0
		[HideInInspector] _IsRightEyeClose("IsRightEyeClose", Float) = 0
		[HideInInspector] _CharacterReflectionOff("CharacterReflectionOff", Float) = 0
		[HideInInspector] _HeadDotDirectionalLightValues("_HeadDotDirectionalLightValues", Vector) = (1, 1, 1, 1)
	}
	SubShader
	{
		LOD 500
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Base"
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Eyelash"
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Outline"
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Reflection"
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Monitor"
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Base-RP"
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Base-RP-Over"
	}
	SubShader
	{
		LOD 300
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Base"
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Eyelash"
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Outline"
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Monitor"
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Base-RP"
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Base-RP-Over"
	}
	SubShader
	{
		LOD 100
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Base"
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Monitor"
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Base-RP"
		UsePass "Hidden/Sekai/Live/Character/Toon-CollaboE/Base-RP-Over"
	}
	Fallback "Legacy Shaders/VertexLit"
}
