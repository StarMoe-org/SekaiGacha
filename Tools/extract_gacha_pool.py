#!/usr/bin/env python3
"""从 master 数据提取单个卡池，生成 Unity 读取的 GachaPool.json。

master 数据来自 Team-Haruki/haruki-sekai-master（与 Moesekai 相同的数据源）：
    python3 Tools/extract_gacha_pool.py --fetch            # 下载 gachas.json / cards.json 到 Cache/master，并同步资源版本
    python3 Tools/extract_gacha_pool.py --list             # 列出最近的卡池
    python3 Tools/extract_gacha_pool.py --gacha-id 4054    # 写入 UnityProject/Assets/Resources/GachaPool.json

只保留 Assets/Scripts/Simulation/GachaMasterData.cs 用到的字段。只用标准库。
"""
import argparse
import datetime
import json
import os
import re
import sys
import urllib.request

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DEFAULT_MASTER = os.path.join(ROOT, "Cache", "master")
DEFAULT_OUT = os.path.join(ROOT, "UnityProject", "Assets", "Resources", "GachaPool.json")
RESOURCE_VERSION = os.path.join(ROOT, "UnityProject", "Assets", "Resources", "ResourceVersion.json")
GACHA_RESOURCES = os.path.join(ROOT, "UnityProject", "Assets", "Scripts", "GachaResources.cs")
MASTER_URL = "https://raw.githubusercontent.com/Team-Haruki/haruki-sekai-master/main/master/"
VERSION_URL = "https://raw.githubusercontent.com/Team-Haruki/haruki-sekai-master/main/versions/current_version.json"
MASTER_FILES = ("gachas.json", "cards.json")

GACHA_FIELDS = ("id", "gachaType", "name", "startAt", "endAt", "wishSelectCount", "wishFixedSelectCount",
                "wishLimitedSelectCount", "rateChoiceGachaWishGroupId")
BEHAVIOR_FIELDS = ("id", "gachaId", "groupId", "priority", "gachaBehaviorType", "costResourceType",
                   "costResourceQuantity", "spinCount")
RATE_FIELDS = ("id", "cardRarityType", "lotteryType", "rate")
DETAIL_FIELDS = ("id", "gachaId", "cardId", "weight", "isWish", "gachaDetailWishType")
PICKUP_FIELDS = ("id", "gachaId", "cardId", "gachaPickupType")
CARD_FIELDS = ("id", "characterId", "cardRarityType", "assetbundleName", "prefix")


def pick(obj, fields):
    return {k: obj[k] for k in fields if k in obj}


def fetch(master):
    os.makedirs(master, exist_ok=True)
    for name in MASTER_FILES:
        target = os.path.join(master, name)
        print("下载", MASTER_URL + name)
        with urllib.request.urlopen(MASTER_URL + name, timeout=300) as response:
            data = response.read()
        json.loads(data)  # 确认是完整 JSON 再落盘
        with open(target + ".tmp", "wb") as f:
            f.write(data)
        os.replace(target + ".tmp", target)
        print("  ->", target, len(data), "bytes")


def sync_resource_version():
    """让 ResourceVersion.json 跟上 master 数据，否则新卡在旧资源清单里不存在。"""
    print("下载", VERSION_URL)
    with urllib.request.urlopen(VERSION_URL, timeout=60) as response:
        current = json.loads(response.read())
    with open(RESOURCE_VERSION, encoding="utf-8") as f:
        local = json.load(f)
    before = (local.get("assetVersion"), local.get("dataVersion"))
    for key in ("assetVersion", "assetHash", "dataVersion"):
        local[key] = current[key]
    with open(RESOURCE_VERSION, "w", encoding="utf-8", newline="\n") as f:
        json.dump(local, f, indent=2)
        f.write("\n")
    print("  ResourceVersion.json：asset %s → %s，data %s → %s" % (before[0], local["assetVersion"], before[1], local["dataVersion"]))
    # 资源请求头里的 App 版本写在 GachaResources.cs；游戏大版本更新后需要同步修改。
    with open(GACHA_RESOURCES, encoding="utf-8") as f:
        source = f.read()
    for header, key in (("X-App-Version", "appVersion"), ("X-App-Hash", "appHash")):
        match = re.search(r'"%s", "([^"]+)"' % header, source)
        if match and match.group(1) != current[key]:
            print("警告：GachaResources.cs 的 %s 是 %s，当前游戏为 %s，需要同步修改" % (header, match.group(1), current[key]), file=sys.stderr)


def load(master, name):
    path = os.path.join(master, name)
    if not os.path.exists(path):
        sys.exit("缺少 %s，先运行 --fetch 或用 --master 指定目录" % path)
    with open(path, encoding="utf-8") as f:
        return json.load(f)


def kind(gacha):
    if gacha.get("rateChoiceGachaWishGroupId"):
        return "概率自选（不支持）"
    if gacha.get("wishSelectCount", 0) > 0 and (gacha.get("wishFixedSelectCount", 0) or gacha.get("wishLimitedSelectCount", 0)):
        return "Dream Pick（不支持）"
    if any(r.get("lotteryType", "normal") != "normal" for r in gacha["gachaCardRarityRates"]):
        return "特殊概率档（不支持）"
    if gacha.get("wishSelectCount", 0) > 0:
        return "自选 %d" % gacha["wishSelectCount"]
    return "普通"


def date(ms):
    return datetime.datetime.fromtimestamp(ms / 1000, datetime.timezone.utc).strftime("%Y-%m-%d")


def list_gachas(gachas, count):
    for gacha in sorted(gachas, key=lambda g: (g["startAt"], g["id"]))[-count:]:
        tens = [b["gachaBehaviorType"] for b in gacha["gachaBehaviors"] if b.get("spinCount") == 10]
        print("%5d  %s  %-8s %-14s %-22s %s" % (gacha["id"], date(gacha["startAt"]), gacha["gachaType"], kind(gacha),
                                               ",".join(sorted(set(tens))) or "无十连", gacha["name"]))


def extract(gachas, cards, gacha_id):
    gacha = next((g for g in gachas if g["id"] == gacha_id), None)
    if gacha is None:
        sys.exit("找不到卡池 %d" % gacha_id)
    card_map = {c["id"]: c for c in cards}
    detail_ids = {d["cardId"] for d in gacha["gachaDetails"]}
    missing = sorted(detail_ids - card_map.keys())
    if missing:
        sys.exit("cards.json 缺少卡牌 %s" % missing[:10])
    out = pick(gacha, GACHA_FIELDS)
    out["gachaBehaviors"] = [pick(b, BEHAVIOR_FIELDS) for b in gacha["gachaBehaviors"]]
    out["gachaCardRarityRates"] = [pick(r, RATE_FIELDS) for r in gacha["gachaCardRarityRates"]]
    out["gachaDetails"] = [pick(d, DETAIL_FIELDS) for d in gacha["gachaDetails"]]
    out["gachaPickups"] = [pick(p, PICKUP_FIELDS) for p in gacha["gachaPickups"]]
    return {"gacha": out, "cards": [pick(card_map[i], CARD_FIELDS) for i in sorted(detail_ids)]}


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--master", default=DEFAULT_MASTER, help="master 目录（默认 Cache/master）")
    parser.add_argument("--fetch", action="store_true", help="先从 Haruki 下载 gachas.json / cards.json，并同步 ResourceVersion.json")
    parser.add_argument("--list", nargs="?", const=20, type=int, metavar="N", help="列出最近 N 个卡池（默认 20）")
    parser.add_argument("--gacha-id", type=int, help="要提取的卡池 id")
    parser.add_argument("--out", default=DEFAULT_OUT, help="输出路径（默认 Resources/GachaPool.json）")
    args = parser.parse_args()
    if args.fetch:
        fetch(args.master)
        sync_resource_version()
    if args.list is None and args.gacha_id is None:
        if not args.fetch:
            parser.print_help()
        return
    gachas = load(args.master, "gachas.json")
    if args.list is not None:
        list_gachas(gachas, args.list)
    if args.gacha_id is not None:
        pool = extract(gachas, load(args.master, "cards.json"), args.gacha_id)
        gacha = pool["gacha"]
        if "不支持" in kind(gacha):
            print("警告：卡池 %d 是%s，GachaLottery 会拒绝加载" % (gacha["id"], kind(gacha)), file=sys.stderr)
        os.makedirs(os.path.dirname(os.path.abspath(args.out)), exist_ok=True)
        with open(args.out, "w", encoding="utf-8", newline="\n") as f:
            json.dump(pool, f, ensure_ascii=False, separators=(",", ":"))
            f.write("\n")
        print("已写入 %s：卡池 %d %s（%s），%d 张卡，%d 个抽卡行为" % (
            args.out, gacha["id"], gacha["name"], kind(gacha), len(pool["cards"]), len(gacha["gachaBehaviors"])))


if __name__ == "__main__":
    main()
