using System;
using UnityEngine;

namespace Sekai.Rendering {

[Serializable]
public struct SekaiEyeTiling
{
	public int TileX;

	public int TileY;

	public int Sample;

	public Vector2 GetTileOffset()
	{
		int tileX = TileX;
		float x;
		float y;
		if (tileX != 0)
		{
			int tileY = TileY;
			if (tileY != 0)
			{
				int sample = Sample;
				int num = sample;
				int num2 = sample;
				int num3 = tileX;
				int num4 = num2;
				float num5 = (float)(num - num3 switch
				{
					0 => 0, 
					-1 => -num4, 
					_ => num4 / num3, 
				} * tileX) / (float)tileX;
				int num6 = sample;
				int num7 = tileY;
				int num8 = num6;
				float num9 = 1f - (float)(num7 switch
				{
					0 => 0, 
					-1 => -num8, 
					_ => num8 / num7, 
				}) / (float)tileY;
				x = num5;
				y = num9;
				goto IL_017f;
			}
		}
		float x2 = Vector2.zero.x;
		float y2 = Vector2.zero.y;
		x = x2;
		y = y2;
		goto IL_017f;
		IL_017f:
		return new Vector2(x, y);
	}
}

}
