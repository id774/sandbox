#!/usr/bin/env python
# -*- encoding: utf-8 -*-
# Segment a sentence into words with MeCab.

import MeCab

wakati = MeCab.Tagger("-O wakati")
print(wakati.parse('最近の夜は寒い'))
