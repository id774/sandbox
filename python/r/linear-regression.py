# -*- coding:utf-8 -*-

# PypeR example
# https://gist.github.com/mia-0032/6378324

import numpy
import pandas
import pylab
import pyper
import matplotlib.pyplot as plt

n = 200
score_x = numpy.random.normal(171.77, 5.54, n)
score_y = numpy.random.normal(62.49, 7.89, n)

score_x.sort()
score_x = numpy.around(score_x + numpy.random.normal(scale=3.0, size=n), 2)
score_y.sort()
score_y = numpy.around(score_y + numpy.random.normal(size=n), 2)

# 散布図を描く
pylab.scatter(score_x, score_y, marker='.', linewidths=0)
pylab.grid(True)
pylab.xlabel('X')
pylab.ylabel('Y')

# R で回帰分析
df = {'X': score_x, 'Y': score_y}
df = pandas.DataFrame(df)

r = pyper.R(use_pandas='True')
r.assign('df', df)

# R のコマンド実行
print(r("summary(df)"))
r("result <- lm(Y~X, data=df)")
print(r("summary(result)"))

# 予測区間と信頼区間を算出するため
new_x = numpy.arange(155, 190, 0.1)
new_df = pandas.DataFrame({'X': new_x})
r.assign('new', new_df)

# 予測区間 (R)
r("prediction <- predict(result, new, interval='prediction')")
# 信頼区間 (R)
r("confidence <- predict(result, new, interval='confidence')")

# Python 側にとってくる
lm_result = r.get('result$fitted.values')
prediction = pandas.DataFrame(r.get('prediction'))
confidence = pandas.DataFrame(r.get('confidence'))

# 回帰直線, 予測区間, 信頼区間を描く
pylab.plot(score_x, lm_result, 'r', linewidth=2)

pylab.plot(new_x, prediction[1], 'g', linewidth=1)
pylab.plot(new_x, prediction[2], 'g', linewidth=1)

pylab.plot(new_x, confidence[1], 'c', linewidth=1)
pylab.plot(new_x, confidence[2], 'c', linewidth=1)

pylab.show()
pylab.savefig("image.png")
