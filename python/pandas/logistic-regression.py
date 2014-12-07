
# http://sinhrks.hatenablog.com/entry/2014/11/24/205305

import sys
import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def plot_x_by_y(x, y, colors, ax=None):
    # 描画領域のサイズ
    fig_size = (5, 3.5)

    if ax is None:
        # 描画領域を作成
        fig = plt.figure(figsize=fig_size)

        # 描画領域に Axes を追加、マージン調整
        ax = fig.add_subplot(1, 1, 1)
        fig.subplots_adjust(bottom=0.15)

    x1 = x.columns[0]
    x2 = x.columns[1]
    for (species, group), c in zip(x.groupby(y), colors):
        ax = group.plot(kind='scatter', x=x1, y=x2,
                        color=c, ax=ax, figsize=fig_size)

    return ax

def read_csv():
    home = os.path.expanduser('~')
    csv = os.path.join(home,
                       'sandbox',
                       'python',
                       'math',
                       'iris.csv'
    )

    names = ['Sepal.Length',
             'Sepal.Width',
             'Petal.Length',
             'Petal.Width',
             'Species'
    ]

    iris = pd.read_csv(csv, header=None, names=names)
    return iris

def conversion(data):
    np.random.seed(1)

    columns = ['Petal.Width', 'Petal.Length']

    x = data[columns]   # データ (説明変数)
    y = data['Species'] # ラベル (目的変数)

    # ラベルを0, 1の列に変換
    y = (y == 'setosa').astype(int)
    return x, y

def main(args):
    iris = read_csv()

    # 2 クラスにするため、setosa, versicolor のデータのみ抽出
    data = iris[:100]
    x, y = conversion(data)
    # 説明変数は 2 つ = 2 次元
    print(y)
    plot_x_by_y(x, y, colors=['red', 'blue'])
    plt.show()
    plt.savefig('image.png')

if __name__ == '__main__':
    argsmin = 0
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            sys.exit(main(sys.argv))
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
