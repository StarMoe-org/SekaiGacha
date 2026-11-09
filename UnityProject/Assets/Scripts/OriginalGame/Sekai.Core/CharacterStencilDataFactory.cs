// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core/CharacterStencilDataFactory.cs。
using UnityEngine.Rendering;

namespace Sekai.Core
{
	public static class CharacterStencilDataFactory
	{
		public static CharacterMaterialData Create(CharacterMaterialType type, int formationId)
		{
			uint renderQueue;
			uint stencilRef2;
			uint readMask;
			int writeMask;
			CompareFunction comp2;
			StencilOp pass2;
			int stencilRef;
			int num2;
			CompareFunction comp;
			StencilOp pass;
			if ((uint)type <= 8u)
			{
				switch (type)
				{
				default:
					renderQueue = 2000u;
					stencilRef2 = 0u;
					readMask = 255u;
					writeMask = 255;
					comp2 = CompareFunction.Always;
					pass2 = StencilOp.Replace;
					stencilRef = 0;
					num2 = 255;
					comp = CompareFunction.Disabled;
					pass = StencilOp.Keep;
					break;
				case CharacterMaterialType.Face:
					renderQueue = 2000u;
					stencilRef2 = 0u;
					readMask = 255u;
					writeMask = 255;
					comp2 = CompareFunction.Always;
					pass2 = StencilOp.Replace;
					stencilRef = 0;
					num2 = 255;
					comp = CompareFunction.Disabled;
					pass = StencilOp.Keep;
					break;
				case CharacterMaterialType.Eyebrow:
					renderQueue = 2001u;
					goto IL_0343;
				case CharacterMaterialType.Eyelash:
					renderQueue = 2001u;
					goto IL_0343;
				case CharacterMaterialType.EyeHighlight:
					renderQueue = 2000u;
					stencilRef2 = 0u;
					readMask = 255u;
					writeMask = 255;
					comp2 = CompareFunction.Always;
					pass2 = StencilOp.Replace;
					stencilRef = 0;
					num2 = 255;
					comp = CompareFunction.Disabled;
					pass = StencilOp.Keep;
					break;
				case CharacterMaterialType.Body:
					renderQueue = 2000u;
					stencilRef2 = 0u;
					readMask = 255u;
					writeMask = 255;
					comp2 = CompareFunction.Always;
					pass2 = StencilOp.Replace;
					stencilRef = 0;
					num2 = 255;
					comp = CompareFunction.Disabled;
					pass = StencilOp.Keep;
					break;
				case CharacterMaterialType.Acc:
					renderQueue = 2000u;
					stencilRef2 = 0u;
					readMask = 255u;
					writeMask = 255;
					comp2 = CompareFunction.Always;
					pass2 = StencilOp.Replace;
					stencilRef = 0;
					num2 = 255;
					comp = CompareFunction.Disabled;
					pass = StencilOp.Keep;
					break;
				case CharacterMaterialType.Other:
					renderQueue = 2000u;
					stencilRef2 = 0u;
					readMask = 255u;
					writeMask = 255;
					comp2 = CompareFunction.Always;
					pass2 = StencilOp.Replace;
					stencilRef = 0;
					num2 = 255;
					comp = CompareFunction.Disabled;
					pass = StencilOp.Keep;
					break;
				case CharacterMaterialType.Hair:
				{
					byte num = (byte)(~(byte)((1 << formationId) & 0xFF));
					pass = StencilOp.Keep;
					comp = CompareFunction.Disabled;
					num2 = 255;
					stencilRef = 0;
					pass2 = StencilOp.Replace;
					comp2 = CompareFunction.Always;
					writeMask = num;
					readMask = 255u;
					stencilRef2 = 0u;
					renderQueue = 2451u;
					break;
				}
				case CharacterMaterialType.Eye:
					{
						renderQueue = 2002u;
						goto IL_0343;
					}
					IL_0343:
					stencilRef2 = 255u;
					readMask = 255u;
					writeMask = 1 << formationId;
					comp2 = CompareFunction.Always;
					pass2 = StencilOp.Replace;
					stencilRef = 1 << formationId;
					num2 = 1 << formationId;
					comp = CompareFunction.Equal;
					pass = StencilOp.Zero;
					break;
				}
			}
			else
			{
				renderQueue = 0u;
				stencilRef2 = 0u;
				readMask = 0u;
				writeMask = 0;
				comp2 = CompareFunction.Disabled;
				pass2 = StencilOp.Keep;
				stencilRef = 0;
				num2 = 0;
				comp = CompareFunction.Disabled;
				pass = StencilOp.Keep;
			}
			return new CharacterMaterialData
			{
				RenderQueue = renderQueue,
				BaseStencil = 
				{
					StencilRef = stencilRef2,
					ReadMask = readMask,
					WriteMask = (uint)writeMask,
					Comp = comp2,
					Pass = pass2
				},
				OverlayStencil = 
				{
					StencilRef = (uint)stencilRef,
					ReadMask = (uint)num2,
					WriteMask = (uint)num2,
					Comp = comp,
					Pass = pass
				}
			};
		}
	}
}
