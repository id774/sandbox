#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math

def cos(v1, v2):
    numerator = sum([v1[c] * v2[c] for c in v1 if c in v2])
    square = lambda x: x * x
    denominator =  math.sqrt(sum(map(square, v1.values())) * sum(map(square, v2.values())))
    return float(numerator) / denominator if denominator != 0 else 0

if __name__=='__main__':
    v1 = {"ほげ":1,"ふが":2,"ぴよ":3}
    v2 = {"ほげ":2,"ふが":1,"ほへ":2}
    v3 = {"ほげ":3,"ふが":2,"ぴよ":1}

    result = cos(v1, v2)
    print ("cos v1,v2 is %(result)s" % locals())
    result = cos(v1, v3)
    print ("cos v1,v3 is %(result)s" % locals())

