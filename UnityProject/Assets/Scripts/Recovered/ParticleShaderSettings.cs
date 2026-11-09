using System.Collections.Generic;
using UnityEngine;

namespace Sekai.Core.Live
{
	[ExecuteInEditMode]
	[RequireComponent(typeof(ParticleSystem))]
	public class ParticleShaderSettings : MonoBehaviour
	{
		public enum Mode
		{
			Additive,
			AlphaBlend
		}

		[SerializeField]
		private Mode mode;

		private List<ParticleSystemVertexStream> streams = new List<ParticleSystemVertexStream>();

		private void Awake()
		{
			UpdateMode();
		}

		private void UpdateMode()
		{
			ParticleSystemRenderer component = GetComponent<ParticleSystemRenderer>();
			if (component != null)
			{
				component.GetActiveVertexStreams(streams);
				if (!streams.Contains(ParticleSystemVertexStream.Custom1X))
				{
					streams.Add(ParticleSystemVertexStream.Custom1X);
				}
				component.SetActiveVertexStreams(streams);
			}
			ParticleSystem component2 = GetComponent<ParticleSystem>();
			if (component2 != null)
			{
				ParticleSystem.CustomDataModule customData = component2.customData;
				customData.enabled = true;
				customData.SetMode(ParticleSystemCustomData.Custom1, ParticleSystemCustomDataMode.Vector);
				customData.SetVectorComponentCount(ParticleSystemCustomData.Custom1, 1);
				switch (mode)
				{
				case Mode.AlphaBlend:
				{
					ParticleSystem.MinMaxCurve minMaxCurve2 = default;
					customData.SetVector(ParticleSystemCustomData.Custom1, 0, new ParticleSystem.MinMaxCurve(0f));
					break;
				}
				case Mode.Additive:
				{
					ParticleSystem.MinMaxCurve minMaxCurve = default;
					customData.SetVector(ParticleSystemCustomData.Custom1, 0, new ParticleSystem.MinMaxCurve(1f));
					break;
				}
				}
			}
		}
	}
}
