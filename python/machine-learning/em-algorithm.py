# -*- coding: utf-8 -*-

""" 
Introducing Monte Carlo Methods with R, C.P.Robert and G.Cassela
Practice 5.14
"""

import numpy as np
from scipy.stats import norm

def get_sample(n, theta, h, g):
    """
    get n sample from  X ~ theta*g(x)+(1-theta)*h(x)
    with parameter:theta
    """
    return np.array([(h() if is_h else g()) for is_h in np.random.random_sample(n) > theta])

def update_theta(theta, x, h, g):
    """
    update parameter:theta by M-step
    """
    return 1.0 / len(x) * sum(theta * g(x) / (theta * g(x) + (1 - theta) * h(x)))

if __name__ == "__main__":
    import matplotlib.pyplot as plt
    # parameter:theta(true value)
    theta_true = 0.3
    # define mixture distribution model
    h_random = lambda: np.random.standard_normal()
    g_random = lambda: (2.0 * np.random.standard_normal() + 2.0)
    h_cdf = norm.pdf
    g_cdf = lambda x: norm.pdf((x - 2.0) / 2.0) / 2
    # get sample from defined model
    x = get_sample(25, theta_true, h_random, g_random)
    # estimate parameter by EM algorithm
    theta = 0.8
    result = []
    for i in range(20):
        theta = update_theta(theta, x, h_cdf, g_cdf)
        result.append(theta)
    print(result)
    plt.plot(result)
    plt.show()
    # plot sample data
    #n, bins, patches = plt.hist(x, normed=1)
    #plt.plot(bins, (1-theta_true)*h_cdf(bins), 'r', linewidth=2)
    #plt.plot(bins, theta_true*g_cdf(bins), 'g', linewidth=2)
    # plt.show()
    plt.savefig("image.png")
