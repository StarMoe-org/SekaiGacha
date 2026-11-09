using UnityEngine;

namespace Sekai.Core
{
	public class MeshFlareParaTexData : ScriptableObject
	{
		[HideInInspector]
		[SerializeField]
		private int id;

		[Header("MeshFlarePara機能で用いるテクスチャ.")]
		[Header("注:配列数は3で固定にしてください.")]
		[SerializeField]
		private Texture2D[] _texture2Ds = new Texture2D[3];

		public Texture2D[] Texture2Ds => _texture2Ds;
	}
}
