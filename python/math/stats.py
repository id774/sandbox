from math import sqrt, exp, log, pi, ceil, floor
from functools import reduce
import re
import random

def add(x, y):
    """足し算"""
    return x + y

def average(l):
    """算術平均を求める"""
    return reduce(add, l, 0.0) / float(len(l))

def standard_deviation(l):
    """標準偏差を求める"""
    avg = average(l)
    l2 = [(x - avg) ** 2 for x in l]
    return sqrt(reduce(add, l2, 0.0) / (float(len(l2) - 1.0)))

def class_size(l):
    """
    階級の個数を求める
    スタージェスの公式
    """
    return int(ceil(1 + (log(len(l), 10) / log(2, 10))))

def class_interval(l):
    """階級の幅を求める"""
    max = sorted(l)[-1]
    min = sorted(l)[0]
    return int(ceil((max - min) / class_size(l)))

def median(l):
    """中央値を求める"""
    if len(l) % 2 == 0:
        x = floor(len(l) / 2)
        return (l[x - 1] + l[x]) / 2.0
    else:
        return l[floor(len(l) / 2)]

def class_list(l):
    """階級値のリストを求める"""
    interval = class_interval(l)
    size = class_size(l)
    min = sorted(l)[0]
    result = []
    for i in range(0, size):
        if i == 0:
            result.append(min)
        else:
            result.append(result[i - 1] + interval)
    return result

def frequency_distribution(l):
    """度数分布を求める"""
    result = {}
    interval = class_interval(l)
    for c in class_list(l):
        for i in l:
            if c <= i and i < (c + interval):
                val = result.setdefault(c, [])
                val.append(i)
                result[c] = val
    return result

def relative_frequency(l):
    """相対度数を求める"""
    result = {}
    total = float(len(l))
    for k, v in frequency_distribution(l).items():
        result[k] = len(v) / total
    return result

def standard_value(x, l):
    """基準値を求める"""
    avg = average(l)
    return (x - avg) / standard_deviation(l)

def deviation(x, l):
    """偏差値を求める"""
    return (standard_value(x, l)) * 10 + 50

def probability_density(x, l):
    """確率密度関数"""
    avg = average(l)
    sd = standard_deviation(l)
    return (1 / (sqrt(2 * pi) * sd)) * exp((- (1 / 2)) * (((x - avg) / sd) ** 2))

def sum_of_products(avg1, avg2, l1, l2):
    """積和を求める"""
    xx = [(x - avg1) for x in l1]
    yy = [(y - avg2) for y in l2]
    return reduce(add, [x * y for x, y in zip(xx, yy)], 0.0)

def sum_of_squared_deviation(avg, l):
    """偏差平方和を求める"""
    return reduce(add, [(x - avg) ** 2 for x in l], 0.0)

def single_correlation_coefficient(l1, l2):
    """単相関係数を求める"""
    avg1 = average(l1)
    sxx = sum_of_squared_deviation(avg1, l1)
    avg2 = average(l2)
    syy = sum_of_squared_deviation(avg2, l2)
    sxy = sum_of_products(avg1, avg2, l1, l2)
    return sxy / (sqrt(sxx * syy))

def correlation_ratio(m):
    """相関比を求める"""
    categories = set([x[1] for x in m.values()])
    groups = {}
    for i in categories:
        for j in m.values():
            if i == j[1]:
                val = groups.setdefault(i, [])
                val.append(j[0])
                groups[i] = val

    avgs = {k: ((reduce(add, v, 0.0)) / len(v)) for k, v in groups.items()}

    within_class_variation = {}
    for k, v in groups.items():
        avg = avgs.get(k)
        val = within_class_variation.setdefault(k, 0.0)
        v2 = [(x - avg) ** 2 for x in v]
        val = reduce(add, v2, 0.0)
        within_class_variation[k] = val

    all_avg = reduce(add, [v[0] for k, v in m.items()], 0.0) / len(m)

    between_class_variation = 0.0
    for k, v in groups.items():
        between_class_variation += len(v) * ((avgs.get(k) - all_avg) ** 2)

    return (between_class_variation / (reduce(add, [v for v in within_class_variation.values()], 0.0) + between_class_variation))

if __name__ == '__main__':
    JP_TOKEN = re.compile("[一-龠]|[ぁ-ん]|[ァ-ヴ]")

    def f(s, l):
        w = str(16 - len(JP_TOKEN.findall(s)))
        return '{:<{}}{}'.format(s, w, l)

    l = [1, 2, 3, 4, 5, 6, 10, 12]
    print(f("標本", l))
    print(f("算術平均", average(l)))
    print(f("標準偏差", standard_deviation(l)))
    print(f("階級の個数", class_size(l)))
    print(f("階級の幅", class_interval(l)))
    print(f("中央値", median(l)))
    print(f("階級値のリスト", class_list(l)))
    print(f("度数分布", frequency_distribution(l)))
    print(f("相対度数", relative_frequency(l)))
    rnd = random.choice(l)
    print(f("基準値", [rnd, standard_value(rnd, l)]))
    print(f("偏差値", [rnd, deviation(rnd, l)]))
    print(f("確率密度関数", [rnd, probability_density(rnd, l)]))
    l1 = [1000, 2000, 4000, 6000, 10000]
    l2 = [6000, 11000, 22500, 34000, 50000]
    print(f("単相関係数1", [single_correlation_coefficient(l, l)]))
    print(f("単相関係数2", [single_correlation_coefficient(l1, l2)]))
    m1 = {1: (16, 'A'), 2: (18, 'A'), 3: (20, 'B'), 4: (
        22, 'A'), 5: (24, 'C'), 6: (26, 'B'), 7: (28, 'C')}
    print(f("相関比1", [correlation_ratio(m1)]))
    m2 = {1: (23, 'A'), 2: (26, 'A'), 3: (27, 'A'), 4: (28, 'A'), 5: (25, 'B'), 6: (26, 'B'), 7: (29, 'B'), 8: (
        32, 'B'), 9: (33, 'B'), 10: (15, 'C'), 11: (16, 'C'), 12: (18, 'C'), 13: (22, 'C'), 14: (26, 'C'), 15: (29, 'C')}
    print(f("相関比2", [correlation_ratio(m2)]))
