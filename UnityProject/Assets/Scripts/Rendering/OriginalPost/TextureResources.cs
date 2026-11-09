// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Pass.PostProcessV2/TextureResources.cs，适配独立 URP 工程。
using UnityEngine;

namespace Pass.PostProcessV2
{
	public sealed class TextureResources
	{
		public readonly Texture2D smaaAreaTex;

		public readonly Texture2D smaaSearchTex;

		public TextureResources()
		{
			smaaAreaTex = Resources.Load<Texture2D>("Textures/SMAA/AreaTex");
			smaaSearchTex = Resources.Load<Texture2D>("Textures/SMAA/SearchTex");
		}

		internal void Cleanup()
		{
			if (smaaAreaTex) Resources.UnloadAsset(smaaAreaTex);
			if (smaaSearchTex) Resources.UnloadAsset(smaaSearchTex);
		}
	}
}
