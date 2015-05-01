import random
import string
import numpy as np
import pandas as pd

def testdata():
    random.seed(0)
    N = 1000

    def rands(n):
        choices = string.ascii_uppercase
        return ''.join([random.choice(choices) for _ in range(n)])
    tickers = np.array([rands(5) for _ in range(N)])

    M = 500
    df = pd.DataFrame({'Momentum': np.random.randn(M) / 200 + 0.03,
                       'Value': np.random.randn(M) / 200 + 0.08,
                       'ShortInterest': np.random.randn(M) / 200 - 0.02},
                      index=tickers[:M])
    return df

if __name__ == '__main__':
    data = testdata()
    print(data)
