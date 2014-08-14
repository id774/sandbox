#!/usr/bin/env python
# -*- coding: utf-8 -*-

import CaboCha

# from xml.etree import ElementTree
from xml.etree.ElementTree import XMLID

def parse_xml(xml):
    print(xml)
    tree, id_map = XMLID(xml)
    for id, dic in sorted(id_map.items()):
        # print dic.text
        print(id)
        for k, v in list(dic.items()):
            if k == 'feature':
                s = v.split(",")
                if s[0] == '名詞' or s[0] == '動詞':
                    print(s[0], s[6])

if __name__ == "__main__":
    cabocha = CaboCha.Parser('--charset=UTF8')
    #sent = u"太郎はこの本を二郎を見た女性に渡した。".encode('UTF-8')
    sent = "老人の承認欲求に彩られ無限に湧き出る責任感から、文字通り死に物狂いでチェ ーンカッターを振りかざした挙句腰が再起不能になるなどして視聴者の涙を誘い、プロ市民が「老人を虐待するな！！」と抗議の電話を掛け、老人を一掃して若者の雇用を試みるも、軟弱な若者は一行に志願せず頓挫というシナリオ".encode(
        'UTF-8')
    print(sent)
    tree = cabocha.parse(sent)
    xml = tree.toString(CaboCha.FORMAT_XML)
    parse_xml(xml)
