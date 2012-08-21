#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ガウス関数
# http://en.wikipedia.org/wiki/Gaussian_function

import math
def gaussian(dist,sigma=10.0):
    exp=math.e**(-dist**2/(2*sigma**2))
    return (1/(sigma*(2*math.pi)**.5))*exp

#print gaussian(0.1)
#print gaussian(1.0)
#print gaussian(5.0)
#print gaussian(0.0)
#print gaussian(3.0)
