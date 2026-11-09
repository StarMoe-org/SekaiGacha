using System;

using UnityEngine;

namespace Sekai.Core {

[ExecuteInEditMode]
public class SekaiCharacterRimLight : MonoBehaviour
{
	public enum RimDirectionMode
	{
		TransformForward,
		ScreenVector
	}

	private const string GROUP_NAME_BASIC = "■ 標準リム";

	private const string GROUP_NAME_DIRECTION = "■ リム方向";

	private const string GROUP_NAME_EDGE = "■ エッジリム";

	private const string GROUP_NAME_SHADOW = "■ シャドウリム";

	[ColorUsage(true, true)]
	[SerializeField]
	private Color rimColor = new Color(1f, 1f, 1f, 1f);

	[SerializeField]

	[Range(0f, 10f)]
	private float range = 1f;

	[SerializeField]
	[Range(0.001f, 1f)]
	[HideInInspector]

	private float edgeSmoothness = 0.001f;

	[SerializeField]
	[Range(0f, 10f)]
	private float emission;


	[SerializeField]
	private RimDirectionMode directionMode;


	[SerializeField]

	private Vector3 rimDirectionVector = new Vector3(-1f, 0f, 0f);

	[Range(0f, 1f)]


	[SerializeField]
	private float lightInfluence = 1f;

	[SerializeField]

	private bool isUseShadowColor;

	[SerializeField]
	[ColorUsage(true, true)]

	private Color shadowRimColor = new Color(0f, 0f, 0f, 1f);

	[Range(0f, 1f)]



	[SerializeField]
	private float shadowSharpness = 0.5f;

	[SerializeField]
	[HideInInspector]
	private int formationId;

	private static Vector4[] lightArray = new Vector4[12];

	private static Vector4[] colorArray = new Vector4[12];

	private static Vector4[] shadowColorArray = new Vector4[12];

	private static Vector4[] factorArray = new Vector4[12];

	private static float[] shadowSharpnessArray = new float[12];

	private Camera mainCamera;

	public Color Color
	{
		get
		{
			return rimColor;
		}
		set
		{
			rimColor = value;
		}
	}

	public float Emission
	{
		get
		{
			return emission;
		}
		set
		{
			emission = value;
		}
	}

	public Color ShadowRimColor
	{
		get
		{
			return shadowRimColor;
		}
		set
		{
			shadowRimColor = value;
		}
	}

	public void Setup(int formationId, Camera mainCamera = null, float range = 9f)
	{
		this.mainCamera = mainCamera;
		this.formationId = formationId;
		this.range = range;
	}

	private Vector3 GetRimLightDirection(RimDirectionMode mode)
	{
		float num5;
		float num6;
		float num7;
		switch (mode)
		{
		case RimDirectionMode.TransformForward:
		{
			Vector3 forward = transform.forward;
			float z2 = forward.z;
			float y2 = forward.y;
			num5 = forward.x;
			num6 = y2;
			num7 = z2;
			break;
		}
		default:
			throw new ArgumentOutOfRangeException("mode", mode, null);
		case RimDirectionMode.ScreenVector:
		{
			Camera camera = mainCamera;
			Vector3 vector = rimDirectionVector;
			Vector4 vector2 = camera.transform.localToWorldMatrix * new Vector4
			{
				x = 0f - vector.x,
				y = 0f - vector.y,
				z = 0f - vector.z,
				w = -0f
			};
			float num = (float)Math.Sqrt(vector2.z * vector2.z + (vector2.x * vector2.x + vector2.y * vector2.y));
			if (num > 1E-05f)
			{
				float num2 = vector2.x / num;
				float num3 = vector2.y / num;
				float num4 = vector2.z / num;
				num5 = num2;
				num6 = num3;
				num7 = num4;
			}
			else
			{
				float x = Vector3.zero.x;
				float y = Vector3.zero.y;
				float z = Vector3.zero.z;
				num5 = x;
				num6 = y;
				num7 = z;
			}
			break;
		}
		}
		float num8 = (float)Math.Sqrt(num7 * num7 + (num5 * num5 + num6 * num6));
		float z3;
		float y3;
		float x2;
		if (num8 > 1E-05f)
		{
			float num9 = num5 / num8;
			float num10 = num6 / num8;
			float num11 = num7 / num8;
			z3 = num11;
			y3 = num10;
			x2 = num9;
		}
		else
		{
			float x3 = Vector3.zero.x;
			float y4 = Vector3.zero.y;
			float z4 = Vector3.zero.z;
			z3 = z4;
			y3 = y4;
			x2 = x3;
		}
		return new Vector3(x2, y3, z3);
	}

	public void Reset()
	{
		rimColor = new Color(1f, 1f, 1f, 1f);
		transform.localRotation = Quaternion.identity;
	}

    private void Update()
    {
        Vector3 direction = GetRimLightDirection(directionMode);
        lightArray[formationId] = new Vector4(direction.x, direction.y, direction.z, 0f);
        colorArray[formationId] = rimColor;
        shadowColorArray[formationId] = isUseShadowColor ? shadowRimColor : rimColor;
        factorArray[formationId] = new Vector4(range, emission, edgeSmoothness, Mathf.GammaToLinearSpace(lightInfluence));
        shadowSharpnessArray[formationId] = shadowSharpness;
        Shader.SetGlobalVectorArray("_SekaiRimLightArray", lightArray);
        Shader.SetGlobalVectorArray("_SekaiRimLightColorArray", colorArray);
        Shader.SetGlobalVectorArray("_SekaiShadowRimLightColorArray", shadowColorArray);
        Shader.SetGlobalVectorArray("_SekaiRimLightFactor", factorArray);
        Shader.SetGlobalFloatArray("_SekaiRimLightShadowSharpnessArray", shadowSharpnessArray);
    }

	private void OnDrawGizmos()
	{
		Color color = Gizmos.color;
		Gizmos.color = new Color(0f, 1f, 0f, 1f);
		Gizmos.DrawCube(transform.position, new Vector3(Vector3.one.x * 0.2f, Vector3.one.y * 0.2f, Vector3.one.z * 0.2f));
		Vector3 position = transform.position;
		Vector3 forward = transform.forward;
		Vector3 forward2 = transform.forward;
		Gizmos.DrawRay(new Vector3(position.x - forward.x * 0.1f, position.y - forward.y * 0.1f, position.z - forward.z * 0.1f), new Vector3(forward2.x + forward2.x, forward2.y + forward2.y, forward2.z + forward2.z));
		Vector3 position2 = transform.position;
		Vector3 up = transform.up;
		Vector3 right = transform.right;
		Vector3 forward3 = transform.forward;
		Vector3 forward4 = transform.forward;
		Gizmos.DrawRay(new Vector3(position2.x + (up.x + right.x - forward3.x) * 0.1f, position2.y + (up.y + right.y - forward3.y) * 0.1f, position2.z + (up.z + right.z - forward3.z) * 0.1f), new Vector3(forward4.x + forward4.x, forward4.y + forward4.y, forward4.z + forward4.z));
		Vector3 position3 = transform.position;
		Vector3 up2 = transform.up;
		Vector3 right2 = transform.right;
		Vector3 forward5 = transform.forward;
		Vector3 forward6 = transform.forward;
		Gizmos.DrawRay(new Vector3(position3.x + (up2.x - right2.x - forward5.x) * 0.1f, position3.y + (up2.y - right2.y - forward5.y) * 0.1f, position3.z + (up2.z - right2.z - forward5.z) * 0.1f), new Vector3(forward6.x + forward6.x, forward6.y + forward6.y, forward6.z + forward6.z));
		Vector3 position4 = transform.position;
		Vector3 up3 = transform.up;
		Vector3 right3 = transform.right;
		Vector3 forward7 = transform.forward;
		Vector3 forward8 = transform.forward;
		Gizmos.DrawRay(new Vector3(position4.x + (right3.x - up3.x - forward7.x) * 0.1f, position4.y + (right3.y - up3.y - forward7.y) * 0.1f, position4.z + (right3.z - up3.z - forward7.z) * 0.1f), new Vector3(forward8.x + forward8.x, forward8.y + forward8.y, forward8.z + forward8.z));
		Vector3 position5 = transform.position;
		Vector3 up4 = transform.up;
		Vector3 right4 = transform.right;
		Vector3 forward9 = transform.forward;
		Vector3 forward10 = transform.forward;
		Gizmos.DrawRay(new Vector3
		{
			x = position5.x + (0f - up4.x - right4.x - forward9.x) * 0.1f,
			y = position5.y + (0f - up4.y - right4.y - forward9.y) * 0.1f,
			z = position5.z + (0f - up4.z - right4.z - forward9.z) * 0.1f
		}, new Vector3(forward10.x + forward10.x, forward10.y + forward10.y, forward10.z + forward10.z));
		Gizmos.color = color;
	}
}

}
