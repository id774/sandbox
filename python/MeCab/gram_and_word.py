#!/usr/bin/env python
# -*- encoding: utf-8 -*-
# gram_and_word.py: Inspect the features of each MeCab morpheme
#
# Description:
# Walk the MeCab node list and inspect the features of each morpheme.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 gram_and_word.py
#
# Requirements:
# - Python 3
# - MeCab with its Python binding
#

import MeCab
mecab = MeCab.Tagger("-Ochasen")
m = mecab.parseToNode("昨日、急に思い立ってザリガニを飼ってみた。")
cnt = 0
while m:
    print(m.surface, "\t", m.feature)
    if m.surface.find('BOS/EOS') >= 0 or len(m.surface) == 0:
        m = m.__next__
        continue
    feat = m.feature
    arr = feat.split(',')
    gram = arr[0]  # part of speech
    word = arr[6]  # base form
    if gram in ('名詞', '動詞', '形容詞'):
        print(gram, word)

    cnt = cnt + 1
    m = m.__next__
