// 源自 Cpp2CS Assembly-CSharp.dll/Sekai.Core/ShaderPreloader.cs；保留原变体预热判断。
using UnityEngine;
namespace SekaiGacha {
static class GachaShaderWarmup {
public static void WarmUpWhenNotLoaded(ShaderVariantCollection shaderVariantCollection)
		{
			if (!(shaderVariantCollection == null) && !shaderVariantCollection.isWarmedUp)
			{
				shaderVariantCollection.WarmUp();
			}
		}
}
}
