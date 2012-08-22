#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ピアソン相関関数
# http://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient

# 二つの変数にどの程度壮観があるのか計測するための指標
# 1 と -1 の間の値を取り、完全に相関するなら 1 、相関がないなら 0 、逆相関なら -1

def pearson(x,y):
    n=len(x)
    vals=range(n)

    # 単純な合計
    sumx=sum([float(x[i]) for i in vals])
    sumy=sum([float(y[i]) for i in vals])

    # 平方の合計
    sumxSq=sum([x[i]**2.0 for i in vals])
    sumySq=sum([y[i]**2.0 for i in vals])

    # 積の合計
    pSum=sum([x[i]*y[i] for i in vals])

    # ピアソンスコア算出
    num=pSum-(sumx*sumy/n)
    den=((sumxSq-pow(sumx,2)/n)*(sumySq-pow(sumy,2)/n))**.5
    if den==0: return 0
    r=num/den
    return r

#print pearson([3,4,5],[4,5,8])
