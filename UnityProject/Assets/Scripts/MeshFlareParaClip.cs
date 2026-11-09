// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/MeshFlareParaClip.cs。
using System;
using Sekai.Timeline.Common;
using UnityEngine;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	[Serializable]
	public class MeshFlareParaClip : PostEffectClipBase
	{
		[Serializable]
		public enum MeshBlendMode
		{
			Overwrite,
			Add,
			TransparentAdd,
			AlphaBlend,
			Multiply,
			MultiplyAdd
		}

		[SerializeField]
		private ReferenceEnumParam<MeshBlendMode> meshFlareParaBlendMode = new ReferenceEnumParam<MeshBlendMode>(MeshBlendMode.Overwrite);

		[SerializeField]
		private ReferenceColorBlend meshFlareParaColor = new ReferenceColorBlend(new Color
		{
			a = 1f
		});

		[SerializeField]
		private ReferenceVector3Blend meshFlareParaPosition = new ReferenceVector3Blend(Vector3.zero);

		[SerializeField]
		private ReferenceVector2Blend meshFlareParaRadius = new ReferenceVector2Blend(Vector2.zero);

		[SerializeField]
		private ReferenceFloatBlend meshFlareParaTheta = new ReferenceFloatBlend();

		[SerializeField]
		private ReferenceVector2Blend meshFlareParaTiling = new ReferenceVector2Blend(Vector2.one);

		[SerializeField]
		private ReferenceBoolParam meshFlareParaZTest = new ReferenceBoolParam();

		public ReferenceEnumParam<MeshBlendMode> MeshFlareParaBlendMode => meshFlareParaBlendMode;

		public ReferenceColorBlend MeshFlareParaColor => meshFlareParaColor;

		public ReferenceVector3Blend MeshFlareParaPosition => meshFlareParaPosition;

		public ReferenceVector2Blend MeshFlareParaRadius => meshFlareParaRadius;

		public ReferenceFloatBlend MeshFlareParaTheta => meshFlareParaTheta;

		public ReferenceVector2Blend MeshFlareParaTiling => meshFlareParaTiling;

		public ReferenceBoolParam MeshFlareParaZTest => meshFlareParaZTest;

		public MeshFlareParaOrder ParamType { get; private set; }

		public override ClipCaps clipCaps => ClipCaps.None;

		public void SetParamType(MeshFlareParaOrder paramType)
		{
			ParamType = paramType;
		}
	}
}
