# -*- coding:utf-8 -*-

import numpy as np
import pandas as pd
import statsmodels.api as sm
import matplotlib.pyplot as plt

stock = pd.read_csv('stock_px.csv', parse_dates=True, index_col=0)

print( stock.head(10) )

rets = stock.pct_change().dropna()
spx_corr = lambda x: x.corrwith(x['SPX'])
stock_by_year = rets.groupby(lambda x: x.year)

result_1 = stock_by_year.apply(spx_corr) # 日次の利益と SPX との相関
result_2 = stock_by_year.apply(lambda g: g['AAPL'].corr(g['MSFT'])) # アップルとマイクロソフトの相関

print( result_1 )
print( result_2 )

plt.figure()
result_1.plot()
plt.show()
plt.savefig("image.png")

plt.figure()
result_2.plot()
plt.show()
plt.savefig("image2.png")

def regression(data, yvar, xvars):
    Y = data[yvar]
    X = data[xvars]
    X['intercept'] = 1.
    result = sm.OLS(Y, X).fit()
    return result.params

result_3 = stock_by_year.apply(regression, 'AAPL', ['SPX'])

print(result_3)

plt.figure()
result_3.plot()plt.show()
plt.savefig("image3.png")

