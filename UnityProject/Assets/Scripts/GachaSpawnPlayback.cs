// 源自 Cpp2CS Assembly-CSharp.dll/Sekai/GachaSpawnAnimationState.cs。
// 外层只将画面控制器和音频管理器替换为回调；Execute 保留恢复逻辑。
using System;
using CP.Timeline;
using UnityEngine;
using UnityEngine.Playables;
namespace SekaiGacha
{
    sealed class GachaSpawnPlayback
    {
        readonly PlayableDirector director;
        readonly LoopWaitTimeline waitTimeline;
        double beforeTime;
        public GachaSpawnPlayback(GameObject root)
        {
            director = root.transform.Find("Timeline").GetComponent<PlayableDirector>();
            waitTimeline = director.GetComponent<LoopWaitTimeline>();
        }
public void Execute(Action nextState, Action<string> playSe)
		{
			if (director != null)
			{
				if (director.time >= 6.199999809265137 && beforeTime < 6.199999809265137)
				{
					playSe("SE_GACHA_STAFF");
				}
				if (director.time >= director.duration - waitTimeline.TriggerInvokedOffesetTime - (double)Time.deltaTime)
				{
					nextState();
				}
				beforeTime = director.time;
			}
		}
    }
}
