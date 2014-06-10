#!/usr/bin/env python
# -*- coding: utf-8 -*-

a = "hoge"
b = 11
c = True
d = None
e = ["e",999]
f = {"f":1}

print("a の値は %(a)s, b の値は %(b)s" %locals() )

print("c の値は %(c)s\n\
d の値は %(d)s" %locals() )

print("e の値は %(e)s, b の値は %(f)s" %locals() )

