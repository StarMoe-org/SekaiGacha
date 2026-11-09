// 源自恢复工程 Assets/Scripts/Assembly-CSharp/LiveEffectMixerBehaviour.cs。
using System;
using Sekai.Live;
using UnityEngine;
using UnityEngine.Playables;

public class LiveEffectMixerBehaviour : PlayableBehaviour
{
	private Transform _trackBinding;

	private LiveEffectTimelineManager _manager;

	private LiveEffectBehaviour[] cachedBehaviours;

	public void Setup(Transform trackBinding, LiveEffectTimelineManager manger)
	{
		_trackBinding = trackBinding;
		_manager = manger;
	}

	public override void OnGraphStart(Playable playable)
	{
		int inputCount = playable.GetInputCount();
		cachedBehaviours = new LiveEffectBehaviour[inputCount];
		if (inputCount < 1)
		{
			return;
		}
		int num = 0;
		long num2 = 0L;
		while (true)
		{
			LiveEffectBehaviour behaviour = ((ScriptPlayable<LiveEffectBehaviour>)playable.GetInput(num)).GetBehaviour();
			behaviour.Setup(_trackBinding, _manager);
			LiveEffectBehaviour[] array = cachedBehaviours;
			if (array == null)
			{
				throw new NullReferenceException();
			}
			object obj = behaviour;
			if (((!array.GetType().GetElementType().IsInstanceOfType(obj)) ? null : obj) == null)
			{
				break;
			}
			array[(nint)num2] = behaviour;
			if ((uint)inputCount == num2 + 1L)
			{
				return;
			}
			num++;
			num2++;
		}
		throw new ArrayTypeMismatchException();
	}

	public void OnRetry()
	{
		LiveEffectBehaviour[] array = cachedBehaviours;
		if (array == null)
		{
			return;
		}
		int num = array.Length;
		if (num < 1)
		{
			return;
		}
		long num2 = 0L;
		uint num3 = (uint)num;
		while (true)
		{
			LiveEffectBehaviour liveEffectBehaviour = array[(nint)num2];
			if (liveEffectBehaviour != null)
			{
				liveEffectBehaviour.OnRetry();
				num3 = (uint)array.Length;
			}
			if (num2 + 1L >= (int)num3)
			{
				break;
			}
			num2++;
		}
	}
}
