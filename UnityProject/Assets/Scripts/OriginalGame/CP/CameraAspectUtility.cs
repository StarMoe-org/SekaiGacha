// 源自恢复工程 Assets/Scripts/Assembly-CSharp/CP/CameraAspectUtility.cs。
using System;


namespace CP
{
	public static class CameraAspectUtility
	{
		public static float CalculateFOV(float verticalFOV, float targetAspect, float currentAspect)
		{
			float num = UnityEngine.Mathf.Atan(UnityEngine.Mathf.Tan(verticalFOV * 0.5f * ((float)3.141592653589793 / 180f)) * targetAspect);
			float num2 = UnityEngine.Mathf.Atan(UnityEngine.Mathf.Tan((num + num) * 57.29578f * 0.5f * ((float)3.141592653589793 / 180f)) / currentAspect);
			return (num2 + num2) * 57.29578f;
		}

		public static float CalculateVertical2HorizontalFOV(float verticalFOV, float aspect)
		{
			float num = UnityEngine.Mathf.Atan(UnityEngine.Mathf.Tan(verticalFOV * 0.5f * ((float)3.141592653589793 / 180f)) * aspect);
			return (num + num) * 57.29578f;
		}

		public static float CalculateHorizontal2VerticalFOV(float horizontalFOV, float aspect)
		{
			float num = UnityEngine.Mathf.Atan(UnityEngine.Mathf.Tan(horizontalFOV * 0.5f * ((float)3.141592653589793 / 180f)) / aspect);
			return (num + num) * 57.29578f;
		}

		public static float CalculateVerticalPositionOffset(float baseFov, float targetFov, float dist)
		{
			return -(UnityEngine.Mathf.Tan(targetFov * 0.5f * ((float)3.141592653589793 / 180f)) - UnityEngine.Mathf.Tan(baseFov * 0.5f * ((float)3.141592653589793 / 180f))) * dist;
		}
	}
}
