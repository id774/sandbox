#!/usr/bin/env python
# -*- coding: utf-8 -*-
# cabocha_example.py: Print a CaboCha dependency parse in several forms
#
# Description:
# Print the CaboCha dependency parse of a sentence in several forms.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 cabocha_example.py
#
# Requirements:
# - Python 3
# - CaboCha with its Python binding
#

import CaboCha
cabocha = CaboCha.Parser('--charset=UTF8')
sent = "太郎はこの本を二郎を見た女性に渡した。"

print("--- print (sent) ---")
print(sent)

print("--- print (cabocha.parseToString(sent)) ---")
print(cabocha.parseToString(sent))

tree = cabocha.parse(sent)

print("-- print (tree.toString(CaboCha.FORMAT_LATTICE)) ---")
print(tree.toString(CaboCha.FORMAT_LATTICE))

print("--- print (tree.toString(CaboCha.FORMAT_XML)) ---")
print(tree.toString(CaboCha.FORMAT_XML))

print("--- print (tree.toString(0)) ---")
print(tree.toString(0))
print("--- print (tree.toString(1)) ---")
print(tree.toString(1))
print("--- print (tree.toString(2)) ---")
print(tree.toString(2))
print("--- print (tree.toString(3)) ---")
print(tree.toString(3))
print("--- print (tree.toString(4)) ---")
print(tree.toString(4))
