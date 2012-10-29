#!/usr/bin/env python
# -*- coding: utf-8 -*-

import CaboCha
cabocha = CaboCha.Parser('--charset=UTF8')
sent = u"太郎はこの本を二郎を見た女性に渡した。".encode('utf-8')

print "print sent"
print sent

print "print cabocha.parseToString(sent)"
print cabocha.parseToString(sent)

tree = cabocha.parse(sent)

print "print tree.toString(CaboCha.FORMAT_LATTICE)"
print tree.toString(CaboCha.FORMAT_LATTICE)

print "print tree.toString(CaboCha.FORMAT_XML)"
print tree.toString(CaboCha.FORMAT_XML)
