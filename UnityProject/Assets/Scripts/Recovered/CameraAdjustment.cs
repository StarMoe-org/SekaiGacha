using UnityEngine;
namespace Sekai.Core
{
    public sealed class CameraAdjustment : MonoBehaviour
    {
        [SerializeField] float defaultHeight = 1.6f, secondDefaultHeight;
        [SerializeField] int target = -1, secondTarget = -1;
        [SerializeField] float targetLerp;
        public float[] Heights;
        float Offset(int index)
        {
            if (Heights == null || index < 0 || index >= Heights.Length) return 0;
            float reference = index == secondTarget && secondDefaultHeight != 0 ? secondDefaultHeight : defaultHeight;
            return (Heights[index] - reference) * 0.883f;
        }
        void LateUpdate()
        {
            var p = transform.localPosition;
            p.y = Mathf.Lerp(Offset(target), Offset(secondTarget), targetLerp);
            transform.localPosition = p;
        }
    }
}
