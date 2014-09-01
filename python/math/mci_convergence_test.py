import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import uniform
import scipy.integrate

# http://aidiary.hatenablog.com/entry/20140830/1409398547

# モンテカルロ積分の収束テスト
# 例3.3の場合

N = 10000

a, b = 0, 1
h = lambda x: (np.cos(50 * x) + np.sin(20 * x)) ** 2

# scipy.integrateで積分を計算
I = scipy.integrate.quad(h, a, b)[0]
print("scipy.integrate:", I)

# モンテカルロ積分の収束テスト
x = h(uniform(loc=a, scale=b - a).rvs(size=N))

# サンプル数1のh_1からサンプル数Nのh_Nまで推定値をまとめて求める
estint = np.cumsum(x) / np.arange(1, N + 1)

# サンプル数1のsqrt(v_1)からサンプル数Nのsqrt(v_N)まで標準偏差をまとめて求める
esterr = np.sqrt(np.cumsum((x - estint) ** 2)) / np.arange(1, N + 1)

plt.plot(estint, color='red', linewidth=2)
plt.plot(estint + 2 * esterr, color='gray')
plt.plot(estint - 2 * esterr, color='gray')
plt.ylim((0, 2))
plt.show()
plt.savefig('1.png')
