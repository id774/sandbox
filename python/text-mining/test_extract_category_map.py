#!/usr/bin/env python
# -*- coding: utf-8 -*-
# test_extract_category_map.py: nose test for the category map extractor
#
# Description:
# Test the category map extractor against fixture files with nose.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     nosetests test_extract_category_map.py
#
# Requirements:
# - Python 3
# - nose
#

import os
from nose.tools import *
from extract_category_map import *

def test_start():
    f1 = os.path.join(
        os.path.dirname(os.path.abspath(__file__)), 'test_filename.txt')
    f2 = os.path.join(
        os.path.dirname(os.path.abspath(__file__)), 'test_exclude.txt')
    args = [__file__, f1, f2]
    analyzer = Analyzer(args)
    result = analyzer._read_from_exclude()
    eq_(['ABC', 'ABD'], result)
