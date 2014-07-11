# -*- coding:utf-8 -*-

# https://gist.github.com/mia-0032/6321746

import numpy
import pylab

# データの生成
n = 200

score_x = numpy.random.normal(171.77, 5.54, n)
score_y = numpy.random.normal(62.49, 7.89, n)

score_x.sort()
score_x = numpy.around(score_x + numpy.random.normal(scale=3.0, size=n), 2)
score_y.sort()
score_y = numpy.around(score_y + numpy.random.normal(size=n), 2)

# ヒストグラムを描く
pylab.subplot(221)
pylab.hist(score_x, 10)

# 箱ひげ図を描く
pylab.subplot(222)
pylab.boxplot(score_x)

# y についても同じく
pylab.subplot(223)
pylab.hist(score_y, 10)

pylab.subplot(224)
pylab.boxplot(score_y)

pylab.show()
pylab.savefig("image.png")

