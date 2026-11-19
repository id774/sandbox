#!/usr/bin/env python
# -*- coding: utf-8 -*-
# test_json_simple_analyzer.py: nose test for the JSON count analyzer
#
# Description:
# Test the JSON count analyzer against a shared fixture with nose.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     nosetests test_json_simple_analyzer.py
#
# Requirements:
# - Python 3
# - nose
#

import os
from nose.tools import *
from json_simple_analyzer import *

def test_start():
    p = os.path.join(os.path.dirname(
        os.path.abspath(__file__)), '..', '..', 'ruby', 'json', 'json.txt')

    args = [__file__, p]
    analyzer = Analyzer(args)
    result = analyzer.start()

    eq_(6, result['実施'])
    eq_(1, result['担当'])
