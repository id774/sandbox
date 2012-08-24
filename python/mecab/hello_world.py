#!/usr/bin/env python
# -*- encoding: utf-8 -*-

import MeCab
m = MeCab.Tagger("-Ochasen")
print m.parse("昨日、急に思い立ってザリガニを飼ってみた。")
print m.parse("Hello World!!")
