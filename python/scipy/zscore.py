import numpy as np
import pandas as pd
from scipy import stats

def calc_zscore(data):
    return (data - data.mean()) / data.std()

def calc_zscore_stats(data):
    return stats.zscore(data)

def main():
    M = 100
    data = pd.Series(np.random.randn(M))
    result = calc_zscore(data)
    print(result.describe())
    result = calc_zscore_stats(data)
    result = pd.Series(result)
    print(result.describe())

if __name__ == '__main__':
    main()
