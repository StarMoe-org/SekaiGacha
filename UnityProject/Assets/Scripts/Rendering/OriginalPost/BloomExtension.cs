// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering/BloomExtension.cs，适配独立 URP 工程。
using System;
using System.Collections.Generic;

using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Sekai.Rendering
{
	public class BloomExtension
	{
		private static class Property
		{
			public static readonly string[] BloomBufferNames = new string[2] { "_BloomBuffer1", "_BloomBuffer2" };

			public static readonly int BloomIntensity = Shader.PropertyToID("_BloomIntensity");

			public static readonly int BloomScatter = Shader.PropertyToID("_BloomScatter");

			public static readonly int BloomScatterWeight = Shader.PropertyToID("_BloomScatterWeight");

			public static readonly string TempBufferName = "_TempBuffer";
		}

		private struct Size
		{
			public int Width;

			public int Height;

			public Size(int width, int height)
			{
				this.Width = width;
				this.Height = height;
			}

			public bool IsEqual(Size destSize)
			{
				if (Width == destSize.Width)
				{
					return Height == destSize.Height;
				}
				return false;
			}
		}

		private struct BloomTextureInfo
		{
			public int Width;

			public int Height;

			public Rect TextureMap;

			public Vector2[] vertices;

			public Vector2[] uvs;

			public Vector2[] sheetVertices;

			public Vector2[] sheetUvs;

			public int[] triangles;

			public BloomTextureInfo(int width, int height, Rect texMap)
			{
				this = default;
				Width = width;
				Height = height;
				TextureMap = texMap;
				vertices = new Vector2[4];
				vertices[0] = new Vector2
				{
					x = texMap.x,
					y = texMap.y + texMap.height
				};
				vertices[1] = new Vector2
				{
					x = texMap.x + texMap.width,
					y = texMap.y + texMap.height
				};
				vertices[2] = new Vector2
				{
					x = texMap.x + texMap.width,
					y = texMap.y
				};
				vertices[3] = new Vector2
				{
					x = texMap.x,
					y = texMap.y
				};
				sheetUvs = new Vector2[vertices.Length];
				Vector2[] array = vertices;
				long num = 4L;
				while (true)
				{
					int num2 = array.Length;
					if (num + -4L < num2)
					{
						if ((uint)(num + -4L) >= (uint)num2)
						{
							throw new IndexOutOfRangeException();
						}
						Vector2[] array2 = sheetUvs;
						if ((uint)(num + -4L) >= (uint)array2.Length)
						{
							throw new IndexOutOfRangeException();
						}
						Vector2 vector = array[(nint)(num + -4L)];
						array2[(nint)(num + -4L)] = new Vector2
						{
							x = vector.x * 0.5f + 0.5f,
							y = vector.y * 0.5f + 0.5f
						};
						array = vertices;
						if (array == null)
						{
							break;
						}
						num++;
						continue;
					}
					uvs = new Vector2[4];
					uvs[0] = new Vector2
					{
						y = 1f
					};
					uvs[1] = new Vector2
					{
						x = 1f,
						y = 1f
					};
					uvs[2] = new Vector2
					{
						x = 1f
					};
					uvs[3] = default;
					sheetVertices = new Vector2[uvs.Length];
					Vector2[] array3 = uvs;
					long num3 = 4L;
					while (true)
					{
						int num4 = array3.Length;
						if (num3 + -4L < num4)
						{
							if ((uint)(num3 + -4L) >= (uint)num4)
							{
								throw new IndexOutOfRangeException();
							}
							Vector2[] array4 = sheetVertices;
							Vector2 vector2 = array3[(nint)(num3 + -4L)];
							Vector2 one = Vector2.one;
							array4[(nint)(num3 + -4L)] = new Vector2
							{
								x = vector2.x + vector2.x - one.x,
								y = vector2.y + vector2.y - one.y
							};
							array3 = uvs;
							if (array3 == null)
							{
								break;
							}
							num3++;
							continue;
						}
						triangles = new int[6];
						int[] array5 = triangles;
						int num5 = array5.Length;
						array5[0] = 0;
						if (num5 == 1)
						{
							throw new IndexOutOfRangeException();
						}
						array5[1] = 1;
						array5[2] = 2;
						if (num5 == 3)
						{
							throw new IndexOutOfRangeException();
						}
						array5[3] = 0;
						array5[4] = 2;
						if (num5 == 5)
						{
							throw new IndexOutOfRangeException();
						}
						array5[5] = 3;
						return;
					}
					break;
				}
				throw new NullReferenceException();
			}
		}

		private static readonly int DownCount = 7;

		private Mesh textureToSheetMesh;

		private Mesh sheetToTextureMesh;

		private static readonly int margin = 7;

		private List<Size> sizeList = new List<Size>();

		private Size latestRenderSize;

		private bool isChangedSize;

		private List<BloomTextureInfo> bloomTextureInfos = new List<BloomTextureInfo>();

		public float intensity = 0.2f;

		public float scatter = 2f;

		private int postWidth;

		private int postHeight;

		private RTHandle sourceHandle;

		private RTHandle destHandle;

		private RTHandle tempBufferHandle;

		private RTHandle[] bloomBufferHandles;

		private RTHandle bloomTexHandle;

		private int destPropertyId;

		private Material material;

		public int DestPropertyId => destPropertyId;

		public BloomExtension(RTHandle sourceHandle, RTHandle destHandle, int postBlurWidth, int postBlurHeight, Material material)
		{
			this.sourceHandle = sourceHandle;
			this.destHandle = destHandle;
			this.material = material;
			postWidth = postBlurWidth;
			postHeight = postBlurHeight;
			destPropertyId = Shader.PropertyToID(destHandle.name);
			RenderTextureDescriptor renderTextureDescriptor = default;
			renderTextureDescriptor = new RenderTextureDescriptor(postBlurWidth, postBlurHeight, RenderTextureFormat.ARGB32, 0);
			bloomBufferHandles = new RTHandle[2];
			RTHandle[] array = bloomBufferHandles;
			RTHandle rTHandle = RTHandles.Alloc(name: Property.BloomBufferNames[0], descriptor: (RenderTextureDescriptor)renderTextureDescriptor, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
			if (array == null)
			{
				throw new NullReferenceException();
			}
			if (rTHandle != null)
			{
				object obj = rTHandle;
				if (((!array.GetType().GetElementType().IsInstanceOfType(obj)) ? null : obj) == null)
				{
					throw new ArrayTypeMismatchException();
				}
			}
			array[0] = rTHandle;
			string name = Property.BloomBufferNames[1];
			RTHandle[] array2 = bloomBufferHandles;
			RTHandle rTHandle2 = RTHandles.Alloc(in renderTextureDescriptor, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, name);
			if (array2 == null)
			{
				throw new NullReferenceException();
			}
			int blurWidth;
			int blurHeight;
			if (rTHandle2 != null)
			{
				object obj2 = rTHandle2;
				if (((!array2.GetType().GetElementType().IsInstanceOfType(obj2)) ? null : obj2) == null)
				{
					throw new ArrayTypeMismatchException();
				}
				array2[1] = rTHandle2;
				AllocTempBufferHandle(postBlurWidth, postBlurHeight, requireReAllocate: false);
				SetupSizeInfo(postBlurWidth, postBlurHeight, out blurWidth, out blurHeight);
			}
			else
			{
				array2[1] = rTHandle2;
				AllocTempBufferHandle(postBlurWidth, postBlurHeight, requireReAllocate: false);
				SetupSizeInfo(postBlurWidth, postBlurHeight, out blurWidth, out blurHeight);
			}
		}

		public void SetupBloom(RTHandle sourceHandle, RTHandle destHandle)
		{
			this.sourceHandle = sourceHandle;
			this.destHandle = destHandle;
		}

		public void Execute(CommandBuffer commandBuffer, Camera camera, Material material, int postWidth, int postHeight)
		{
			this.postWidth = postWidth;
			this.postHeight = postHeight;
			SetupTexture(commandBuffer);
			if (isChangedSize || textureToSheetMesh == null || sheetToTextureMesh == null)
			{
				if (textureToSheetMesh != null)
				{
					CoreUtils.Destroy(textureToSheetMesh);
				}
				if (sheetToTextureMesh != null)
				{
					CoreUtils.Destroy(sheetToTextureMesh);
				}
				textureToSheetMesh = CreateTextureToSheetMesh();
				sheetToTextureMesh = CreateSheetToTextureMesh();
			}
			DrawBloomSheet(camera, commandBuffer);
			DrawBlur(commandBuffer);
			DrawBloomTexture(camera, commandBuffer);
		}

		private void AllocTempBufferHandle(int width, int height, bool requireReAllocate)
		{
			RenderTextureDescriptor renderTextureDescriptor = default;
			renderTextureDescriptor = new RenderTextureDescriptor(width, height, RenderTextureFormat.ARGB32, 0);
			renderTextureDescriptor.useMipMap = true;
			renderTextureDescriptor.autoGenerateMips = true;
			if (requireReAllocate)
			{
				bool flag = RenderingUtils.ReAllocateIfNeeded(name: Property.TempBufferName, handle: ref tempBufferHandle, descriptor: in renderTextureDescriptor, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
			}
			else
			{
				tempBufferHandle = RTHandles.Alloc(in renderTextureDescriptor, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, Property.TempBufferName);
			}
		}

		private void AllocBloomBufferHandles(int blurWidth, int blurHeight, bool requireReAllocate)
		{
			RenderTextureDescriptor renderTextureDescriptor = default;
			renderTextureDescriptor = new RenderTextureDescriptor(blurWidth, blurHeight, RenderTextureFormat.ARGB32, 0);
			RTHandle[] array = bloomBufferHandles;
			if (requireReAllocate)
			{
				if (array == null)
				{
					throw new NullReferenceException();
				}
				string name = Property.BloomBufferNames[0];
				if (array.Length == 0)
				{
					throw new IndexOutOfRangeException();
				}
				bool flag = RenderingUtils.ReAllocateIfNeeded(ref array[0], (RenderTextureDescriptor)renderTextureDescriptor, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, name);
				RTHandle[] array2 = bloomBufferHandles;
				if (array2 == null)
				{
					throw new NullReferenceException();
				}
				string[] bloomBufferNames = Property.BloomBufferNames;
				if (1u >= (uint)bloomBufferNames.Length)
				{
					throw new IndexOutOfRangeException();
				}
				if (1u >= (uint)array2.Length)
				{
					throw new IndexOutOfRangeException();
				}
				bool flag2 = RenderingUtils.ReAllocateIfNeeded(name: bloomBufferNames[1], handle: ref array2[1], descriptor: in renderTextureDescriptor, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
				return;
			}
			RTHandle rTHandle = RTHandles.Alloc(name: Property.BloomBufferNames[0], descriptor: (RenderTextureDescriptor)renderTextureDescriptor, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
			if (array == null)
			{
				throw new NullReferenceException();
			}
			if (rTHandle != null)
			{
				object obj = rTHandle;
				if (((!array.GetType().GetElementType().IsInstanceOfType(obj)) ? null : obj) == null)
				{
					throw new ArrayTypeMismatchException();
				}
			}
			array[0] = rTHandle;
			string name2 = Property.BloomBufferNames[1];
			RTHandle[] array3 = bloomBufferHandles;
			RTHandle rTHandle2 = RTHandles.Alloc(in renderTextureDescriptor, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, name2);
			if (array3 == null)
			{
				throw new NullReferenceException();
			}
			if (rTHandle2 != null)
			{
				object obj2 = rTHandle2;
				if (((!array3.GetType().GetElementType().IsInstanceOfType(obj2)) ? null : obj2) == null)
				{
					throw new ArrayTypeMismatchException();
				}
				array3[1] = rTHandle2;
			}
			else
			{
				array3[1] = rTHandle2;
			}
		}

		private void SetupSizeInfo(int postWidth, int postHeight, out int blurWidth, out int blurHeight)
{
			Size size = default;
			size = new Size(postWidth, postHeight);
			bool flag = size.IsEqual(latestRenderSize);
			isChangedSize = !flag;
			if (!flag)
			{
				sizeList.Clear();
				for (int num = 0; num < DownCount; num++)
				{
					float num2 = Mathf.Pow(2f, num);
					List<Size> list = sizeList;
					Size item = default;
					int width;
					if ((float)size.Width / num2 == float.PositiveInfinity)
					{
						width = int.MinValue;
					}
					else
					{
						float num3 = (float)size.Width / num2;
						width = ((num3 == num3) ? ((!(num3 < 2.1474836E+09f)) ? int.MaxValue : ((num3 > -2.1474836E+09f) ? ((int)num3) : int.MinValue)) : 0);
					}
					int height;
					if ((float)size.Height / num2 == float.PositiveInfinity)
					{
						height = int.MinValue;
					}
					else
					{
						float num4 = (float)size.Height / num2;
						height = ((num4 == num4) ? ((num4 < 2.1474836E+09f) ? ((num4 > -2.1474836E+09f) ? ((int)num4) : int.MinValue) : int.MaxValue) : 0);
					}
					item = new Size(width, height);
					list.Add(item);
				}
			}
			Size size2 = sizeList[0];
			int num5 = margin;
			blurWidth = size2.Width + ((num5 & 0x7FFFFFFF) << 1);
			Size size3 = sizeList[0];
			Size size4 = sizeList[1];
			int num6 = margin;
			blurHeight = size4.Height + size3.Height + ((num6 & 0x3FFFFFFF) << 2);
			if (isChangedSize)
			{
				bloomTextureInfos.Clear();
				Size size5 = sizeList[0];
				List<Size> list2 = sizeList;
				int num7 = margin;
				Size size6 = list2[0];
				List<Size> list3 = sizeList;
				int num8 = margin;
				Size size7 = list3[0];
				List<Size> list4 = sizeList;
				int num9 = blurWidth;
				Size size8 = list4[0];
				List<Size> list5 = sizeList;
				int num10 = blurHeight;
				Size size9 = list5[0];
				Size size10 = sizeList[0];
				BloomTextureInfo bloomTextureInfo = default;
				bloomTextureInfo = new BloomTextureInfo(size9.Width, size10.Height, new Rect(-1f, -1f, (float)size7.Width / (float)num9 + (float)size7.Width / (float)num9, (float)size8.Height / (float)num10 + (float)size8.Height / (float)num10));
				bloomTextureInfos.Add(bloomTextureInfo);
				Size size11 = sizeList[1];
				List<Size> list6 = sizeList;
				int num11 = blurWidth;
				Size size12 = list6[1];
				List<BloomTextureInfo> list7 = bloomTextureInfos;
				int num12 = blurHeight;
				BloomTextureInfo bloomTextureInfo2 = list7[0];
				BloomTextureInfo bloomTextureInfo3 = bloomTextureInfos[0];
				Size size13 = sizeList[1];
				Size size14 = sizeList[1];
				BloomTextureInfo item2 = default;
				item2 = new BloomTextureInfo(size13.Width, size14.Height, new Rect(-1f, 1f / (float)size6.Height * (float)num8 + 1f / (float)size6.Height * (float)num8 + (((Rect)bloomTextureInfo2.TextureMap).y + ((Rect)bloomTextureInfo3.TextureMap).height), (float)size11.Width / (float)num11 + (float)size11.Width / (float)num11, (float)size12.Height / (float)num12 + (float)size12.Height / (float)num12));
				bloomTextureInfos.Add(item2);
				Size size15 = sizeList[2];
				List<Size> list8 = sizeList;
				int num13 = blurWidth;
				Size size16 = list8[2];
				List<BloomTextureInfo> list9 = bloomTextureInfos;
				int num14 = blurHeight;
				BloomTextureInfo bloomTextureInfo4 = list9[1];
				BloomTextureInfo bloomTextureInfo5 = bloomTextureInfos[1];
				BloomTextureInfo bloomTextureInfo6 = bloomTextureInfos[0];
				BloomTextureInfo bloomTextureInfo7 = bloomTextureInfos[0];
				Size size17 = sizeList[2];
				Size size18 = sizeList[2];
				BloomTextureInfo item3 = default;
				item3 = new BloomTextureInfo(size17.Width, size18.Height, new Rect(1f / (float)size5.Width * (float)num7 + 1f / (float)size5.Width * (float)num7 + (((Rect)bloomTextureInfo4.TextureMap).x + ((Rect)bloomTextureInfo5.TextureMap).width), 1f / (float)size6.Height * (float)num8 + 1f / (float)size6.Height * (float)num8 + (((Rect)bloomTextureInfo6.TextureMap).y + ((Rect)bloomTextureInfo7.TextureMap).height), (float)size15.Width / (float)num13 + (float)size15.Width / (float)num13, (float)size16.Height / (float)num14 + (float)size16.Height / (float)num14));
				bloomTextureInfos.Add(item3);
				Size size19 = sizeList[3];
				List<Size> list10 = sizeList;
				int num15 = blurWidth;
				Size size20 = list10[3];
				List<BloomTextureInfo> list11 = bloomTextureInfos;
				int num16 = blurHeight;
				BloomTextureInfo bloomTextureInfo8 = list11[1];
				BloomTextureInfo bloomTextureInfo9 = bloomTextureInfos[1];
				BloomTextureInfo bloomTextureInfo10 = bloomTextureInfos[2];
				BloomTextureInfo bloomTextureInfo11 = bloomTextureInfos[2];
				Size size21 = sizeList[3];
				Size size22 = sizeList[3];
				BloomTextureInfo item4 = default;
				item4 = new BloomTextureInfo(size21.Width, size22.Height, new Rect(1f / (float)size5.Width * (float)num7 + 1f / (float)size5.Width * (float)num7 + (((Rect)bloomTextureInfo8.TextureMap).x + ((Rect)bloomTextureInfo9.TextureMap).width), 1f / (float)size6.Height * (float)num8 + 1f / (float)size6.Height * (float)num8 + (((Rect)bloomTextureInfo10.TextureMap).y + ((Rect)bloomTextureInfo11.TextureMap).height), (float)size19.Width / (float)num15 + (float)size19.Width / (float)num15, (float)size20.Height / (float)num16 + (float)size20.Height / (float)num16));
				bloomTextureInfos.Add(item4);
				Size size23 = sizeList[4];
				List<Size> list12 = sizeList;
				int num17 = blurWidth;
				Size size24 = list12[4];
				List<BloomTextureInfo> list13 = bloomTextureInfos;
				int num18 = blurHeight;
				BloomTextureInfo bloomTextureInfo12 = list13[2];
				BloomTextureInfo bloomTextureInfo13 = bloomTextureInfos[2];
				BloomTextureInfo bloomTextureInfo14 = bloomTextureInfos[0];
				BloomTextureInfo bloomTextureInfo15 = bloomTextureInfos[0];
				Size size25 = sizeList[4];
				Size size26 = sizeList[4];
				BloomTextureInfo item5 = default;
				item5 = new BloomTextureInfo(size25.Width, size26.Height, new Rect(1f / (float)size5.Width * (float)num7 + 1f / (float)size5.Width * (float)num7 + (((Rect)bloomTextureInfo12.TextureMap).x + ((Rect)bloomTextureInfo13.TextureMap).width), 1f / (float)size6.Height * (float)num8 + 1f / (float)size6.Height * (float)num8 + (((Rect)bloomTextureInfo14.TextureMap).y + ((Rect)bloomTextureInfo15.TextureMap).height), (float)size23.Width / (float)num17 + (float)size23.Width / (float)num17, (float)size24.Height / (float)num18 + (float)size24.Height / (float)num18));
				bloomTextureInfos.Add(item5);
				Size size27 = sizeList[5];
				List<Size> list14 = sizeList;
				int num19 = blurWidth;
				Size size28 = list14[5];
				List<BloomTextureInfo> list15 = bloomTextureInfos;
				int num20 = blurHeight;
				BloomTextureInfo bloomTextureInfo16 = list15[4];
				BloomTextureInfo bloomTextureInfo17 = bloomTextureInfos[4];
				BloomTextureInfo bloomTextureInfo18 = bloomTextureInfos[0];
				BloomTextureInfo bloomTextureInfo19 = bloomTextureInfos[0];
				Size size29 = sizeList[5];
				Size size30 = sizeList[5];
				BloomTextureInfo item6 = default;
				item6 = new BloomTextureInfo(size29.Width, size30.Height, new Rect(1f / (float)size5.Width * (float)num7 + 1f / (float)size5.Width * (float)num7 + (((Rect)bloomTextureInfo16.TextureMap).x + ((Rect)bloomTextureInfo17.TextureMap).width), 1f / (float)size6.Height * (float)num8 + 1f / (float)size6.Height * (float)num8 + (((Rect)bloomTextureInfo18.TextureMap).y + ((Rect)bloomTextureInfo19.TextureMap).height), (float)size27.Width / (float)num19 + (float)size27.Width / (float)num19, (float)size28.Height / (float)num20 + (float)size28.Height / (float)num20));
				bloomTextureInfos.Add(item6);
				Size size31 = sizeList[6];
				List<Size> list16 = sizeList;
				int num21 = blurWidth;
				Size size32 = list16[6];
				List<BloomTextureInfo> list17 = bloomTextureInfos;
				int num22 = blurHeight;
				BloomTextureInfo bloomTextureInfo20 = list17[4];
				BloomTextureInfo bloomTextureInfo21 = bloomTextureInfos[4];
				BloomTextureInfo bloomTextureInfo22 = bloomTextureInfos[5];
				BloomTextureInfo bloomTextureInfo23 = bloomTextureInfos[5];
				Size size33 = sizeList[6];
				Size size34 = sizeList[6];
				BloomTextureInfo item7 = default;
				item7 = new BloomTextureInfo(size33.Width, size34.Height, new Rect(1f / (float)size5.Width * (float)num7 + 1f / (float)size5.Width * (float)num7 + (((Rect)bloomTextureInfo20.TextureMap).x + ((Rect)bloomTextureInfo21.TextureMap).width), 1f / (float)size6.Height * (float)num8 + 1f / (float)size6.Height * (float)num8 + (((Rect)bloomTextureInfo22.TextureMap).y + ((Rect)bloomTextureInfo23.TextureMap).height), (float)size31.Width / (float)num21 + (float)size31.Width / (float)num21, (float)size32.Height / (float)num22 + (float)size32.Height / (float)num22));
				bloomTextureInfos.Add(item7);
			}
			latestRenderSize = size;
		}

		private void SetupTexture(CommandBuffer commandBuffer)
		{
			int width = postWidth;
			int height = postHeight;
			Size size = default;
			size = new Size(width, height);
			AllocTempBufferHandle(size.Width, size.Height, requireReAllocate: true);
			SetupSizeInfo(postWidth, postHeight, out var blurWidth, out var blurHeight);
			AllocBloomBufferHandles(blurWidth, blurHeight, requireReAllocate: true);
			RenderTargetIdentifier renderTarget = destHandle;
			if (commandBuffer == null)
			{
				throw new NullReferenceException();
			}
			commandBuffer.SetRenderTarget(renderTarget);
			Blitter.BlitCameraTexture(commandBuffer, sourceHandle, tempBufferHandle, material, 5);
		}

		private Mesh CreateTextureToSheetMesh()
		{
			Mesh mesh = new Mesh();
			mesh.hideFlags = HideFlags.HideAndDontSave;
			List<Vector3> list = new List<Vector3>();
			List<Vector2> list2 = new List<Vector2>();
			List<Vector2> list3 = new List<Vector2>();
			List<int> list4 = new List<int>();
			list.Add(new Vector3
			{
				x = -1f,
				y = 1f
			});
			list.Add(new Vector3
			{
				x = 1f,
				y = 1f
			});
			list.Add(new Vector3
			{
				x = 1f,
				y = -1f
			});
			list.Add(new Vector3
			{
				x = -1f,
				y = -1f
			});
			list2.Add(new Vector2
			{
				y = 1f
			});
			list2.Add(new Vector2
			{
				x = 1f,
				y = 1f
			});
			list2.Add(new Vector2
			{
				x = 1f
			});
			list2.Add(default);
			list3.Add(default);
			list3.Add(default);
			list3.Add(default);
			list3.Add(default);
			list4.Add(0);
			list4.Add(1);
			list4.Add(2);
			list4.Add(0);
			list4.Add(2);
			list4.Add(3);
			for (int num = 0; num < DownCount; num++)
			{
				List<BloomTextureInfo> list5 = bloomTextureInfos;
				long num2 = 0L;
				while (true)
				{
					BloomTextureInfo bloomTextureInfo = list5[num];
					List<BloomTextureInfo> list6 = bloomTextureInfos;
					if (num2 < bloomTextureInfo.vertices.Length)
					{
						BloomTextureInfo bloomTextureInfo2 = list6[num];
						if ((uint)num2 >= (uint)bloomTextureInfo2.vertices.Length)
						{
							throw new IndexOutOfRangeException();
						}
						if (list == null)
						{
							throw new NullReferenceException();
						}
						float x = bloomTextureInfo2.vertices[(nint)num2].x;
						float y = bloomTextureInfo2.vertices[(nint)num2].y;
						list.Add(new Vector3
						{
							x = x,
							y = y
						});
						BloomTextureInfo bloomTextureInfo3 = bloomTextureInfos[num];
						if ((uint)num2 >= (uint)bloomTextureInfo3.uvs.Length)
						{
							throw new IndexOutOfRangeException();
						}
						if (list2 == null)
						{
							throw new NullReferenceException();
						}
						list2.Add(bloomTextureInfo3.uvs[(nint)num2]);
						list3.Add(new Vector2
						{
							x = num,
							y = 1f
						});
						list5 = bloomTextureInfos;
						if (list5 == null)
						{
							throw new NullReferenceException();
						}
						num2++;
						continue;
					}
					BloomTextureInfo bloomTextureInfo4 = list6[num];
					List<BloomTextureInfo> list7 = bloomTextureInfos;
					int num3 = bloomTextureInfo4.vertices.Length;
					for (long num4 = 0L; num4 < list7[num].triangles.Length; num4++)
					{
						BloomTextureInfo bloomTextureInfo5 = bloomTextureInfos[num];
						if ((uint)num4 >= (uint)bloomTextureInfo5.triangles.Length)
						{
							throw new IndexOutOfRangeException();
						}
						if (list4 == null)
						{
							throw new NullReferenceException();
						}
						list4.Add(bloomTextureInfo5.triangles[(nint)num4] + num * num3);
						list7 = bloomTextureInfos;
						if (list7 == null)
						{
							throw new NullReferenceException();
						}
					}
					break;
				}
			}
			mesh.vertices = list.ToArray();
			mesh.uv = list2.ToArray();
			mesh.uv2 = list3.ToArray();
			mesh.triangles = list4.ToArray();
			return mesh;
		}

		private Mesh CreateSheetToTextureMesh()
		{
			Mesh mesh = new Mesh();
			mesh.hideFlags = HideFlags.HideAndDontSave;
			List<Vector3> list = new List<Vector3>();
			List<Vector2> list2 = new List<Vector2>();
			List<Vector2> list3 = new List<Vector2>();
			List<int> list4 = new List<int>();
			list.Add(new Vector3
			{
				x = -1f,
				y = 1f
			});
			list.Add(new Vector3
			{
				x = 1f,
				y = 1f
			});
			list.Add(new Vector3
			{
				x = 1f,
				y = -1f
			});
			list.Add(new Vector3
			{
				x = -1f,
				y = -1f
			});
			list2.Add(new Vector2
			{
				y = 1f
			});
			list2.Add(new Vector2
			{
				x = 1f,
				y = 1f
			});
			list2.Add(new Vector2
			{
				x = 1f
			});
			list2.Add(default);
			list3.Add(new Vector2
			{
				y = 1f
			});
			list3.Add(new Vector2
			{
				y = 1f
			});
			list3.Add(new Vector2
			{
				y = 1f
			});
			list3.Add(new Vector2
			{
				y = 1f
			});
			list4.Add(0);
			list4.Add(1);
			list4.Add(2);
			list4.Add(0);
			list4.Add(2);
			list4.Add(3);
			int num = 0;
			long num2 = 0L;
			while (num < DownCount)
			{
				List<BloomTextureInfo> list5 = bloomTextureInfos;
				long num3 = 0L;
				while (true)
				{
					int num4 = list5[num].vertices.Length;
					List<BloomTextureInfo> list6 = bloomTextureInfos;
					if (num3 < num4)
					{
						BloomTextureInfo bloomTextureInfo = list6[num];
						if ((uint)num3 >= (uint)bloomTextureInfo.sheetVertices.Length)
						{
							throw new IndexOutOfRangeException();
						}
						if (list == null)
						{
							throw new NullReferenceException();
						}
						float x = bloomTextureInfo.sheetVertices[(nint)num3].x;
						float y = bloomTextureInfo.sheetVertices[(nint)num3].y;
						list.Add(new Vector3
						{
							x = x,
							y = y
						});
						BloomTextureInfo bloomTextureInfo2 = bloomTextureInfos[num];
						if ((uint)num3 >= (uint)bloomTextureInfo2.sheetUvs.Length)
						{
							throw new IndexOutOfRangeException();
						}
						if (list2 == null)
						{
							throw new NullReferenceException();
						}
						list2.Add(bloomTextureInfo2.sheetUvs[(nint)num3]);
						list3.Add(new Vector2
						{
							x = num
						});
						list5 = bloomTextureInfos;
						if (list5 == null)
						{
							throw new NullReferenceException();
						}
						num3++;
						continue;
					}
					for (long num5 = 0L; num5 < list6[num].triangles.Length; num5++)
					{
						BloomTextureInfo bloomTextureInfo3 = bloomTextureInfos[num];
						if ((uint)num5 >= (uint)bloomTextureInfo3.triangles.Length)
						{
							throw new IndexOutOfRangeException();
						}
						if (list4 == null)
						{
							throw new NullReferenceException();
						}
						list4.Add(bloomTextureInfo3.triangles[(nint)num5] + ((int)(num2 & 0x3FFFFFFFL) << 2));
						list6 = bloomTextureInfos;
						if (list6 == null)
						{
							throw new NullReferenceException();
						}
					}
					break;
				}
				num2 = (uint)(num + 1);
				num++;
			}
			mesh.vertices = list.ToArray();
			mesh.uv = list2.ToArray();
			mesh.uv2 = list3.ToArray();
			mesh.triangles = list4.ToArray();
			return mesh;
		}

		private void DrawBloomSheet(Camera camera, CommandBuffer commandBuffer)
		{
			RenderTargetIdentifier nameID = bloomBufferHandles[0].nameID;
			if (commandBuffer == null)
			{
				throw new NullReferenceException();
			}
			commandBuffer.SetRenderTarget(nameID);
			commandBuffer.SetGlobalTexture(destPropertyId, tempBufferHandle.rt);
			commandBuffer.SetViewProjectionMatrices(Matrix4x4.identity, Matrix4x4.identity);
			commandBuffer.DrawMesh(textureToSheetMesh, Matrix4x4.identity, material, 0, 0);
			commandBuffer.SetViewProjectionMatrices(camera.worldToCameraMatrix, camera.projectionMatrix);
		}

		private void DrawBlur(CommandBuffer commandBuffer)
		{
			RTHandle[] array = bloomBufferHandles;
			switch (array.Length)
			{
			case 0:
				throw new IndexOutOfRangeException();
			case 1:
				throw new IndexOutOfRangeException();
			}
			Blitter.BlitCameraTexture(commandBuffer, array[0], array[1], material, 1);
			RTHandle[] array2 = bloomBufferHandles;
			if (1u >= (uint)array2.Length)
			{
				throw new IndexOutOfRangeException();
			}
			Blitter.BlitCameraTexture(destination: array2[0], cmd: commandBuffer, source: array2[1], material: material, pass: 2);
		}

		private void DrawBloomTexture(Camera camera, CommandBuffer cmd)
{
			cmd.SetRenderTarget(destHandle);
			int num = 0;
			float num2 = 0f;
			while (num < DownCount)
			{
				float num3 = Mathf.Pow(scatter, num);
				num++;
				num2 += num3 * 0.01f;
			}
			cmd.SetGlobalTexture(value: bloomBufferHandles[0].nameID, nameID: destPropertyId);
			cmd.SetGlobalFloat(Property.BloomIntensity, intensity);
			cmd.SetGlobalFloat(Property.BloomScatter, scatter);
			cmd.SetGlobalFloat(Property.BloomScatterWeight, 1f / num2);
			cmd.SetViewProjectionMatrices(Matrix4x4.identity, Matrix4x4.identity);
			cmd.DrawMesh(sheetToTextureMesh, Matrix4x4.identity, material, 0, 4);
			cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix, camera.projectionMatrix);
		}

		public void Dispose()
		{
			if (textureToSheetMesh != null)
			{
				CoreUtils.Destroy(textureToSheetMesh);
			}
			if (sheetToTextureMesh != null)
			{
				CoreUtils.Destroy(sheetToTextureMesh);
			}
			DisposeBloomHandles();
		}

		private void DisposeBloomHandles()
		{
			
			sourceHandle = null;
			
			destHandle = null;
			tempBufferHandle?.Release();
			tempBufferHandle = null;
			RTHandle[] array = bloomBufferHandles;
			if (array == null)
			{
				return;
			}
			for (long num = 0L; num < array.Length; num++)
			{
				RTHandle rTHandle = array[(nint)num];
				if (rTHandle != null)
				{
					rTHandle.Release();
					array = bloomBufferHandles;
				}
				array[(nint)num] = null;
				array = bloomBufferHandles;
				if (array == null)
				{
					throw new NullReferenceException();
				}
			}
			bloomBufferHandles = null;
		}
	}
}
