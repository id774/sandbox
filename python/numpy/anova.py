#! /usr/bin/python
# -*- coding: utf-8 -*-

import numpy as np

data = np.array([[  5.,   7.,  12.],
                 [  6.,   5.,  10.],
                 [  3.,   4.,   8.],
                 [  2.,   4.,   6.]])

s_mean = np.zeros(data.shape)

for i in range(data.shape[1]):
    s_mean[:,i] = data[:,i].mean()

print( "水準平均 " + str(s_mean) )

kouka = s_mean - np.ones(data.shape)*data.mean()

print( "水準間偏差（因子の効果） := 水準平均 - 全体平均 " + str(kouka) )

Q1 = (kouka * kouka).sum()
print( "水準間変動（効果の偏差平方和（SS）） " + str(Q1) )

f1 = data.shape[1] - 1
print( "自由度 " + str(f1) )

V1 = Q1 / f1
print ("水準間偏差（効果）の平均平方（MS）（不変分散） " + str(V1) )

error = data - s_mean
print( "水準内偏差（統計誤差） " + str(error) )

Q2 = (error * error).sum()
print( "誤差の偏差平方和（SS） " + str(Q2) )

f2 = ( data.shape[0] - 1 ) * data.shape[1]
print( "自由度（DF） " + str(f2) )

V2 = Q2 / f2
print( "水準内偏差（誤差）の平均平方（MS）（不変分散） " + str(V2) )

F = V1 / V2
print( "分散比（F値） " + str(F) )

