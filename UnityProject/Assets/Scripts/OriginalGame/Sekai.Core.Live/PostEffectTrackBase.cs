// 源自恢复工程 Packages/com.unity.timeline/Runtime/ReSekai/Sekai.Core.Live/PostEffectTrackBase.cs。
using System;
using System.Linq;

using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	public abstract class PostEffectTrackBase<TMixerBehaviour, TClip, TParamType> : PostEffectTrackAsset, IPostEffectTrack<TParamType>, ICustomizableTrackDisplayLabel, ISupportableCameraCutAddClipAction where TMixerBehaviour : PlayableBehaviour, IPostEffectMixerBehaviour<IPostEffectTrack<TParamType>, TParamType>, new() where TClip : IPostEffectClip<TParamType> where TParamType : Enum
	{
		[SerializeField]
		private TParamType m_ParamType;

		public TParamType ParamType => m_ParamType;

		public string GetDisplayLabel()
		{
			return m_ParamType.ToString();
		}

		public Type SupportClipType()
		{
			return typeof(TClip);
		}

		public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
		{
			SetParamTypeForClip();
			ScriptPlayable<TMixerBehaviour> scriptPlayable = ScriptPlayable<TMixerBehaviour>.Create(graph, inputCount);
			PlayableDirector component = go.GetComponent<PlayableDirector>();
			IPostEffect target = component.GetGenericBinding(this) as IPostEffect;
			TMixerBehaviour behaviour = scriptPlayable.GetBehaviour();
			TimelineClip[] array = GetClips().ToArray();
			behaviour.Setup(component, array, target, this);
			return scriptPlayable;
		}

		private void OnValidate()
		{
			SetParamTypeForClip();
		}

		protected override void OnCreateClip(TimelineClip clip)
		{
			SetParamTypeForClip(clip);
		}

		public void SetParamType(TParamType paramType)
		{
			m_ParamType = paramType;
			SetParamTypeForClip();
		}

		private void SetParamTypeForClip()
		{
			TimelineClip[] array = GetClips().ToArray();
			if (array.Length < 1)
			{
				return;
			}
			long num = 0L;
			while (true)
			{
				SetParamTypeForClip(array[(nint)num]);
				if (num + 1L >= array.Length)
				{
					break;
				}
				num++;
			}
		}

		private void SetParamTypeForClip(TimelineClip clip)
		{
			if (clip == null)
			{
				return;
			}
			clip.displayName = m_ParamType.ToString();
			UnityEngine.Object asset = clip.asset;
			if ((TClip)(object)((asset is TClip) ? asset : null) != null)
			{
				TClip val = (TClip)(object)((asset is TClip) ? asset : null);
				if (val == null)
				{
					throw new NullReferenceException();
				}
				TClip val2 = (TClip)((((object)val) is TClip) ? ((object)val) : null);
				if (val2 == null)
				{
					throw new InvalidCastException();
				}
				TParamType paramType = m_ParamType;
				val2.SetParamType(paramType);
			}
		}
	}
}
