using System;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Threading;
using UnityEngine;

namespace CP.Timeline
{
	public class LoopWaitTimeline : MonoBehaviour
	{
		[SerializeField]
		private bool trigger;

		[CompilerGenerated]
		private Action m_OnTrigger;

		public double TriggerInvokedOffesetTime { get; set; }

		public bool Trigger
		{
			get
			{
				return trigger;
			}
			set
			{
				bool flag = trigger;
				trigger = value;
				if (flag != value && value)
				{
					this.m_OnTrigger?.Invoke();
				}
			}
		}

		public event Action OnTrigger
		{
			[CompilerGenerated]
			add
			{
				Action action = this.m_OnTrigger;
				while (true)
				{
					Delegate obj = Delegate.Combine(action, value);
					if ((object)obj != null && !(obj is Action))
					{
						throw new InvalidCastException();
					}
					Action action2 = Interlocked.CompareExchange(ref this.m_OnTrigger, obj as Action, action);
					if ((object)action == action2)
					{
						break;
					}
					action = action2;
				}
			}
			[CompilerGenerated]
			remove
			{
				Action action = this.m_OnTrigger;
				while (true)
				{
					Delegate obj = Delegate.Remove(action, value);
					if ((object)obj != null && !(obj is Action))
					{
						throw new InvalidCastException();
					}
					Action action2 = Interlocked.CompareExchange(ref this.m_OnTrigger, obj as Action, action);
					if ((object)action == action2)
					{
						break;
					}
					action = action2;
				}
			}
		}

		public void AddTrigger(Action callback)
		{
			Action action = this.m_OnTrigger;
			if (action != null)
			{
				if (!action.GetInvocationList().Contains(callback))
				{
					OnTrigger += callback;
				}
			}
			else
			{
				OnTrigger += callback;
			}
		}

		public void RemoveTrigger(Action callback)
		{
			Action action = this.m_OnTrigger;
			if (action != null && action.GetInvocationList().Contains(callback))
			{
				OnTrigger -= callback;
			}
		}
	}
}
