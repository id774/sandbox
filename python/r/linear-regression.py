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

# Draw the scatter plot
pylab.scatter(score_x, score_y, marker='.', linewidths=0)
pylab.grid(True)
pylab.xlabel('X')
pylab.ylabel('Y')

# Run the regression in R
df = {'X': score_x, 'Y': score_y}
df = pandas.DataFrame(df)

r = pyper.R(use_pandas='True')
r.assign('df', df)

# Run the R commands
print(r("summary(df)"))
r("result <- lm(Y~X, data=df)")
print(r("summary(result)"))

# Needed to compute the prediction and confidence intervals
new_x = numpy.arange(155, 190, 0.1)
new_df = pandas.DataFrame({'X': new_x})
r.assign('new', new_df)

# Prediction interval, from R
r("prediction <- predict(result, new, interval='prediction')")
# Confidence interval, from R
r("confidence <- predict(result, new, interval='confidence')")

# Bring the results back into Python
lm_result = r.get('result$fitted.values')
prediction = pandas.DataFrame(r.get('prediction'))
confidence = pandas.DataFrame(r.get('confidence'))

# Draw the regression line with its prediction and confidence intervals
pylab.plot(score_x, lm_result, 'r', linewidth=2)

pylab.plot(new_x, prediction[1], 'g', linewidth=1)
pylab.plot(new_x, prediction[2], 'g', linewidth=1)

pylab.plot(new_x, confidence[1], 'c', linewidth=1)
pylab.plot(new_x, confidence[2], 'c', linewidth=1)

pylab.show()
pylab.savefig("image.png")
