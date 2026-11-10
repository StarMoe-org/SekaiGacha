using System.Collections.Generic;

// 抽卡 master 数据的最小子集。字段名与 master JSON（Haruki gachas.json / cards.json）一致，
// 也与客户端 Sekai.MasterGacha* 的 Key 一致，可直接反序列化。
// 本目录不引用 UnityEngine，可在 Unity 外用 dotnet 编译测试（见 Tests/GachaSimulation）。
namespace SekaiGacha.Simulation
{
    // Tools/extract_gacha_pool.py 生成的单卡池文件：一个卡池及其涉及的卡牌。
    public sealed class GachaPool
    {
        public MasterGacha gacha;
        public List<MasterCard> cards = new List<MasterCard>();
        // 揭卡演出用：★2 卡背景按角色所属单位选择（GachaDisplayState.SetupBackground）。
        public List<MasterGameCharacter> gameCharacters = new List<MasterGameCharacter>();
    }

    public sealed class MasterGacha
    {
        public int id;
        public string gachaType;
        public string name;
        public long startAt;
        public long endAt;
        public int wishSelectCount;
        public int wishFixedSelectCount;
        public int wishLimitedSelectCount;
        public int rateChoiceGachaWishGroupId;
        public List<MasterGachaBehavior> gachaBehaviors = new List<MasterGachaBehavior>();
        public List<MasterGachaCardRarityRate> gachaCardRarityRates = new List<MasterGachaCardRarityRate>();
        public List<MasterGachaDetail> gachaDetails = new List<MasterGachaDetail>();
        public List<MasterGachaPickup> gachaPickups = new List<MasterGachaPickup>();
    }

    public sealed class MasterGachaBehavior
    {
        public int id;
        public int gachaId;
        public int groupId;
        public int priority;
        public string gachaBehaviorType;
        public string costResourceType;
        public int? costResourceQuantity;
        public int spinCount;
    }

    public sealed class MasterGachaCardRarityRate
    {
        public int id;
        public string cardRarityType;
        public string lotteryType;
        public double rate;
    }

    public sealed class MasterGachaDetail
    {
        public int id;
        public int gachaId;
        public int cardId;
        public long weight;
        public bool isWish;
        public string gachaDetailWishType;
    }

    public sealed class MasterGachaPickup
    {
        public int id;
        public int gachaId;
        public int cardId;
        public string gachaPickupType;
    }

    public sealed class MasterCard
    {
        public int id;
        public int characterId;
        public string cardRarityType;
        public string assetbundleName;
        public string prefix;
        public string gachaPhrase;
        public string initialSpecialTrainingStatus;
    }

    public sealed class MasterGameCharacter
    {
        public int id;
        public string unit;
    }
}
