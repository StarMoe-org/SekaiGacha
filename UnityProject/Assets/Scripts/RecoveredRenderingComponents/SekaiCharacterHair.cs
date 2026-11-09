using System;
using UnityEngine;

namespace Sekai.Rendering {

[ExecuteAlways]
public class SekaiCharacterHair : MonoBehaviour
{
	[SerializeField]
	private Transform headTransform;

	[SerializeField]
	private Vector3 offset;

	private static readonly int HeadPositionId = Shader.PropertyToID("_HeadPosition");

	private const string HAIR_SHADOW_KEYWORD = "_HAIR_SHADOW";

	private const string LAMBERT_KEYWORD = "_LAMBERT";

	private Material[] materials;

	public void Setup(Transform headTrans, bool useHairShadow)
	{
		headTransform = headTrans;
		PopulateMaterials();
		Material[] array = materials;
		ulong num = (uint)array.Length;
		if ((int)num < 1)
		{
			return;
		}
		ulong num2 = num;
		ulong num3 = 0uL;
		while (true)
		{
			if ((uint)num3 >= (uint)num2)
			{
				throw new IndexOutOfRangeException();
			}
			Material material = array[(uint)num3];
			if ((object)material == null)
			{
				throw new NullReferenceException();
			}
			if (useHairShadow)
			{
				material.EnableKeyword("_HAIR_SHADOW");
				material.EnableKeyword("_LAMBERT");
			}
			else
			{
				material.DisableKeyword("_HAIR_SHADOW");
				material.DisableKeyword("_LAMBERT");
			}
			ulong num4 = (uint)array.Length;
			ulong num5 = (uint)((int)num3 + 1);
			if ((int)num5 >= (int)num4)
			{
				break;
			}
			num2 = num4;
			num3 = num5;
		}
	}

	private void OnEnable()
	{
		PopulateMaterials();
	}

	private void PopulateMaterials()
	{
		materials = GetComponent<Renderer>().sharedMaterials;
	}

	public void OnUpdate()
	{
		if (!headTransform)
		{
			return;
		}
		Vector3 vector = headTransform.TransformPoint(offset);
		Material[] array = materials;
		ulong num = (uint)array.Length;
		if ((int)num < 1)
		{
			return;
		}
		ulong num2 = num;
		ulong num3 = 0uL;
		while (true)
		{
			if ((uint)num3 >= (uint)num2)
			{
				throw new IndexOutOfRangeException();
			}
			array[(uint)num3].SetVector(HeadPositionId, new Vector4(vector.x, vector.y, vector.z, 0f));
			ulong num4 = (uint)array.Length;
			ulong num5 = (uint)((int)num3 + 1);
			if ((int)num5 >= (int)num4)
			{
				break;
			}
			num2 = num4;
			num3 = num5;
		}
	}

	private void OnDrawGizmos()
	{
		if ((bool)headTransform)
		{
			Gizmos.DrawWireSphere(headTransform.TransformPoint(offset), 0.02f);
		}
	}
}

}
