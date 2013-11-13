#!/usr/bin/env python
# -*- coding: utf-8 -*-

def jaccard_weight(v1, v2):
    numerator = 0
    denominator = 0

    keys = set(v1.keys())
    keys.update(v2.keys())

    for k in keys:
        f1 = v1.get(k, 0)
        f2 = v2.get(k, 0)
        numerator += min(f1, f2)
        denominator += max(f1, f2)
    return float(numerator) / denominator if denominator != 0 else 0

if __name__=='__main__':
    v1 = {"ほげ":1,"ふが":2,"ぴよ":3}
    v2 = {"ほげ":2,"ふが":1,"ほへ":2}
    v3 = {"ほげ":3,"ふが":2,"ぴよ":1}

    result = jaccard_weight(v1, v2)
    print ("jaccard_weight v1,v2 is %(result)s" % locals())
    result = jaccard_weight(v1, v3)
    print ("jaccard_weight v1,v3 is %(result)s" % locals())

