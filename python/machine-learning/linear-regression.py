import numpy as np
import matplotlib.pyplot as plt

X = np.array([0.02, 0.12, 0.19, 0.27, 0.42, 0.51, 0.64, 0.84, 0.88, 0.99])
t = np.array([0.05, 0.87, 0.94, 0.92, 0.54, -0.11, -0.78, -0.79, -0.89, -0.04])

def phi(x):
    s = 0.1
    return np.append(1, np.exp(-(x - np.arange(0, 1 + s, s)) ** 2 / (2 * s * s)))

PHI = np.array([phi(x) for x in X])
w = np.linalg.solve(np.dot(PHI.T, PHI), np.dot(PHI.T, t))

print("線形回帰の値は %(w)s" %locals() )

alpha = 0.1
beta = 9.0

Sigma_N = np.linalg.inv(alpha * np.identity(PHI.shape[1]) + beta * np.dot(PHI.T, PHI))
mu_N = beta * np.dot(Sigma_N, np.dot(PHI.T, t))

print("ベイズ線形回帰の値は %(mu_N)s" %locals() )
