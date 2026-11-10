// 源自恢复工程 ThirdParty.SpringBone/UTJ/ForceProvider.cs。
using UnityEngine;

namespace UTJ
{
	public class ForceProvider : MonoBehaviour
	{
		public virtual Vector3 GetForceOnBone(SpringBone springBone)
		{
			return Vector3.zero;
		}
	}
}
