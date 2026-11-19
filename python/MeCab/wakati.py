#!/usr/bin/env python
# -*- encoding: utf-8 -*-
# wakati.py: Segment a sentence into words with MeCab
#
# Description:
# Segment a sentence into words with MeCab.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 wakati.py
#
# Requirements:
# - Python 3
# - MeCab with its Python binding
#

import MeCab

wakati = MeCab.Tagger("-O wakati")
print(wakati.parse('最近の夜は寒い'))
