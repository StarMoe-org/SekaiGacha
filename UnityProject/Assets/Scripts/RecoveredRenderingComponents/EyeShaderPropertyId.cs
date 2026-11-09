using UnityEngine;

namespace Sekai.Rendering {

internal static class EyeShaderPropertyId
{
	public static readonly int IsRightEyeClose = Shader.PropertyToID("_IsRightEyeClose");

	public static readonly int IsLeftEyeClose = Shader.PropertyToID("_IsLeftEyeClose");
}

}
