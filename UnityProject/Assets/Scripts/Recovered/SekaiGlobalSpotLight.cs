
using UnityEngine;

namespace Sekai
{
	[ExecuteAlways]
	public class SekaiGlobalSpotLight : MonoBehaviour
	{
		[SerializeField]
		private Color outerColor = new Color
		{
			r = 1f,
			g = 1f,
			b = 1f,
			a = 1f
		};

		[SerializeField]
		private float radiusNear = 999f;

		[SerializeField]
		private float radiusFar = 1000f;

		public Color OuterColor
		{
			get
			{
				return outerColor;
			}
			set
			{
				outerColor = value;
			}
		}

		public float RadiusNear
		{
			get
			{
				return radiusNear;
			}
			set
			{
				radiusNear = value;
			}
		}

		public float RadiusFar
		{
			get
			{
				return radiusFar;
			}
			set
			{
				radiusFar = value;
			}
		}

		public void SetEnabled(bool isEnable)
		{
			gameObject.SetActive(isEnable);
			Shader.SetGlobalInt("_SekaiGlobalSpotLightEnabled", isEnable ? 1 : 0);
		}

		public bool CheckInsideOnHorizontal(Vector3 pos)
		{
			if (gameObject.activeInHierarchy)
			{
				Vector3 position = transform.position;
				float num = radiusFar;
				return (pos.z - position.z) * (pos.z - position.z) + ((pos.x - position.x) * (pos.x - position.x) + 0f) <= num * num;
			}
			return true;
		}

		public void Reset()
		{
			outerColor = new Color
			{
				r = 1f,
				g = 1f,
				b = 1f,
				a = 1f
			};
			radiusNear = 999f;
			radiusFar = 1000f;
			transform.position = Vector3.zero;
		}

		private void Update()
		{
			int sEKAI_GLOBAL_SPOT_LIGHT_POS_ID = ShaderPropertyID.SEKAI_GLOBAL_SPOT_LIGHT_POS_ID;
			Vector3 position = transform.position;
			Shader.SetGlobalVector(sEKAI_GLOBAL_SPOT_LIGHT_POS_ID, new Vector4
			{
				x = position.x,
				y = position.y,
				z = position.z
			});
			Shader.SetGlobalColor(ShaderPropertyID.SEKAI_GLOBAL_SPOT_LIGHT_COLOR_ID, outerColor);
			float num = radiusNear;
			Shader.SetGlobalFloat(ShaderPropertyID.SEKAI_GLOBAL_SPOT_LIGHT_RADIUS_NEAR_ID, num * num);
			float num2 = radiusFar;
			Shader.SetGlobalFloat(ShaderPropertyID.SEKAI_GLOBAL_SPOT_LIGHT_RADIUS_FAR_ID, num2 * num2);
		}
	}
}
