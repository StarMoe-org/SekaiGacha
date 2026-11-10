using UnityEngine;
using UnityEngine.UI;

namespace SekaiGacha
{
    // 原版 Sekai.TweenAlpha（DOTween）在 ScreenLayerGachaAnimation/TapToStart 上的设置：
    // startTiming PlayOnEnable，componentType UnityUI，from 0.2 → to 1，duration 1，delay 0，
    // loopType PingPong（DOTween Yoyo）、loopCount 0（无限），SetEase(curve)，curve 为 (0,0 斜率 2) → (1,1 斜率 0)。
    [RequireComponent(typeof(RawImage))]
    sealed class GachaTapToStartTween : MonoBehaviour
    {
        const float From = 0.2f, To = 1f, Duration = 1f;
        static readonly AnimationCurve Curve = new AnimationCurve(new Keyframe(0, 0, 2, 2), new Keyframe(1, 1, 0, 0));
        RawImage image;
        float elapsed;

        void Awake() => image = GetComponent<RawImage>();

        // PlayOnEnable：每次显示都从 from 开始。
        void OnEnable()
        {
            elapsed = 0;
            Apply();
        }

        void Update()
        {
            elapsed += Time.deltaTime;
            Apply();
        }

        void Apply()
        {
            int loop = (int)(elapsed / Duration);
            float position = elapsed / Duration - loop;
            // Yoyo：奇数轮倒放，缓动按倒放后的位置求值。
            if (loop % 2 == 1) position = 1 - position;
            var color = image.color;
            color.a = Mathf.LerpUnclamped(From, To, Curve.Evaluate(position));
            image.color = color;
        }
    }
}
