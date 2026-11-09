using System;
using Sekai.Rendering.Setup3DUtility;
using UnityEngine;
using UnityEngine.Events;

namespace Sekai.Rendering {

[ExecuteAlways]
public class SekaiCharacterEye : MonoBehaviour
{
	private static class DefaultValueDefine
	{
		public const float LightInfluence = 1f;

		public const float LightInfluenceForEyeHighlight = 1f;
	}

	[Range(0f, 1f)]
	[SerializeField]
	private float lightInfluence = BitConverter.Int32BitsToSingle(1065353216);

	private float lightInfluenceShaderParam = BitConverter.Int32BitsToSingle(1065353216);

	[Range(0f, 1f)]
	[SerializeField]
	private float lightInfluenceForEyeHighlight = BitConverter.Int32BitsToSingle(1065353216);

	private float lightInfluenceForEyeHighlightShaderParam = BitConverter.Int32BitsToSingle(1065353216);

	[SerializeField]
	[ColorUsage(true, true)]
	private Color tintColor = new Color(BitConverter.Int32BitsToSingle(1065353216), BitConverter.Int32BitsToSingle(1065353216), BitConverter.Int32BitsToSingle(1065353216), BitConverter.Int32BitsToSingle(1065353216));

	[SerializeField]
	private Color emissionColor = new Color(0f, 0f, 0f, 1f);

	[SerializeField]
	private SekaiEyeTiling baseTiling = new SekaiEyeTiling
	{
		TileX = 2,
		TileY = 2,
		Sample = 0
	};

	[SerializeField]
	private SekaiEyeTiling highlightTiling = new SekaiEyeTiling
	{
		TileX = 5,
		TileY = 5,
		Sample = 0
	};

	private const string EYE_BASE_SHADER_NAME = "Sekai/Live/Character/Eye-Base";

	private const string EYE_HIGHLIGHT_SHADER_NAME = "Sekai/Live/Character/Eye-Highlight";

	private static readonly int MainTexId = Shader.PropertyToID("_MainTex");

	private static readonly int TintColorId = Shader.PropertyToID("_TintColor");

	private static readonly int EmissionColorId = Shader.PropertyToID("_EmissionColor");

	private static readonly int LightInfluenceId = Shader.PropertyToID("_LightInfluence");

	private static readonly int LightInfluenceForEyeHighlightId = Shader.PropertyToID("_LightInfluenceForEyeHighlight");

	private Material baseMaterial;

	private Material highlightMaterial;

	private Material eyelashMaterial;

	[SerializeField]
	private float leftEyeCloseBlendShapeValue;

	[SerializeField]
	private float rightEyeCloseBlendShapeValue;

	private SkinnedMeshRenderer _eyeRenderer;

	private IBlendShapeIndexTable blendShapeIndexTable;

	private UnityAction characterEyeAction = () =>
	{
	};

	private void Update()
	{
		GetBlendShapeValue();
		ApplyTiling(material: baseMaterial, tiling: baseTiling);
		ApplyTiling(material: highlightMaterial, tiling: highlightTiling);
		ApplyTintColor();
		ApplyEmissionColor();
		ApplyEyebrowTransparent();
		characterEyeAction();
		ApplyLightInfluence();
		ApplyLightInfluenceForHighlight();
	}

	private void GetBlendShapeValue()
	{
		IBlendShapeIndexTable blendShapeIndexTable = this.blendShapeIndexTable;
		if (blendShapeIndexTable == null)
		{
			return;
		}
		leftEyeCloseBlendShapeValue = 0f;
		rightEyeCloseBlendShapeValue = 0f;
		int[] leftEyeClose = blendShapeIndexTable.LeftEyeClose;
		ulong num = (uint)leftEyeClose.Length;
		if ((int)num >= 1)
		{
			ulong num2 = num & 0xFFFFFFFFL;
			ulong num3 = num2;
			ulong num4 = 0uL;
			while (true)
			{
				if (num4 >= (uint)num3)
				{
					throw new IndexOutOfRangeException();
				}
				float blendShapeWeight = _eyeRenderer.GetBlendShapeWeight(leftEyeClose[(uint)num4]);
				if (leftEyeCloseBlendShapeValue < blendShapeWeight)
				{
					leftEyeCloseBlendShapeValue = blendShapeWeight;
				}
				ulong num5 = (uint)leftEyeClose.Length;
				ulong num6 = num4 + 1L;
				if ((long)(num4 + 1L) >= (long)(int)num5)
				{
					break;
				}
				num3 = num5;
				num4 = num6;
			}
		}
		int[] rightEyeClose = this.blendShapeIndexTable.RightEyeClose;
		ulong num7 = (uint)rightEyeClose.Length;
		if ((int)num7 < 1)
		{
			return;
		}
		ulong num8 = num7 & 0xFFFFFFFFL;
		ulong num9 = num8;
		ulong num10 = 0uL;
		while (true)
		{
			if (num10 >= (uint)num9)
			{
				throw new IndexOutOfRangeException();
			}
			float blendShapeWeight2 = _eyeRenderer.GetBlendShapeWeight(rightEyeClose[(uint)num10]);
			if (rightEyeCloseBlendShapeValue < blendShapeWeight2)
			{
				rightEyeCloseBlendShapeValue = blendShapeWeight2;
			}
			ulong num11 = (uint)rightEyeClose.Length;
			ulong num12 = num10 + 1L;
			if ((long)(num10 + 1L) >= (long)(int)num11)
			{
				break;
			}
			num9 = num11;
			num10 = num12;
		}
	}

	private void ApplyEyebrowTransparent()
	{
		float num = leftEyeCloseBlendShapeValue;
		float num2 = rightEyeCloseBlendShapeValue;
		Material material = baseMaterial;
		int value = ((num >= 99.9f) ? 1 : 0);
		int value2 = ((num2 >= 99.9f) ? 1 : 0);
		material.SetInt(EyeShaderPropertyId.IsLeftEyeClose, value);
		highlightMaterial.SetInt(EyeShaderPropertyId.IsLeftEyeClose, value);
		eyelashMaterial.SetInt(EyeShaderPropertyId.IsLeftEyeClose, value);
		baseMaterial.SetInt(EyeShaderPropertyId.IsRightEyeClose, value2);
		highlightMaterial.SetInt(EyeShaderPropertyId.IsRightEyeClose, value2);
		eyelashMaterial.SetInt(EyeShaderPropertyId.IsRightEyeClose, value2);
	}

	private void TryGetRenderer(ref SkinnedMeshRenderer eyeRenderer)
	{
		if (eyeRenderer == null)
		{
			eyeRenderer = GetComponent<SkinnedMeshRenderer>();
		}
	}

	private void GetMaterials(SkinnedMeshRenderer renderer)
	{
		Material[] sharedMaterials = renderer.sharedMaterials;
		ulong num = (uint)sharedMaterials.Length;
		if ((int)num < 1)
		{
			return;
		}
		ulong num2 = num & 0xFFFFFFFFL;
		ulong num3 = num2;
		ulong num4 = 0uL;
		while (true)
		{
			if (num4 >= (uint)num3)
			{
				throw new IndexOutOfRangeException();
			}
			Material material = sharedMaterials[(uint)num4];
			if (!(material == null))
			{
				if (eyelashMaterial == null)
				{
					if (material.name.Contains("Eyelash"))
					{
						eyelashMaterial = material;
					}
				}
				else if ((object)material == null)
				{
					throw new NullReferenceException();
				}
				string text = material.shader.name;
				if (text == "Sekai/Live/Character/Eye-Base")
				{
					baseMaterial = material;
				}
				else if (text == "Sekai/Live/Character/Eye-Highlight")
				{
					highlightMaterial = material;
				}
			}
			ulong num5 = (uint)sharedMaterials.Length;
			ulong num6 = num4 + 1L;
			if ((long)(num4 + 1L) >= (long)(int)num5)
			{
				break;
			}
			num3 = num5;
			num4 = num6;
		}
	}

	private void ApplyTiling(SekaiEyeTiling tiling, Material material)
	{
		material.SetTextureOffset(MainTexId, ((SekaiEyeTiling)tiling).GetTileOffset());
	}

	private void ApplyTintColor()
	{
		baseMaterial.SetColor(TintColorId, tintColor);
		highlightMaterial.SetColor(TintColorId, tintColor);
	}

	private void ApplyEmissionColor()
	{
		highlightMaterial.SetColor(EmissionColorId, emissionColor);
	}

	private void ApplyLightInfluence()
	{
		baseMaterial.SetFloat(value: lightInfluenceShaderParam, nameID: LightInfluenceId);
	}

	private void ApplyLightInfluenceForHighlight()
	{
		highlightMaterial.SetFloat(value: lightInfluenceForEyeHighlightShaderParam, nameID: LightInfluenceForEyeHighlightId);
	}

	private void UpdateLightInfluenceShaderParams()
	{
		float num = lightInfluence;
		float num2 = lightInfluenceForEyeHighlight;
		lightInfluenceShaderParam = num;
		lightInfluenceForEyeHighlightShaderParam = num2;
	}

	public void Setup(IBlendShapeIndexTable blendShapeIndexTable, SetupType.Setup3DType setup3DType)
	{
		this.blendShapeIndexTable = blendShapeIndexTable;
		TryGetRenderer(ref _eyeRenderer);
		if (_eyeRenderer == null)
		{
			Debug.LogError("EyeRendererが存在しません.");
			return;
		}
		GetMaterials(_eyeRenderer);
		int num = (int)(setup3DType + 1);
		lightInfluence = 1f;
		lightInfluenceForEyeHighlight = 1f;
		if ((uint)num > 6u)
		{
			return;
		}
		uint num2 = (uint)(1 << num);
		if ((num2 & 0x4C) == 0)
		{
			if ((num2 & 0x22) != 0)
			{
				Delegate obj = Delegate.Combine(characterEyeAction, new UnityAction(UpdateLightInfluenceShaderParams));
				if ((object)obj != null)
				{
					if ((object)obj == null)
					{
						throw new NullReferenceException();
					}
					if (!(obj is UnityAction))
					{
						throw new InvalidCastException();
					}
					UnityAction unityAction = (characterEyeAction = obj as UnityAction);
					if (unityAction == null)
					{
						throw new NullReferenceException();
					}
					if (unityAction == null)
					{
						throw new InvalidCastException();
					}
				}
				else
				{
					characterEyeAction = null;
				}
			}
			else if (num == 0)
			{
				Debug.LogWarning("SetupTypeが定義されていないため, 瞳の明るさパラメータ(LightInfluence)を更新しません.");
			}
		}
		else
		{
			Debug.LogWarning($"{setup3DType}では瞳の明るさパラメータ(LightInfluence)を更新しません.");
		}
	}
}

}
