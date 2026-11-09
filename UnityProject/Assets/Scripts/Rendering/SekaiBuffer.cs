using System;

using UnityEngine.Rendering.Universal;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;

namespace Sekai.Rendering {

public class SekaiBuffer
{
	internal enum BufferHandles
	{
		Color,
		Depth,
		Brightness,
		Count
	}

	private static class RenderTargetNames
	{
		public const string Color = "_ColorBuffer";

		public const string Depth = "_DepthBuffer";

		public const string Brightness = "_BrightnessBuffer";
	}

	private readonly RTHandle[] sekaiBufferHandles;

	private RTHandle depthAttachment;

	internal RTHandle[] SekaiBufferHandles => sekaiBufferHandles;

	internal RTHandle SekaiBufferColorHandle
	{
		get
		{
			RTHandle[] array = sekaiBufferHandles;
			if (array.Length == 0)
			{
				throw new IndexOutOfRangeException();
			}
			return array[0];
		}
	}

	internal RTHandle SekaiBufferDepthHandle
	{
		get
		{
			RTHandle[] array = sekaiBufferHandles;
			if (1u >= (uint)array.Length)
			{
				throw new IndexOutOfRangeException();
			}
			return array[1];
		}
	}

	internal RTHandle SekaiBufferBrightnessHandle
	{
		get
		{
			RTHandle[] array = sekaiBufferHandles;
			if (2u >= (uint)array.Length)
			{
				throw new IndexOutOfRangeException();
			}
			return array[2];
		}
	}

	internal RTHandle DepthAttachment => depthAttachment;

	internal GraphicsFormat[] SekaiBufferHandleFormats { get; }

	public FilterMode[] BufferFilterModes { get; }

	internal SekaiBuffer()
	{
		ColorSpace activeColorSpace = QualitySettings.activeColorSpace;
		SekaiBufferHandleFormats = new GraphicsFormat[3];
		GraphicsFormat[] array = SekaiBufferHandleFormats;
		int num = ((activeColorSpace != ColorSpace.Linear) ? 8 : 4);
		int num2 = array.Length;
		if (num2 == 0)
		{
			throw new IndexOutOfRangeException();
		}
		array[0] = (GraphicsFormat)num;
		if (num2 == 1)
		{
			throw new IndexOutOfRangeException();
		}
		array[1] = (GraphicsFormat)num;
		if (2u >= (uint)num2)
		{
			throw new IndexOutOfRangeException();
		}
		array[2] = (GraphicsFormat)num;
		BufferFilterModes = new FilterMode[3];
		FilterMode[] array2 = BufferFilterModes;
		int num3 = array2.Length;
		if (num3 == 0)
		{
			throw new IndexOutOfRangeException();
		}
		array2[0] = FilterMode.Point;
		if (num3 == 1)
		{
			throw new IndexOutOfRangeException();
		}
		array2[1] = FilterMode.Point;
		if (2u >= (uint)num3)
		{
			throw new IndexOutOfRangeException();
		}
		array2[2] = FilterMode.Point;
		SetupBufferAttachments(ref sekaiBufferHandles);
	}

	public void Setup(CommandBuffer cmd, RTHandle depthAttachment)
	{
		this.depthAttachment = depthAttachment;
		RTHandle[] array = sekaiBufferHandles;
		if (array == null)
		{
			return;
		}
		ulong num = (uint)array.Length;
		if (num == 0L || (int)num < 1)
		{
			return;
		}
		ulong num2 = num;
		RTHandle[] array2 = array;
		ulong num3 = 0uL;
		while (true)
		{
			if (num3 >= (uint)num2)
			{
				throw new IndexOutOfRangeException();
			}
			ClearRenderTarget(cmd, array2[(uint)num3]);
			RTHandle[] array3 = sekaiBufferHandles;
			ulong num4 = (uint)array3.Length;
			ulong num5 = num3 + 1L;
			if ((long)(num3 + 1L) >= (long)(int)num4)
			{
				break;
			}
			num2 = num4;
			array2 = array3;
			num3 = num5;
		}
	}

	private void ClearRenderTarget(CommandBuffer cmd, RTHandle handle)
	{
		cmd.SetRenderTarget(handle.nameID);
		cmd.ClearRenderTarget(clearDepth: false, clearColor: true, new Color(0f, 0f, 0f, 1f));
	}

    public void AllocSekaiBufferHandles(RenderTextureDescriptor cameraTextureDescriptor)
    {
        for (int i = 0; i < sekaiBufferHandles.Length; i++)
        {
            var descriptor = cameraTextureDescriptor;
            descriptor.depthBufferBits = 0;
            descriptor.stencilFormat = GraphicsFormat.None;
            descriptor.graphicsFormat = SekaiBufferHandleFormats[i];
            RenderingUtils.ReAllocateIfNeeded(ref sekaiBufferHandles[i], descriptor, BufferFilterModes[i], TextureWrapMode.Clamp, name: sekaiBufferHandles[i].name);
        }
    }

	public void ReleaseMRT()
	{
		RTHandle[] array = sekaiBufferHandles;
		if (array == null)
		{
			return;
		}
		RTHandle[] array2 = array;
		long num = 0L;
		while (true)
		{
			if ((int)num >= array2.Length)
			{
				return;
			}
			array2[(int)num].Release();
			RTHandle[] array3 = sekaiBufferHandles;
			long num2 = num + 1L;
			if (array3 == null)
			{
				break;
			}
			array2 = array3;
			num = num2;
		}
		throw new NullReferenceException();
	}

	private void SetupBufferAttachments(ref RTHandle[] sekaiBufferHandles)
	{
		sekaiBufferHandles = new RTHandle[3];
		string[] array = new string[3] { "_ColorBuffer", "_DepthBuffer", "_BrightnessBuffer" };
		int nameID = Shader.PropertyToID("_ColorBuffer");
		int nameID2 = Shader.PropertyToID("_DepthBuffer");
		int nameID3 = Shader.PropertyToID("_BrightnessBuffer");
		RenderTargetIdentifier[] array2 = new RenderTargetIdentifier[3];
		RenderTargetIdentifier renderTargetIdentifier = default;
		renderTargetIdentifier = new RenderTargetIdentifier(nameID);
		array2[0] = renderTargetIdentifier;
		RenderTargetIdentifier renderTargetIdentifier2 = default;
		renderTargetIdentifier2 = new RenderTargetIdentifier(nameID2);
		array2[1] = renderTargetIdentifier2;
		RenderTargetIdentifier renderTargetIdentifier3 = default;
		renderTargetIdentifier3 = new RenderTargetIdentifier(nameID3);
		array2[2] = renderTargetIdentifier3;
		RTHandle[] array3 = sekaiBufferHandles;
		if (array3 == null)
		{
			throw new NullReferenceException();
		}
		ulong num = 0uL;
		RTHandle[] array4 = array3;
		while (true)
		{
			if ((long)num >= (long)array4.Length)
			{
				return;
			}
			if (num >= 3L)
			{
				throw new IndexOutOfRangeException();
			}
			RTHandle rTHandle = RTHandles.Alloc(array2[(uint)num], array[(uint)num]);
			if (rTHandle != null && ((!array4.GetType().GetElementType().IsInstanceOfType(rTHandle)) ? null : rTHandle) == null)
			{
				throw new ArrayTypeMismatchException();
			}
			ulong num2 = (uint)array4.Length;
			array4[(uint)num] = rTHandle;
			RTHandle[] array5 = sekaiBufferHandles;
			ulong num3 = num + 1L;
			if (array5 == null)
			{
				break;
			}
			num = num3;
			array4 = array5;
		}
		throw new NullReferenceException();
	}
}

}
