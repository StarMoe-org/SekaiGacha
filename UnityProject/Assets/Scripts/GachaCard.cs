using System;
using System.Text.RegularExpressions;

namespace SekaiGacha
{
    // 卡牌稀有度，数值与原版 CardRarityType 一致（rarity_1 不会出现在招募中）。
    public enum GachaRarity
    {
        Rarity2 = 2,
        Rarity3 = 3,
        Rarity4 = 4,
        Birthday = 5,
    }

    // 一张要揭开的卡：资源名决定卡面、语音和角色，稀有度决定演出。
    public readonly struct GachaCard
    {
        static readonly Regex IdPattern = new Regex(@"^res\d+_no\d+$");

        public readonly string Id;
        public readonly GachaRarity Rarity;

        public GachaCard(string id, GachaRarity rarity)
        {
            if (!IsValidId(id)) throw new ArgumentException("无效的卡牌资源名 " + id, nameof(id));
            if (!Enum.IsDefined(typeof(GachaRarity), rarity)) throw new ArgumentException("无效的稀有度 " + rarity, nameof(rarity));
            Id = id;
            Rarity = rarity;
        }

        public int CharacterId => int.Parse(Id.Substring(3, Id.IndexOf('_') - 3));
        // 原版按 (rarity & ~1) == 4 判断，四星与生日卡同属最高档。
        public static bool IsTopRarity(GachaRarity rarity) => rarity == GachaRarity.Rarity4 || rarity == GachaRarity.Birthday;
        public static bool IsValidId(string id) => id != null && IdPattern.IsMatch(id);

        // 接受主数据的 cardRarityType 写法：rarity_2、rarity_3、rarity_4、rarity_birthday。
        public static bool TryParseRarity(string value, out GachaRarity rarity)
        {
            switch (value)
            {
                case "rarity_2": rarity = GachaRarity.Rarity2; return true;
                case "rarity_3": rarity = GachaRarity.Rarity3; return true;
                case "rarity_4": rarity = GachaRarity.Rarity4; return true;
                case "rarity_birthday": rarity = GachaRarity.Birthday; return true;
                default: rarity = default; return false;
            }
        }
    }
}
