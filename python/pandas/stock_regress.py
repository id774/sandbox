import sys
import pandas as pd
import statsmodels.api as sm
from matplotlib import pyplot as plt
from matplotlib import font_manager

if sys.platform == "darwin":
    font_path = "/Library/Fonts/Osaka.ttf"
else:
    font_path = "/usr/share/fonts/truetype/fonts-japanese-gothic.ttf"

prop = font_manager.FontProperties(fname=font_path)

df = pd.read_csv('stocks.csv',
                 index_col=0, parse_dates=True)

rets = df.pct_change().dropna()
by_year = rets.groupby(lambda x: x.year)
vol_corr = lambda x: x.corrwith(x['A社'])

result1 = by_year.apply(vol_corr)

print(result1)

plt.figure()
result1.plot()
plt.legend(prop=prop)
plt.xticks([2010, 2011, 2012, 2013, 2014, 2015])
plt.xlabel('年', fontproperties=prop)
plt.show()
plt.savefig("image.png")
plt.close()

result2 = by_year.apply(lambda g: g['B社'].corr(g['C社']))

print(result2)

def regression(data, yvar, xvars):
    Y = data[yvar]
    X = data[xvars]
    X['intercept'] = 1.
    result = sm.OLS(Y, X).fit()
    return result.params

result3 = by_year.apply(regression, 'B社', ['A社'])

print(result3)
