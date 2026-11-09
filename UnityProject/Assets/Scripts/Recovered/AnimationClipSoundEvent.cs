using System;

using UnityEngine;

namespace Sekai
{
	public class AnimationClipSoundEvent : MonoBehaviour
	{
		public Action<string> OnPlaySeAction { private get; set; }

		public Action OnStopSeAction { private get; set; }

		public Action<string> OnFadePlaySeAction { private get; set; }

		public Action<string> OnFadeSeVolumeAction { private get; set; }

		public Action<string> OnFadeStopSeAction { private get; set; }

		
		public void OnPlaySE(string input)
		{
			OnPlaySeAction?.Invoke(input);
		}

		
		public void OnStopSE()
		{
			OnStopSeAction?.Invoke();
		}

		
		public void OnFadePlaySE(string input)
		{
			OnFadePlaySeAction?.Invoke(input);
		}

		
		public void OnFadeSEVolume(string input)
		{
			OnFadeSeVolumeAction?.Invoke(input);
		}

		
		public void OnFadeStopSE(string input)
		{
			OnFadeStopSeAction?.Invoke(input);
		}
	}
}
