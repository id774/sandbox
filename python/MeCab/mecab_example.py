#!/usr/bin/env python
# -*- encoding: utf-8 -*-
# mecab_example.py: MeCab morphological analysis of a sentence
#
# Description:
# Print the MeCab morphological analysis of a sentence.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 mecab_example.py
#
# Requirements:
# - Python 3
# - MeCab with its Python binding
#

import MeCab
m = MeCab.Tagger("-Ochasen")
print(m.parse("太郎はこの本を二郎を見た女性に渡した。"))
