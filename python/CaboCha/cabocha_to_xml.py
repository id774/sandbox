#!/usr/bin/env python
# -*- coding: utf-8 -*-

import CaboCha

from xml.etree import ElementTree
from xml.etree.ElementTree import XMLID

def parse_xml(xml):
    print xml
    tree, id_map = XMLID(xml)
    array = []
    func = 0
    for id, dic in sorted(id_map.items()):
        print dic.text
        array.append(dic.text)
        if id == func:
            print "ok"
        for k,v in dic.items():
            print k,v
    print array

if __name__ == "__main__":
    cabocha = CaboCha.Parser('--charset=UTF8')
    sent = u"太郎はこの本を二郎を見た女性に渡した。".encode('utf-8')
    print sent
    tree = cabocha.parse(sent)
    xml = tree.toString(CaboCha.FORMAT_XML)
    parse_xml(xml)

