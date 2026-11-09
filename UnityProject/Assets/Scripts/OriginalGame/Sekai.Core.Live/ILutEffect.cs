// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Core.Live/ILutEffect.cs。
using UnityEngine;

namespace Sekai.Core.Live
{
	public interface ILutEffect
	{
		void SetFrontLutTex(Texture3D frontLut);

		void SetBackLutTex(Texture3D backLut);

		void SetFrontLutBlend(float frontLutBlend);

		void SetBackLutBlend(float backLutBlend);

		void SetFrontLutPoint(Vector2 frontLutPoint);

		void SetFrontNonLutPoint(Vector2 frontNonLutPoint);

		void SetBackLutPoint(Vector2 backLutPoint);

		void SetBackNonLutPoint(Vector2 backNonLutPoint);
	}
}
