using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.Json;
using SekaiGacha.Simulation;

// 零依赖测试：dotnet run --project Tests/GachaSimulation [-- --master <master 目录> --pool <GachaPool.json>]
// 默认读取仓库 Cache/master（Haruki gachas.json / cards.json）；不存在则跳过真实数据用例。
static class Program
{
    static int passed, failed, skipped;

    static int Main(string[] args)
    {
        string root = FindRepoRoot();
        string master = Option(args, "--master") ?? Path.Combine(root, "Cache", "master");
        string pool = Option(args, "--pool") ?? Path.Combine(root, "UnityProject", "Assets", "Resources", "GachaPool.json");

        Run("普通抽：单卡概率 = 档概率 × weight / 档内总 weight", NormalRates);
        Run("★3 保底表：★2 并入 ★3，★4 不变", GuaranteedRarity3);
        Run("★4 保底表：★2、★3 并入 ★4", GuaranteedRarity4);
        Run("生日池 ★3 保底：生日卡不变", BirthdayGuarantee);
        Run("十连只有最后一抽是保底，且保底抽 ≥★3", TenPullGuaranteeSlot);
        Run("非保底行为不产生保底抽", NormalBehaviorHasNoGuarantee);
        Run("大样本频率与公示概率一致", MonteCarlo);
        Run("同一种子结果相同", Deterministic);
        Run("自选池：选中卡平分 ★4 概率，未选中卡不出", SelectGacha);
        Run("自选池：选择数量、重复、非法卡报错", SelectGachaValidation);
        Run("暂不支持的卡池类型明确报错", UnsupportedKinds);
        Run("未知行为类型、缺卡数据报错", InvalidData);
        Run("默认十连优先选择带保底的 10 抽", DefaultTenPull);

        if (File.Exists(Path.Combine(master, "gachas.json")) && File.Exists(Path.Combine(master, "cards.json")))
            Run("真实 master：全部卡池概率合计 100%，各行为可抽", () => RealMaster(master));
        else Skip("真实 master（未找到 " + master + "）");
        if (File.Exists(pool)) Run("卡池文件 " + Path.GetFileName(pool) + " 可加载并十连", () => PoolFile(pool));
        else Skip("卡池文件（未找到 " + pool + "）");

        Console.WriteLine();
        Console.WriteLine($"通过 {passed}，失败 {failed}，跳过 {skipped}");
        return failed == 0 ? 0 : 1;
    }

    // ---------- 合成数据 ----------

    static GachaPool Pool(int gachaId = 1, params (int id, string rarity, long weight, bool wish)[] details)
    {
        var pool = new GachaPool { gacha = new MasterGacha { id = gachaId, gachaType = "ceil", name = "测试" } };
        foreach (var d in details)
        {
            pool.cards.Add(new MasterCard { id = d.id, characterId = 1, cardRarityType = d.rarity, assetbundleName = $"res001_no{d.id:000}" });
            pool.gacha.gachaDetails.Add(new MasterGachaDetail { id = d.id, gachaId = gachaId, cardId = d.id, weight = d.weight, isWish = d.wish });
        }
        return pool;
    }

    static GachaPool Rate(GachaPool pool, string rarity, double rate, string lottery = "normal")
    {
        pool.gacha.gachaCardRarityRates.Add(new MasterGachaCardRarityRate { cardRarityType = rarity, lotteryType = lottery, rate = rate });
        return pool;
    }

    static MasterGachaBehavior Behavior(GachaPool pool, int id, string type, int spinCount)
    {
        var behavior = new MasterGachaBehavior { id = id, gachaId = pool.gacha.id, gachaBehaviorType = type, spinCount = spinCount, costResourceType = "jewel" };
        pool.gacha.gachaBehaviors.Add(behavior);
        return behavior;
    }

    // 与 Lit in the Dark 卡池同结构：UP ★4 权重 4,000,000，其余 ★4 共 26,000,000 → UP 单卡 0.4%。
    static GachaPool Standard()
    {
        var pool = Pool(1,
            (1, "rarity_2", 1, false), (2, "rarity_2", 1, false),
            (3, "rarity_3", 1, false),
            (4, "rarity_4", 4_000_000, false), (5, "rarity_4", 13_000_000, false), (6, "rarity_4", 13_000_000, false));
        Rate(pool, "rarity_2", 88.5); Rate(pool, "rarity_3", 8.5); Rate(pool, "rarity_4", 3.0);
        pool.gacha.gachaPickups.Add(new MasterGachaPickup { id = 1, gachaId = 1, cardId = 4, gachaPickupType = "normal" });
        Behavior(pool, 10, "normal", 1);
        Behavior(pool, 11, "over_rarity_3_once", 10);
        return pool;
    }

    static Dictionary<int, double> Rates(GachaLottery lottery, int guaranteed = 0) =>
        lottery.GetCardRates(guaranteed).ToDictionary(r => r.Card.id, r => r.Rate);

    static void NormalRates()
    {
        var rates = Rates(new GachaLottery(Standard()));
        Near(rates[1], 44.25); Near(rates[2], 44.25); Near(rates[3], 8.5);
        Near(rates[4], 0.4); Near(rates[5], 1.3); Near(rates[6], 1.3);
        Near(rates.Values.Sum(), 100);
    }

    static void GuaranteedRarity3()
    {
        var rates = Rates(new GachaLottery(Standard()), 3);
        Check(!rates.ContainsKey(1) && !rates.ContainsKey(2), "★2 在 ★3 保底抽中不应出现");
        Near(rates[3], 97); Near(rates[4], 0.4); Near(rates.Values.Sum(), 100);
    }

    static void GuaranteedRarity4()
    {
        var rates = Rates(new GachaLottery(Standard()), 4);
        Check(rates.Keys.All(id => id >= 4), "★4 保底抽只应出 ★4");
        Near(rates[4], 100 * 4.0 / 30); Near(rates.Values.Sum(), 100);
    }

    static void BirthdayGuarantee()
    {
        var pool = Pool(1, (1, "rarity_2", 1, false), (2, "rarity_3", 1, false), (3, "rarity_birthday", 1, false));
        Rate(pool, "rarity_2", 88.5); Rate(pool, "rarity_3", 8.5); Rate(pool, "rarity_birthday", 3.0);
        var rates = Rates(new GachaLottery(pool), 3);
        Near(rates[2], 97); Near(rates[3], 3); Check(!rates.ContainsKey(1), "★2 不应出现");
        Throws<InvalidDataException>(() => new GachaLottery(pool).GetCardRates(4));
    }

    static void TenPullGuaranteeSlot()
    {
        var pool = Standard();
        var lottery = new GachaLottery(pool);
        var behavior = lottery.FindBehavior(11);
        var random = new SystemRandomSource(7);
        for (int n = 0; n < 5000; n++)
        {
            var prizes = lottery.Spin(behavior, random);
            Check(prizes.Length == 10, "十连应有 10 张");
            Check(prizes.Take(9).All(p => !p.IsGuaranteedSlot) && prizes[9].IsGuaranteedSlot, "只有第 10 抽是保底抽");
            Check(prizes[9].Card.cardRarityType != "rarity_2", "保底抽出了 ★2");
        }
    }

    static void NormalBehaviorHasNoGuarantee()
    {
        var lottery = new GachaLottery(Standard());
        var random = new SystemRandomSource(3);
        bool sawRarity2 = false;
        for (int n = 0; n < 200; n++)
        {
            var prize = lottery.Spin(lottery.FindBehavior(10), random).Single();
            Check(!prize.IsGuaranteedSlot, "单抽不应是保底抽");
            sawRarity2 |= prize.Card.cardRarityType == "rarity_2";
        }
        Check(sawRarity2, "200 次单抽应出现 ★2");
    }

    static void MonteCarlo()
    {
        var lottery = new GachaLottery(Standard());
        var random = new SystemRandomSource(12345);
        const int spins = 50_000;
        var counts = new Dictionary<int, int>();
        foreach (var prize in Enumerable.Range(0, spins).SelectMany(_ => lottery.Spin(lottery.FindBehavior(11), random)))
            counts[prize.Card.id] = counts.GetValueOrDefault(prize.Card.id) + 1;
        double total = spins * 10;
        // 9 抽普通 + 1 抽保底的期望。
        var normal = Rates(lottery); var guaranteed = Rates(lottery, 3);
        foreach (int id in normal.Keys)
        {
            double expected = (9 * normal[id] + guaranteed.GetValueOrDefault(id)) / 10 / 100;
            double actual = counts.GetValueOrDefault(id) / total;
            double sigma = Math.Sqrt(expected * (1 - expected) / total);
            Check(Math.Abs(actual - expected) < 5 * sigma, $"卡 {id} 频率 {actual:P4}，期望 {expected:P4}");
        }
    }

    static void Deterministic()
    {
        var lottery = new GachaLottery(Standard());
        var a = lottery.Spin(lottery.FindBehavior(11), new SystemRandomSource(99)).Select(p => p.Card.id);
        var b = lottery.Spin(lottery.FindBehavior(11), new SystemRandomSource(99)).Select(p => p.Card.id);
        Check(a.SequenceEqual(b), "同一种子结果不同");
    }

    static GachaPool SelectPool()
    {
        var pool = Pool(2,
            (1, "rarity_2", 1, false), (2, "rarity_3", 1, false),
            (10, "rarity_4", 1, true), (11, "rarity_4", 1, true), (12, "rarity_4", 1, true), (13, "rarity_4", 1, true));
        pool.gacha.wishSelectCount = 2;
        Rate(pool, "rarity_2", 85.5); Rate(pool, "rarity_3", 8.5); Rate(pool, "rarity_4", 6.0);
        pool.gacha.gachaPickups.Add(new MasterGachaPickup { id = 1, gachaId = 2, cardId = 12 });
        Behavior(pool, 20, "over_rarity_3_once", 10);
        return pool;
    }

    static void SelectGacha()
    {
        var pool = SelectPool();
        var rates = Rates(new GachaLottery(pool, new[] { 11, 13 }));
        Near(rates[11], 3); Near(rates[13], 3);
        Check(!rates.ContainsKey(10) && !rates.ContainsKey(12), "未选中的卡不应出现");
        Near(rates.Values.Sum(), 100);
        var defaults = GachaLottery.DefaultWishSelection(pool);
        Check(defaults.SequenceEqual(new[] { 12, 10 }), "默认自选应先选 UP 卡: " + string.Join(",", defaults));
    }

    static void SelectGachaValidation()
    {
        var pool = SelectPool();
        Throws<ArgumentException>(() => new GachaLottery(pool));
        Throws<ArgumentException>(() => new GachaLottery(pool, new[] { 10 }));
        Throws<ArgumentException>(() => new GachaLottery(pool, new[] { 10, 10 }));
        Throws<ArgumentException>(() => new GachaLottery(pool, new[] { 10, 2 }));
        Throws<ArgumentException>(() => new GachaLottery(Standard(), new[] { 4 }));
    }

    static void UnsupportedKinds()
    {
        var rateChoice = Standard(); rateChoice.gacha.rateChoiceGachaWishGroupId = 1;
        Throws<NotSupportedException>(() => new GachaLottery(rateChoice));
        var dreamPick = SelectPool(); dreamPick.gacha.wishFixedSelectCount = 1;
        Throws<NotSupportedException>(() => new GachaLottery(dreamPick, new[] { 10, 11 }));
        var categorized = Rate(Standard(), "rarity_4", 1.0, "categorized_wish");
        Throws<NotSupportedException>(() => new GachaLottery(categorized));
    }

    static void InvalidData()
    {
        var pool = Standard();
        var bad = Behavior(pool, 99, "over_rarity_5_once", 10);
        var lottery = new GachaLottery(pool);
        Throws<NotSupportedException>(() => lottery.Spin(bad, new SystemRandomSource(1)));
        var missing = Standard(); missing.cards.RemoveAll(c => c.id == 3);
        Throws<InvalidDataException>(() => new GachaLottery(missing));
        var noCards = Standard(); noCards.gacha.gachaDetails.RemoveAll(d => d.cardId == 3);
        Throws<InvalidDataException>(() => new GachaLottery(noCards));
        Throws<ArgumentException>(() => lottery.Spin(new MasterGachaBehavior { id = 5, gachaId = 2, gachaBehaviorType = "normal", spinCount = 1 }, new SystemRandomSource(1)));
    }

    static void DefaultTenPull()
    {
        var pool = Standard();
        pool.gacha.gachaBehaviors.Insert(0, new MasterGachaBehavior { id = 9, gachaId = 1, gachaBehaviorType = "normal", spinCount = 10 });
        Check(new GachaLottery(pool).DefaultTenPullBehavior().id == 11, "应选择 over_rarity_3_once 十连");
    }

    // ---------- 真实数据 ----------

    static readonly JsonSerializerOptions Json = new JsonSerializerOptions { IncludeFields = true, PropertyNameCaseInsensitive = true };

    static void RealMaster(string dir)
    {
        var gachas = JsonSerializer.Deserialize<List<MasterGacha>>(File.ReadAllText(Path.Combine(dir, "gachas.json")), Json);
        var cards = JsonSerializer.Deserialize<List<MasterCard>>(File.ReadAllText(Path.Combine(dir, "cards.json")), Json);
        int supported = 0;
        var unsupported = new List<string>();
        foreach (var gacha in gachas)
        {
            if (GachaLottery.UnsupportedReason(gacha) is string reason) { unsupported.Add(reason); continue; }
            var pool = new GachaPool { gacha = gacha, cards = cards };
            var lottery = new GachaLottery(pool, GachaLottery.DefaultWishSelection(pool));
            Near(lottery.GetCardRates().Sum(r => r.Rate), 100, $"卡池 {gacha.id} 普通抽");
            var random = new SystemRandomSource(gacha.id);
            foreach (var behavior in gacha.gachaBehaviors)
            {
                int level = GachaLottery.GuaranteedRarityOf(behavior);
                if (level > 0)
                {
                    var rates = lottery.GetCardRates(level);
                    Near(rates.Sum(r => r.Rate), 100, $"卡池 {gacha.id} ★{level} 保底");
                    Check(rates.All(r => r.Card.cardRarityType != "rarity_2"), $"卡池 {gacha.id} 保底抽含 ★2");
                    if (level == 4) Check(rates.All(r => r.Card.cardRarityType == "rarity_4"), $"卡池 {gacha.id} ★4 保底抽含非 ★4");
                }
                Check(lottery.Spin(behavior, random).Length == behavior.spinCount, $"卡池 {gacha.id} 行为 {behavior.id} 抽数不对");
            }
            supported++;
        }
        // 已知数据点：Lit in the Dark（4054）3 张 UP ★4 公示各 0.4000%。
        // 权重合计 29,999,821 不是整数倍，按客户端显示方式（4 位小数、AwayFromZero，GachaMemberRateCell）比较。
        var lit = gachas.FirstOrDefault(g => g.id == 4054);
        if (lit != null)
        {
            var rates = Rates(new GachaLottery(new GachaPool { gacha = lit, cards = cards }));
            foreach (var pickup in lit.gachaPickups)
                Near(Math.Round(rates[pickup.cardId], 4, MidpointRounding.AwayFromZero), 0.4, $"4054 UP 卡 {pickup.cardId}");
        }
        Console.WriteLine($"    卡池 {gachas.Count}：支持 {supported}，暂不支持 {unsupported.Count}");
        foreach (var group in unsupported.GroupBy(r => r.Substring(r.IndexOf('是') >= 0 ? r.IndexOf('是') : 0)))
            Console.WriteLine($"      {group.Count()} × {group.Key}");
    }

    static void PoolFile(string path)
    {
        var pool = JsonSerializer.Deserialize<GachaPool>(File.ReadAllText(path), Json);
        var lottery = new GachaLottery(pool, GachaLottery.DefaultWishSelection(pool));
        var prizes = lottery.Spin(lottery.DefaultTenPullBehavior(), new SystemRandomSource(1));
        Check(prizes.Length == 10, "十连应有 10 张");
        Check(prizes.All(p => System.Text.RegularExpressions.Regex.IsMatch(p.Card.assetbundleName ?? "", @"^res\d+_no\d+$")), "资源名应能交给 GachaApp.PlayCards");
        Console.WriteLine($"    {pool.gacha.id} {pool.gacha.name}：" + string.Join(" ", prizes.Select(p => p.Card.assetbundleName + "(" + p.Card.cardRarityType.Replace("rarity_", "★") + ")")));
    }

    // ---------- 工具 ----------

    static void Run(string name, Action test)
    {
        try { test(); passed++; Console.WriteLine("  ✓ " + name); }
        catch (Exception e) { failed++; Console.WriteLine("  ✗ " + name + "\n      " + e.GetType().Name + ": " + e.Message); }
    }

    static void Skip(string name) { skipped++; Console.WriteLine("  - 跳过 " + name); }
    static void Check(bool condition, string message) { if (!condition) throw new Exception(message); }
    static void Near(double actual, double expected, string what = "") =>
        Check(Math.Abs(actual - expected) < 1e-6, $"{what} 实际 {actual}，期望 {expected}");

    static void Throws<T>(Action action) where T : Exception
    {
        try { action(); }
        catch (T) { return; }
        catch (Exception e) { throw new Exception($"应抛出 {typeof(T).Name}，实际 {e.GetType().Name}: {e.Message}"); }
        throw new Exception($"应抛出 {typeof(T).Name}，但没有异常");
    }

    static string Option(string[] args, string name)
    {
        int i = Array.IndexOf(args, name);
        return i >= 0 && i + 1 < args.Length ? args[i + 1] : null;
    }

    static string FindRepoRoot()
    {
        var dir = new DirectoryInfo(AppContext.BaseDirectory);
        while (dir != null && !Directory.Exists(Path.Combine(dir.FullName, "UnityProject"))) dir = dir.Parent;
        return dir?.FullName ?? Directory.GetCurrentDirectory();
    }
}
