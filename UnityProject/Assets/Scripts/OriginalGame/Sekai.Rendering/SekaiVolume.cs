// 源自恢复工程 Packages/com.unity.render-pipelines.universal/Runtime/ReSekai/Sekai.Rendering/SekaiVolume.cs。
using System;
using Sekai.Rendering.Components;
using Sekai.Rendering.Components.PostProcessV2;
using UnityEngine;
using UnityEngine.Rendering;
using sekai_rendering.Runtime.Components;

namespace Sekai.Rendering
{
	public class SekaiVolume : IDisposable
	{
		private Volume volume;

		private VolumeProfile volumeProfile;

		public Vignette Vignette;

		public LightOverlay LightOverlay;

		public IncidentLight IncidentLight;

		public Saturation Saturation;

		public Solarisation Solarisation;

		public FadeOutBeforeProp FadeOutBeforeProp;

		public FadeOut FadeOut;

		public SaturationBlur SaturationBlur;

		public LegacyLut Lut;

		public LegacyBloom Bloom;

		public LegacyDof LegacyDof;

		public DirectionalBlur DirectionalBlur;

		public SekaiDof SekaiDof;

		public Antialiasing Antialiasing;

		public ScreenDistortion ScreenDistortion;

		public ChromaticAberration ChromaticAberration;

		public bool Enabled
		{
			get
			{
				return volume.enabled;
			}
			set
			{
				volume.enabled = value;
			}
		}

		public void SetupVolume(GameObject gameObject, string profileName)
		{
			if (!gameObject.TryGetComponent<Volume>(out this.volume))
			{
				this.volume = gameObject.AddComponent<Volume>();
			}
			Volume volume = this.volume;
			volume.weight = 1f;
			volume.isGlobal = true;
			if (volumeProfile == null)
			{
				VolumeProfile template = Resources.Load<VolumeProfile>("Profiles/" + profileName);
				volumeProfile = ScriptableObject.CreateInstance<VolumeProfile>();
				volumeProfile.hideFlags = HideFlags.HideAndDontSave;
				SetupProfile(volumeProfile, template);
			}
			this.volume.profile = volumeProfile;
			bool flag = volumeProfile.TryGet<LightOverlay>(out LightOverlay);
			bool flag2 = volumeProfile.TryGet<IncidentLight>(out IncidentLight);
			bool flag3 = volumeProfile.TryGet<Saturation>(out Saturation);
			bool flag4 = volumeProfile.TryGet<Solarisation>(out Solarisation);
			bool flag5 = volumeProfile.TryGet<FadeOutBeforeProp>(out FadeOutBeforeProp);
			bool flag6 = volumeProfile.TryGet<FadeOut>(out FadeOut);
			bool flag7 = volumeProfile.TryGet<SaturationBlur>(out SaturationBlur);
			bool flag8 = volumeProfile.TryGet<LegacyLut>(out Lut);
			bool flag9 = volumeProfile.TryGet<LegacyBloom>(out Bloom);
			bool flag10 = volumeProfile.TryGet<LegacyDof>(out LegacyDof);
			bool flag11 = volumeProfile.TryGet<DirectionalBlur>(out DirectionalBlur);
			bool flag12 = volumeProfile.TryGet<SekaiDof>(out SekaiDof);
			bool flag13 = volumeProfile.TryGet<Antialiasing>(out Antialiasing);
			bool flag14 = volumeProfile.TryGet<Vignette>(out Vignette);
			bool flag15 = volumeProfile.TryGet<ScreenDistortion>(out ScreenDistortion);
			volumeProfile.TryGet<ChromaticAberration>(out ChromaticAberration);
		}

		private void SetupProfile(VolumeProfile target, VolumeProfile template)
		{
			foreach (VolumeComponent component in template.components)
			{
				VolumeComponent volumeComponent = target.Add(component.GetType(), overrides: true);
			}
		}

		public void Dispose()
		{
			CoreUtils.Destroy(volumeProfile);
			volumeProfile = null;
		}
	}
}
