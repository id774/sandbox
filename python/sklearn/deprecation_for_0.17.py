import sklearn.linear_model as linear_model
import numpy as np

X = np.array([10, 20, 30, 60, 108])
Y = np.array([11, 23, 43, 170.5, 934.6])
model = linear_model.LinearRegression()
X = X.reshape(-1, 1)
model.fit(X, Y)

# print("Predict for number 12 {}".format(model.predict(np.array([12]).reshape(-1, 1))[0]))

print("Predict for number 12 {}".format(model.predict([12])[0]))
