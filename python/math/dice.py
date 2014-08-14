#!/usr/bin/env python
# -*- coding: utf-8 -*-

def dice(v1, v2):
    numerator = sum([c in v2 for c in v1])
    denominator = len(v1) + len(v2)
    return 2 * float(numerator) / denominator if denominator != 0 else 0

if __name__ == '__main__':
    v1 = {"ほげ": 1, "ふが": 2, "ぴよ": 3}
    v2 = {"ほげ": 2, "ふが": 1, "ほへ": 2}
    v3 = {"ほげ": 3, "ふが": 2, "ぴよ": 1}

    result = dice(v1, v2)
    print("dice v1,v2 is %(result)s" % locals())
    result = dice(v1, v3)
    print("dice v1,v3 is %(result)s" % locals())
