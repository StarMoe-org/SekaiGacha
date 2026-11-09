using System;
using UnityEngine;

namespace Sekai {

[ExecuteInEditMode]
public class SekaiDirectionalLight : MonoBehaviour
{
	[SerializeField]
	private SekaiCharacterDirectionalLight characterDirectionalLightData;

	[SerializeField]
	private Color shadowColor = new Color(1f, 1f, 1f, 1f);

	[SerializeField]
	[Range(0f, 1f)]
	private float shadowThreshold = 13f / 32f;

	public SekaiCharacterDirectionalLight CharacterDirectionalLightData => characterDirectionalLightData;

	public void Reset()
	{
		transform.localEulerAngles = new Vector3(-45f, 60f, 0f);
	}

	private void Start()
	{
		if (characterDirectionalLightData != null)
		{
			characterDirectionalLightData.Initialize();
		}
	}

	private void Update()
	{
		Vector3 forward = transform.forward;
		Shader.SetGlobalVector("_WorldSpaceLightPos0", new Vector4(forward.x, forward.y, forward.z, 0f));
		Shader.SetGlobalVector("_SekaiDirectionalLight", new Vector4(forward.x, forward.y, forward.z, 0f));
		Shader.SetGlobalColor("_SekaiShadowColor", shadowColor);
		Shader.SetGlobalFloat("_SekaiShadowThreshold", shadowThreshold);
		if (characterDirectionalLightData != null && (object)characterDirectionalLightData == null)
		{
			throw new NullReferenceException();
		}
	}

	private void OnDrawGizmos()
	{
		Color color = Gizmos.color;
		Gizmos.color = new Color(1f, 235f / 255f, 4f / 255f, 1f);
		Gizmos.DrawCube(transform.position, new Vector3(Vector3.one.x * 0.2f, Vector3.one.y * 0.2f, Vector3.one.z * 0.2f));
		Vector3 position = transform.position;
		Vector3 forward = transform.forward;
		Vector3 forward2 = transform.forward;
		Gizmos.DrawRay(new Vector3(position.x - forward.x * 0.1f, position.y - forward.y * 0.1f, position.z - forward.z * 0.1f), new Vector3(forward2.x * -2f, forward2.y * -2f, forward2.z * -2f));
		Vector3 position2 = transform.position;
		Vector3 up = transform.up;
		Vector3 right = transform.right;
		Vector3 forward3 = transform.forward;
		Vector3 forward4 = transform.forward;
		Gizmos.DrawRay(new Vector3(position2.x + (up.x + right.x - forward3.x) * 0.1f, position2.y + (up.y + right.y - forward3.y) * 0.1f, position2.z + (up.z + right.z - forward3.z) * 0.1f), new Vector3(forward4.x * -2f, forward4.y * -2f, forward4.z * -2f));
		Vector3 position3 = transform.position;
		Vector3 up2 = transform.up;
		Vector3 right2 = transform.right;
		Vector3 forward5 = transform.forward;
		Vector3 forward6 = transform.forward;
		Gizmos.DrawRay(new Vector3(position3.x + (up2.x - right2.x - forward5.x) * 0.1f, position3.y + (up2.y - right2.y - forward5.y) * 0.1f, position3.z + (up2.z - right2.z - forward5.z) * 0.1f), new Vector3(forward6.x * -2f, forward6.y * -2f, forward6.z * -2f));
		Vector3 position4 = transform.position;
		Vector3 up3 = transform.up;
		Vector3 right3 = transform.right;
		Vector3 forward7 = transform.forward;
		Vector3 forward8 = transform.forward;
		Gizmos.DrawRay(new Vector3(position4.x + (right3.x - up3.x - forward7.x) * 0.1f, position4.y + (right3.y - up3.y - forward7.y) * 0.1f, position4.z + (right3.z - up3.z - forward7.z) * 0.1f), new Vector3(forward8.x * -2f, forward8.y * -2f, forward8.z * -2f));
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
		}, new Vector3(forward10.x * -2f, forward10.y * -2f, forward10.z * -2f));
		Gizmos.color = color;
	}
}

}
