using UnityEngine;
using UnityEngine.UI;

namespace SekaiGacha
{
    // 原版 ScreenLayerGachaAnimation/ComponentRoot/SafeArea/UIPartsSkipButton（SafeArea 铺满画面）：
    // 右上角锚点、位置 (-64, -64)、96×96 的 btn_circle_h80_wh；子节点 SkipIcon 在 (3, 0)，44×28 的 icon_skip_h28_wh。
    // 按下效果照 CustomButton.buttonViewInteraction = MultiButtonTapEffect → 两个 GraphicButtonTapEffect：
    // OnPressed 用 FadeInTime（0.1 秒）DOColor 到 effect 色，OnReleased 用 FadeOutTime（0.4 秒）回到 default 色，
    // 缓动取 DOTweenSettings.defaultEaseType（OutQuad）。底图 base_wh → tap_gn_1，图标 base_dbl → base_wh，颜色取自 PaletteStore。
    // CustomButton 的 pressScale 在原版代码里没有用到。Cover 只在不可交互时显示，此按钮始终可交互，所以不建。
    sealed class GachaSkipButton : MonoBehaviour
    {
        static readonly Color BaseWh = new Color(1, 1, 1, 1);
        static readonly Color BaseDbl = new Color(0.26666668f, 0.26666668f, 0.4f, 1);
        static readonly Color TapGn1 = new Color(0.6313726f, 0.95686275f, 0.92156863f, 1);
        const float FadeInTime = 0.1f, FadeOutTime = 0.4f;

        RectTransform rect;
        Fade button, icon;
        bool pressed;

        public static GachaSkipButton Create(Transform parent)
        {
            var root = new GameObject("UIPartsSkipButton", typeof(RectTransform), typeof(RawImage));
            var rect = (RectTransform)root.transform;
            rect.SetParent(parent, false);
            rect.anchorMin = rect.anchorMax = new Vector2(1, 1);
            rect.pivot = new Vector2(0.5f, 0.5f);
            rect.anchoredPosition = new Vector2(-64, -64);
            rect.sizeDelta = new Vector2(96, 96);
            var background = root.GetComponent<RawImage>();
            background.texture = Resources.Load<Texture2D>("GachaSkipButton");
            background.raycastTarget = false;

            var iconObject = new GameObject("SkipIcon", typeof(RectTransform), typeof(RawImage));
            var iconRect = (RectTransform)iconObject.transform;
            iconRect.SetParent(rect, false);
            iconRect.anchorMin = iconRect.anchorMax = new Vector2(0.5f, 0.5f);
            iconRect.pivot = new Vector2(0.5f, 0.5f);
            iconRect.anchoredPosition = new Vector2(3, 0);
            iconRect.sizeDelta = new Vector2(44, 28);
            var iconImage = iconObject.GetComponent<RawImage>();
            iconImage.texture = Resources.Load<Texture2D>("GachaSkipIcon");
            iconImage.raycastTarget = false;

            var skip = root.AddComponent<GachaSkipButton>();
            skip.rect = rect;
            skip.button = new Fade(background, BaseWh, TapGn1);
            skip.icon = new Fade(iconImage, BaseDbl, BaseWh);
            skip.ResetColors();
            return skip;
        }

        // Image 的射线检测按矩形（未设 alphaHitTestMinimumThreshold）；画布是 Screen Space Overlay。
        public bool Contains(Vector2 screenPoint) =>
            isActiveAndEnabled && RectTransformUtility.RectangleContainsScreenPoint(rect, screenPoint, null);

        public void Press()
        {
            pressed = true;
            button.To(true, FadeInTime);
            icon.To(true, FadeInTime);
        }

        public void Release()
        {
            if (!pressed) return;
            pressed = false;
            button.To(false, FadeOutTime);
            icon.To(false, FadeOutTime);
        }

        // 原版 GraphicButtonTapEffect.Awake → RefreshColor：显示时回到 default 色。
        void OnDisable() => ResetColors();

        void ResetColors()
        {
            pressed = false;
            button.Set(false);
            icon.Set(false);
        }

        void Update()
        {
            button.Step(Time.deltaTime);
            icon.Step(Time.deltaTime);
        }

        // DOColor：从当前颜色补间到目标色；新补间开始前 KillFadeTween。
        sealed class Fade
        {
            readonly Graphic graphic;
            readonly Color normal, effect;
            Color from, to;
            float duration, elapsed;
            bool running;

            public Fade(Graphic graphic, Color normal, Color effect)
            {
                this.graphic = graphic;
                this.normal = normal;
                this.effect = effect;
            }

            public void Set(bool toEffect)
            {
                running = false;
                graphic.color = toEffect ? effect : normal;
            }

            public void To(bool toEffect, float seconds)
            {
                from = graphic.color;
                to = toEffect ? effect : normal;
                duration = seconds;
                elapsed = 0;
                running = true;
            }

            public void Step(float deltaTime)
            {
                if (!running) return;
                elapsed += deltaTime;
                float t = Mathf.Clamp01(elapsed / duration);
                // DOTween Ease.OutQuad。
                graphic.color = Color.LerpUnclamped(from, to, t * (2 - t));
                if (t >= 1) running = false;
            }
        }
    }
}
