// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core/CharacterModel.cs；仅保留抽卡调用链，改动见 docs/重建问题记录.md。
using System;
using System.Diagnostics;
using Debug = UnityEngine.Debug;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using UnityEngine;
using UnityEngine.Events;
using Sekai.Rendering;
using Sekai.Rendering.Setup3DUtility;
using Sekai.Scripts.Live.Common;
namespace Sekai.Core {
public sealed class CharacterModel : MonoBehaviour {
 public int formationId;
 int _rendererFormationId, _stencilFormationId=-1;
 [SerializeField] Color defaultSkinColor,shadow1SkinColor,shadow2SkinColor;
 Renderer[] renderers;
 Transform headTransform,_directionalLightTransform;
 SekaiCharacterDirectionalLight _characterDirectionalLightData;
 UnityAction characterAction;
 readonly RendererBufferCacheTable rendererBufferTable=new RendererBufferCacheTable();
 public int CharacterDataId { get; private set; }
 public float Height { get; private set; }
 public Transform PositionNote { get; private set; }
 public GameObject Face { get; private set; }
 public GameObject Body { get; private set; }
 public GameObject Hair { get; private set; }
 public GameObject Hip { get; private set; }
 public GameObject Neck { get; private set; }
 void LateUpdate() { characterAction?.Invoke(); }
private class RendererBufferCacheTable
		{
			public RendererBufferCache[] RendererBufferCaches { get; private set; }

			public RendererBufferCache Face { get; private set; }

			public RendererBufferCache Body { get; private set; }

			public RendererBufferCache Hair { get; private set; }

			public RendererBufferCache Acc { get; private set; }

			public void Rebuild(Renderer[] renderers)
			{
				RendererBufferCaches = new RendererBufferCache[renderers.Length];
				int num = renderers.Length;
				if (num < 1)
				{
					return;
				}
				int num2 = 0;
				long num3 = 0L;
				while (true)
				{
					if ((uint)num2 >= (uint)num)
					{
						throw new IndexOutOfRangeException();
					}
					Renderer renderer = renderers[(nint)num3];
					RendererBufferCache rendererBufferCache = new RendererBufferCache(renderer);
					RendererBufferCache[] array = RendererBufferCaches;
					if (array == null)
					{
						throw new NullReferenceException();
					}
					if (rendererBufferCache != null)
					{
						object obj = rendererBufferCache;
						if (((!array.GetType().GetElementType().IsInstanceOfType(obj)) ? null : obj) == null)
						{
							throw new ArrayTypeMismatchException();
						}
					}
					if ((uint)num2 >= (uint)array.Length)
					{
						throw new IndexOutOfRangeException();
					}
					array[(nint)num3] = rendererBufferCache;
					switch (renderer.gameObject.name)
					{
					case "Acc":
						Acc = rendererBufferCache;
						break;
					case "Hair":
						Hair = rendererBufferCache;
						break;
					case "Body":
						Body = rendererBufferCache;
						break;
					case "Face":
						Face = rendererBufferCache;
						break;
					}
					num = renderers.Length;
					if (num2 + 1 >= num)
					{
						break;
					}
					num2++;
					num3++;
				}
			}

			public void Release()
			{
				RendererBufferCache[] array = RendererBufferCaches;
				if (array == null)
				{
					return;
				}
				if (array.Length >= 1)
				{
					long num = 0L;
					int num2 = 0;
					while (true)
					{
						array[(nint)num].Release();
						if (num2 + 1 >= array.Length)
						{
							break;
						}
						num++;
						num2++;
					}
				}
				RendererBufferCaches = null;
				Face?.Release();
				Body?.Release();
				Hair?.Release();
				Face = null;
				Body = null;
				Hair = null;
			}
		}

private class RendererBufferCache
		{
			public Renderer renderer { get; private set; }

			public MaterialData[] MaterialDatas { get; private set; }

			public RendererBufferCache(Renderer r)
			{
				renderer = r;
				MaterialDatas = new MaterialData[r.sharedMaterials.Length];
				MaterialData[] array = MaterialDatas;
				long num = 4L;
				while (true)
				{
					if (num + -4L >= array.Length)
					{
						return;
					}
					MaterialData materialData = new MaterialData(r.sharedMaterials[(nint)(num + -4L)]);
					if (materialData != null)
					{
						object obj = materialData;
						if (((!array.GetType().GetElementType().IsInstanceOfType(obj)) ? null : obj) == null)
						{
							throw new ArrayTypeMismatchException();
						}
					}
					array[(nint)(num + -4L)] = materialData;
					array = MaterialDatas;
					if (array == null)
					{
						break;
					}
					num++;
				}
				throw new NullReferenceException();
			}

			[Conditional("SEKAI_DEBUG")]
			private void OverrideShader(Material[] materials)
			{
				if (materials == null)
				{
					throw new NullReferenceException();
				}
			}

			[Conditional("SEKAI_DEBUG")]
			private void OverrideShader(Material material)
			{
				if (!(material == null) && !(material.shader == null))
				{
					Shader shader = LoadShader(material.shader.name);
					if (shader != null)
					{
						int renderQueue = material.renderQueue;
						material.shader = shader;
						material.renderQueue = renderQueue;
					}
				}
			}

			private static Shader LoadShader(string shaderName)
			{
				Shader shader = Shader.Find(shaderName);
				if (shader == null)
				{
					Debug.LogError("アプリ内シェーダーのロードに失敗しました: shaderName=" + shaderName);
				}
				return shader;
			}

			public void Release()
			{
				renderer = null;
				MaterialData[] array = MaterialDatas;
				if (array == null)
				{
					return;
				}
				if (array.Length >= 1)
				{
					long num = 0L;
					int num2 = 0;
					while (true)
					{
						array[(nint)num].Release();
						if (num2 + 1 >= array.Length)
						{
							break;
						}
						num++;
						num2++;
					}
					MaterialDatas = null;
				}
				else
				{
					MaterialDatas = null;
				}
			}

			public Material[] GetFaceMaterials(Material[] materials, int indexA, int indexB)
			{
				int num = materials.Length;
				if (num >= 1)
				{
					int num2 = 0;
					while (true)
					{
						if ((uint)indexA >> 31 << 31 == 0 && num > indexB && (uint)indexB >> 31 << 31 == 0 && num > indexA)
						{
							if ((uint)indexB >= (uint)num)
							{
								throw new IndexOutOfRangeException();
							}
							if ((uint)indexA >= (uint)num)
							{
								throw new IndexOutOfRangeException();
							}
							Material material = materials[indexB];
							Material material2 = materials[indexA];
							if ((object)material != null)
							{
								object obj = material;
								if (((!materials.GetType().GetElementType().IsInstanceOfType(obj)) ? null : obj) == null)
								{
									throw new ArrayTypeMismatchException();
								}
							}
							materials[indexA] = material;
							if ((object)material2 != null)
							{
								object obj2 = material2;
								if (((!materials.GetType().GetElementType().IsInstanceOfType(obj2)) ? null : obj2) == null)
								{
									throw new ArrayTypeMismatchException();
								}
							}
							materials[indexB] = material2;
						}
						num = materials.Length;
						if (num2 + 1 >= num)
						{
							break;
						}
						num2++;
					}
					return materials;
				}
				return materials;
			}
		}

private class MaterialData
		{
			public readonly CharacterMaterialType Type;

			public Material SharedMaterial { get; private set; }

			public MaterialData(Material material)
			{
				SharedMaterial = material;
				Type = SetMaterialType(material);
			}

			private CharacterMaterialType SetMaterialType(Material material)
			{
				string text = material.name.ToLower();
				switch (text)
				{
				case "mtl_chr_00":
					return CharacterMaterialType.Face;
				case "mtl_chr_eye_00":
					return CharacterMaterialType.Eye;
				case "mtl_chr_eyebrow_00":
					return CharacterMaterialType.Eyebrow;
				case "mtl_chr_eyelash_00":
					return CharacterMaterialType.Eyelash;
				case "mtl_chr_ehl_00":
					return CharacterMaterialType.EyeHighlight;
				case "mtl_chr_hair_00":
					return CharacterMaterialType.Hair;
				default:
					if (Regex.IsMatch(text, "mtl_bdy_[0-9]+"))
					{
						return CharacterMaterialType.Body;
					}
					return (!Regex.IsMatch(text, "mtl_chr_acc_[0-9]+")) ? CharacterMaterialType.Other : CharacterMaterialType.Acc;
				}
			}

			public void Release()
			{
				SharedMaterial = null;
			}
		}

public class BlendShapeIndexTable : IBlendShapeIndexTable
		{
			public int[] LeftEyeClose { get; }

			public int[] RightEyeClose { get; }

			public BlendShapeIndexTable(CharacterSettings settings, Mesh mesh)
			{
				int[] array;
				if (mesh == null)
				{
					LeftEyeClose = new int[0];
					array = new int[0];
				}
				else
				{
					LeftEyeClose = (from data in settings.LeftCloseEyeBlendShapeNames
						select data.DeformerName + "." + data.TargetShapeName into name
						select mesh.GetBlendShapeIndex(name)).ToArray();
					array = (from data in settings.RightCloseEyeBlendShapeNames
						select data.DeformerName + "." + data.TargetShapeName into name
						select mesh.GetBlendShapeIndex(name)).ToArray();
				}
				RightEyeClose = array;
			}
		}

public void GachaModelSetup(int characterId, float height, CharacterLightData lightData, Color[] skinColors)
		{
			CharacterDataId = characterId;
			Transform transform = base.transform.GetComponentsInChildren<Transform>().FirstOrDefault((Transform transform3) => transform3.name == "Position");
			if ((object)transform == null)
			{
				transform = base.transform;
			}
			PositionNote = transform;
			Transform transform2 = PositionNote;
			float y = Vector3.one.y;
			float z = Vector3.one.z;
			float x = Vector3.one.x;
			transform2.localScale = new Vector3
			{
				x = x * height,
				y = y * height,
				z = z * height
			};
			Height = height;
			renderers = gameObject.GetComponentsInChildren<Renderer>();
            rendererBufferTable.Rebuild(renderers);
			Face = GetComponentsInChildren<Transform>(true).FirstOrDefault(t => t.name == "Face")?.gameObject;
			Body = GetComponentsInChildren<Transform>(true).FirstOrDefault(t => t.name == "Body")?.gameObject;
			Hair = GetComponentsInChildren<Transform>(true).FirstOrDefault(t => t.name == "Hair")?.gameObject;
			Hip = GetComponentsInChildren<Transform>(true).FirstOrDefault(t => t.name == "Hip")?.gameObject;
			Neck = GetComponentsInChildren<Transform>(true).FirstOrDefault(t => t.name == "Neck")?.gameObject;
			SetupRenderQueueAndStencil(rendererBufferTable, _rendererFormationId);
			if (lightData != null)
			{
				_directionalLightTransform = lightData.DirectionalLight.transform;
				_characterDirectionalLightData = lightData.DirectionalLight.CharacterDirectionalLightData;
			}
			if (_directionalLightTransform != null && _characterDirectionalLightData != null && characterAction == null)
			{
				Delegate obj = Delegate.Combine(null, new UnityAction(SetupFaceShadowAction));
				if ((object)obj != null)
				{
					if (!(obj is UnityAction))
					{
						throw new InvalidCastException();
					}
					characterAction = obj as UnityAction;
					if (!(obj is UnityAction))
					{
						throw new InvalidCastException();
					}
				}
				else
				{
					characterAction = null;
				}
			}
			SetupCharacterSettings();
			
			SetupDitherTexture(renderers);
			SetupHeadTransform();
			if (!(skinColors == null || skinColors.Length == 0))
			{
				int num = skinColors.Length;
				switch (num)
				{
				case 0:
					throw new IndexOutOfRangeException();
				case 1:
					throw new IndexOutOfRangeException();
				}
				if (2u >= (uint)num)
				{
					throw new IndexOutOfRangeException();
				}
				SetupSkin(skinColors[0], skinColors[1], skinColors[2]);
			}
			name = "CharacterModel";
		}

private void RebuildMaterialCache()
		{
			renderers = gameObject.GetComponentsInChildren<Renderer>();
			rendererBufferTable.Rebuild(renderers);
		}

private void SetupRenderQueueAndStencil(RendererBufferCacheTable bufferCacheTable, int formationId)
		{
			RendererBufferCache[] rendererBufferCaches = bufferCacheTable.RendererBufferCaches;
			if (rendererBufferCaches.Length < 1)
			{
				return;
			}
			long num = 0L;
			int num2 = 0;
			while (true)
			{
				MaterialData[] materialDatas = rendererBufferCaches[(nint)num].MaterialDatas;
				if (materialDatas.Length >= 1)
				{
					long num3 = 0L;
					while (true)
					{
						SetStencil(materialDatas[(nint)num3], formationId);
						if (num3 + 1L >= materialDatas.Length)
						{
							break;
						}
						num3++;
					}
				}
				if (num2 + 1 >= rendererBufferCaches.Length)
				{
					break;
				}
				num = (uint)(num2 + 1);
				num2++;
			}
		}

private void SetStencil(MaterialData materialData, int formationId)
		{
			int stencilFormationId = _stencilFormationId;
			CharacterMaterialType type = materialData.Type;
			Material sharedMaterial = materialData.SharedMaterial;
			CharacterMaterialData characterMaterialData = CharacterStencilDataFactory.Create(type, (stencilFormationId < 0) ? formationId : stencilFormationId);
			sharedMaterial.renderQueue = (int)characterMaterialData.RenderQueue;
			SetBaseStencil(sharedMaterial, characterMaterialData.BaseStencil);
			SetOverlayStencil(sharedMaterial, characterMaterialData.OverlayStencil);
		}

private static void SetBaseStencil(Material material, CharacterStencilData data)
		{
			material.SetInt(ShaderPropertyID.CharacterModelShaderPropertyId.Stencil, (int)data.StencilRef);
			material.SetInt(ShaderPropertyID.CharacterModelShaderPropertyId.ReadMask, (int)data.ReadMask);
			material.SetInt(ShaderPropertyID.CharacterModelShaderPropertyId.WriteMask, (int)data.WriteMask);
			material.SetInt(ShaderPropertyID.CharacterModelShaderPropertyId.StencilComp, (int)data.Comp);
			material.SetInt(ShaderPropertyID.CharacterModelShaderPropertyId.StencilOp, (int)data.Pass);
			material.SetInt(ShaderPropertyID.CharacterModelShaderPropertyId.StencilFail, (int)data.Fail);
			material.SetInt(ShaderPropertyID.CharacterModelShaderPropertyId.StencilZFail, (int)data.ZFail);
		}

private static void SetOverlayStencil(Material material, CharacterStencilData data)
		{
			material.SetInt(ShaderPropertyID.CharacterModelShaderPropertyId.EyelashStencil, (int)data.StencilRef);
			material.SetInt(ShaderPropertyID.CharacterModelShaderPropertyId.EyelashReadMask, (int)data.ReadMask);
			material.SetInt(ShaderPropertyID.CharacterModelShaderPropertyId.EyelashWriteMask, (int)data.WriteMask);
			material.SetInt(ShaderPropertyID.CharacterModelShaderPropertyId.EyelashStencilComp, (int)data.Comp);
			material.SetInt(ShaderPropertyID.CharacterModelShaderPropertyId.EyelashStencilOp, (int)data.Pass);
			material.SetInt(ShaderPropertyID.CharacterModelShaderPropertyId.EyelashStencilFail, (int)data.Fail);
			material.SetInt(ShaderPropertyID.CharacterModelShaderPropertyId.EyelashStencilZFail, (int)data.ZFail);
		}

private void SetupCharacterSettings()
		{
			SkinnedMeshRenderer component = Face.GetComponent<SkinnedMeshRenderer>();
			if (component == null)
			{
				Debug.LogError("Face に SkinnedMeshRenerer がアタッチされていません", gameObject);
			}
			SekaiCharacterEye component2 = Face.GetComponent<SekaiCharacterEye>();
			if (component2 == null)
			{
				Debug.LogError("Face に SekaiCharacterEye がアタッチされていません", gameObject);
			}
			if (component.sharedMesh == null)
			{
				Debug.LogError("faceRendererのmeshがnullです");
			}
			if (component != null && component2 != null)
			{
				Mesh sharedMesh = component.sharedMesh;
				CharacterSettings characterSettings = Resources.Load<CharacterSettings>($"CharacterSettings/{CharacterDataId:D2}");
				if (characterSettings != null)
				{
					component2.Setup(new BlendShapeIndexTable(characterSettings, sharedMesh), SetupType.Setup3DType.None);
				}
				else
				{
					Debug.LogError($"CharacterSettingsのロードに失敗しました。 characterId={CharacterDataId}", gameObject);
				}
			}
		}

private void SetupHeadTransform()
		{
			headTransform = gameObject.GetComponentInChildren<SkinnedMeshRenderer>().rootBone.GetComponentsInChildren<Transform>(true).First(t => t.name == "Head");
		}

public void SetupHairShadow(bool useHairShadow)
		{
			SekaiCharacterHair componentInChildren = gameObject.GetComponentInChildren<SekaiCharacterHair>();
			if (componentInChildren == null)
			{
				Debug.LogWarning("SekaiCharacterHairがアタッチされたHairオブジェクトが存在しません gameObject.name=" + gameObject.name);
				return;
			}
			if (headTransform != null)
			{
				componentInChildren.Setup(headTransform, useHairShadow);
			}
			if (!useHairShadow)
			{
				return;
			}
			Delegate obj = Delegate.Combine(characterAction, new UnityAction(componentInChildren.OnUpdate));
			if ((object)obj != null)
			{
				if (!(obj is UnityAction))
				{
					throw new InvalidCastException();
				}
				characterAction = obj as UnityAction;
				if (!(obj is UnityAction))
				{
					throw new InvalidCastException();
				}
			}
			else
			{
				characterAction = null;
			}
		}

private void SetupSkin(Color defaultSkinColor, Color shadow1SkinColor, Color shadow2SkinColor)
		{
			this.defaultSkinColor = defaultSkinColor;
			this.shadow1SkinColor = shadow1SkinColor;
			this.shadow2SkinColor = shadow2SkinColor;
			UpdateSkinColor();
		}

private void SetupFaceShadowAction()
		{
			Vector3 up = headTransform.up;
			float num2;
			float num3;
			if ((float)Math.Sqrt(up.x * up.x + up.z * up.z) > 1E-05f)
			{
				float num = -up.x / (float)Math.Sqrt(up.x * up.x + up.z * up.z);
				num2 = -up.z / (float)Math.Sqrt(up.x * up.x + up.z * up.z);
				num3 = num;
			}
			else
			{
				num3 = Vector2.zero.x;
				num2 = Vector2.zero.y;
			}
			Vector3 vector = headTransform.rotation.eulerAngles;
			Vector3 vector2 = vector;
			Vector3 forward = _directionalLightTransform.forward;
			float num5;
			float num6;
			if ((float)Math.Sqrt(forward.x * forward.x + forward.z * forward.z) > 1E-05f)
			{
				float num4 = forward.x / (float)Math.Sqrt(forward.x * forward.x + forward.z * forward.z);
				num5 = forward.z / (float)Math.Sqrt(forward.x * forward.x + forward.z * forward.z);
				num6 = num4;
			}
			else
			{
				num6 = Vector2.zero.x;
				num5 = Vector2.zero.y;
			}
			Vector3 vector3 = _directionalLightTransform.rotation.eulerAngles;
			Vector3 vector4 = vector3;
			foreach (Material item in rendererBufferTable.Face.MaterialDatas.Select((MaterialData data) => data.SharedMaterial))
			{
				if (_characterDirectionalLightData.UseFaceShadowLimiter)
				{
					item.EnableKeyword("_FACE_SHADOW_RANGE_LIMIT");
				}
				else
				{
					item.DisableKeyword("_FACE_SHADOW_RANGE_LIMIT");
				}
				item.SetFloat(value: _characterDirectionalLightData.FaceShadowLimitRange, nameID: ShaderPropertyID.CharacterModelShaderPropertyId.RangeLimit);
				item.SetVector(ShaderPropertyID.CharacterModelShaderPropertyId.SekaiCharacterHeadDotDirectionalLight, new Vector4
				{
					x = num3 * num6 + num2 * num5,
					y = Math.Abs(Math.Abs(vector4.y - vector2.y) + -180f) / -180f + 1f
				});
			}
		}

private void SetupDitherTexture(Renderer[] targetRenderers)
		{
			if (targetRenderers == null || targetRenderers.Length == 0)
			{
				return;
			}
			Texture2D value = Resources.Load<Texture2D>("Core/VirtualLive/Avatar/BayerMatrix");
			if (targetRenderers.Length < 1)
			{
				return;
			}
			long num = 0L;
			int num2 = 0;
			while (true)
			{
				Material[] sharedMaterials = targetRenderers[(nint)num].sharedMaterials;
				if (sharedMaterials.Length >= 1)
				{
					long num3 = 0L;
					int num4 = 0;
					while (true)
					{
						sharedMaterials[(nint)num3].SetTexture(ShaderPropertyID.DITHER_TEX_ID, value);
						if (num4 + 1 >= sharedMaterials.Length)
						{
							break;
						}
						num3 = (uint)(num4 + 1);
						num4++;
					}
				}
				if (num2 + 1 >= targetRenderers.Length)
				{
					break;
				}
				num = (uint)(num2 + 1);
				num2++;
			}
		}

private void UpdateSkinColor()
		{
			if ((rendererBufferTable.RendererBufferCaches == null || rendererBufferTable.RendererBufferCaches.Length == 0))
			{
				return;
			}
			RendererBufferCache[] rendererBufferCaches = rendererBufferTable.RendererBufferCaches;
			if (rendererBufferCaches.Length < 1)
			{
				return;
			}
			long num = 0L;
			int num2 = 0;
			while (true)
			{
				foreach (Material item in rendererBufferCaches[(nint)num].MaterialDatas.Select((MaterialData data) => data.SharedMaterial))
				{
					item.SetColor(ShaderPropertyID.CharacterModelShaderPropertyId.DefaultSkinColor, defaultSkinColor);
					item.SetColor(ShaderPropertyID.CharacterModelShaderPropertyId.Shadow1SkinColor, shadow1SkinColor);
					item.SetColor(ShaderPropertyID.CharacterModelShaderPropertyId.Shadow2SkinColor, shadow2SkinColor);
				}
				if (num2 + 1 >= rendererBufferCaches.Length)
				{
					break;
				}
				num = (uint)(num2 + 1);
				num2++;
			}
		}

private void UpdateFormation()
		{
			if ((rendererBufferTable.RendererBufferCaches == null || rendererBufferTable.RendererBufferCaches.Length == 0))
			{
				return;
			}
			RendererBufferCache[] rendererBufferCaches = rendererBufferTable.RendererBufferCaches;
			if (rendererBufferCaches.Length >= 1)
			{
				long num = 0L;
				int num2 = 0;
				while (true)
				{
					using (IEnumerator<Material> enumerator = rendererBufferCaches[(nint)num].MaterialDatas.Select((MaterialData data) => data.SharedMaterial).GetEnumerator())
					{
						while (enumerator.MoveNext())
						{
							enumerator.Current.SetInt(ShaderPropertyID.CHARACTER_ID, _rendererFormationId);
						}
					}
					if (num2 + 1 >= rendererBufferCaches.Length)
					{
						break;
					}
					num = (uint)(num2 + 1);
					num2++;
				}
			}
			SetupRenderQueueAndStencil(rendererBufferTable, _rendererFormationId);
		}

private void OnDestroy()
		{
			rendererBufferTable.Release();
		}
}}
