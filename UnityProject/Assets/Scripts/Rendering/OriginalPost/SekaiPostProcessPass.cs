// 源自重建工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering.PostPrcessV2/SekaiPostProcessPass.cs，适配独立 URP 工程。
using System;

using Pass.PostProcessV2;
using Sekai.Rendering.Components;
using Sekai.Rendering.Components.PostProcessV2;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using sekai_rendering.Runtime.Components;

namespace Sekai.Rendering.PostPrcessV2
{
	public class SekaiPostProcessPass : ScriptableRenderPass
	{
		private SekaiBuffer buffer;

		private RenderTextureDescriptor descriptor;

		private RTHandle source;

		private RTHandle destination;

		private RTHandle m_EdgeStencilTexture;

		private RTHandle m_EdgeColorTexture;

		private RTHandle m_BloomTexHandle;

		private RTHandle m_CoCHandle;

		private RTHandle[] m_BlurMidHandle;

		private RTHandle[] m_BlurLowHandle;

		private RenderTargetIdentifier[] m_BlurMidTexIdentifiers;

		private RTHandle[] m_BlurTmpHandle;

		private RTHandle m_DofTex;

		private RTHandle m_BlurHandle;

		private RTHandle[] m_BoxBlurHandle;

		private RTHandle m_SatTexHandle;

		private RTHandle m_DirBlurHandle;

		private RTHandle m_SmaaHandle;

		private GraphicsFormat m_SMAAEdgeFormat;

		private GraphicsFormat m_SMAAFormat;

		private MaterialLibrary materials;

		private TextureResources textures;

		private LightOverlay lightOverlay;

		private IncidentLight incidentLight;

		private Saturation saturation;

		private Solarisation solarisation;

		private FadeOutBeforeProp fadeOutBeforeProp;

		private SaturationBlur saturationBlur;

		private LegacyLut lut;

		private LegacyBloom bloom;

		private Antialiasing antialiasing;

		private Sekai.Rendering.Components.PostProcessV2.Vignette vignette;

		private SekaiDof sekaiDof;

		private DirectionalBlur directionalBlur;

		private ScreenDistortion screenDistortion;

		private sekai_rendering.Runtime.Components.ChromaticAberration chromaticAberration;

		private BloomExtension bloomExtension;

		private int postWidth;

		private int postHeight;

		private bool isCreate;

		private bool useBlurTex;

		public SekaiPostProcessPass()
		{
			profilingSampler = new ProfilingSampler("SekaiPostProcessPass");
		}

		internal void Setup(RenderPassEvent evt, SekaiBuffer buffer, RenderTextureDescriptor baseDescriptor, in RTHandle source, in RTHandle destination)
		{
			this.buffer = buffer;
			renderPassEvent = evt;
			descriptor = baseDescriptor;
			this.source = source;
			this.destination = destination;
			int width = ((RenderTextureDescriptor)descriptor).width;
			int height = ((RenderTextureDescriptor)descriptor).height;
			double num3;
			if (!((float)width / (float)height * 256f >= 0f))
			{
				if ((((double)((float)width / (float)height * 256f) != Math.Truncate((float)width / (float)height * 256f)) ? ((double)((float)width / (float)height * 256f) - Math.Truncate((float)width / (float)height * 256f)) : (((double)((float)width / (float)height * 256f) == 0.0) ? ((double)((float)width / (float)height * 256f)) : ((!((double)((float)width / (float)height * 256f) < 0.0)) ? 0.0 : -0.0))) == -0.5)
				{
					double num = -1.0;
					double num2 = Math.Truncate((float)width / (float)height * 256f);
					num3 = (((((num2 != num2) ? 0L : ((!(num2 < 9.223372036854776E+18)) ? long.MaxValue : ((num2 > -9.223372036854776E+18) ? ((long)num2) : long.MinValue))) & 1L) != 0L) ? (Math.Truncate((float)width / (float)height * 256f) + num) : Math.Truncate((float)width / (float)height * 256f));
				}
				else
				{
					num3 = Math.Ceiling((double)((float)width / (float)height * 256f) + -0.5);
				}
			}
			else if ((((double)((float)width / (float)height * 256f) != Math.Truncate((float)width / (float)height * 256f)) ? ((double)((float)width / (float)height * 256f) - Math.Truncate((float)width / (float)height * 256f)) : (((double)((float)width / (float)height * 256f) == 0.0) ? ((double)((float)width / (float)height * 256f)) : ((!((double)((float)width / (float)height * 256f) < 0.0)) ? 0.0 : -0.0))) == 0.5)
			{
				double num = 1.0;
				double num4 = Math.Truncate((float)width / (float)height * 256f);
				num3 = (((((num4 != num4) ? 0L : ((!(num4 < 9.223372036854776E+18)) ? long.MaxValue : ((num4 > -9.223372036854776E+18) ? ((long)num4) : long.MinValue))) & 1L) != 0L) ? (Math.Truncate((float)width / (float)height * 256f) + num) : Math.Truncate((float)width / (float)height * 256f));
			}
			else
			{
				num3 = Math.Floor((double)((float)width / (float)height * 256f) + 0.5);
			}
			bool flag = isCreate;
			int num5;
			if (num3 == double.PositiveInfinity)
			{
				num5 = int.MinValue;
			}
			else
			{
				double num6 = num3;
				num5 = ((num6 == num6) ? ((!(num6 < 2147483648.0)) ? int.MaxValue : ((num6 > -2147483648.0) ? ((int)num6) : int.MinValue)) : 0);
			}
			postWidth = num5;
			postHeight = 256;
			if (!flag)
			{
				isCreate = true;
				materials = new MaterialLibrary();
				AllocBloomHandle(postWidth, postHeight, requireReAllocate: false);
				bloomExtension = new BloomExtension(buffer.SekaiBufferBrightnessHandle, material: materials.bloom, postBlurHeight: postHeight, postBlurWidth: postWidth, destHandle: m_BloomTexHandle);
				textures = new TextureResources();
				AllocBlurTexHandle(postWidth, postHeight, requireReAllocate: false);
				AllocSekaiDofHandle(postWidth, postHeight, requireReAllocate: false);
				AllocSatTexHandle(requireReAlloc: false);
				AllocSMAAHandle(requireReAllocate: false);
				AllocDirBlurHandle(requireReAlloc: false);
			}
			m_SMAAFormat = ((QualitySettings.activeColorSpace != ColorSpace.Linear) ? GraphicsFormat.R8G8B8A8_UNorm : GraphicsFormat.R8G8B8A8_SRGB);
			m_SMAAEdgeFormat = ((!SystemInfo.IsFormatSupported(GraphicsFormat.R8G8_UNorm, FormatUsage.Render)) ? GraphicsFormat.R8G8B8A8_UNorm : (SystemInfo.graphicsDeviceVendor.ToLowerInvariant().Contains("arm") ? GraphicsFormat.R8G8_UNorm : GraphicsFormat.R8G8B8A8_UNorm));
		}

		public void Dispose()
		{
			
			
			m_EdgeStencilTexture?.Release();
			m_EdgeColorTexture?.Release();
			DisposeBlurHandle();
			DisposeBloomHandle();
			DisposeSekaiDofHandle();
			DisposeSatTexHandle();
			DisposeDirBlurHandle();
			DisposeSMAAHandle();
			materials?.Cleanup();
			materials = null;
			textures?.Cleanup();
			textures = null;
			bloomExtension?.Dispose();
			bloomExtension = null;
			isCreate = false;
		}

		public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
		{
			
		}

		public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)
		{
			ConfigureTarget(destination);
			ConfigureClear(ClearFlag.Depth, default);
		}

		public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
		{
			var camera = renderingData.cameraData.camera;
            VolumeManager.instance.Update(camera.transform, camera.GetUniversalAdditionalCameraData().volumeLayerMask);
            VolumeStack stack = VolumeManager.instance.stack;
			lightOverlay = stack.GetComponent<LightOverlay>();
			incidentLight = stack.GetComponent<IncidentLight>();
			saturation = stack.GetComponent<Saturation>();
			solarisation = stack.GetComponent<Solarisation>();
			fadeOutBeforeProp = stack.GetComponent<FadeOutBeforeProp>();
			saturationBlur = stack.GetComponent<SaturationBlur>();
			lut = stack.GetComponent<LegacyLut>();
			bloom = stack.GetComponent<LegacyBloom>();
			sekaiDof = stack.GetComponent<SekaiDof>();
			antialiasing = stack.GetComponent<Antialiasing>();
			directionalBlur = stack.GetComponent<DirectionalBlur>();
			screenDistortion = stack.GetComponent<ScreenDistortion>();
			vignette = stack.GetComponent<Sekai.Rendering.Components.PostProcessV2.Vignette>();
			chromaticAberration = stack.GetComponent<sekai_rendering.Runtime.Components.ChromaticAberration>();
			CommandBuffer commandBuffer = CommandBufferPool.Get();
			ProfilingSampler sampler = profilingSampler;
			ProfilingScope profilingScope = default;
			using (new ProfilingScope(commandBuffer, sampler))
			{
				Render(commandBuffer, ref renderingData);
			}
			((ScriptableRenderContext)context).ExecuteCommandBuffer(commandBuffer);
			CommandBufferPool.Release(commandBuffer);
		}

		private RenderTextureDescriptor GetCompatibleDescriptor()
		{
			int width = ((RenderTextureDescriptor)descriptor).width;
			int height = ((RenderTextureDescriptor)descriptor).height;
			GraphicsFormat graphicsFormat = descriptor.graphicsFormat;
			RenderTextureDescriptor renderTextureDescriptor = descriptor;
			renderTextureDescriptor.depthBufferBits = 0;
			RenderTextureDescriptor renderTextureDescriptor2 = renderTextureDescriptor;
			renderTextureDescriptor2.width = width;
			renderTextureDescriptor2.height = height;
			renderTextureDescriptor2.msaaSamples = 1;
			RenderTextureDescriptor result = renderTextureDescriptor2;
			result.graphicsFormat = graphicsFormat;
			return result;
		}

		private RenderTextureDescriptor GetCompatibleDescriptor(int width, int height, GraphicsFormat format, DepthBits depthBufferBits = DepthBits.None)
		{
			RenderTextureDescriptor renderTextureDescriptor = descriptor;
			renderTextureDescriptor.depthBufferBits = (int)depthBufferBits;
			RenderTextureDescriptor renderTextureDescriptor2 = renderTextureDescriptor;
			renderTextureDescriptor2.width = width;
			renderTextureDescriptor2.height = height;
			renderTextureDescriptor2.msaaSamples = 1;
			RenderTextureDescriptor result = renderTextureDescriptor2;
			result.graphicsFormat = format;
			return result;
		}

		internal static RenderTextureDescriptor GetCompatibleDescriptor(RenderTextureDescriptor desc, int width, int height, GraphicsFormat format, DepthBits depthBufferBits = DepthBits.None)
		{
			RenderTextureDescriptor renderTextureDescriptor = desc;
			renderTextureDescriptor.depthBufferBits = (int)depthBufferBits;
			RenderTextureDescriptor renderTextureDescriptor2 = renderTextureDescriptor;
			renderTextureDescriptor2.width = width;
			renderTextureDescriptor2.height = height;
			renderTextureDescriptor2.msaaSamples = 1;
			RenderTextureDescriptor result = renderTextureDescriptor2;
			result.graphicsFormat = format;
			return result;
		}

		private void Render(CommandBuffer cmd, ref RenderingData renderingData)
		{
			materials.uber.shaderKeywords = null;
			bool flag = this.saturationBlur.IsActive() || sekaiDof.IsActive();
			SaturationBlur saturationBlur = this.saturationBlur;
			useBlurTex = flag;
			int num = (saturationBlur.IsActive() ? (((!sekaiDof.IsActive()) ? 1 : 0) & 1) : 0);
			if (useBlurTex)
			{
				AllocBlurTexHandle(postWidth, postHeight, requireReAllocate: true);
			}
			ProfilingSampler sampler = ProfilingSampler.Get(ProfileId.Blur);
			ProfilingScope profilingScope = default;
			profilingScope = new ProfilingScope(cmd, sampler);
			if (num != 0)
			{
				try
				{
					UpdateBlur(cmd);
				}
				finally
				{
					profilingScope.Dispose();
				}
			}
			else
			{
				profilingScope.Dispose();
			}
			using (new ProfilingScope(cmd, ProfilingSampler.Get(ProfileId.Dof)))
			{
				if (sekaiDof.IsActive())
				{
					AllocSekaiDofHandle(postWidth, postHeight, requireReAllocate: true);
					UpdateSekaiDof(cmd, buffer.SekaiBufferColorHandle, buffer.SekaiBufferColorHandle, materials.sekaiDof);
				}
			}
			using (new ProfilingScope(cmd, ProfilingSampler.Get(ProfileId.Bloom)))
			{
				if (bloom.IsActive())
				{
					AllocBloomHandle(postWidth, postHeight, requireReAllocate: true);
					UpdateBloom(cmd, renderingData.cameraData.camera, materials.uber);
				}
			}
			using (new ProfilingScope(cmd, ProfilingSampler.Get(ProfileId.SaturationBlur)))
			{
				if (this.saturationBlur.IsActive())
				{
					AllocSatTexHandle(requireReAlloc: true);
					UpdateSaturationBlur(cmd, materials.uber);
				}
			}
			using (new ProfilingScope(cmd, ProfilingSampler.Get(ProfileId.ScreenDistortion)))
			{
				UpdateScreenDistortion(cmd);
			}
			RTHandle smaaHandle;
			if (IsUseSMAA())
			{
				AllocSMAAHandle(requireReAllocate: true);
				smaaHandle = m_SmaaHandle;
			}
			else
			{
				smaaHandle = destination;
			}
			using (new ProfilingScope(cmd, ProfilingSampler.Get(ProfileId.Uber)))
			{
				if (lightOverlay.IsActive())
				{
					UpdateLightOverlay(cmd, materials.uber);
				}
				if (incidentLight.IsActive())
				{
					UpdateIncidentLight(cmd, materials.uber);
				}
				if (saturation.IsActive())
				{
					UpdateSaturation(cmd, materials.uber);
				}
				if (solarisation.IsActive())
				{
					UpdateSolarisation(cmd);
				}
				else
				{
					ResetSolarisation(cmd);
				}
				if (chromaticAberration.IsActive())
				{
					UpdateChromaticAberration(cmd, materials.uber);
				}
				if (fadeOutBeforeProp.IsActive())
				{
					UpdateFadeOutBeforeProp(cmd);
				}
				else
				{
					ResetFadeOutBeforeProp(cmd);
				}
				if (lut.IsActive())
				{
					UpdateLut(cmd, materials.uber);
				}
				BlitUberPost(cmd, buffer.SekaiBufferColorHandle, smaaHandle);
			}
			if (!IsUseSMAA())
			{
				return;
			}
			profilingScope = new ProfilingScope(cmd, ProfilingSampler.Get(ProfileId.SMAA));
			RTHandle rTHandle = destination;
			try
			{
				DoSubpixelMorphologicalAntialiasing(ref renderingData.cameraData, cmd, smaaHandle, rTHandle);
			}
			finally
			{
				profilingScope.Dispose();
			}
		}

		private void UpdateScreenDistortion(CommandBuffer cmd)
		{
			float x;
			float y;
			float z;
			float w;
			float x2;
			float y2;
			float z2;
			float w2;
			if (screenDistortion != null)
			{
				if (!screenDistortion.IsActive())
				{
					x = 0f;
					y = 0f;
					z = 0f;
					w = 0f;
					x2 = 0f;
					y2 = 0f;
					z2 = 0f;
					w2 = 0f;
				}
				else
				{
					x = screenDistortion.IntensityAmount.value;
					y = screenDistortion.ScaleAmount.value;
					z = screenDistortion.OffsetAmount.value;
					w = Convert.ToSingle(screenDistortion.UseNoise.value);
					float value = screenDistortion.Time.value;
					Vector2 value2 = screenDistortion.NoiseScale.value;
					Vector2 value3 = screenDistortion.NoiseScale.value;
					Vector2 value4 = screenDistortion.NoiseScrollSpeed.value;
					Vector2 value5 = screenDistortion.NoiseScrollSpeed.value;
					float x3 = value2.x;
					float y3 = value3.y;
					float num = value * value4.x;
					w2 = value * value5.y;
					z2 = num;
					y2 = y3;
					x2 = x3;
				}
			}
			else
			{
				x = 0f;
				y = 0f;
				z = 0f;
				w = 0f;
				x2 = 0f;
				y2 = 0f;
				z2 = 0f;
				w2 = 0f;
			}
			cmd.SetGlobalVector(Property.ScreenDistortionParam, new Vector4
			{
				x = x,
				y = y,
				z = z,
				w = w
			});
			cmd.SetGlobalVector(Property.ScreenDistortionNoiseTextureParam, new Vector4
			{
				x = x2,
				y = y2,
				z = z2,
				w = w2
			});
		}

		private bool IsUseSMAA()
		{
			if (antialiasing.IsActive())
			{
				return antialiasing.mode.value == AntialiasingMode.SubpixelMorphologicalAntiAliasing;
			}
			return false;
		}

		private void BlitUberPost(CommandBuffer cmd, RTHandle source, RTHandle destination)
		{
			UpdateVignette(cmd);
			bool flag = directionalBlur.IsActive();
			Material uber = materials.uber;
			RTHandle rTHandle;
			Material uber2;
			int pass;
			if (flag)
			{
				UpdateDirectionalBlur(cmd, uber);
				Blitter.BlitCameraTexture(cmd, buffer.SekaiBufferColorHandle, m_DirBlurHandle, materials.uber, 3);
				MaterialLibrary materialLibrary = materials;
				rTHandle = m_DirBlurHandle;
				uber2 = materialLibrary.uber;
				pass = 4;
			}
			else
			{
				DisableDirectionalBlurKeyword(uber);
				uber2 = materials.uber;
				rTHandle = source;
				pass = 1;
			}
			Blitter.BlitCameraTexture(cmd, rTHandle, destination, uber2, pass);
		}

		private void UpdateVignette(CommandBuffer cmd)
		{
			Color value = vignette.color.value;
			float value2 = vignette.roundness.value;
			Vector2 value3 = vignette.center.value;
			Vector2 value4 = vignette.center.value;
			float value5 = vignette.intensity.value;
			float value6 = vignette.smoothness.value;
			cmd.SetGlobalVector(Property.Vignette.Vignette_Params1, new Vector4
			{
				x = value.r,
				y = value.g,
				z = value.b,
				w = value2
			});
			cmd.SetGlobalVector(Property.Vignette.Vignette_Params2, new Vector4
			{
				x = value3.x,
				y = value4.y,
				z = value5,
				w = value6
			});
		}

		private void UpdateLightOverlay(CommandBuffer cmd, Material material)
		{
			cmd.SetGlobalColor(Property.BrightColor, lightOverlay.brightColor.value);
			cmd.SetGlobalColor(Property.DarkColor, lightOverlay.darkColor.value);
			Vector2Parameter darkPosition = lightOverlay.darkPosition;
			int darkPosition2 = Property.DarkPosition;
			Vector2 value = darkPosition.value;
			cmd.SetGlobalVector(darkPosition2, new Vector4
			{
				x = value.x,
				y = value.y
			});
			Vector2 value2 = lightOverlay.brightPosition.value;
			Vector2 value3 = lightOverlay.darkPosition.value;
			float w = (((float)Math.Sqrt((value2.x - value3.x) * (value2.x - value3.x) + (value2.y - value3.y) * (value2.y - value3.y)) != 0f) ? (1f / (float)Math.Sqrt((value2.x - value3.x) * (value2.x - value3.x) + (value2.y - value3.y) * (value2.y - value3.y)) / (float)Math.Sqrt((value2.x - value3.x) * (value2.x - value3.x) + (value2.y - value3.y) * (value2.y - value3.y))) : 0f);
			cmd.SetGlobalVector(Property.LightVector, new Vector4
			{
				x = value2.x - value3.x,
				y = value2.y - value3.y,
				z = (float)Math.Sqrt((value2.x - value3.x) * (value2.x - value3.x) + (value2.y - value3.y) * (value2.y - value3.y)),
				w = w
			});
			material.EnableKeyword("_LIGHT_OVERLAY");
		}

		private void UpdateIncidentLight(CommandBuffer cmd, Material material)
		{
			cmd.SetGlobalColor(Property.IncidentLightColor, incidentLight.incidentLightColor.value);
			cmd.SetGlobalVector(Property.IncidentLightVector, GetIncidentLightVector());
			material.EnableKeyword("_INCIDENT_LIGHT");
		}

		private Vector4 GetIncidentLightVector()
		{
			float value = incidentLight.incidentLightLength.value;
			Vector2 value2 = incidentLight.incidentLightPosition.value;
			float z = ((value > 0f) ? (1f / value / value) : 0f);
			int value3 = incidentLight.incidentLightAddBlend.value;
			return new Vector4
			{
				x = value2.x,
				y = value2.y,
				z = z,
				w = value3
			};
		}

		private void UpdateSaturation(CommandBuffer cmd, Material material)
		{
			cmd.SetGlobalFloat(Property.Saturation, saturation.saturation.value);
			material.EnableKeyword("_SATURATION");
		}

		private void UpdateSolarisation(CommandBuffer cmd)
		{
			cmd.SetGlobalFloat(Property.Solarisation, solarisation.solarisation.value);
		}

		private void ResetSolarisation(CommandBuffer cmd)
		{
			cmd.SetGlobalFloat(Property.Solarisation, 0f);
		}

		private void UpdateChromaticAberration(CommandBuffer cmd, Material material)
		{
			int value = chromaticAberration.ChromaticAberrationMode.value;
			Vector2 value2 = chromaticAberration.OffsetR.value;
			Vector2 value3 = chromaticAberration.OffsetG.value;
			Vector2 value4 = chromaticAberration.OffsetB.value;
			float value5 = chromaticAberration.ScaleR.value;
			float value6 = chromaticAberration.ScaleG.value;
			float value7 = chromaticAberration.ScaleB.value;
			cmd.SetGlobalInt(Property.ChromaticAberrationParamType, value);
			cmd.SetGlobalVector(Property.ChromaticAberrationOffsetR, new Vector4
			{
				x = value2.x,
				y = value2.y
			});
			cmd.SetGlobalVector(Property.ChromaticAberrationOffsetG, new Vector4
			{
				x = value3.x,
				y = value3.y
			});
			cmd.SetGlobalVector(Property.ChromaticAberrationOffsetB, new Vector4
			{
				x = value4.x,
				y = value4.y
			});
			cmd.SetGlobalVector(Property.ChromaticAberrationScale, new Vector4
			{
				x = value5,
				y = value6,
				z = value7
			});
			material.EnableKeyword("_CHROMATIC_ABERRATION");
		}

		private void UpdateFadeOutBeforeProp(CommandBuffer cmd)
		{
			ClampedFloatParameter clampedFloatParameter = fadeOutBeforeProp.fadeOutBeforeProp;
			int nameID = Property.FadeOutBeforeProp;
			float value = clampedFloatParameter.value;
			cmd.SetGlobalFloat(nameID, value + value + -1f);
			ClampedFloatParameter fadeOutBeforePropLerp = fadeOutBeforeProp.fadeOutBeforePropLerp;
			int fadeOutBeforePropLerp2 = Property.FadeOutBeforePropLerp;
			float value2 = fadeOutBeforePropLerp.value;
			cmd.SetGlobalFloat(fadeOutBeforePropLerp2, value2 + value2 + -1f);
		}

		private void ResetFadeOutBeforeProp(CommandBuffer cmd)
		{
			cmd.SetGlobalFloat(Property.FadeOutBeforeProp, 0f);
			cmd.SetGlobalFloat(Property.FadeOutBeforePropLerp, 0f);
		}

		private void AllocBlurTexHandle(int postWidth, int postHeight, bool requireReAllocate)
		{
			RenderTextureDescriptor renderTextureDescriptor = descriptor;
			renderTextureDescriptor.depthBufferBits = 0;
			RenderTextureDescriptor renderTextureDescriptor2 = renderTextureDescriptor;
			renderTextureDescriptor2.width = postWidth;
			renderTextureDescriptor2.height = postHeight;
			renderTextureDescriptor2.msaaSamples = 1;
			RenderTextureDescriptor renderTextureDescriptor3 = renderTextureDescriptor2;
			renderTextureDescriptor3.graphicsFormat = GraphicsFormat.R8G8B8A8_UNorm;
			if (requireReAllocate)
			{
				bool flag = RenderingUtils.ReAllocateIfNeeded(name: m_BlurHandle.name, handle: ref m_BlurHandle, descriptor: (RenderTextureDescriptor)renderTextureDescriptor3, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
				for (long num = 0L; num < Property.BoxBlurTexNames.Length; num++)
				{
					bool flag2 = RenderingUtils.ReAllocateIfNeeded(name: Property.BoxBlurTexNames[(nint)num], handle: ref m_BlurHandle, descriptor: (RenderTextureDescriptor)renderTextureDescriptor3, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
				}
				return;
			}
			m_BlurHandle = RTHandles.Alloc(name: Property.BlurTexName, descriptor: (RenderTextureDescriptor)renderTextureDescriptor3, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
			m_BoxBlurHandle = new RTHandle[Property.BoxBlurTexNames.Length];
			long num2 = 0L;
			while (true)
			{
				if (num2 >= Property.BoxBlurTexNames.Length)
				{
					return;
				}
				RTHandle[] boxBlurHandle = m_BoxBlurHandle;
				RTHandle rTHandle = RTHandles.Alloc(name: Property.BoxBlurTexNames[(nint)num2], descriptor: (RenderTextureDescriptor)renderTextureDescriptor3, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
				if (boxBlurHandle == null)
				{
					throw new NullReferenceException();
				}
				if (rTHandle != null)
				{
					object obj = rTHandle;
					if (((!boxBlurHandle.GetType().GetElementType().IsInstanceOfType(obj)) ? null : obj) == null)
					{
						break;
					}
				}
				boxBlurHandle[(nint)num2] = rTHandle;
				num2++;
			}
			throw new ArrayTypeMismatchException();
		}

		private void AllocSatTexHandle(bool requireReAlloc)
		{
			RenderTextureDescriptor renderTextureDescriptor = m_BlurHandle.rt.descriptor;
			if (requireReAlloc)
			{
				bool flag = RenderingUtils.ReAllocateIfNeeded(name: m_BlurHandle.name, handle: ref m_BlurHandle, descriptor: in renderTextureDescriptor, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
			}
			else
			{
				m_SatTexHandle = RTHandles.Alloc(in renderTextureDescriptor, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, Property.SatTexName);
			}
		}

		private void UpdateSaturationBlur(CommandBuffer cmd, Material material)
		{
			cmd.SetGlobalFloat(Property.Sat, saturationBlur.SaturationValue);
			cmd.SetGlobalFloat(Property.SatAlpha, saturationBlur.alpha.value);
			Blitter.BlitCameraTexture(cmd, m_BlurHandle, m_SatTexHandle, materials.uber, 2);
			cmd.SetGlobalTexture(value: m_SatTexHandle.nameID, nameID: Property.SatTex);
			if (saturationBlur.saturationBlurType == SaturationBlurVolumeType.V2)
			{
				material.DisableKeyword("_SATURATION_BLUR_V1");
				material.EnableKeyword("_SATURATION_BLUR_V2");
			}
			else
			{
				material.EnableKeyword("_SATURATION_BLUR_V1");
				material.DisableKeyword("_SATURATION_BLUR_V2");
			}
		}

		private void DisposeSatTexHandle()
		{
			m_SatTexHandle?.Release();
			m_SatTexHandle = null;
		}

		private void UpdateLut(CommandBuffer cmd, Material material)
		{
			float value = lut.frontBlend.value;
			float value2 = lut.backBlend.value;
			if (!lut.frontTex.value)
			{
				value = 0f;
			}
			else
			{
				TextureParameter frontTex = lut.frontTex;
				int frontLut = Property.FrontLut;
				RenderTargetIdentifier value3 = frontTex.value;
				if (cmd == null)
				{
					throw new NullReferenceException();
				}
				cmd.SetGlobalTexture(frontLut, value3);
				cmd.SetGlobalFloat(Property.HalfCol, 0.5f / (float)lut.frontTex.value.width);
				cmd.SetGlobalFloat(Property.Threshold, (float)(lut.frontTex.value.width + -1) / (float)lut.frontTex.value.width);
				Vector2Parameter frontNonPoint = lut.frontNonPoint;
				int frontNonLutPosition = Property.FrontNonLutPosition;
				Vector2 value4 = frontNonPoint.value;
				cmd.SetGlobalVector(frontNonLutPosition, new Vector4
				{
					x = value4.x,
					y = value4.y
				});
				Vector2 value5 = lut.frontPoint.value;
				Vector2 value6 = lut.frontNonPoint.value;
				float w = (((float)Math.Sqrt((value5.x - value6.x) * (value5.x - value6.x) + (value5.y - value6.y) * (value5.y - value6.y)) != 0f) ? (1f / (float)Math.Sqrt((value5.x - value6.x) * (value5.x - value6.x) + (value5.y - value6.y) * (value5.y - value6.y)) / (float)Math.Sqrt((value5.x - value6.x) * (value5.x - value6.x) + (value5.y - value6.y) * (value5.y - value6.y))) : 0f);
				cmd.SetGlobalVector(Property.FrontLutVector, new Vector4
				{
					x = value5.x - value6.x,
					y = value5.y - value6.y,
					z = (float)Math.Sqrt((value5.x - value6.x) * (value5.x - value6.x) + (value5.y - value6.y) * (value5.y - value6.y)),
					w = w
				});
			}
			if (!lut.backTex.value)
			{
				value2 = 0f;
			}
			else
			{
				TextureParameter backTex = lut.backTex;
				int backLut = Property.BackLut;
				RenderTargetIdentifier value7 = backTex.value;
				if (cmd == null)
				{
					throw new NullReferenceException();
				}
				cmd.SetGlobalTexture(backLut, value7);
				cmd.SetGlobalFloat(Property.HalfCol, 0.5f / (float)lut.backTex.value.width);
				cmd.SetGlobalFloat(Property.Threshold, (float)(lut.backTex.value.width + -1) / (float)lut.backTex.value.width);
				Vector2Parameter backNonPoint = lut.backNonPoint;
				int backNonLutPosition = Property.BackNonLutPosition;
				Vector2 value8 = backNonPoint.value;
				cmd.SetGlobalVector(backNonLutPosition, new Vector4
				{
					x = value8.x,
					y = value8.y
				});
				Vector2 value9 = lut.backPoint.value;
				Vector2 value10 = lut.backNonPoint.value;
				float w2 = (((float)Math.Sqrt((value9.x - value10.x) * (value9.x - value10.x) + (value9.y - value10.y) * (value9.y - value10.y)) != 0f) ? (1f / (float)Math.Sqrt((value9.x - value10.x) * (value9.x - value10.x) + (value9.y - value10.y) * (value9.y - value10.y)) / (float)Math.Sqrt((value9.x - value10.x) * (value9.x - value10.x) + (value9.y - value10.y) * (value9.y - value10.y))) : 0f);
				cmd.SetGlobalVector(Property.BackLutVector, new Vector4
				{
					x = value9.x - value10.x,
					y = value9.y - value10.y,
					z = (float)Math.Sqrt((value9.x - value10.x) * (value9.x - value10.x) + (value9.y - value10.y) * (value9.y - value10.y)),
					w = w2
				});
			}
			cmd.SetGlobalFloat(Property.FrontLutBlend, value);
			cmd.SetGlobalFloat(Property.BackLutBlend, value2);
			material.EnableKeyword("_COLOR_LUT");
		}

		private void AllocBloomHandle(int postWidth, int postHeight, bool requireReAllocate)
		{
			RenderTextureDescriptor renderTextureDescriptor = descriptor;
			renderTextureDescriptor.depthBufferBits = 0;
			RenderTextureDescriptor renderTextureDescriptor2 = renderTextureDescriptor;
			renderTextureDescriptor2.width = postWidth;
			renderTextureDescriptor2.height = postHeight;
			renderTextureDescriptor2.msaaSamples = 1;
			RenderTextureDescriptor renderTextureDescriptor3 = renderTextureDescriptor2;
			renderTextureDescriptor3.graphicsFormat = GraphicsFormat.R8G8B8A8_UNorm;
			if (requireReAllocate)
			{
				bool flag = RenderingUtils.ReAllocateIfNeeded(name: Property.BloomTexName, handle: ref m_BloomTexHandle, descriptor: in renderTextureDescriptor3, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
			}
			else
			{
				m_BloomTexHandle = RTHandles.Alloc(in renderTextureDescriptor3, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, Property.BloomTexName);
			}
		}

		private void UpdateBloom(CommandBuffer cmd, Camera camera, Material material)
		{
			SekaiBuffer sekaiBuffer = buffer;
			this.bloomExtension.SetupBloom(sekaiBuffer.SekaiBufferBrightnessHandle, m_BloomTexHandle);
			ClampedFloatParameter intensity = bloom.intensity;
			this.bloomExtension.intensity = intensity.value;
			ClampedFloatParameter scatter = bloom.scatter;
			this.bloomExtension.scatter = scatter.value;
			MaterialLibrary materialLibrary = materials;
			this.bloomExtension.Execute(cmd, camera, materialLibrary.bloom, postWidth, postHeight);
			cmd.SetGlobalInt(Property.BloomBlendMode, bloom.useNewBlend.value ? 1 : 0);
			BloomExtension bloomExtension = this.bloomExtension;
			if (bloomExtension == null)
			{
				throw new NullReferenceException();
			}
			cmd.SetGlobalTexture(value: m_BloomTexHandle.nameID, nameID: bloomExtension.DestPropertyId);
			material.EnableKeyword("_BLOOM");
		}

		private void DisposeBloomHandle()
		{
			m_BloomTexHandle?.Release();
			m_BloomTexHandle = null;
		}

		private void AllocDirBlurHandle(bool requireReAlloc)
		{
			RenderTextureDescriptor compatibleDescriptor = GetCompatibleDescriptor();
			if (requireReAlloc)
			{
				bool flag = RenderingUtils.ReAllocateIfNeeded(name: m_DirBlurHandle.name, handle: ref m_DirBlurHandle, descriptor: in compatibleDescriptor, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
			}
			else
			{
				m_DirBlurHandle = RTHandles.Alloc(in compatibleDescriptor, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, Property.DirBlurName);
			}
		}

		private void UpdateDirectionalBlur(CommandBuffer cmd, Material material)
{
			string keyword;
			string keyword2;
			switch (directionalBlur.blurType.value)
			{
			default:
				return;
			case 0:
			{
				cmd.SetGlobalFloat(Property.DirBlurStrength, directionalBlur.blurStrength.value);
				float sine = default;
				float cosine = default;
				float radians = (90f - directionalBlur.blurDirection.value) * Mathf.Deg2Rad;
                sine = Mathf.Sin(radians);
                cosine = Mathf.Cos(radians);
				cmd.SetGlobalVector(Property.DirBlurDirection, new Vector4
				{
					x = cosine,
					y = sine
				});
				keyword = "_RADIAL_BLUR";
				keyword2 = "_DIRECTIONAL_BLUR";
				break;
			}
			case 1:
			{
				cmd.SetGlobalFloat(Property.DirBlurStrength, directionalBlur.blurStrength.value);
				Vector2Parameter blurCenterPosition = directionalBlur.blurCenterPosition;
				int dirBlurCenterPosition = Property.DirBlurCenterPosition;
				Vector2 value = blurCenterPosition.value;
				cmd.SetGlobalVector(dirBlurCenterPosition, new Vector4
				{
					x = value.x,
					y = value.y
				});
				keyword = "_DIRECTIONAL_BLUR";
				keyword2 = "_RADIAL_BLUR";
				break;
			}
			}
			material.EnableKeyword(keyword2);
			material.DisableKeyword(keyword);
		}

		private void DisableDirectionalBlurKeyword(Material material)
		{
			material.DisableKeyword("_DIRECTIONAL_BLUR");
			material.DisableKeyword("_RADIAL_BLUR");
		}

		private void DisposeDirBlurHandle()
		{
			m_DirBlurHandle?.Release();
			m_DirBlurHandle = null;
		}

		private void AllocSMAAHandle(bool requireReAllocate)
		{
			RenderTextureDescriptor compatibleDescriptor = GetCompatibleDescriptor();
			RenderTextureDescriptor renderTextureDescriptor = compatibleDescriptor;
			renderTextureDescriptor.depthBufferBits = 0;
			GraphicsFormat sMAAFormat = QualitySettings.activeColorSpace == ColorSpace.Linear ? GraphicsFormat.R8G8B8A8_SRGB : GraphicsFormat.R8G8B8A8_UNorm;
			RenderTextureDescriptor renderTextureDescriptor2 = renderTextureDescriptor;
			renderTextureDescriptor2.graphicsFormat = sMAAFormat;
			if (requireReAllocate)
			{
				bool flag = RenderingUtils.ReAllocateIfNeeded(name: Property.SmaaTemp, handle: ref m_SmaaHandle, descriptor: in renderTextureDescriptor2, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
			}
			else
			{
				m_SmaaHandle = RTHandles.Alloc(in renderTextureDescriptor2, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, Property.SmaaTemp);
			}
		}

		private void DoSubpixelMorphologicalAntialiasing(ref CameraData cameraData, CommandBuffer cmd, RTHandle source, RTHandle destination)
		{
			MaterialLibrary materialLibrary = materials;
			if (materialLibrary == null)
			{
				throw new NullReferenceException();
			}
			RenderTargetIdentifier nameID = buffer.DepthAttachment.nameID;
			int width = ((RenderTextureDescriptor)cameraData.cameraTargetDescriptor).width;
			int height = ((RenderTextureDescriptor)cameraData.cameraTargetDescriptor).height;
			Material subpixelMorphologicalAntialiasing = materialLibrary.subpixelMorphologicalAntialiasing;
			float x = Vector2.zero.x;
			float y = Vector2.zero.y;
			RTHandle edgeStencilTexture;
			if (!(nameID == BuiltinRenderTextureType.CameraTarget) && ((RenderTextureDescriptor)descriptor).msaaSamples < 2)
			{
				edgeStencilTexture = buffer.DepthAttachment;
			}
			else
			{
				int width2 = ((RenderTextureDescriptor)descriptor).width;
				int height2 = ((RenderTextureDescriptor)descriptor).height;
				RenderTextureDescriptor renderTextureDescriptor = descriptor;
				renderTextureDescriptor.depthBufferBits = 24;
				RenderTextureDescriptor renderTextureDescriptor2 = renderTextureDescriptor;
				renderTextureDescriptor2.width = width2;
				renderTextureDescriptor2.height = height2;
				renderTextureDescriptor2.msaaSamples = 1;
				RenderTextureDescriptor renderTextureDescriptor3 = renderTextureDescriptor2;
				renderTextureDescriptor3.graphicsFormat = GraphicsFormat.None;
				bool flag = RenderingUtils.ReAllocateIfNeeded(name: Property.EdgeStencilTexture, handle: ref m_EdgeStencilTexture, descriptor: in renderTextureDescriptor3, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
				edgeStencilTexture = m_EdgeStencilTexture;
			}
			int width3 = ((RenderTextureDescriptor)descriptor).width;
			int height3 = ((RenderTextureDescriptor)descriptor).height;
			RenderTextureDescriptor renderTextureDescriptor4 = descriptor;
			GraphicsFormat sMAAEdgeFormat = m_SMAAEdgeFormat;
			renderTextureDescriptor4.depthBufferBits = 0;
			RenderTextureDescriptor renderTextureDescriptor5 = renderTextureDescriptor4;
			renderTextureDescriptor5.width = width3;
			renderTextureDescriptor5.height = height3;
			renderTextureDescriptor5.msaaSamples = 1;
			RenderTextureDescriptor renderTextureDescriptor6 = renderTextureDescriptor5;
			renderTextureDescriptor6.graphicsFormat = sMAAEdgeFormat;
			bool flag2 = RenderingUtils.ReAllocateIfNeeded(name: Property.EdgeColorTexture, handle: ref m_EdgeColorTexture, descriptor: in renderTextureDescriptor6, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
			RTHandle edgeColorTexture = m_EdgeColorTexture;
			Vector2Int vector2Int = ((!edgeColorTexture.useScaling) ? new Vector2Int(edgeColorTexture.rt.width, m_EdgeColorTexture.rt.height) : edgeColorTexture.rtHandleProperties.currentRenderTargetSize);
			cmd.SetGlobalVector(Property.Metrics, new Vector4
			{
				x = 1f / (float)vector2Int.x,
				y = 1f / (float)vector2Int.y,
				z = vector2Int.x,
				w = vector2Int.y
			});
			cmd.SetGlobalTexture(Property.AreaTexture, textures.smaaAreaTex);
			cmd.SetGlobalTexture(Property.SearchTexture, textures.smaaSearchTex);
			cmd.SetGlobalFloat(Property.StencilRef, 64f);
			cmd.SetGlobalFloat(Property.StencilMask, 64f);
			subpixelMorphologicalAntialiasing.shaderKeywords = null;
			if ((uint)cameraData.antialiasingQuality <= 2u)
			{
				subpixelMorphologicalAntialiasing.EnableKeyword((cameraData.antialiasingQuality == AntialiasingQuality.Low) ? "_SMAA_PRESET_LOW" : ((cameraData.antialiasingQuality != AntialiasingQuality.Medium) ? "_SMAA_PRESET_HIGH" : "_SMAA_PRESET_MEDIUM"));
			}
			PostBlit.Blit(destinationColor: m_EdgeColorTexture, cmd: cmd, source: source, viewport: new Rect(x, y, width, height), colorLoadAction: RenderBufferLoadAction.DontCare, colorStoreAction: RenderBufferStoreAction.Store, destinationDepthStencil: edgeStencilTexture, depthStencilLoadAction: RenderBufferLoadAction.DontCare, depthStencilStoreAction: RenderBufferStoreAction.Store, clearFlag: ClearFlag.ColorStencil, clearColor: default, material: subpixelMorphologicalAntialiasing);
			SekaiBuffer sekaiBuffer = buffer;
			PostBlit.Blit(source: m_EdgeColorTexture, destination: sekaiBuffer.SekaiBufferBrightnessHandle, cmd: cmd, viewport: new Rect(x, y, width, height), loadAction: RenderBufferLoadAction.DontCare, storeAction: RenderBufferStoreAction.Store, clearFlag: ClearFlag.None, clearColor: default, material: subpixelMorphologicalAntialiasing, passIndex: 1);
			cmd.SetGlobalTexture(Property.BlendTexture, buffer.SekaiBufferBrightnessHandle);
			Blitter.BlitCameraTexture(cmd, source, destination, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, subpixelMorphologicalAntialiasing, 2);
		}

		private void DisposeSMAAHandle()
		{
			m_SmaaHandle?.Release();
			m_SmaaHandle = null;
		}

		private void GaussianBlur(CommandBuffer cmd, RTHandle source)
		{
			RTHandle[] boxBlurHandle = m_BoxBlurHandle;
			if (boxBlurHandle.Length == 0)
			{
				throw new IndexOutOfRangeException();
			}
			int width = postWidth;
			int height = postHeight;
			GraphicsFormat graphicsFormat = boxBlurHandle[0].rt.graphicsFormat;
			RenderTextureDescriptor renderTextureDescriptor = descriptor;
			renderTextureDescriptor.depthBufferBits = 0;
			RenderTextureDescriptor renderTextureDescriptor2 = renderTextureDescriptor;
			renderTextureDescriptor2.width = width;
			renderTextureDescriptor2.height = height;
			renderTextureDescriptor2.msaaSamples = 1;
			RenderTextureDescriptor renderTextureDescriptor3 = renderTextureDescriptor2;
			renderTextureDescriptor3.graphicsFormat = graphicsFormat;
			string name = Property.BoxBlurTexNames[0];
			if (boxBlurHandle.Length == 0)
			{
				throw new IndexOutOfRangeException();
			}
			bool flag = RenderingUtils.ReAllocateIfNeeded(ref boxBlurHandle[0], in renderTextureDescriptor3, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, name);
			RTHandle[] boxBlurHandle2 = m_BoxBlurHandle;
			if (boxBlurHandle2.Length == 0)
			{
				throw new IndexOutOfRangeException();
			}
			MaterialLibrary materialLibrary = materials;
			if (materialLibrary == null)
			{
				throw new NullReferenceException();
			}
			Blitter.BlitCameraTexture(cmd, source, boxBlurHandle2[0], materialLibrary.uber, 6);
			RTHandle[] boxBlurHandle3 = m_BoxBlurHandle;
			if (boxBlurHandle3.Length == 0)
			{
				throw new IndexOutOfRangeException();
			}
			MaterialLibrary materialLibrary2 = materials;
			if (materialLibrary2 == null)
			{
				throw new NullReferenceException();
			}
			Blitter.BlitCameraTexture(cmd, boxBlurHandle3[0], source, materialLibrary2.uber, 7);
		}

		private void UpdateBlur(CommandBuffer cmd)
		{
			Blitter.BlitCameraTexture(cmd, buffer.SekaiBufferColorHandle, m_BlurHandle, materials.uber, 0);
			BoxBlur(cmd, m_BlurHandle);
		}

		private void BoxBlur(CommandBuffer cmd, RTHandle source)
		{
			int num = Property.BoxBlurTexNames.Length;
			RTHandle[] boxBlurHandle;
			if (num >= 1)
			{
				int num2 = postHeight;
				int num3 = postWidth;
				boxBlurHandle = m_BoxBlurHandle;
				long num4 = 0L;
				int num5 = 0;
				RTHandle rTHandle = source;
				while (true)
				{
					GraphicsFormat graphicsFormat = boxBlurHandle[(nint)num4].rt.graphicsFormat;
					RenderTextureDescriptor renderTextureDescriptor = descriptor;
					renderTextureDescriptor.depthBufferBits = 0;
					RenderTextureDescriptor renderTextureDescriptor2 = renderTextureDescriptor;
					renderTextureDescriptor2.width = num3;
					renderTextureDescriptor2.height = num2;
					renderTextureDescriptor2.msaaSamples = 1;
					RenderTextureDescriptor renderTextureDescriptor3 = renderTextureDescriptor2;
					renderTextureDescriptor3.graphicsFormat = graphicsFormat;
					string name = Property.BoxBlurTexNames[(nint)num4];
					if ((uint)num5 >= (uint)boxBlurHandle.Length)
					{
						throw new IndexOutOfRangeException();
					}
					bool flag = RenderingUtils.ReAllocateIfNeeded(ref boxBlurHandle[(nint)num4], in renderTextureDescriptor3, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, name);
					RTHandle[] boxBlurHandle2 = m_BoxBlurHandle;
					if ((uint)num5 >= (uint)boxBlurHandle2.Length)
					{
						throw new IndexOutOfRangeException();
					}
					MaterialLibrary materialLibrary = materials;
					if (materialLibrary == null)
					{
						throw new NullReferenceException();
					}
					Blitter.BlitCameraTexture(cmd, rTHandle, boxBlurHandle2[(nint)num4], materialLibrary.boxBlur, 0);
					boxBlurHandle = m_BoxBlurHandle;
					rTHandle = boxBlurHandle[(nint)num4];
					if (num == num5 + 1)
					{
						break;
					}
					ulong num6 = (uint)(num5 + 1);
					int num7 = (int)((uint)((num3 < 0) ? (num3 + 1) : num3) >> 1 << 1) >> 1;
					int num8 = (int)((uint)((num2 < 0) ? (num2 + 1) : num2) >> 1 << 1) >> 1;
					num5++;
					num2 = num8;
					num3 = num7;
					num4 = (long)num6;
				}
			}
			else
			{
				boxBlurHandle = m_BoxBlurHandle;
			}
			long num9 = num + -1;
			uint num10 = (uint)(num + -1);
			int num11;
			while (true)
			{
				num11 = boxBlurHandle.Length;
				if (num9 <= 0L)
				{
					break;
				}
				if (num10 >= (uint)num11)
				{
					throw new IndexOutOfRangeException();
				}
				if ((uint)((int)num10 + -1) >= (uint)num11)
				{
					throw new IndexOutOfRangeException();
				}
				MaterialLibrary materialLibrary2 = materials;
				if (materialLibrary2 == null)
				{
					throw new NullReferenceException();
				}
				Blitter.BlitCameraTexture(cmd, boxBlurHandle[(nint)num9], boxBlurHandle[(nint)(num9 + -1L)], materialLibrary2.boxBlur, 1);
				boxBlurHandle = m_BoxBlurHandle;
				if (boxBlurHandle != null)
				{
					num9 += -1L;
					num10 += uint.MaxValue;
					continue;
				}
				throw new NullReferenceException();
			}
			if (num11 == 0)
			{
				throw new IndexOutOfRangeException();
			}
			MaterialLibrary materialLibrary3 = materials;
			if (materialLibrary3 == null)
			{
				throw new NullReferenceException();
			}
			Blitter.BlitCameraTexture(cmd, boxBlurHandle[0], source, materialLibrary3.boxBlur, 1);
		}

		private void DisposeBlurHandle()
		{
			m_BlurHandle?.Release();
			m_BlurHandle = null;
			if (m_BoxBlurHandle == null)
			{
				return;
			}
			for (long num = 0L; num < Property.BoxBlurTexNames.Length; num++)
			{
				RTHandle[] boxBlurHandle = m_BoxBlurHandle;
				RTHandle rTHandle = boxBlurHandle[(nint)num];
				if (rTHandle != null)
				{
					rTHandle.Release();
					boxBlurHandle = m_BoxBlurHandle;
				}
				boxBlurHandle[(nint)num] = null;
			}
			m_BoxBlurHandle = null;
		}

		private void AllocSekaiDofHandle(int postWidth, int postHeight, bool requireReAllocate)
		{
			int width = ((RenderTextureDescriptor)descriptor).width;
			int height = ((RenderTextureDescriptor)descriptor).height;
			RenderTextureDescriptor renderTextureDescriptor = descriptor;
			renderTextureDescriptor.depthBufferBits = 0;
			RenderTextureDescriptor renderTextureDescriptor2 = renderTextureDescriptor;
			renderTextureDescriptor2.width = width;
			renderTextureDescriptor2.height = height;
			renderTextureDescriptor2.msaaSamples = 1;
			RenderTextureDescriptor renderTextureDescriptor3 = renderTextureDescriptor2;
			renderTextureDescriptor3.graphicsFormat = GraphicsFormat.R8G8B8A8_UNorm;
			RenderTextureDescriptor renderTextureDescriptor4 = descriptor;
			renderTextureDescriptor4.depthBufferBits = 0;
			RenderTextureDescriptor renderTextureDescriptor5 = renderTextureDescriptor4;
			renderTextureDescriptor5.width = postWidth;
			renderTextureDescriptor5.height = postHeight;
			renderTextureDescriptor5.msaaSamples = 1;
			RenderTextureDescriptor renderTextureDescriptor6 = renderTextureDescriptor5;
			renderTextureDescriptor6.graphicsFormat = GraphicsFormat.R8G8B8A8_UNorm;
			RenderTextureDescriptor renderTextureDescriptor7 = descriptor;
			renderTextureDescriptor7.depthBufferBits = 0;
			RenderTextureDescriptor renderTextureDescriptor8 = renderTextureDescriptor7;
			renderTextureDescriptor8.width = (int)((uint)((postWidth < 0) ? (postWidth + 1) : postWidth) >> 1 << 1) >> 1;
			renderTextureDescriptor8.height = (int)((uint)((postHeight < 0) ? (postHeight + 1) : postHeight) >> 1 << 1) >> 1;
			renderTextureDescriptor8.msaaSamples = 1;
			RenderTextureDescriptor renderTextureDescriptor9 = renderTextureDescriptor8;
			renderTextureDescriptor9.graphicsFormat = GraphicsFormat.R8G8B8A8_UNorm;
			RenderTextureDescriptor compatibleDescriptor = GetCompatibleDescriptor();
			if (requireReAllocate)
			{
				bool flag = RenderingUtils.ReAllocateIfNeeded(name: m_DofTex.name, handle: ref m_DofTex, descriptor: in compatibleDescriptor, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
				bool flag2 = RenderingUtils.ReAllocateIfNeeded(name: m_CoCHandle.name, handle: ref m_CoCHandle, descriptor: in renderTextureDescriptor3, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
				RTHandle[] blurMidHandle = m_BlurMidHandle;
				bool flag3 = RenderingUtils.ReAllocateIfNeeded(name: blurMidHandle[0].name, handle: ref blurMidHandle[0], descriptor: (RenderTextureDescriptor)renderTextureDescriptor6, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
				RTHandle[] blurMidHandle2 = m_BlurMidHandle;
				bool flag4 = RenderingUtils.ReAllocateIfNeeded(name: blurMidHandle2[1].name, handle: ref blurMidHandle2[1], descriptor: (RenderTextureDescriptor)renderTextureDescriptor6, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
				RTHandle[] blurLowHandle = m_BlurLowHandle;
				bool flag5 = RenderingUtils.ReAllocateIfNeeded(name: blurLowHandle[0].name, handle: ref blurLowHandle[0], descriptor: (RenderTextureDescriptor)renderTextureDescriptor9, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
				RTHandle[] blurLowHandle2 = m_BlurLowHandle;
				bool flag6 = RenderingUtils.ReAllocateIfNeeded(name: blurLowHandle2[1].name, handle: ref blurLowHandle2[1], descriptor: (RenderTextureDescriptor)renderTextureDescriptor9, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
				RTHandle[] blurTmpHandle = m_BlurTmpHandle;
				bool flag7 = RenderingUtils.ReAllocateIfNeeded(name: blurTmpHandle[0].name, handle: ref blurTmpHandle[0], descriptor: in renderTextureDescriptor6, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
				RTHandle[] blurTmpHandle2 = m_BlurTmpHandle;
				bool flag8 = RenderingUtils.ReAllocateIfNeeded(name: blurTmpHandle2[1].name, handle: ref blurTmpHandle2[1], descriptor: in renderTextureDescriptor9, filterMode: FilterMode.Bilinear, wrapMode: TextureWrapMode.Clamp);
			}
			else
			{
				m_DofTex = RTHandles.Alloc(in compatibleDescriptor, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, Property.DofTexName);
				m_CoCHandle = RTHandles.Alloc(in renderTextureDescriptor3, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, Property.ColorCoCTexName);
				m_BlurMidHandle = new RTHandle[2];
				string name = Property.BlurMidNames[0];
				RTHandle[] blurMidHandle3 = m_BlurMidHandle;
				RTHandle rTHandle = RTHandles.Alloc((RenderTextureDescriptor)renderTextureDescriptor6, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, name);
				if (blurMidHandle3 == null)
				{
					throw new NullReferenceException();
				}
				if (rTHandle != null)
				{
					object obj = rTHandle;
					if (((!blurMidHandle3.GetType().GetElementType().IsInstanceOfType(obj)) ? null : obj) == null)
					{
						throw new ArrayTypeMismatchException();
					}
				}
				blurMidHandle3[0] = rTHandle;
				string name2 = Property.BlurMidNames[1];
				RTHandle[] blurMidHandle4 = m_BlurMidHandle;
				RTHandle rTHandle2 = RTHandles.Alloc((RenderTextureDescriptor)renderTextureDescriptor6, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, name2);
				if (blurMidHandle4 == null)
				{
					throw new NullReferenceException();
				}
				if (rTHandle2 != null)
				{
					object obj2 = rTHandle2;
					if (((!blurMidHandle4.GetType().GetElementType().IsInstanceOfType(obj2)) ? null : obj2) == null)
					{
						throw new ArrayTypeMismatchException();
					}
				}
				blurMidHandle4[1] = rTHandle2;
				m_BlurLowHandle = new RTHandle[2];
				string name3 = Property.BlurLowNames[0];
				RTHandle[] blurLowHandle3 = m_BlurLowHandle;
				RTHandle rTHandle3 = RTHandles.Alloc((RenderTextureDescriptor)renderTextureDescriptor9, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, name3);
				if (blurLowHandle3 == null)
				{
					throw new NullReferenceException();
				}
				if (rTHandle3 != null)
				{
					object obj3 = rTHandle3;
					if (((!blurLowHandle3.GetType().GetElementType().IsInstanceOfType(obj3)) ? null : obj3) == null)
					{
						throw new ArrayTypeMismatchException();
					}
				}
				blurLowHandle3[0] = rTHandle3;
				string name4 = Property.BlurLowNames[1];
				RTHandle[] blurLowHandle4 = m_BlurLowHandle;
				RTHandle rTHandle4 = RTHandles.Alloc(in renderTextureDescriptor9, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, name4);
				if (blurLowHandle4 == null)
				{
					throw new NullReferenceException();
				}
				if (rTHandle4 != null)
				{
					object obj4 = rTHandle4;
					if (((!blurLowHandle4.GetType().GetElementType().IsInstanceOfType(obj4)) ? null : obj4) == null)
					{
						throw new ArrayTypeMismatchException();
					}
				}
				blurLowHandle4[1] = rTHandle4;
				m_BlurTmpHandle = new RTHandle[2];
				string name5 = Property.BlurTmpName[0];
				RTHandle[] blurTmpHandle3 = m_BlurTmpHandle;
				RTHandle rTHandle5 = RTHandles.Alloc((RenderTextureDescriptor)renderTextureDescriptor6, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, name5);
				if (blurTmpHandle3 == null)
				{
					throw new NullReferenceException();
				}
				if (rTHandle5 != null)
				{
					object obj5 = rTHandle5;
					if (((!blurTmpHandle3.GetType().GetElementType().IsInstanceOfType(obj5)) ? null : obj5) == null)
					{
						throw new ArrayTypeMismatchException();
					}
				}
				blurTmpHandle3[0] = rTHandle5;
				string name6 = Property.BlurTmpName[1];
				RTHandle[] blurTmpHandle4 = m_BlurTmpHandle;
				RTHandle rTHandle6 = RTHandles.Alloc(in renderTextureDescriptor6, FilterMode.Bilinear, TextureWrapMode.Clamp, isShadowMap: false, 1, 0f, name6);
				if (blurTmpHandle4 == null)
				{
					throw new NullReferenceException();
				}
				if (rTHandle6 != null)
				{
					object obj6 = rTHandle6;
					if (((!blurTmpHandle4.GetType().GetElementType().IsInstanceOfType(obj6)) ? null : obj6) == null)
					{
						throw new ArrayTypeMismatchException();
					}
					blurTmpHandle4[1] = rTHandle6;
					m_BlurMidTexIdentifiers = new RenderTargetIdentifier[2];
				}
				else
				{
					blurTmpHandle4[1] = rTHandle6;
					m_BlurMidTexIdentifiers = new RenderTargetIdentifier[2];
				}
			}
			RTHandle rTHandle7 = m_BlurMidHandle[0];
			RenderTargetIdentifier[] blurMidTexIdentifiers = m_BlurMidTexIdentifiers;
			RenderTargetIdentifier nameID = rTHandle7.nameID;
			if (blurMidTexIdentifiers.Length == 0)
			{
				throw new IndexOutOfRangeException();
			}
			blurMidTexIdentifiers[0] = nameID;
			RTHandle rTHandle8 = m_BlurMidHandle[1];
			RenderTargetIdentifier[] blurMidTexIdentifiers2 = m_BlurMidTexIdentifiers;
			RenderTargetIdentifier nameID2 = rTHandle8.nameID;
			if (1u >= (uint)blurMidTexIdentifiers2.Length)
			{
				throw new IndexOutOfRangeException();
			}
			blurMidTexIdentifiers2[1] = nameID2;
		}

		private void DisposeSekaiDofHandle()
		{
			m_DofTex?.Release();
			m_DofTex = null;
			m_CoCHandle?.Release();
			m_CoCHandle = null;
			RTHandle[] blurMidHandle = m_BlurMidHandle;
			if (blurMidHandle != null)
			{
				for (long num = 0L; num < blurMidHandle.Length; num++)
				{
					RTHandle rTHandle = blurMidHandle[(nint)num];
					if (rTHandle != null)
					{
						rTHandle.Release();
						blurMidHandle = m_BlurMidHandle;
					}
					blurMidHandle[(nint)num] = null;
					blurMidHandle = m_BlurMidHandle;
					if (blurMidHandle == null)
					{
						throw new NullReferenceException();
					}
				}
				m_BlurMidHandle = null;
			}
			RTHandle[] blurLowHandle = m_BlurLowHandle;
			if (blurLowHandle != null)
			{
				for (long num2 = 0L; num2 < blurLowHandle.Length; num2++)
				{
					RTHandle rTHandle2 = blurLowHandle[(nint)num2];
					if (rTHandle2 != null)
					{
						rTHandle2.Release();
						blurLowHandle = m_BlurLowHandle;
					}
					blurLowHandle[(nint)num2] = null;
					blurLowHandle = m_BlurLowHandle;
					if (blurLowHandle == null)
					{
						throw new NullReferenceException();
					}
				}
				m_BlurLowHandle = null;
			}
			RTHandle[] blurTmpHandle = m_BlurTmpHandle;
			if (blurTmpHandle == null)
			{
				return;
			}
			for (long num3 = 0L; num3 < blurTmpHandle.Length; num3++)
			{
				RTHandle rTHandle3 = blurTmpHandle[(nint)num3];
				if (rTHandle3 != null)
				{
					rTHandle3.Release();
					blurTmpHandle = m_BlurTmpHandle;
				}
				blurTmpHandle[(nint)num3] = null;
				blurTmpHandle = m_BlurTmpHandle;
				if (blurTmpHandle == null)
				{
					throw new NullReferenceException();
				}
			}
			m_BlurTmpHandle = null;
			return;
		}

		private void UpdateSekaiDof(CommandBuffer cmd, RTHandle source, RTHandle destination, Material material)
		{
			RTHandle dofTex = m_DofTex;
			SekaiBuffer sekaiBuffer = buffer;
			string name = dofTex.name;
			RenderTargetIdentifier value = sekaiBuffer.SekaiBufferDepthHandle.rt;
			if (cmd == null)
			{
				throw new NullReferenceException();
			}
			cmd.SetGlobalTexture(name, value);
			RenderTextureDescriptor desc = descriptor;
			int num = postWidth;
			int num2 = postHeight;
			cmd.SetGlobalVector("_SourceSize", new Vector4(desc.width, desc.height, 1f / desc.width, 1f / desc.height));
			Blitter.BlitCameraTexture(cmd, source, m_CoCHandle, material, 0);
			RenderTargetIdentifier[] blurMidTexIdentifiers = m_BlurMidTexIdentifiers;
			if (blurMidTexIdentifiers.Length == 0)
			{
				throw new IndexOutOfRangeException();
			}
			CoreUtils.SetRenderTarget(cmd, blurMidTexIdentifiers, blurMidTexIdentifiers[0]);
			float y;
			float x2;
			if (source.useScaling)
			{
				RTHandleProperties rtHandleProperties = source.rtHandleProperties;
				RTHandleProperties rtHandleProperties2 = source.rtHandleProperties;
				float x = rtHandleProperties.rtHandleScale.x;
				y = rtHandleProperties2.rtHandleScale.y;
				x2 = x;
			}
			else
			{
				x2 = Vector2.one.x;
				y = Vector2.one.y;
			}
			Blitter.BlitTexture(cmd, m_CoCHandle, new Vector4
			{
				x = x2,
				y = y
			}, material, 1);
			cmd.SetGlobalVector(Property.InvRenderTargetSize, new Vector4
			{
				x = 1f / (float)num,
				y = 1f / (float)num2
			});
			RTHandle[] blurMidHandle = m_BlurMidHandle;
			if (blurMidHandle.Length == 0)
			{
				throw new IndexOutOfRangeException();
			}
			RTHandle[] blurTmpHandle = m_BlurTmpHandle;
			if (blurTmpHandle.Length == 0)
			{
				throw new IndexOutOfRangeException();
			}
			RTHandle rTHandle = blurMidHandle[0];
			Blur(cmd, rTHandle, rTHandle, blurTmpHandle[0], material, 2, (float)num / (float)num2, 1f / ((float)num2 + (float)num2));
			cmd.SetGlobalVector(Property.InvRenderTargetSize, new Vector4
			{
				x = 1f / ((float)num * 0.5f),
				y = 1f / ((float)num2 * 0.5f)
			});
			RTHandle[] blurMidHandle2 = m_BlurMidHandle;
			if (blurMidHandle2.Length == 0)
			{
				throw new IndexOutOfRangeException();
			}
			RTHandle[] blurLowHandle = m_BlurLowHandle;
			if (blurLowHandle.Length == 0)
			{
				throw new IndexOutOfRangeException();
			}
			Blitter.BlitCameraTexture(cmd, blurMidHandle2[0], blurLowHandle[0], material, 4);
			RTHandle[] blurLowHandle2 = m_BlurLowHandle;
			if (blurLowHandle2.Length == 0)
			{
				throw new IndexOutOfRangeException();
			}
			RTHandle[] blurTmpHandle2 = m_BlurTmpHandle;
			if (1u >= (uint)blurTmpHandle2.Length)
			{
				throw new IndexOutOfRangeException();
			}
			RTHandle rTHandle2 = blurLowHandle2[0];
			Blur(cmd, rTHandle2, rTHandle2, blurTmpHandle2[1], material, 3, (float)num / (float)num2, 1f / ((float)num2 + (float)num2));
			RTHandle[] blurMidHandle3 = m_BlurMidHandle;
			if (blurMidHandle3.Length == 0)
			{
				throw new IndexOutOfRangeException();
			}
			MaterialLibrary materialLibrary = materials;
			if (materialLibrary == null)
			{
				throw new NullReferenceException();
			}
			Blitter.BlitCameraTexture(destination: m_BlurHandle, cmd: cmd, source: blurMidHandle3[0], material: materialLibrary.uber, pass: 0);
			RTHandle coCHandle;
			int pass;
			if (sekaiDof.disableForeBokeh.value)
			{
				string[] blurLowNames = Property.BlurLowNames;
				if (blurLowNames.Length == 0)
				{
					throw new IndexOutOfRangeException();
				}
				cmd.SetGlobalTexture(blurLowNames[0], m_BlurLowHandle[0].rt);
				coCHandle = m_CoCHandle;
				pass = 8;
			}
			else
			{
				cmd.SetGlobalVector(Property.InvRenderTargetSize, new Vector4
				{
					x = 1f / (float)num,
					y = 1f / (float)num2
				});
				RTHandle[] blurMidHandle4 = m_BlurMidHandle;
				if (1u >= (uint)blurMidHandle4.Length)
				{
					throw new IndexOutOfRangeException();
				}
				RTHandle[] blurTmpHandle3 = m_BlurTmpHandle;
				if (blurTmpHandle3.Length == 0)
				{
					throw new IndexOutOfRangeException();
				}
				RTHandle rTHandle3 = blurMidHandle4[1];
				Blur(cmd, rTHandle3, rTHandle3, blurTmpHandle3[0], material, 5, (float)num / (float)num2, 1f / ((float)num2 + (float)num2));
				cmd.SetGlobalVector(Property.InvRenderTargetSize, new Vector4
				{
					x = 1f / ((float)num * 0.5f),
					y = 1f / ((float)num2 * 0.5f)
				});
				string[] blurMidNames = Property.BlurMidNames;
				if (1u >= (uint)blurMidNames.Length)
				{
					throw new IndexOutOfRangeException();
				}
				cmd.SetGlobalTexture(blurMidNames[1], m_BlurMidHandle[1].rt);
				RTHandle[] blurMidHandle5 = m_BlurMidHandle;
				if (1u >= (uint)blurMidHandle5.Length)
				{
					throw new IndexOutOfRangeException();
				}
				RTHandle[] blurLowHandle3 = m_BlurLowHandle;
				if (1u >= (uint)blurLowHandle3.Length)
				{
					throw new IndexOutOfRangeException();
				}
				Blitter.BlitCameraTexture(cmd, blurMidHandle5[1], blurLowHandle3[1], material, 4);
				string[] blurLowNames2 = Property.BlurLowNames;
				if (blurLowNames2.Length == 0)
				{
					throw new IndexOutOfRangeException();
				}
				cmd.SetGlobalTexture(blurLowNames2[0], m_BlurLowHandle[0].rt);
				string[] blurLowNames3 = Property.BlurLowNames;
				if (1u >= (uint)blurLowNames3.Length)
				{
					throw new IndexOutOfRangeException();
				}
				cmd.SetGlobalTexture(blurLowNames3[1], m_BlurLowHandle[1].rt);
				RTHandle[] blurLowHandle4 = m_BlurLowHandle;
				if (1u >= (uint)blurLowHandle4.Length)
				{
					throw new IndexOutOfRangeException();
				}
				RTHandle[] blurTmpHandle4 = m_BlurTmpHandle;
				if (1u >= (uint)blurTmpHandle4.Length)
				{
					throw new IndexOutOfRangeException();
				}
				RTHandle rTHandle4 = blurLowHandle4[1];
				Blur(cmd, rTHandle4, rTHandle4, blurTmpHandle4[1], material, 6, (float)num / (float)num2, 1f / ((float)num2 + (float)num2));
				coCHandle = m_CoCHandle;
				pass = 7;
			}
			Blitter.BlitCameraTexture(cmd, coCHandle, destination, material, pass);
		}

		private void Blur(CommandBuffer cmd, RTHandle from, RTHandle to, RTHandle sampling, Material material, int blurPass, float widthOverHeight, float oneOverBaseSize)
		{
			cmd.SetGlobalVector(Property.Offsets, new Vector4
			{
				y = oneOverBaseSize * 1.75f
			});
			Blitter.BlitCameraTexture(cmd, from, sampling, material, blurPass);
			cmd.SetGlobalVector(Property.Offsets, new Vector4
			{
				x = 1.75f / widthOverHeight * oneOverBaseSize
			});
			Blitter.BlitCameraTexture(cmd, sampling, to, material, blurPass);
		}
	}
}
