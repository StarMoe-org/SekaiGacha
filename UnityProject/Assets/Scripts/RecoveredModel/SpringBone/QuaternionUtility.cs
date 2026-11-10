using UnityEngine;

namespace CP
{
	public static class QuaternionUtility
	{
		private static float x;

		private static float y;

		private static float z;

		private static float w;

		public static void Right(Quaternion rotation, ref Vector3 target)
		{
			x = rotation.w + rotation.x;
			y = rotation.y + rotation.z;
			z = rotation.z - rotation.y;
			w = rotation.w - rotation.x;
			target = new Vector3
			{
				x = rotation.y * (rotation.z - rotation.y) + (rotation.w * (rotation.w + rotation.x) - rotation.x * (rotation.w - rotation.x) - rotation.z * (rotation.y + rotation.z)),
				y = rotation.z * (rotation.w + rotation.x) + (rotation.w * (rotation.y + rotation.z) - rotation.y * (rotation.w - rotation.x) - rotation.x * (rotation.z - rotation.y)),
				z = rotation.x * (rotation.y + rotation.z) + (rotation.w * (rotation.z - rotation.y) - rotation.z * (rotation.w - rotation.x) - rotation.y * (rotation.w + rotation.x))
			};
		}

		public static void Left(Quaternion rotation, ref Vector3 target)
		{
			x = rotation.x - rotation.w;
			y = rotation.y - rotation.z;
			z = rotation.z + rotation.y;
			w = rotation.w + rotation.x;
			target = new Vector3
			{
				x = rotation.y * (rotation.z + rotation.y) + (rotation.w * (rotation.x - rotation.w) - rotation.x * (rotation.w + rotation.x) - rotation.z * (rotation.y - rotation.z)),
				y = rotation.z * (rotation.x - rotation.w) + (rotation.w * (rotation.y - rotation.z) - rotation.y * (rotation.w + rotation.x) - rotation.x * (rotation.z + rotation.y)),
				z = rotation.x * (rotation.y - rotation.z) + (rotation.w * (rotation.z + rotation.y) - rotation.z * (rotation.w + rotation.x) - rotation.y * (rotation.x - rotation.w))
			};
		}

		public static void Up(Quaternion rotation, ref Vector3 target)
		{
			x = rotation.x - rotation.z;
			y = rotation.w + rotation.y;
			z = rotation.z + rotation.x;
			w = rotation.w - rotation.y;
			target = new Vector3
			{
				x = rotation.y * (rotation.z + rotation.x) + (rotation.w * (rotation.x - rotation.z) - rotation.x * (rotation.w - rotation.y) - rotation.z * (rotation.w + rotation.y)),
				y = rotation.z * (rotation.x - rotation.z) + (rotation.w * (rotation.w + rotation.y) - rotation.y * (rotation.w - rotation.y) - rotation.x * (rotation.z + rotation.x)),
				z = rotation.x * (rotation.w + rotation.y) + (rotation.w * (rotation.z + rotation.x) - rotation.z * (rotation.w - rotation.y) - rotation.y * (rotation.x - rotation.z))
			};
		}

		public static void Down(Quaternion rotation, ref Vector3 target)
		{
			x = rotation.x + rotation.z;
			y = rotation.y - rotation.w;
			z = rotation.z - rotation.x;
			w = rotation.w + rotation.y;
			target = new Vector3
			{
				x = rotation.y * (rotation.z - rotation.x) + (rotation.w * (rotation.x + rotation.z) - rotation.x * (rotation.w + rotation.y) - rotation.z * (rotation.y - rotation.w)),
				y = rotation.z * (rotation.x + rotation.z) + (rotation.w * (rotation.y - rotation.w) - rotation.y * (rotation.w + rotation.y) - rotation.x * (rotation.z - rotation.x)),
				z = rotation.x * (rotation.y - rotation.w) + (rotation.w * (rotation.z - rotation.x) - rotation.z * (rotation.w + rotation.y) - rotation.y * (rotation.x + rotation.z))
			};
		}

		public static void Forward(Quaternion rotation, ref Vector3 target)
		{
			x = rotation.x + rotation.y;
			y = rotation.y - rotation.x;
			z = rotation.w + rotation.z;
			w = rotation.w - rotation.z;
			target = new Vector3
			{
				x = rotation.y * (rotation.w + rotation.z) + (rotation.w * (rotation.x + rotation.y) - rotation.x * (rotation.w - rotation.z) - rotation.z * (rotation.y - rotation.x)),
				y = rotation.z * (rotation.x + rotation.y) + (rotation.w * (rotation.y - rotation.x) - rotation.y * (rotation.w - rotation.z) - rotation.x * (rotation.w + rotation.z)),
				z = rotation.x * (rotation.y - rotation.x) + (rotation.w * (rotation.w + rotation.z) - rotation.z * (rotation.w - rotation.z) - rotation.y * (rotation.x + rotation.y))
			};
		}

		public static void Back(Quaternion rotation, ref Vector3 target)
		{
			x = rotation.x - rotation.y;
			y = rotation.y + rotation.x;
			z = rotation.z - rotation.w;
			w = rotation.w + rotation.z;
			target = new Vector3
			{
				x = rotation.y * (rotation.z - rotation.w) + (rotation.w * (rotation.x - rotation.y) - rotation.x * (rotation.w + rotation.z) - rotation.z * (rotation.y + rotation.x)),
				y = rotation.z * (rotation.x - rotation.y) + (rotation.w * (rotation.y + rotation.x) - rotation.y * (rotation.w + rotation.z) - rotation.x * (rotation.z - rotation.w)),
				z = rotation.x * (rotation.y + rotation.x) + (rotation.w * (rotation.z - rotation.w) - rotation.z * (rotation.w + rotation.z) - rotation.y * (rotation.x - rotation.y))
			};
		}
	}
}
