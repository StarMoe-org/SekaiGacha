using System;
using UnityEngine;

namespace SekaiGacha
{
    public sealed class GachaOfflineCatalog : ScriptableObject
    {
        [Serializable]
        public struct Entry
        {
            public string bundle;
            public string name;
            public UnityEngine.Object asset;
        }
        public Entry[] entries;
    }
}
