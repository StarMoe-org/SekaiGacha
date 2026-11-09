// 源自恢复工程 Assets/Scripts/Assembly-CSharp/LiveEffectBehaviour.cs，适配独立场景的销毁顺序。
using System;
using System.Collections;
using System.Linq;
using CP;
using Sekai;
using Sekai.Live;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;

[Serializable]
public class LiveEffectBehaviour : PlayableBehaviour
{
	public string parentNodeName;

	public GameObject prefab;

	public AnimationClip clip;

	private Animator animator;

	private GameObject go;

	private ParticleSystem[] particleSystems = new ParticleSystem[0];

	private Animator[] particleSystemAnimators = new Animator[0];

	private float[] particleSystemAnimatorInitSpeeds;

	private float liveEffectAnimatorInitSpeed;

	private Renderer[] renderers = new Renderer[0];

	public Transform trackBinding;

	private bool isActiveBeforeParentObj = true;

	private GameObject parentNodeObj;

	private LiveEffectTimelineManager _liveEffectTimelineManager;

	private float _particlePlayTime;

	private PlayableGraph playableGraph;

	private AnimationClipPlayable playableClip;

	private float playablePreTime;

	public bool IsCalledParticlePlay { get; private set; }

	public void Setup(Transform trackBinding, LiveEffectTimelineManager manager)
	{
		this.trackBinding = trackBinding;
		_liveEffectTimelineManager = manager;
	}

	private void PlayParticle(float time)
	{
		Renderer[] array;
		int num;
		long num2;
		if (trackBinding != null)
		{
			if (!(trackBinding.gameObject != null))
			{
				array = renderers;
				num = 0;
				num2 = 0L;
			}
			else if (trackBinding.gameObject.activeSelf)
			{
				array = renderers;
				num = 0;
				num2 = 0L;
			}
			else
			{
				trackBinding.gameObject.SetActive(value: true);
				array = renderers;
				num = 0;
				num2 = 0L;
			}
		}
		else
		{
			array = renderers;
			num = 0;
			num2 = 0L;
		}
		while (true)
		{
			if (num < array.Length)
			{
				array[(nint)num2].enabled = true;
				array = renderers;
				if (array != null)
				{
					num++;
					num2++;
					continue;
				}
			}
			else
			{
				ParticleSystem[] array2 = particleSystems;
				int num3 = 0;
				long num4 = 0L;
				while (true)
				{
					if (num3 < array2.Length)
					{
						ParticleSystem particleSystem = array2[(nint)num4];
						if (!particleSystem.isPaused || particleSystem.main.simulationSpace != ParticleSystemSimulationSpace.World)
						{
							particleSystem.Simulate(time, withChildren: false, restart: true);
						}
						particleSystem.Play(withChildren: false);
						array2 = particleSystems;
						if (array2 == null)
						{
							break;
						}
						num3++;
						num4++;
						continue;
					}
					Animator[] array3 = particleSystemAnimators;
					if (array3 != null && particleSystemAnimatorInitSpeeds != null)
					{
						int num5 = 0;
						long num6 = 0L;
						while (true)
						{
							int num7 = array3.Length;
							if (num5 >= num7)
							{
								break;
							}
							if ((uint)num5 >= (uint)num7)
							{
								throw new IndexOutOfRangeException();
							}
							float[] array4 = particleSystemAnimatorInitSpeeds;
							if ((uint)num5 >= (uint)array4.Length)
							{
								throw new IndexOutOfRangeException();
							}
							Animator animator = array3[(nint)num6];
							if ((object)animator == null)
							{
								throw new NullReferenceException();
							}
							animator.speed = array4[(nint)num6];
							array3 = particleSystemAnimators;
							if (array3 == null)
							{
								goto end_IL_0228;
							}
							num5++;
							num6++;
						}
					}
					if (clip == null && this.animator != null)
					{
						this.animator.speed = liveEffectAnimatorInitSpeed;
					}
					return;
					continue;
					end_IL_0228:
					break;
				}
			}
			throw new NullReferenceException();
		}
	}

	private Transform FindChild(Transform transform, string[] parentNodeElements, int index = 0)
	{
		int num = parentNodeElements.Length;
		if (num <= index)
		{
			return transform;
		}
		if ((uint)index >= (uint)num)
		{
			throw new IndexOutOfRangeException();
		}
		if ((object)transform == null)
		{
			throw new NullReferenceException();
		}
		string text = parentNodeElements[index];
		IEnumerator enumerator = transform.GetEnumerator();
		Transform transform2;
		try
		{
			do
			{
				if (!enumerator.MoveNext())
				{
					transform2 = null;
					break;
				}
				Transform transform3 = (Transform)enumerator.Current;
				transform2 = ((transform3.name == text) ? FindChild(transform3, parentNodeElements, index + 1) : ((index == 0) ? FindChild(transform3, parentNodeElements) : null));
			}
			while (!(transform2 != null));
		}
		finally
		{
			IDisposable disposable = enumerator as IDisposable;
			if (disposable != null)
			{
				disposable.Dispose();
			}
		}
		return transform2;
	}

	public override void OnPlayableCreate(Playable playable)
	{
		base.OnPlayableCreate(playable);
		if (prefab != null)
		{
			prefab.SetActive(value: false);
			go = UnityEngine.Object.Instantiate(prefab, null);
			GameObjectUtility.ChangeLayer(go, LayerID.LiveMV, includeChildren: true);
		}
		if (go != null)
		{
			Animator animator = go.GetComponentInChildren<Animator>();
			if ((object)animator == null)
			{
				animator = go.AddComponent<Animator>();
			}
			this.animator = animator;
			if (clip == null)
			{
				liveEffectAnimatorInitSpeed = this.animator.speed;
			}
			particleSystems = go.GetComponentsInChildren<ParticleSystem>();
			particleSystemAnimators = null;
			particleSystemAnimatorInitSpeeds = null;
			ParticleSystem[] array = particleSystems;
			if (array != null)
			{
				particleSystemAnimators = (from p in array
					select p.GetComponent<Animator>() into a
					where a != null
					select a).ToArray();
				particleSystemAnimatorInitSpeeds = new float[particleSystemAnimators.Length];
				Animator[] array2 = particleSystemAnimators;
				int num = 0;
				long num2 = 0L;
				while (num < array2.Length)
				{
					Animator animator2 = array2[(nint)num2];
					particleSystemAnimatorInitSpeeds[(nint)num2] = animator2.speed;
					array2 = particleSystemAnimators;
					if (array2 == null)
					{
						throw new NullReferenceException();
					}
					num++;
					num2++;
				}
			}
			renderers = go.GetComponentsInChildren<Renderer>();
			ParticleSystem[] array3 = particleSystems;
			int num3 = 0;
			long num4 = 0L;
			while (num3 < array3.Length)
			{
				array3[0].Play(withChildren: false);
				particleSystems[0].Stop(withChildren: false, ParticleSystemStopBehavior.StopEmittingAndClear);
				particleSystems[(nint)num4].randomSeed = 0u;
				array3 = particleSystems;
				if (array3 == null)
				{
					throw new NullReferenceException();
				}
				num3++;
				num4++;
			}
			Renderer[] array4 = renderers;
			int num5 = 0;
			long num6 = 0L;
			while (num5 < array4.Length)
			{
				array4[(nint)num6].enabled = false;
				array4 = renderers;
				if (array4 == null)
				{
					throw new NullReferenceException();
				}
				num5++;
				num6++;
			}
			go.SetActive(value: true);
		}
		if (this.animator != null && clip != null)
		{
			PlayableGraph graph = PlayableGraph.Create();
			AnimationClip animationClip = clip;
			playableGraph = graph;
			AnimationClipPlayable animationClipPlayable = AnimationClipPlayable.Create(graph, animationClip);
			Animator animator3 = this.animator;
			playableClip = animationClipPlayable;
			if ((object)animator3 == null)
			{
				throw new NullReferenceException();
			}
			AnimationPlayableOutput.Create(playableGraph, animator3.name, this.animator).SetSourcePlayable(playableClip);
			playableGraph.Play();
			playableClip.SetPlayState(PlayState.Paused);
		}
		return;
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		base.OnPlayableDestroy(playable);
		if (playableGraph.IsValid())
		{
			playableGraph.Destroy();
		}
		particleSystemAnimators = new Animator[0];
		UnityEngine.Object.DestroyImmediate(go);
		renderers = new Renderer[0];
		particleSystems = new ParticleSystem[0];
	}

	public override void OnGraphStart(Playable playable)
	{
		base.OnGraphStart(playable);
		Transform transform = trackBinding;
		if (transform != null && !string.IsNullOrEmpty(parentNodeName))
		{
			transform = FindChild(transform, parentNodeName.Split("/"));
			parentNodeObj = transform.gameObject;
		}
		if (go != null)
		{
			go.transform.SetParent(transform, worldPositionStays: false);
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		LiveEffectTimelineManager liveEffectTimelineManager = _liveEffectTimelineManager;
		IsCalledParticlePlay = true;
		if (liveEffectTimelineManager.IsNowPlaying)
		{
			double time = playable.GetTime();
			_particlePlayTime = (float)time;
			PlayParticle((float)time);
			IsCalledParticlePlay = false;
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
		if (!go) return;
		switch (playable.GetPlayState())
		{
		case PlayState.Paused:
		{
			Renderer[] array3 = renderers;
			long num4 = 4L;
			while (true)
			{
				if (num4 + -4L >= array3.Length)
				{
					return;
				}
				if (array3[(nint)(num4 + -4L)] != null)
				{
					renderers[(nint)(num4 + -4L)].enabled = false;
				}
				array3 = renderers;
				if (array3 == null)
				{
					break;
				}
				num4++;
			}
			goto IL_0361;
		}
		case PlayState.Playing:
			{
				ParticleSystem[] array = particleSystems;
				long num = 4L;
				while (true)
				{
					if (num + -4L < array.Length)
					{
						if (array[(nint)(num + -4L)] != null)
						{
							particleSystems[(nint)(num + -4L)].Pause(withChildren: false);
						}
						array = particleSystems;
						if (array == null)
						{
							break;
						}
						num++;
						continue;
					}
					Animator[] array2 = particleSystemAnimators;
					if (array2 != null)
					{
						int num2 = 0;
						long num3 = 0L;
						while (num2 < array2.Length)
						{
							array2[(nint)num3].speed = 0f;
							array2 = particleSystemAnimators;
							if (array2 == null)
							{
								goto end_IL_018f;
							}
							num2++;
							num3++;
						}
					}
					if (clip == null && animator != null)
					{
						animator.speed = 0f;
					}
					if (playableClip.IsValid() && playableClip.GetPlayState() == PlayState.Playing)
					{
						playableClip.Pause();
					}
					return;
					continue;
					end_IL_018f:
					break;
				}
				goto IL_0361;
			}
			IL_0361:
			throw new NullReferenceException();
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		double time = playable.GetTime();
		LiveEffectTimelineManager liveEffectTimelineManager = _liveEffectTimelineManager;
		if (liveEffectTimelineManager.IsNowPlaying && liveEffectTimelineManager.IsSwitchExecutable && IsCalledParticlePlay)
		{
			PlayParticle((float)time - _particlePlayTime);
			_liveEffectTimelineManager.IsSwitchExecutable = false;
		}
		if (!isActiveBeforeParentObj && parentNodeObj != null && parentNodeObj.activeSelf)
		{
			PlayParticle((float)time);
		}
		if (playableClip.IsValid())
		{
			playableClip.SetTime((float)time);
		}
		if (parentNodeObj != null)
		{
			isActiveBeforeParentObj = parentNodeObj.activeSelf;
		}
		base.ProcessFrame(playable, info, playerData);
	}

	public void OnRetry()
	{
		ParticleSystem[] array = particleSystems;
		if (array == null)
		{
			return;
		}
		if (array.Length >= 1)
		{
			long num = 0L;
			int num2 = 0;
			while (true)
			{
				array[(nint)num].Simulate(0f, withChildren: false, restart: true);
				if (num2 + 1 >= array.Length)
				{
					break;
				}
				num++;
				num2++;
			}
			_liveEffectTimelineManager.OnRetry();
		}
		else
		{
			_liveEffectTimelineManager.OnRetry();
		}
	}
}
