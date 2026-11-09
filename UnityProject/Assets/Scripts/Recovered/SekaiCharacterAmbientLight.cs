using System;
using UnityEngine;

namespace Sekai.Core {

[ExecuteInEditMode]
public class SekaiCharacterAmbientLight : MonoBehaviour
{
	private static class CharacterAmbientShaderPropertyID
	{
		public static readonly int SekaiCharacterAmbientLightIntensityArray = Shader.PropertyToID("_SekaiCharacterAmbientLightIntensityArray");

		public static readonly int SekaiCharacterAmbientLightColorArray = Shader.PropertyToID("_SekaiCharacterAmbientLightColorArray");

		public static readonly int SekaiCharacterSpecularColorArray = Shader.PropertyToID("_SekaiCharacterSpecularColorArray");

		public static readonly int SekaiCharacterOutlineColorArray = Shader.PropertyToID("_SekaiCharacterOutlineColorArray");

		public static readonly int SekaiCharacterOutlineBlendingArray = Shader.PropertyToID("_SekaiCharacterOutlineBlendingArray");
	}

	[SerializeField]
	private Color ambientColor = new Color(BitConverter.Int32BitsToSingle(1065353216), BitConverter.Int32BitsToSingle(1065353216), BitConverter.Int32BitsToSingle(1065353216), BitConverter.Int32BitsToSingle(1065353216));

	[Range(0f, 1f)]
	[SerializeField]
	private float intensity = BitConverter.Int32BitsToSingle(1065353216);

	[SerializeField]
	private Color specularColor = new Color(BitConverter.Int32BitsToSingle(1065353216), BitConverter.Int32BitsToSingle(1065353216), BitConverter.Int32BitsToSingle(1065353216), 1f);

	[SerializeField]
	private Color outlineColor = new Color(0f, 0f, 0f, 1f);

	[Tooltip("テクスチャカラーやライティングを考慮したアウトラインカラーと, SekaiCharacterAmbientLight.outlineColorのブレンド率. 0...テクスチャカラーやライティングを考慮したアウトラインカラー. 1...SekaiCharacterAmbientLight.outlineColor. ブレンド率の初期値は0.5f.")]
	[SerializeField]
	[Range(0f, 1f)]
	private float outlineBlending = 0.5f;

	[SerializeField]
	[HideInInspector]
	private int formationId;

	private static float[] intensityArray = new float[12];

	private static Vector4[] colorArray = new Vector4[12];

	private static Vector4[] specularColorArray = new Vector4[12];

	private static Vector4[] outlineColorArray = new Vector4[12];

	private static float[] outlineBlendingArray = new float[12];

	public float Intensity
	{
		get
		{
			return intensity;
		}
		set
		{
			intensity = value;
		}
	}

	public Color Color
	{
		get
		{
			return ambientColor;
		}
		set
		{
			ambientColor = value;
		}
	}

	public int FormationId
	{
		get
		{
			return formationId;
		}
		set
		{
			formationId = value;
		}
	}

	public void Reset()
	{
		intensity = 1f;
		ambientColor = new Color(0.5f, 0.5f, 0.5f, 1f);
	}

	private void Update()
	{
		float[] array = intensityArray;
		int num = formationId;
		ulong num2 = (uint)array.Length;
		array[num] = intensity;
		Vector4[] array2 = colorArray;
		ulong num3 = (uint)array2.Length;
		Color color = ambientColor;
		array2[num].x = color.r;
		array2[num].y = color.g;
		array2[num].z = color.b;
		array2[num].w = color.a;
		Vector4[] array3 = specularColorArray;
		int num4 = formationId;
		ulong num5 = (uint)array3.Length;
		Color color2 = specularColor;
		array3[num4].x = color2.r;
		array3[num4].y = color2.g;
		array3[num4].z = color2.b;
		array3[num4].w = color2.a;
		Vector4[] array4 = outlineColorArray;
		int num6 = formationId;
		ulong num7 = (uint)array4.Length;
		Color color3 = outlineColor;
		array4[num6].x = color3.r;
		array4[num6].y = color3.g;
		array4[num6].z = color3.b;
		array4[num6].w = color3.a;
		float[] array5 = outlineBlendingArray;
		ulong num8 = (uint)array5.Length;
		float num9 = outlineBlending;
		array5[formationId] = num9;
		Shader.SetGlobalFloatArray(values: intensityArray, nameID: CharacterAmbientShaderPropertyID.SekaiCharacterAmbientLightIntensityArray);
		Shader.SetGlobalVectorArray(values: colorArray, nameID: CharacterAmbientShaderPropertyID.SekaiCharacterAmbientLightColorArray);
		Shader.SetGlobalVectorArray(values: specularColorArray, nameID: CharacterAmbientShaderPropertyID.SekaiCharacterSpecularColorArray);
		Shader.SetGlobalVectorArray(values: outlineColorArray, nameID: CharacterAmbientShaderPropertyID.SekaiCharacterOutlineColorArray);
		Shader.SetGlobalFloatArray(values: outlineBlendingArray, nameID: CharacterAmbientShaderPropertyID.SekaiCharacterOutlineBlendingArray);
	}
}

}
