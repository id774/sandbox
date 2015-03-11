# coding: utf-8

# http://sinhrks.hatenablog.com/entry/2015/02/04/002258

import sys
import datetime
import pandas as pd
import pandas.tools.plotting as plotting
import matplotlib.pyplot as plt
from pandas.stats.moments import ewma
from matplotlib.dates import date2num, AutoDateFormatter, AutoDateLocator
from matplotlib import font_manager
from jpstock import JpStock

class OhlcPlot(plotting.LinePlot):
    ohlc_cols = pd.Index(['open', 'high', 'low', 'close'])
    reader_cols = pd.Index(
        ['Open', 'High', 'Low', 'Close', 'Volume', 'Adj Close'])

    def __init__(self, data, **kwargs):
        data = data.copy()
        self.freq = kwargs.pop('freq', 'B')

        if isinstance(data, pd.Series):
            data = data.resample(self.freq, how='ohlc')
        assert isinstance(data, pd.DataFrame)
        assert isinstance(data.index, pd.DatetimeIndex)
        if data.columns.equals(self.ohlc_cols):
            data.columns = [c.title() for c in data.columns]
        elif data.columns.equals(self.reader_cols):
            pass
        else:
            raise ValueError('data is not ohlc-like')
        data = data[['Open', 'Close', 'High', 'Low']]
        plotting.LinePlot.__init__(self, data, **kwargs)

    def _get_plot_function(self):
        from matplotlib.finance import candlestick

        def _plot(data, ax, **kwds):
            candles = candlestick(ax, data.values, **kwds)
            return candles
        return _plot

    def _make_plot(self):
        from pandas.tseries.plotting import _decorate_axes, format_dateaxis
        plotf = self._get_plot_function()
        ax = self._get_ax(0)

        data = self.data
        data.index.name = 'Date'
        data = data.to_period(freq=self.freq)
        data = data.reset_index(level=0)

        if self._is_ts_plot():
            data['Date'] = data['Date'].apply(lambda x: x.ordinal)
            _decorate_axes(ax, self.freq, self.kwds)
            candles = plotf(data, ax, **self.kwds)
            format_dateaxis(ax, self.freq)
        else:
            data['Date'] = data['Date'].apply(
                lambda x: date2num(x.to_timestamp()))
            candles = plotf(data, ax, **self.kwds)

            locator = AutoDateLocator()
            ax.xaxis.set_major_locator(locator)
            ax.xaxis.set_major_formatter(AutoDateFormatter(locator))
        return candles


def calc_rsi(price, n=14):
    ''' Relative Strength Index '''

    # calculate price gain with previous day, first row nan is filled with 0
    gain = (price - price.shift(1)).fillna(0)

    def rsiCalc(p):
        ''' subfunction for calculating rsi for one lookback period '''
        avgGain = p[p > 0].sum() / n
        avgLoss = -p[p < 0].sum() / n
        rs = avgGain / avgLoss
        return 100 - 100 / (1 + rs)

    # run for all periods with rolling_apply
    return pd.rolling_apply(gain, n, rsiCalc)


def plot_stock(stock, name, days):
    plotting._all_kinds.append('ohlc')
    plotting._common_kinds.append('ohlc')
    plotting._plot_klass['ohlc'] = OhlcPlot
    fontprop = font_manager.FontProperties(
        fname="/usr/share/fonts/truetype/fonts-japanese-gothic.ttf")

    start = '2014-09-01'
    end = datetime.datetime.now()

    try:
        if stock == 'N225':
            start = datetime.datetime.strptime(start, '%Y-%m-%d')
            stock_tse = web.DataReader('^N225', 'yahoo', start, end)
        else:
            jpstock = JpStock()
            stock_tse = jpstock.get(int(stock), start=start)

        stock_d = stock_tse.asfreq('B')[days:]
        rsi = calc_rsi(stock_d, n=14)
        stock_d.to_csv("".join(["stock_", stock, ".csv"]))

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

        rsi['Adj Close'].plot(label="RSI")
        plt.subplots_adjust(bottom=0.20)

        closed = round(rsi.ix[-1:, 'Adj Close'][0], 2)
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
        plot_stock(str(s[0]), s[1], -90)

def main():
    if len(sys.argv) == 2:
        read_csv(sys.argv[1])
    if len(sys.argv) == 3:
        plot_stock(sys.argv[1], sys.argv[2], -180)
    if len(sys.argv) > 3:
        plot_stock(sys.argv[1], sys.argv[2], int(sys.argv[3]))

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
