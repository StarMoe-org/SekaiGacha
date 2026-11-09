// 源自恢复工程 Assets/Scripts/Assembly-CSharp/LiveEffectTrack.cs。
using Sekai.Core.Live;
using Sekai.Live;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[TrackColor(0.855f, 0.8623f, 0.87f)]
[TrackBindingType(typeof(GameObject))]
[TrackClipType(typeof(LiveEffectClip))]
public class LiveEffectTrack : TrackAsset, IRetryHandleTrack
{
	private PlayableDirector playableDirector;

	private LiveEffectMixerBehaviour liveEffectMixerBehaviour;

	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<LiveEffectMixerBehaviour> scriptPlayable = ScriptPlayable<LiveEffectMixerBehaviour>.Create(graph, inputCount);
		PlayableDirector component = go.GetComponent<PlayableDirector>();
		Object genericBinding = component.GetGenericBinding(this);
		GameObject gameObject = (((object)genericBinding == null) ? null : (genericBinding as GameObject));
		LiveEffectTimelineManager component2 = component.GetComponent<LiveEffectTimelineManager>();
		liveEffectMixerBehaviour = scriptPlayable.GetBehaviour();
		liveEffectMixerBehaviour.Setup((gameObject != null) ? gameObject.transform : null, component2);
		return scriptPlayable;
	}

	public void OnRetry()
	{
		liveEffectMixerBehaviour?.OnRetry();
	}
}
