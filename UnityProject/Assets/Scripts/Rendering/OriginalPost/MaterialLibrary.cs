// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.PostPrcessV2/MaterialLibrary.cs，适配独立 URP 工程。
using UnityEngine;
using UnityEngine.Rendering;

namespace Sekai.Rendering.PostPrcessV2
{
	public class MaterialLibrary
	{
		public readonly Material uber;

		public readonly Material boxBlur;

		public readonly Material bloom;

		public readonly Material sekaiDof;

		public readonly Material subpixelMorphologicalAntialiasing;

		public MaterialLibrary()
		{
			uber = Load("Hidden/Sekai/V2/UberPost");
			boxBlur = Load("Hidden/CP/PostEffect/BoxBlur");
			bloom = Load("Hidden/SekaiRP/PostEffect/Bloom");
			sekaiDof = Load("Hidden/Sekai/V2/SekaiDepthOfField");
			subpixelMorphologicalAntialiasing = Load("Hidden/Sekai/SubpixelMorphologicalAntialiasing");
		}

		private Material Load(string shaderName)
		{
			Shader shader = Shader.Find(shaderName);
			if (shader == null)
			{
				Debug.LogErrorFormat("Missing shader. (" + shaderName + ") " + GetType().DeclaringType.Name + " render pass will not execute. Check for missing reference in the renderer resources.");
				return null;
			}
			if (!shader.isSupported)
			{
				return null;
			}
			return CoreUtils.CreateEngineMaterial(shader);
		}

		internal void Cleanup()
		{
			CoreUtils.Destroy(uber);
			CoreUtils.Destroy(boxBlur);
			CoreUtils.Destroy(bloom);
			CoreUtils.Destroy(sekaiDof);
			CoreUtils.Destroy(subpixelMorphologicalAntialiasing);
		}
	}
}
