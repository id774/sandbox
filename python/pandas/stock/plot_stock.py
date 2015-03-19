# coding: utf-8

import sys
import os
import datetime
import pandas as pd
import pandas.io.data as web
import pandas.tools.plotting as plotting
import matplotlib.pyplot as plt
from pandas.stats.moments import ewma
from matplotlib.dates import AutoDateFormatter
from matplotlib.dates import AutoDateLocator
from matplotlib.dates import date2num
from matplotlib import font_manager
sys.path.append(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                             'lib'))
from ohlc_plot import OhlcPlot
from jpstock import JpStock
from calc_rsi import calc_rsi


def _plot_stock(stock, name, days=0, filename=None):
    plotting._all_kinds.append('ohlc')
    plotting._common_kinds.append('ohlc')
    plotting._plot_klass['ohlc'] = OhlcPlot
    fontprop = font_manager.FontProperties(
        fname="/usr/share/fonts/truetype/fonts-japanese-gothic.ttf")

    start = '2014-09-01'
    end = datetime.datetime.now()

    try:
        if filename:
            stock_tse = pd.read_csv(filename,
                                    index_col=0, parse_dates=True)
        else:
            if stock == 'N225':
                start = datetime.datetime.strptime(start, '%Y-%m-%d')
                stock_tse = web.DataReader('^N225', 'yahoo', start, end)
            else:
                jpstock = JpStock()
                stock_tse = jpstock.get(int(stock), start=start)
            stock_tse.to_csv("".join(["stock_", stock, ".csv"]))

        stock_d = stock_tse.asfreq('B')[days:]

        plt.figure()

        # stock_tse.plot(kind='ohlc')
        # plt.show()
        # plt.savefig('image.png')

        stock_d.plot(kind='ohlc')
        plt.subplots_adjust(bottom=0.20)

        # sma25 = pd.rolling_mean(stock_d['Adj Close'], window=25)
        # sma5 = pd.rolling_mean(stock_d['Adj Close'], window=5)
        # sma25.plot(label="SMA25")
        # sma5.plot(label="SMA5")

        ewma75 = ewma(stock_d['Adj Close'], span=75)
        ewma25 = ewma(stock_d['Adj Close'], span=25)
        ewma5 = ewma(stock_d['Adj Close'], span=5)
        ewma75.plot(label="EWMA75")
        ewma25.plot(label="EWMA25")
        ewma5.plot(label="EWMA5")

        closed = stock_d.ix[-1:, 'Adj Close'][0]
        plt.xlabel("".join(
                   [name, '(', stock, '):',
                    str(closed)]),
                   fontdict={"fontproperties": fontprop})
        plt.legend(loc="best")
        plt.show()
        plt.savefig("".join(["stock_", stock, ".png"]))
        plt.close()

        plt.figure()

        rsi9 = calc_rsi(stock_d, n=9)
        rsi14 = calc_rsi(stock_d, n=14)
        rsi9['Adj Close'].plot(label="RSI9")
        rsi14['Adj Close'].plot(label="RSI14")
        plt.subplots_adjust(bottom=0.20)

        closed = round(rsi14.ix[-1:, 'Adj Close'][0], 2)
        plt.xlabel("".join(
                   [name, '(', stock, '):',
                    str(closed)]),
                   fontdict={"fontproperties": fontprop})
        # plt.ylim = (np.arange(0, 110, step=10))
        plt.ylim = ([0, 100])
        plt.legend(loc="best")
        plt.show()
        plt.savefig("".join(["rsi_", stock, ".png"]))
        plt.legend(loc="best")
        plt.close()

    except ValueError:
        print("Value Error occured in", stock)

def read_csv(filename):
    stocks = pd.read_csv(filename, header=None)
    for s in stocks.values:
        _plot_stock(str(s[0]), s[1], days=-90)

def main():
    if len(sys.argv) == 2:
        read_csv(sys.argv[1])
    if len(sys.argv) == 3:
        _plot_stock(sys.argv[1], sys.argv[2], days=-180)
    if len(sys.argv) > 3:
        _plot_stock(sys.argv[1], sys.argv[2], filename=sys.argv[3])

if __name__ == '__main__':
    argsmin = 1
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            main()
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
