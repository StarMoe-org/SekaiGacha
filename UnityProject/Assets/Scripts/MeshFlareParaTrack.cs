// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/MeshFlareParaTrack.cs。
using System;
using System.Collections.Generic;
using System.Linq;
using Sekai.Timeline.Common;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	[Serializable]
	[TrackBindingType(typeof(MeshFlareParaController))]
	[TrackClipType(typeof(MeshFlareParaClip))]
	[TrackColor(1f, 1f, 1f)]
	public class MeshFlareParaTrack : TrackAsset
	{
		[SerializeField]
		private MeshFlareParaOrder _meshFlareParaOrder;

		private bool needUpdateTrackName = true;

		public MeshFlareParaOrder MeshFlareParaTrackOrder => _meshFlareParaOrder;

		public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
		{
			IEnumerable<TimelineClip> enumerable = GetClips();
			ScriptPlayable<MeshFlareParaMixerBehaviour> scriptPlayable = ScriptPlayable<MeshFlareParaMixerBehaviour>.Create(graph, inputCount);
			PlayableDirector component = go.GetComponent<PlayableDirector>();
			UnityEngine.Object genericBinding = component.GetGenericBinding(this);
			MeshFlareParaController meshFlareParaController;
			if ((object)genericBinding != null && ((genericBinding is MeshFlareParaController) ? 1u : 0u) != (byte)0)
			{
				meshFlareParaController = genericBinding as MeshFlareParaController;
				if (enumerable != null)
				{
					goto IL_00cf;
				}
			}
			else if (enumerable != null)
			{
				meshFlareParaController = null;
				goto IL_00cf;
			}
			throw new ArgumentNullException("clips");
			IL_00cf:
			TimelineClip[] array = enumerable.ToArray();
			SetParamTypeForClip();
			scriptPlayable.GetBehaviour().Setup(component, meshFlareParaController, array, this);
			return scriptPlayable;
		}

		protected override void OnCreateClip(TimelineClip clip)
		{
			SetParamTypeForClip(clip);
		}

		private void OnValidate()
		{
			needUpdateTrackName = true;
			SetParamTypeForClip();
		}

		protected override void OnBeforeTrackSerialize()
		{
			base.OnBeforeTrackSerialize();
			if (needUpdateTrackName)
			{
				(int, int) tuple = this.FindIndex();
				name = "MeshFlareParaTrack";
				needUpdateTrackName = false;
			}
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
			if (clip != null)
			{
				clip.displayName = _meshFlareParaOrder.ToString();
				UnityEngine.Object asset = clip.asset;
				if ((object)asset != null && ((asset is MeshFlareParaClip) ? 1u : 0u) != (byte)0)
				{
					(asset as MeshFlareParaClip).SetParamType(_meshFlareParaOrder);
				}
			}
		}
	}
}
