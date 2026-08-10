# -*- coding: utf-8 -*-
# Classify handwritten digits with a linear SVM and report the confusion matrix.

import pylab as pl
import numpy as np
from sklearn.datasets import load_digits
from sklearn.cross_validation import train_test_split
from sklearn.svm import LinearSVC
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score

digits = load_digits()
print(digits.data.shape)

pl.gray()
pl.matshow(digits.images[0])
pl.show()
print(digits.data)

# Split into training and test data
data_train, data_test, label_train, label_test = train_test_split(
    digits.data, digits.target)

# Give the classifier its parameters
estimator = LinearSVC(C=1.0)

# Fit on the training data
estimator.fit(data_train, label_train)

# Predict the test data
label_predict = estimator.predict(data_test)

print(label_predict)
print(confusion_matrix(label_test, label_predict))

y_true = [2, 0, 2, 2, 0, 1]
y_pred = [0, 0, 2, 2, 0, 2]
print(confusion_matrix(y_true, y_pred))

confusion_matrix(y_true, y_pred)
na = np.array([[2, 0, 0],
               [0, 0, 1],
               [1, 0, 2]])
print(na)
print(accuracy_score(y_true, y_pred))
