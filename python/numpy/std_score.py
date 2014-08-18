import numpy as np
from scipy import stats

sugaku = np.array([61, 74, 55, 85, 68, 72, 64, 80, 82, 59])
kokugo = np.array([79, 81, 77, 78, 83, 80, 82, 78, 80, 82])

def std_score(a):
    return np.round_(50 + 10 * (a - np.average(a)) / np.std(a))

def test(label, a):
    print(label)
    print("得点", a)
    print("合計", np.sum(a))
    print("平均(average)", np.average(a))
    print("分散(variance)", np.var(a))
    print("標準偏差(standard deviation)", np.std(a))
    print("偏差値(standard score)\n", std_score(a))
    print("Z得点(z score)\n", stats.zscore(a))

test("数学", sugaku)
test("国語", kokugo)
