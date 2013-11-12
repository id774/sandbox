#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
from nose.tools import *
from json_simple_analyzer import *

def test_start():
    p = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'ruby', 'json', 'json.txt')

    args = [__file__, p]
    analyzer = Analyzer(args)
    result = analyzer.start()

    eq_(6, result['実施'])
    eq_(1, result['担当'])

