# -*- coding:utf-8 -*-
# Fit a noisy sine with support vector regression tuned by grid search.

import numpy as np
import matplotlib.pyplot as plt
from sklearn import svm
from sklearn import cross_validation
from sklearn.grid_search import GridSearchCV

# Sample x at random and generate y = sin(x) + noise to match
np.random.seed(1)
x = np.sort(np.random.uniform(-np.pi, np.pi, 100))
y = np.sin(x) + 0.1 * np.random.normal(size=len(x))

# Reshape into the format scikit-learn expects
x = x.reshape((len(x), 1))

# Use 60 percent of the data for training and 40 percent for testing
x_train, x_test, y_train, y_test = cross_validation.train_test_split(
    x, y, test_size=0.4)

# Sort x_test and y_test by x_test so the plot joins the points in order
index = x_test.argsort(0).reshape(len(x_test))
x_test = x_test[index]
y_test = y_test[index]

# Fit a support vector regression on the training data
reg = svm.SVR(kernel='rbf', C=1).fit(x_train, y_train)

# Plot the predictions for the test data
plt.plot(x_test, y_test, 'bo-', x_test, reg.predict(x_test), 'ro-')
plt.show()
plt.savefig("image.png")

# Coefficient of determination R^2
print(reg.score(x_test, y_test))

# 5-fold cross validation; the default score is r^2, so this is equivalent to the following
# cross_validation.cross_val_score(svm.SVR(), x, y, cv=5, scoring="r2")
scores = cross_validation.cross_val_score(svm.SVR(), x, y, cv=5)

# Mean R^2 across the 5 folds with its plus or minus 2 sigma range
print("R^2(not adjusted): %0.2f (+/- %0.2f)" %
      (scores.mean(), scores.std() * 2))

# Switch the score to mean squared error
scores = cross_validation.cross_val_score(
    svm.SVR(), x, y, cv=5, scoring="mean_squared_error")

# Mean MSE across the 5 folds with its plus or minus 2 sigma range
print("MSE: %0.2f (+/- %0.2f)" % (-scores.mean(), scores.std() * 2))

# Search several RBF gamma and penalty C values for the best score; the kernel can be a parameter too
tuned_parameters = [{'kernel': ['rbf'], 'gamma': [
    10 ** i for i in range(-4, 0)], 'C': [10 ** i for i in range(1, 4)]}]
gscv = GridSearchCV(
    svm.SVR(), tuned_parameters, cv=5, scoring="mean_squared_error")
gscv.fit(x_train, y_train)

# Print the worst and best scoring settings
params_min, _, _ = gscv.grid_scores_[
    np.argmin([x[1] for x in gscv.grid_scores_])]
reg_min = svm.SVR(
    kernel=params_min['kernel'], C=params_min['C'], gamma=params_min['gamma'])
reg_max = gscv.best_estimator_

# Refit using all of the training data
reg_min.fit(x_train, y_train)
reg_min.fit(x_train, y_train)

# Plot the truth in blue, the best result in red, and the worst in green
plt.plot(x_test, y_test, 'bo-', x_test, reg_max.predict(x_test),
         'ro-', x_test, reg_min.predict(x_test), 'go-')
plt.show()
plt.savefig("image2.png")
