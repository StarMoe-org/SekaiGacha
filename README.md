最小抽卡渲染工程：启动自动十连，仅播放 3D 演出、逐张卡牌及语音，结束停在最后一张卡牌。

## 抽卡模拟

`UnityProject/Assets/Resources/GachaPool.json` 存在时，启动后的十连由真实卡池数据模拟；删除该文件则回到 `CardCatalog.json` 随机演示。WebGL 离线构建只打包了 `CardCatalog.json` 的卡，因此离线时忽略卡池、仍用随机演示。

```sh
python3 Tools/extract_gacha_pool.py --fetch            # 下载 master（Team-Haruki/haruki-sekai-master）到 Cache/master
python3 Tools/extract_gacha_pool.py --list 30          # 列出最近 30 个卡池及是否支持
python3 Tools/extract_gacha_pool.py --gacha-id 4054    # 生成 Resources/GachaPool.json
```

上层可调用 `GachaApp.Instance.PlaySpin(behaviorId)` 用当前卡池执行任一抽卡行为（≤10 抽）并播放，结果见 `CurrentPrizes`。

规则在 `Assets/Scripts/Simulation/GachaLottery.cs`，不依赖 UnityEngine，按逆向的 jp 7.1.0 客户端公示概率计算方式实现（真实抽选在服务端）：

- 先按 `gachaCardRarityRates` 抽稀有度，再在同稀有度内按 `gachaDetails.weight` 抽卡；单卡概率 = 稀有度概率 × weight / 同稀有度总 weight。
- `over_rarity_3_once` / `over_rarity_4_once` 的最后一抽使用保底概率：★3 保底时 ★2 并入 ★3，★4 保底时 ★2、★3 并入 ★4，生日卡不变。
- 自选卡池（`wishSelectCount`）的 ★4 只从选中卡中等概率抽出；默认选择先选 UP 卡，再按卡池顺序补满。
- 暂不支持 Dream Pick（分类 wish）与概率自选（rate choice）卡池，加载时报错；也未实现抽卡积分、天井兑换。

演出目前对所有稀有度都使用 ★4 演出；没有获得语音资源的卡只显示卡面。

测试（Unity 外，需 .NET SDK；核心按 .NET Standard 2.1 / C# 9 编译，与 Unity 2022.3 一致）：

```sh
dotnet run --project Tests/GachaSimulation   # 有 Cache/master 时额外校验全部真实卡池
```
