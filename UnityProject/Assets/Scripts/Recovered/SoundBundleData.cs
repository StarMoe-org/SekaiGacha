using System;
using UnityEngine;

namespace Sekai {

[Serializable]
public class SoundBundleData
{
	public enum FormatType
	{
		Normal,
		Split
	}

	[SerializeField]
	private FormatType formatType;

	[SerializeField]
	private string assetBundleFileName;

	[SerializeField]
	private string cueSheetName;

	[SerializeField]
	private int spilitFileNum;

	public FormatType Format
	{
		get
		{
			return (FormatType)(uint)formatType;
		}
		set
		{
			formatType = value;
		}
	}

	public string AssetBundleFileName
	{
		get
		{
			return assetBundleFileName;
		}
		set
		{
			assetBundleFileName = value;
		}
	}

	public string CueSheetName
	{
		get
		{
			return cueSheetName;
		}
		set
		{
			cueSheetName = value;
		}
	}

	public int SpilitFileNum
	{
		get
		{
			return (int)(uint)spilitFileNum;
		}
		set
		{
			spilitFileNum = value;
		}
	}
}

}
