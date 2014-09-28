import numpy as np

# 500 個の正規分布にしたがうサンプルデータを用意する
data = np.random.normal(loc=100, scale=25, size=500)

# 平均を求める
mu = np.mean(data)

# 分散を求める
s2 = np.var(data, ddof=1)

# 90% 信頼区間
from scipy.stats import norm
rv = norm()
z = rv.ppf(0.995)

# 100(1-σ)% 信頼区間
r = np.array([-z, z]) * np.sqrt(25 / 500)
print(mu + r)
