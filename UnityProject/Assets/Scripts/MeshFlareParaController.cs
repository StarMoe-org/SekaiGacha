// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core/MeshFlareParaController.cs。
using System;
using System.Collections.Generic;

using Sekai.Core.Live;

using UnityEngine;

namespace Sekai.Core
{
	[ExecuteInEditMode]
	[DefaultExecutionOrder(1)]
	public class MeshFlareParaController : MonoBehaviour
	{
		private static readonly float DISTANCE = 0.1f;

		private List<Material> _materials;

		private Camera _targetCamera;

		[SerializeField]
		private List<GameObject> _meshFlareParaObject;

		private bool[] _dirty;

		private Vector3[] _pos;

		private Vector2[] _scaleXY;

		private bool[] _zTest;

		private readonly int FLARE_PARA_COUNT = 3;

		private readonly float PARAMETER_POSITION_WEIGHT = 0.01f;

		private readonly float PARAMETER_SCALE_WEIGHT = 0.1f;

		private readonly string MULTIPLY_BLEND_SHADER_KEYWORD = "_MULTIPLY_BLEND";

		private readonly string SHADER_NAME = "Sekai/Live/MeshFlarePara";

		private readonly float ZERO_VALUE_THRESHOLD = 0.001f;

		public void Setup(Camera targetCamera, Texture2D[] texture2Ds)
		{
			_dirty = new bool[FLARE_PARA_COUNT];
			_pos = new Vector3[FLARE_PARA_COUNT];
			_scaleXY = new Vector2[FLARE_PARA_COUNT];
			_zTest = new bool[FLARE_PARA_COUNT];
			_targetCamera = targetCamera;
			SetupParentTransform();
			_materials = new List<Material>();
			if (FLARE_PARA_COUNT < 1)
			{
				return;
			}
			long num = 0L;
			int num2 = 0;
			int num3 = 3000;
			while (true)
			{
				Texture2D texture2D = texture2Ds[(nint)num];
				if (texture2D == null)
				{
					Debug.LogError($"index = {num2}のMeshFlarePara用テクスチャが存在しません.");
				}
				Material material = new Material(Shader.Find(SHADER_NAME));
				material.renderQueue = num3 + FLARE_PARA_COUNT;
				material.SetTexture(ShaderPropertyID.MESH_FLARE_PARA_TEX_ID, texture2D);
				_materials.Add(material);
				_meshFlareParaObject[num2].GetComponent<MeshRenderer>().sharedMaterial = _materials[num2];
				SetupMeshTransform(_meshFlareParaObject[num2]);
				_meshFlareParaObject[num2].SetActive(value: false);
				if (num + 1L >= FLARE_PARA_COUNT)
				{
					break;
				}
				num++;
				num2++;
				num3 += -1;
			}
		}

		private void SetupParentTransform()
		{
			transform.SetParent(_targetCamera.transform);
			transform.localPosition = Vector3.forward;
			transform.localEulerAngles = Vector3.zero;
			transform.localScale = Vector3.one;
		}

		private void SetupMeshTransform(GameObject gameObject)
		{
			gameObject.transform.SetParent(base.transform);
			float num = Mathf.Tan(_targetCamera.fieldOfView * 0.5f * ((float)3.141592653589793 / 180f));
			Transform transform = gameObject.transform;
			float x = Vector3.forward.x;
			float y = Vector3.forward.y;
			float z = Vector3.forward.z;
			float dISTANCE = DISTANCE;
			transform.localPosition = new Vector3
			{
				x = x * dISTANCE,
				y = y * dISTANCE,
				z = z * dISTANCE
			};
			gameObject.transform.localScale = new Vector3
			{
				x = num * 0.2f,
				y = num * 0.2f,
				z = num * 0.2f
			};
			gameObject.transform.localEulerAngles = default;
		}

		public void SetBlendModePropertyBlock(int order, MeshFlareParaClip.MeshBlendMode meshFlareParaBlendMode)
		{
			if (!(_materials[order] == null))
			{
				int value;
				int value2;
				if ((uint)meshFlareParaBlendMode <= 5u)
				{
					int num = meshFlareParaBlendMode switch
					{
						MeshFlareParaClip.MeshBlendMode.Overwrite => 1, 
						MeshFlareParaClip.MeshBlendMode.Add => 1, 
						MeshFlareParaClip.MeshBlendMode.TransparentAdd => 5, 
						MeshFlareParaClip.MeshBlendMode.AlphaBlend => 5, 
						_ => 2, 
					};
					value = meshFlareParaBlendMode switch
					{
						MeshFlareParaClip.MeshBlendMode.Overwrite => 0, 
						MeshFlareParaClip.MeshBlendMode.Add => 1, 
						MeshFlareParaClip.MeshBlendMode.TransparentAdd => 1, 
						MeshFlareParaClip.MeshBlendMode.AlphaBlend => 10, 
						MeshFlareParaClip.MeshBlendMode.Multiply => 0, 
						_ => 2, 
					};
					value2 = num;
				}
				else
				{
					value2 = 5;
					value = 1;
				}
				_materials[order].SetInt(ShaderPropertyID.MESH_FLARE_PARA_BLEND_SRC_ID, value2);
				_materials[order].SetInt(ShaderPropertyID.MESH_FLARE_PARA_BLEND_DST_ID, value);
			}
		}

		public void SetMultiBlendShaderKeyword(int order, bool enable)
		{
			if (!(_materials[order] == null))
			{
				Material material = _materials[order];
				string mULTIPLY_BLEND_SHADER_KEYWORD = MULTIPLY_BLEND_SHADER_KEYWORD;
				if (enable)
				{
					material.EnableKeyword(mULTIPLY_BLEND_SHADER_KEYWORD);
				}
				else
				{
					material.DisableKeyword(mULTIPLY_BLEND_SHADER_KEYWORD);
				}
			}
		}

		public void SetColorPropertyBlock(int order, Color color)
		{
			if (!(_materials[order] == null))
			{
				float zERO_VALUE_THRESHOLD = ZERO_VALUE_THRESHOLD;
				_materials[order].SetColor(ShaderPropertyID.MESH_FLARE_PARA_COLOR_ID, new Color
				{
					r = ((!(color.r < zERO_VALUE_THRESHOLD)) ? color.r : 0f),
					g = ((!(color.g < zERO_VALUE_THRESHOLD)) ? color.g : 0f),
					b = ((!(color.b < zERO_VALUE_THRESHOLD)) ? color.b : 0f),
					a = ((!(color.a < zERO_VALUE_THRESHOLD)) ? color.a : 0f)
				});
			}
		}

		public void SetPositionAndScaleParams(int order, Vector3 position, Vector2 scaleXY, bool zTest)
		{
			_dirty[order] = true;
			_pos[order] = position;
			_scaleXY[order] = scaleXY;
			_zTest[order] = zTest;
		}

		public void SetActiveObj(int order, bool isActive)
		{
			if (!(_meshFlareParaObject[order] == null))
			{
				_meshFlareParaObject[order].SetActive(isActive);
			}
		}

		public void SetTheta(int order, float theta)
		{
			if (!(_meshFlareParaObject[order] == null))
			{
				_meshFlareParaObject[order].transform.localRotation = Quaternion.AngleAxis(theta, Vector3.forward);
			}
		}

		public void SetZTest(int order, bool zTest)
		{
			if (!(_materials[order] == null))
			{
				_materials[order].SetFloat(ShaderPropertyID.MESH_FLARE_PARA_ZTEST_ID, (!zTest) ? 8f : 4f);
			}
		}

		public void SetTiling(int order, Vector2 tiling)
		{
			if (!(_materials[order] == null))
			{
				_materials[order].SetTextureScale(ShaderPropertyID.MESH_FLARE_PARA_TEX_ID, tiling);
			}
		}

		public void ResetPositionAndScale(int order)
		{
			if (!(_meshFlareParaObject[order] == null))
			{
				Transform transform = _meshFlareParaObject[order].transform;
				float x = Vector3.forward.x;
				float y = Vector3.forward.y;
				float z = Vector3.forward.z;
				float dISTANCE = DISTANCE;
				transform.position = new Vector3
				{
					x = x * dISTANCE,
					y = y * dISTANCE,
					z = z * dISTANCE
				};
				_meshFlareParaObject[order].transform.localScale = Vector3.zero;
			}
		}

		public bool GetIsActiveObj(int order)
		{
			if (_meshFlareParaObject[order] == null)
			{
				return false;
			}
			return _meshFlareParaObject[order].activeSelf;
		}

		public void Unload()
		{
			if (!(_materials == null || _materials.Count == 0))
			{
				List<Material> materials = _materials;
				int num = 0;
				while (num < materials.Count)
				{
					UnityEngine.Object.Destroy(materials[num]);
					_materials[num] = null;
					materials = _materials;
					if (materials != null)
					{
						num++;
						continue;
					}
					throw new NullReferenceException();
				}
			}
			if ((_meshFlareParaObject == null || _meshFlareParaObject.Count == 0))
			{
				return;
			}
			List<GameObject> meshFlareParaObject = _meshFlareParaObject;
			int num2 = 0;
			while (true)
			{
				if (num2 >= meshFlareParaObject.Count)
				{
					return;
				}
				UnityEngine.Object.Destroy(meshFlareParaObject[num2]);
				_meshFlareParaObject[num2] = null;
				meshFlareParaObject = _meshFlareParaObject;
				if (meshFlareParaObject == null)
				{
					break;
				}
				num2++;
			}
			throw new NullReferenceException();
		}

		private Vector2Int GetShaderBlendMode(MeshFlareParaClip.MeshBlendMode meshFlareParaBlendMode)
		{
			uint num4;
			uint num5;
			uint num6;
			uint num7;
			if ((uint)meshFlareParaBlendMode <= 5u)
			{
				uint num = (uint)((meshFlareParaBlendMode switch
				{
					MeshFlareParaClip.MeshBlendMode.Overwrite => 1L, 
					MeshFlareParaClip.MeshBlendMode.Add => 1L, 
					MeshFlareParaClip.MeshBlendMode.TransparentAdd => 5L, 
					MeshFlareParaClip.MeshBlendMode.AlphaBlend => 5L, 
					_ => 2L, 
				}) & 0xFFFFFFFFL);
				uint num2 = (uint)((meshFlareParaBlendMode switch
				{
					MeshFlareParaClip.MeshBlendMode.Overwrite => 0L, 
					MeshFlareParaClip.MeshBlendMode.Add => 4294967296L, 
					MeshFlareParaClip.MeshBlendMode.TransparentAdd => 4294967296L, 
					MeshFlareParaClip.MeshBlendMode.AlphaBlend => 42949672960L, 
					MeshFlareParaClip.MeshBlendMode.Multiply => 0L, 
					_ => 8589934592L, 
				}) & 0xFFFFFFFFL);
				uint num3 = (uint)((ulong)(meshFlareParaBlendMode switch
				{
					MeshFlareParaClip.MeshBlendMode.Overwrite => 1L, 
					MeshFlareParaClip.MeshBlendMode.Add => 1L, 
					MeshFlareParaClip.MeshBlendMode.TransparentAdd => 5L, 
					MeshFlareParaClip.MeshBlendMode.AlphaBlend => 5L, 
					_ => 2L, 
				}) >> 32);
				num4 = (uint)((ulong)(meshFlareParaBlendMode switch
				{
					MeshFlareParaClip.MeshBlendMode.Overwrite => 0L, 
					MeshFlareParaClip.MeshBlendMode.Add => 4294967296L, 
					MeshFlareParaClip.MeshBlendMode.TransparentAdd => 4294967296L, 
					MeshFlareParaClip.MeshBlendMode.AlphaBlend => 42949672960L, 
					MeshFlareParaClip.MeshBlendMode.Multiply => 0L, 
					_ => 8589934592L, 
				}) >> 32);
				num5 = num3;
				num6 = num2;
				num7 = num;
			}
			else
			{
				num7 = 5u;
				num6 = 0u;
				num5 = 0u;
				num4 = 1u;
			}
			return new Vector2Int((int)(num7 | num6), (int)(num5 | num4));
		}

		private void UpdatePositionAndScale()
		{
			float fieldOfView = _targetCamera.fieldOfView;
			float dISTANCE = DISTANCE;
			float num = Mathf.Tan(fieldOfView * 0.5f * ((float)3.141592653589793 / 180f));
			int width = Screen.width;
			int height = Screen.height;
			int fLARE_PARA_COUNT = FLARE_PARA_COUNT;
			if (fLARE_PARA_COUNT < 1)
			{
				return;
			}
			bool[] dirty = _dirty;
			long num2 = 0L;
			long num3 = 0L;
			int num4 = 0;
			long num5 = 0L;
			while (true)
			{
				if (dirty[(nint)num2])
				{
					bool[] zTest = _zTest;
					float reference;
					if (zTest[(nint)num2])
					{
						Vector3[] pos = _pos;
						if ((uint)num2 >= (uint)pos.Length)
						{
							throw new IndexOutOfRangeException();
						}
						reference = pos[(nint)num3].z;
					}
					else
					{
						zTest = _zTest;
						reference = DISTANCE;
					}
					float x;
					float y;
					float z;
					if (zTest[(nint)num2])
					{
						Vector3[] pos2 = _pos;
						if ((uint)num2 >= (uint)pos2.Length)
						{
							throw new IndexOutOfRangeException();
						}
						x = pos2[(nint)num3].x;
						y = pos2[(nint)num3].y;
						z = pos2[(nint)num3].z;
					}
					else
					{
						Camera targetCamera = _targetCamera;
						float distance = reference;
						Transform transform = targetCamera.transform;
						Vector3[] pos3 = _pos;
						if ((uint)num2 >= (uint)pos3.Length)
						{
							throw new IndexOutOfRangeException();
						}
						float pARAMETER_POSITION_WEIGHT = PARAMETER_POSITION_WEIGHT;
						float x2 = pos3[(nint)num3].x;
						float y2 = pos3[(nint)num3].y;
						Vector3 vector = ScreenToWorldPoint(nearClipPlane: targetCamera.nearClipPlane, farClipPlane: targetCamera.farClipPlane, position: transform.position, rotation: transform.rotation, screenPosition: new Vector2
						{
							x = x2 * (float)width * pARAMETER_POSITION_WEIGHT,
							y = pARAMETER_POSITION_WEIGHT * (y2 * (float)height)
						}, fov: fieldOfView, width: width, height: height, distance: distance);
						float x3 = vector.x;
						float y3 = vector.y;
						z = vector.z;
						y = y3;
						x = x3;
					}
					_meshFlareParaObject[num4].transform.position = new Vector3
					{
						x = x,
						y = y,
						z = z
					};
					Transform transform2 = _meshFlareParaObject[num4].transform;
					Vector2[] scaleXY = _scaleXY;
					if ((uint)num2 >= (uint)scaleXY.Length)
					{
						throw new IndexOutOfRangeException();
					}
					if ((object)transform2 == null)
					{
						throw new NullReferenceException();
					}
					float pARAMETER_SCALE_WEIGHT = PARAMETER_SCALE_WEIGHT;
					float x4 = scaleXY[(nint)num5].x;
					float y4 = scaleXY[(nint)num5].y;
					transform2.localScale = new Vector3
					{
						x = (dISTANCE + dISTANCE) * num * (pARAMETER_SCALE_WEIGHT * x4),
						y = (dISTANCE + dISTANCE) * num * (pARAMETER_SCALE_WEIGHT * y4),
						z = 1f
					};
					dirty = _dirty;
					dirty[(nint)num2] = false;
					fLARE_PARA_COUNT = FLARE_PARA_COUNT;
				}
				if (num2 + 1L >= fLARE_PARA_COUNT)
				{
					break;
				}
				num2++;
				num3++;
				num4++;
				num5++;
			}
		}

		private Matrix4x4 WorldToCameraMatrix(Vector3 position, Quaternion rotation)
		{
			return Matrix4x4.TRS(position, rotation, new Vector3
			{
				x = 1f,
				y = 1f,
				z = -1f
			});
		}

		private Matrix4x4 ProjectionMatrix(float fov, float width, float height, float nearClipPlane, float farClipPlane)
		{
			return Matrix4x4.Perspective(fov, width / height, nearClipPlane, farClipPlane);
		}

		private Matrix4x4 ViewportMatrix(float width, float height, float nearClipPlane, float farClipPlane)
		{
			float m = Matrix4x4.identity.m31;
			float m2 = Matrix4x4.identity.m02;
			float m3 = Matrix4x4.identity.m12;
			float m4 = Matrix4x4.identity.m22;
			float m5 = Matrix4x4.identity.m00;
			float m6 = Matrix4x4.identity.m10;
			float m7 = Matrix4x4.identity.m20;
			float m8 = Matrix4x4.identity.m30;
			float m9 = Matrix4x4.identity.m01;
			float m10 = Matrix4x4.identity.m11;
			float m11 = Matrix4x4.identity.m21;
			float m12 = Matrix4x4.identity.m31;
			float m13 = Matrix4x4.identity.m32;
			float m14 = Matrix4x4.identity.m33;
			return new Matrix4x4
			{
				m00 = width * 0.5f,
				m10 = m6,
				m20 = m7,
				m30 = m8,
				m01 = m9,
				m11 = height * 0.5f,
				m21 = m11,
				m31 = m12,
				m02 = m2,
				m12 = m3,
				m22 = (farClipPlane - nearClipPlane) * 0.5f,
				m32 = m13,
				m03 = width * 0.5f,
				m13 = height * 0.5f,
				m23 = (nearClipPlane + farClipPlane) * 0.5f,
				m33 = m14
			};
		}

		private Vector3 ScreenToWorldPoint(Vector2 screenPosition, float nearClipPlane, float farClipPlane, Vector3 position, Quaternion rotation, float fov, float width, float height, float distance)
		{
			Matrix4x4 matrix4x = Matrix4x4.TRS(position, rotation, new Vector3
			{
				x = 1f,
				y = 1f,
				z = -1f
			});
			Matrix4x4 inverse = Matrix4x4.Perspective(fov, width / height, nearClipPlane + distance, farClipPlane).inverse;
			Matrix4x4 inverse2 = ViewportMatrix(width, height, nearClipPlane + distance, farClipPlane).inverse;
			Matrix4x4 matrix4x2 = matrix4x * inverse * inverse2;
			float x;
			float y;
			float z;
			if (screenPosition.x * matrix4x2.m30 + screenPosition.y * matrix4x2.m31 + (nearClipPlane + distance) * matrix4x2.m32 + matrix4x2.m33 == 0f)
			{
				x = Vector3.zero.x;
				y = Vector3.zero.y;
				z = Vector3.zero.z;
			}
			else
			{
				float num = (matrix4x2.m00 * screenPosition.x + matrix4x2.m01 * screenPosition.y + matrix4x2.m02 * (nearClipPlane + distance) + matrix4x2.m03) / (screenPosition.x * matrix4x2.m30 + screenPosition.y * matrix4x2.m31 + (nearClipPlane + distance) * matrix4x2.m32 + matrix4x2.m33);
				float num2 = (matrix4x2.m10 * screenPosition.x + matrix4x2.m11 * screenPosition.y + matrix4x2.m12 * (nearClipPlane + distance) + matrix4x2.m13) / (screenPosition.x * matrix4x2.m30 + screenPosition.y * matrix4x2.m31 + (nearClipPlane + distance) * matrix4x2.m32 + matrix4x2.m33);
				z = (screenPosition.x * matrix4x2.m20 + screenPosition.y * matrix4x2.m21 + (nearClipPlane + distance) * matrix4x2.m22 + matrix4x2.m23) / (screenPosition.x * matrix4x2.m30 + screenPosition.y * matrix4x2.m31 + (nearClipPlane + distance) * matrix4x2.m32 + matrix4x2.m33);
				y = num2;
				x = num;
			}
			return new Vector3
			{
				x = x,
				y = y,
				z = z
			};
		}

		private Color CorrectColorValue(Color color)
		{
			float zERO_VALUE_THRESHOLD = ZERO_VALUE_THRESHOLD;
			return new Color
			{
				r = ((!(color.r < zERO_VALUE_THRESHOLD)) ? color.r : 0f),
				g = ((!(color.g < zERO_VALUE_THRESHOLD)) ? color.g : 0f),
				b = ((!(color.b < zERO_VALUE_THRESHOLD)) ? color.b : 0f),
				a = ((!(color.a < zERO_VALUE_THRESHOLD)) ? color.a : 0f)
			};
		}

		private void LateUpdate()
		{
			UpdatePositionAndScale();
		}
	}
}
