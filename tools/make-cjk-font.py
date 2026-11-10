"""Builds the font used for gacha text from the CN, TW and KR servers.

The game's gacha text font (FOT-RodinNTLG Pro EB, Resources/GachaFont.otf) has almost no simplified
Chinese or Hangul glyphs. The TW client ships Source Han Sans SC Bold in place of that font, so the
stage uses the same font for those servers. The full font is 17 MB; this keeps only common characters:

  GB2312 (common simplified), Big5 level 1 (common traditional), the 2,350 Hangul syllables of KS X 1001,
  ASCII, general and CJK punctuation, full-width forms, and every character in the card names and gacha
  phrases of the given master data files.

Source Han Sans is under the SIL Open Font License 1.1 with Reserved Font Name "Source", so the subset is
renamed and the license goes next to it.

    python make-cjk-font.py SourceHanSansSC-Bold.otf out.otf cards-cn.json cards-tw.json cards-kr.json ...

Needs fontTools. The source font is the official release:
https://github.com/adobe-fonts/source-han-sans/raw/release/OTF/SimplifiedChinese/SourceHanSansSC-Bold.otf
"""
import json
import sys

from fontTools import subset
from fontTools.ttLib import TTFont

FAMILY = "SekaiGacha CJK"
POSTSCRIPT = "SekaiGachaCJK-Bold"


def codec_chars(encoding, first_bytes, second_bytes, keep=lambda first, second, char: True):
    chars = set()
    for first in first_bytes:
        for second in second_bytes:
            try:
                char = bytes([first, second]).decode(encoding)
            except UnicodeDecodeError:
                continue
            if keep(first, second, char):
                chars.add(char)
    return chars


def charset(card_files):
    chars = set()
    chars |= codec_chars("gb2312", range(0xA1, 0xF8), range(0xA1, 0xFF))
    big5_second = list(range(0x40, 0x7F)) + list(range(0xA1, 0xFF))
    chars |= codec_chars("big5", range(0xA4, 0xC7), big5_second, lambda first, second, _: (first, second) <= (0xC6, 0x7E))
    chars |= codec_chars("euc_kr", range(0xB0, 0xC9), range(0xA1, 0xFF), lambda first, second, char: 0xAC00 <= ord(char) <= 0xD7A3)
    for start, end in ((0x20, 0x7F), (0x2000, 0x2070), (0x3000, 0x3100), (0xFF00, 0xFFF0)):
        chars |= {chr(code) for code in range(start, end)}
    for path in card_files:
        with open(path, encoding="utf-8") as file:
            for card in json.load(file):
                chars |= set((card.get("prefix") or "") + (card.get("gachaPhrase") or ""))
    return chars


def rename(font):
    names = font["name"]
    for record in list(names.names):
        if record.nameID in (1, 16):
            names.setName(FAMILY, record.nameID, record.platformID, record.platEncID, record.langID)
        elif record.nameID == 3:
            names.setName(POSTSCRIPT + ";" + FAMILY, 3, record.platformID, record.platEncID, record.langID)
        elif record.nameID == 4:
            names.setName(FAMILY + " Bold", 4, record.platformID, record.platEncID, record.langID)
        elif record.nameID == 6:
            names.setName(POSTSCRIPT, 6, record.platformID, record.platEncID, record.langID)
        elif record.nameID in (17, 18, 20, 21):
            names.removeNames(nameID=record.nameID)
    cff = font["CFF "].cff
    cff.fontNames = [POSTSCRIPT]
    top = cff.topDictIndex[0]
    top.FullName = FAMILY + " Bold"
    top.FamilyName = FAMILY
    if hasattr(top, "FDArray"):
        for index, fd in enumerate(top.FDArray):
            fd.FontName = "%s-%d" % (POSTSCRIPT, index)


def main(source, output, *card_files):
    options = subset.Options()
    options.layout_features = []
    options.hinting = False
    options.name_IDs = ["*"]
    options.name_languages = ["*"]
    font = TTFont(source)
    subsetter = subset.Subsetter(options)
    subsetter.populate(text="".join(sorted(charset(card_files))))
    subsetter.subset(font)
    rename(font)
    font.save(output)
    print(output, "characters", len(font.getBestCmap()))


if __name__ == "__main__":
    main(*sys.argv[1:])
