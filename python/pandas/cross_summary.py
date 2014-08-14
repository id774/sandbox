#!/usr/bin/env python
# - * - coding: utf-8 - * -

# 関連ライブラリの読み込み
import numpy as np
import pandas as pd
import scipy as sp
import scipy.stats
from pandas import DataFrame, Series

# データ読み込み
data = pd.read_csv("data.txt", sep="\t")

# データのサマリ
data.describe()
#=>
#   gender  animal
# count  38  38
# unique 2   3
# top    f   dog
# freq   25  15

# 単純集計
for col in data:
    print(pd.value_counts(data[col]))
    print("\n")
#=>
# f  25
# m  13
# dtype: int64
#
# dog    15
# cat    14
# usagi  9
# dtype: int64

# クロス集計
crossed = pd.crosstab(data.gender, data.animal)
print(crossed)
#=>
# gender cat dog usagi
# f  3   13  9
# m  6   2   5

# 行%表の作成
arr = []
for row in crossed.T:
    arr.append(crossed.T[row] / float(crossed.T[row].sum()))
crossed_per = DataFrame(arr)
print(crossed_per)
#=>
# animal cat dog usagi
# f  0.120000    0.520000    0.360000
# m  0.461538    0.153846    0.384615

x2, p, dof, expected = sp.stats.chi2_contingency(crossed)
print(x2)
print(p)
#=> 0.028280095
print(dof)
print(expected)

def chi_sq_test(df):
    res = {}
    # カイ2乗検定の実施→カイ2乗値、p値、自由度、期待値が戻り値
    df_chi = sp.stats.chi2_contingency(df)

    res = {
        "data": df,
        # p値
        "p_val": df_chi[1],
        # 期待値
        "df_exp": DataFrame(df_chi[3])
    }

    # 期待値のカラム名とインデックス名を基データに合わせる
    res["df_exp"].columns = df.columns
    res["df_exp"].index = df.index

    # 残差
    res["df_res"] = df - res["df_exp"]
    res["df_res"].columns = df.columns
    res["df_res"].index = df.index

    # 行％の計算
    arr = []
    for row in df.T:
        arr.append(df.T[row] / float(df.T[row].sum()))

    res["df_per"] = DataFrame(arr)
    res["df_per"].columns = df.columns
    res["df_per"].index = df.index

    # 残差分析用前処理
    row_sum = df.T.sum()
    col_sum = df.sum()
    full_sum = float(row_sum.sum())

    # 残差分散を算出
    arr_all = []
    for r in row_sum:
        arr = []
        for c in col_sum:
            arr.append((1 - (r / full_sum)) * (1 - (c / full_sum)))
        arr_all.append(arr)

    res["df_res_var"] = DataFrame(arr_all)
    res["df_res_var"].columns = df.columns
    res["df_res_var"].index = df.index

    col_size = df.columns.size
    row_size = df.index.size

    # 調整済み標準化残差を算出
    arr_all = []
    for r in np.arange(row_size):
        arr = []
        for c in np.arange(col_size):
            arr.append(res["df_res"].iloc[r].iloc[
                       c] / np.sqrt(res["df_exp"].iloc[r].iloc[c] * res["df_res_var"].iloc[r].iloc[c]))
        arr_all.append(arr)

    res["df_res_final"] = DataFrame(arr_all)
    res["df_res_final"].columns = df.columns
    res["df_res_final"].index = df.index

    return res

# 関数の実行
res = chi_sq_test(crossed)

# p値の出力
print(res["p_val"])
#=> 0.028280095

# 調整済み標準化残差の出力
print(res["df_res_final"])
#=>
# gender cat dog usagi
# f  -2.349377704162738  2.190723321954562   -0.14923492309463762
# m  2.349377704162738   -2.1907233219545614 0.149234923094637
