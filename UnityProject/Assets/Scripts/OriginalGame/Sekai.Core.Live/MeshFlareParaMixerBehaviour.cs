// 源自恢复工程 Assets/Scripts/Assembly-CSharp/Sekai.Core.Live/MeshFlareParaMixerBehaviour.cs。
using System;
using System.Linq;

using Sekai.Timeline.Common;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Sekai.Core.Live
{
	public class MeshFlareParaMixerBehaviour : PlayableBehaviour
	{
		private PlayableDirector _director;

		private MeshFlareParaController _targetFlareParaController;

		private TimelineClip[] _targetClips;

		private MeshFlareParaClip[] _meshFlareParaClips;

		private MeshFlareParaTrack _meshFlareParaTrack;

		private Color _currentColor;

		private MeshFlareParaClip.MeshBlendMode _currentMeshFlareParaBlendMode;

		private float _currentTheta;

		private Vector2 _currentTiling;

		private bool _currentZTest;

		private bool _currentEnableMultiBlend;

		public void Setup(PlayableDirector director, MeshFlareParaController meshFlareParaController, TimelineClip[] clips, MeshFlareParaTrack meshFlareParaTrack)
		{
			_director = director;
			_targetFlareParaController = meshFlareParaController;
			_targetClips = clips;
			_meshFlareParaTrack = meshFlareParaTrack;
			_meshFlareParaClips = null;
			if (!(_targetClips == null || _targetClips.Length == 0))
			{
				_meshFlareParaClips = _targetClips.Select((TimelineClip c) => c.asset).OfType<MeshFlareParaClip>().ToArray();
				OnSetupClip(_targetClips);
			}
		}

		public override void ProcessFrame(Playable playable, FrameData info, object playerData)
		{
			base.ProcessFrame(playable, info, playerData);
			if (_targetFlareParaController == null)
			{
				return;
			}
			MeshFlareParaClip[] meshFlareParaClips = _meshFlareParaClips;
			if (meshFlareParaClips == null)
			{
				return;
			}
			int num = meshFlareParaClips.Length;
			if (num < 1)
			{
				return;
			}
			long num2 = 0L;
			int num3 = 0;
			bool flag = false;
			while (true)
			{
				MeshFlareParaClip meshFlareParaClip = meshFlareParaClips[(nint)num2];
				if (!(meshFlareParaClip == null) && playable.GetInputWeight(num3) > 0f)
				{
					UpdateClipParam((int)_meshFlareParaTrack.MeshFlareParaTrackOrder, meshFlareParaClip);
					if (num2 + 1L == (uint)num)
					{
						return;
					}
					flag = true;
				}
				else if (num2 + 1L == (uint)num)
				{
					break;
				}
				meshFlareParaClips = _meshFlareParaClips;
				if (meshFlareParaClips == null)
				{
					throw new NullReferenceException();
				}
				num2++;
				num3++;
			}
			if (!flag)
			{
				MeshFlareParaTrack meshFlareParaTrack = _meshFlareParaTrack;
				if (_targetFlareParaController.GetIsActiveObj((int)meshFlareParaTrack.MeshFlareParaTrackOrder))
				{
					Disable((int)_meshFlareParaTrack.MeshFlareParaTrackOrder);
				}
				MeshFlareParaTrack meshFlareParaTrack2 = _meshFlareParaTrack;
				_targetFlareParaController.SetActiveObj((int)meshFlareParaTrack2.MeshFlareParaTrackOrder, isActive: false);
			}
		}

		private void OnSetupClip(TimelineClip[] clips)
		{
			if (clips != null)
			{
				_meshFlareParaClips = clips.Select((TimelineClip c) => c.asset).OfType<MeshFlareParaClip>().ToArray();
				ReferenceColorBlend[] blends = _meshFlareParaClips.Select((MeshFlareParaClip c) => c.MeshFlareParaColor).ToArray();
				ReferenceVector3Blend[] blends2 = _meshFlareParaClips.Select((MeshFlareParaClip c) => c.MeshFlareParaPosition).ToArray();
				ReferenceVector2Blend[] blends3 = _meshFlareParaClips.Select((MeshFlareParaClip c) => c.MeshFlareParaRadius).ToArray();
				ReferenceFloatBlend[] blends4 = _meshFlareParaClips.Select((MeshFlareParaClip c) => c.MeshFlareParaTheta).ToArray();
				ReferenceVector2Blend[] blends5 = _meshFlareParaClips.Select((MeshFlareParaClip c) => c.MeshFlareParaTiling).ToArray();
				bool flag = BlendBase<Color>.Setup(blends, clips);
				bool flag2 = BlendBase<Vector3>.Setup(blends2, clips);
				bool flag3 = BlendBase<Vector2>.Setup(blends3, clips);
				bool flag4 = BlendBase<float>.Setup(blends4, clips);
				BlendBase<Vector2>.Setup(blends5, clips);
			}
		}

		private void UpdateClipParam(int order, MeshFlareParaClip meshFlareParaClip)
		{
			if (!_targetFlareParaController.GetIsActiveObj(order))
			{
				_targetFlareParaController.SetActiveObj(order, isActive: true);
			}
			PlayableDirector director = _director;
			Color color = meshFlareParaClip.MeshFlareParaColor.CalcBlend(director.time);
			if (_currentColor.r.Equals(color.r))
			{
				if (!_currentColor.g.Equals(color.g))
				{
					_targetFlareParaController.SetColorPropertyBlock(order, color);
					_currentColor = color;
				}
				else if (!_currentColor.b.Equals(color.b))
				{
					_targetFlareParaController.SetColorPropertyBlock(order, color);
					_currentColor = color;
				}
				else if (!_currentColor.a.Equals(color.a))
				{
					_targetFlareParaController.SetColorPropertyBlock(order, color);
					_currentColor = color;
				}
			}
			else
			{
				_targetFlareParaController.SetColorPropertyBlock(order, color);
				_currentColor = color;
			}
			MeshFlareParaClip.MeshBlendMode param = meshFlareParaClip.MeshFlareParaBlendMode.Param;
			if (!_currentMeshFlareParaBlendMode.Equals(param))
			{
				_targetFlareParaController.SetBlendModePropertyBlock(order, param);
				_targetFlareParaController.SetMultiBlendShaderKeyword(order, param == MeshFlareParaClip.MeshBlendMode.Multiply);
				_currentMeshFlareParaBlendMode = param;
			}
			bool param2 = meshFlareParaClip.MeshFlareParaZTest.Param;
			if (_currentZTest != param2)
			{
				_targetFlareParaController.SetZTest(order, param2);
				_currentZTest = param2;
			}
			PlayableDirector director2 = _director;
			Vector3 position = meshFlareParaClip.MeshFlareParaPosition.CalcBlend(director2.time);
			PlayableDirector director3 = _director;
			Vector2 scaleXY = meshFlareParaClip.MeshFlareParaRadius.CalcBlend(director3.time);
			_targetFlareParaController.SetPositionAndScaleParams(order, position, scaleXY, _currentZTest);
			PlayableDirector director4 = _director;
			float num = meshFlareParaClip.MeshFlareParaTheta.CalcBlend(director4.time);
			if (!_currentTheta.Equals(num))
			{
				_targetFlareParaController.SetTheta(order, num);
				_currentTheta = num;
			}
			PlayableDirector director5 = _director;
			Vector2 vector = meshFlareParaClip.MeshFlareParaTiling.CalcBlend(director5.time);
			if (_currentTiling.x == vector.x)
			{
				if (_currentTiling.y != vector.y)
				{
					_targetFlareParaController.SetTiling(order, vector);
					_currentTiling = vector;
				}
			}
			else
			{
				_targetFlareParaController.SetTiling(order, vector);
				_currentTiling = vector;
			}
		}

		private void Disable(int order)
		{
			_currentMeshFlareParaBlendMode = MeshFlareParaClip.MeshBlendMode.Overwrite;
			_currentTheta = 0f;
			_currentColor = new Color
			{
				a = 1f
			};
			MeshFlareParaController targetFlareParaController = _targetFlareParaController;
			Vector2 one = Vector2.one;
			_currentZTest = false;
			_currentEnableMultiBlend = false;
			_currentTiling = one;
			targetFlareParaController.ResetPositionAndScale(order);
			_targetFlareParaController.SetColorPropertyBlock(order, _currentColor);
			_targetFlareParaController.SetBlendModePropertyBlock(order, _currentMeshFlareParaBlendMode);
			_targetFlareParaController.SetTheta(order, _currentTheta);
			_targetFlareParaController.SetTiling(order, _currentTiling);
			_targetFlareParaController.SetZTest(order, _currentZTest);
		}
	}
}
