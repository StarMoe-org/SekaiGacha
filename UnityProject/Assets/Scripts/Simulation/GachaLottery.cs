using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

// 抽卡模拟核心。真实抽选在服务端，这里按客户端公示概率的计算方式复现（依据逆向的 jp 7.1.0 客户端）：
// - 先按 gachaCardRarityRates 抽“概率档”（稀有度 + lotteryType），再在档内按 gachaDetails.weight 抽卡；
//   单卡概率 = 档概率 × weight / 档内总 weight（GachaMemberRateCell.Setup）。
// - over_rarity_3_once / over_rarity_4_once 行为每次执行有一抽使用保底概率表（GachaUtility.GetFixedRarityRate）：
//   ★3 保底时 ★2 的概率并入 ★3；★4 保底时 ★2、★3 的概率并入 ★4；生日卡不变。
//   保底抽固定放在本次执行的最后一抽（十连的第 10 抽），与官方“10 回目”公示一致；客户端看不到服务端实际顺序。
// - 自选卡池（wishSelectCount > 0）：含 wish 卡的档只从玩家选中的卡里抽，选中卡平分该档概率
//   （GachaMemberRateTopCell.Setup 的 rarityRate / wishListCount）。
// 暂不支持：分类 wish（Dream Pick，categorized_wish）与概率自选（rate_choice_*）卡池，其普通档的候选集合在客户端里无法确定。
namespace SekaiGacha.Simulation
{
    // 返回 [0, 1) 的随机数。
    public interface IRandomSource
    {
        double NextDouble();
    }

    public sealed class SystemRandomSource : IRandomSource
    {
        readonly Random random;
        public SystemRandomSource() { random = new Random(); }
        public SystemRandomSource(int seed) { random = new Random(seed); }
        public double NextDouble() => random.NextDouble();
    }

    public sealed class GachaPrize
    {
        public MasterCard Card { get; }
        public string LotteryType { get; }
        public bool IsGuaranteedSlot { get; }
        public GachaPrize(MasterCard card, string lotteryType, bool isGuaranteedSlot)
        {
            Card = card;
            LotteryType = lotteryType;
            IsGuaranteedSlot = isGuaranteedSlot;
        }
    }

    public sealed class CardRate
    {
        public MasterCard Card { get; }
        // 百分比，所有卡合计 100。
        public double Rate { get; }
        public CardRate(MasterCard card, double rate) { Card = card; Rate = rate; }
    }

    public sealed class GachaLottery
    {
        public const string NormalLottery = "normal";

        sealed class Candidate
        {
            public MasterCard Card;
            public long Weight;
        }

        sealed class Bucket
        {
            public string Rarity;
            public string LotteryType;
            public double Rate;
            public Candidate[] Candidates;
            public long TotalWeight;
            public Bucket WithRate(double rate) => new Bucket { Rarity = Rarity, LotteryType = LotteryType, Rate = rate, Candidates = Candidates, TotalWeight = TotalWeight };
        }

        readonly Bucket[] normalTable;
        readonly Dictionary<int, Bucket[]> guaranteedTables = new Dictionary<int, Bucket[]>();

        public MasterGacha Gacha { get; }
        public bool IsSelectGacha => Gacha.wishSelectCount > 0;
        public IReadOnlyList<int> WishCardIds { get; }

        public GachaLottery(GachaPool pool, IEnumerable<int> wishCardIds = null)
        {
            if (pool?.gacha == null) throw new InvalidDataException("卡池文件缺少 gacha");
            Gacha = pool.gacha;
            string reason = UnsupportedReason(Gacha);
            if (reason != null) throw new NotSupportedException(reason);
            var cards = new Dictionary<int, MasterCard>();
            foreach (var card in pool.cards ?? new List<MasterCard>()) cards[card.id] = card;
            var wish = ResolveWish(wishCardIds);
            WishCardIds = wish == null ? (IReadOnlyList<int>)Array.Empty<int>() : wish.ToArray();
            normalTable = BuildNormalTable(cards, wish == null ? null : new HashSet<int>(wish));
        }

        // 返回 null 表示支持；否则返回不支持的原因。
        public static string UnsupportedReason(MasterGacha gacha)
        {
            if (gacha.rateChoiceGachaWishGroupId != 0)
                return "卡池 " + gacha.id + " 是概率自选卡池（rate choice），暂不支持";
            if (gacha.wishSelectCount > 0 && (gacha.wishFixedSelectCount > 0 || gacha.wishLimitedSelectCount > 0))
                return "卡池 " + gacha.id + " 是分类 wish 卡池（Dream Pick），暂不支持";
            var other = gacha.gachaCardRarityRates.FirstOrDefault(r => !IsNormalLottery(r.lotteryType));
            if (other != null)
                return "卡池 " + gacha.id + " 含 lotteryType=" + other.lotteryType + " 的概率档，暂不支持";
            if (gacha.gachaCardRarityRates.Count == 0)
                return "卡池 " + gacha.id + " 没有稀有度概率";
            return null;
        }

        // 自选卡池的默认选择：先选 UP 卡，再按 gachaDetails 顺序补满 wishSelectCount。
        public static int[] DefaultWishSelection(GachaPool pool)
        {
            var gacha = pool.gacha;
            if (gacha.wishSelectCount <= 0) return Array.Empty<int>();
            var eligible = WishEligible(gacha);
            var pickups = new HashSet<int>(gacha.gachaPickups.Select(p => p.cardId));
            return eligible.Where(pickups.Contains).Concat(eligible.Where(id => !pickups.Contains(id)))
                .Take(gacha.wishSelectCount).ToArray();
        }

        // 保底稀有度：over_rarity_3_once → 3，over_rarity_4_once → 4，无保底 → 0。
        public static int GuaranteedRarityOf(MasterGachaBehavior behavior)
        {
            switch (behavior.gachaBehaviorType)
            {
                case "over_rarity_3_once": return 3;
                case "over_rarity_4_once": return 4;
                case "normal":
                case "once_a_day":
                case "once_a_week": return 0;
                default: throw new NotSupportedException("未知的抽卡行为类型 " + behavior.gachaBehaviorType);
            }
        }

        public MasterGachaBehavior FindBehavior(int behaviorId)
        {
            var behavior = Gacha.gachaBehaviors.FirstOrDefault(b => b.id == behaviorId);
            if (behavior == null) throw new ArgumentException("卡池 " + Gacha.id + " 没有抽卡行为 " + behaviorId, nameof(behaviorId));
            return behavior;
        }

        // 默认十连：优先带保底的 10 抽，其次任意 10 抽。
        public MasterGachaBehavior DefaultTenPullBehavior()
        {
            var tens = Gacha.gachaBehaviors.Where(b => b.spinCount == 10).ToList();
            var behavior = tens.FirstOrDefault(b => GuaranteedRarityOf(b) > 0) ?? tens.FirstOrDefault();
            if (behavior == null) throw new InvalidDataException("卡池 " + Gacha.id + " 没有十连");
            return behavior;
        }

        public GachaPrize[] Spin(MasterGachaBehavior behavior, IRandomSource random)
        {
            if (behavior == null) throw new ArgumentNullException(nameof(behavior));
            if (random == null) throw new ArgumentNullException(nameof(random));
            if (behavior.gachaId != 0 && behavior.gachaId != Gacha.id)
                throw new ArgumentException("抽卡行为 " + behavior.id + " 不属于卡池 " + Gacha.id, nameof(behavior));
            if (behavior.spinCount < 1) throw new InvalidDataException("抽卡行为 " + behavior.id + " 的抽数无效: " + behavior.spinCount);
            int guaranteed = GuaranteedRarityOf(behavior);
            var prizes = new GachaPrize[behavior.spinCount];
            for (int i = 0; i < prizes.Length; i++)
            {
                bool slot = guaranteed > 0 && i == prizes.Length - 1;
                prizes[i] = Draw(slot ? GuaranteedTable(guaranteed) : normalTable, random, slot);
            }
            return prizes;
        }

        // 单抽各卡概率（百分比）。guaranteedRarity 为 0 表示普通抽，3/4 表示对应保底抽。
        public IReadOnlyList<CardRate> GetCardRates(int guaranteedRarity = 0)
        {
            var table = guaranteedRarity > 0 ? GuaranteedTable(guaranteedRarity) : normalTable;
            double total = table.Sum(b => b.Rate);
            var rates = new Dictionary<int, double>();
            var order = new List<MasterCard>();
            foreach (var bucket in table)
            {
                if (bucket.Rate <= 0) continue;
                foreach (var candidate in bucket.Candidates)
                {
                    double rate = 100 * bucket.Rate / total * candidate.Weight / bucket.TotalWeight;
                    if (rates.TryGetValue(candidate.Card.id, out double sum)) rates[candidate.Card.id] = sum + rate;
                    else { rates.Add(candidate.Card.id, rate); order.Add(candidate.Card); }
                }
            }
            return order.Select(card => new CardRate(card, rates[card.id])).ToArray();
        }

        static bool IsNormalLottery(string lotteryType) => string.IsNullOrEmpty(lotteryType) || lotteryType == NormalLottery;

        static List<int> WishEligible(MasterGacha gacha) =>
            gacha.gachaDetails.Where(d => d.isWish).Select(d => d.cardId).Distinct().ToList();

        List<int> ResolveWish(IEnumerable<int> wishCardIds)
        {
            var selected = wishCardIds?.ToList();
            if (!IsSelectGacha)
            {
                if (selected != null && selected.Count > 0) throw new ArgumentException("卡池 " + Gacha.id + " 不是自选卡池", nameof(wishCardIds));
                return null;
            }
            var eligible = WishEligible(Gacha);
            int required = Math.Min(Gacha.wishSelectCount, eligible.Count);
            if (selected == null || selected.Count != required)
                throw new ArgumentException("自选卡池 " + Gacha.id + " 需要选择 " + required + " 张卡，实际 " + (selected?.Count ?? 0), nameof(wishCardIds));
            if (selected.Distinct().Count() != selected.Count) throw new ArgumentException("自选卡有重复", nameof(wishCardIds));
            var eligibleSet = new HashSet<int>(eligible);
            var invalid = selected.Where(id => !eligibleSet.Contains(id)).ToList();
            if (invalid.Count > 0) throw new ArgumentException("这些卡不能自选: " + string.Join(",", invalid), nameof(wishCardIds));
            return selected;
        }

        Bucket[] BuildNormalTable(Dictionary<int, MasterCard> cards, HashSet<int> wish)
        {
            var details = Gacha.gachaDetails.Select(d =>
            {
                if (!cards.TryGetValue(d.cardId, out var card)) throw new InvalidDataException("卡池 " + Gacha.id + " 缺少卡牌数据 " + d.cardId);
                return (detail: d, card);
            }).ToList();
            var table = new List<Bucket>();
            foreach (var rate in Gacha.gachaCardRarityRates)
            {
                RarityRank(rate.cardRarityType);
                var inRarity = details.Where(x => x.card.cardRarityType == rate.cardRarityType).ToList();
                Candidate[] candidates;
                if (wish != null && inRarity.Any(x => x.detail.isWish))
                    candidates = inRarity.Where(x => x.detail.isWish && wish.Contains(x.card.id))
                        .Select(x => new Candidate { Card = x.card, Weight = 1 }).ToArray();
                else
                    candidates = inRarity.Where(x => x.detail.weight > 0)
                        .Select(x => new Candidate { Card = x.card, Weight = x.detail.weight }).ToArray();
                if (rate.rate > 0 && candidates.Length == 0)
                    throw new InvalidDataException("卡池 " + Gacha.id + " 的 " + rate.cardRarityType + " 有概率但没有可抽的卡");
                table.Add(new Bucket
                {
                    Rarity = rate.cardRarityType,
                    LotteryType = string.IsNullOrEmpty(rate.lotteryType) ? NormalLottery : rate.lotteryType,
                    Rate = Math.Max(0, rate.rate),
                    Candidates = candidates,
                    TotalWeight = candidates.Sum(c => c.Weight),
                });
            }
            if (table.Sum(b => b.Rate) <= 0) throw new InvalidDataException("卡池 " + Gacha.id + " 的概率合计为 0");
            return table.ToArray();
        }

        static int RarityRank(string rarity)
        {
            switch (rarity)
            {
                case "rarity_1": return 1;
                case "rarity_2": return 2;
                case "rarity_3": return 3;
                case "rarity_4": return 4;
                // 生日卡与 ★4 同级，保底时不并入也不被并入。
                case "rarity_birthday": return 4;
                default: throw new InvalidDataException("未知的稀有度 " + rarity);
            }
        }

        Bucket[] GuaranteedTable(int level)
        {
            if (guaranteedTables.TryGetValue(level, out var cached)) return cached;
            if (level != 3 && level != 4) throw new ArgumentOutOfRangeException(nameof(level), level, "保底稀有度只能是 3 或 4");
            string targetRarity = "rarity_" + level;
            int target = Array.FindIndex(normalTable, b => b.Rarity == targetRarity);
            double moved = normalTable.Where(b => RarityRank(b.Rarity) < level).Sum(b => b.Rate);
            if (moved > 0 && target < 0) throw new InvalidDataException("卡池 " + Gacha.id + " 没有 " + targetRarity + "，无法计算 ★" + level + " 保底");
            var table = normalTable.Select((b, i) => i == target ? b.WithRate(b.Rate + moved) : RarityRank(b.Rarity) < level ? b.WithRate(0) : b).ToArray();
            guaranteedTables.Add(level, table);
            return table;
        }

        static GachaPrize Draw(Bucket[] table, IRandomSource random, bool guaranteedSlot)
        {
            var bucket = Pick(table, b => b.Rate, random.NextDouble());
            var candidate = Pick(bucket.Candidates, c => c.Weight, random.NextDouble());
            return new GachaPrize(candidate.Card, bucket.LotteryType, guaranteedSlot);
        }

        // 按权重取一项；u ∈ [0, 1)。权重为 0 的项不会被选中。
        static T Pick<T>(IList<T> items, Func<T, double> weight, double u)
        {
            double total = 0;
            foreach (var item in items) total += Math.Max(0, weight(item));
            double roll = u * total, sum = 0;
            T last = default;
            foreach (var item in items)
            {
                double w = Math.Max(0, weight(item));
                if (w <= 0) continue;
                sum += w;
                last = item;
                if (roll < sum) return item;
            }
            return last;
        }
    }
}
