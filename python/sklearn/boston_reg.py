import numpy as np
from sklearn import datasets
from matplotlib import pyplot as plt

def main():
    # ボストンデータセットを読み込む
    boston = datasets.load_boston()
    # 部屋の数
    rooms = boston.data[:, 5]
    # 家の値段
    house_prices = boston.target

    plt.scatter(rooms, house_prices, color='r')

    # 最小二乗法で誤差が最も少なくなる直線を得る
    x = np.array([[v, 1] for v in rooms])  # バイアス項を追加する
    y = house_prices
    (slope, bias), total_error, _, _ = np.linalg.lstsq(x, y)

    # 得られた直線をプロットする
    plt.plot(x[:, 0], slope * x[:, 0] + bias)

    # 訓練誤差の RMSE
    rmse = np.sqrt(total_error[0] / len(x))
    msg = 'RMSE (training): {0}'.format(rmse)
    print(msg)

    # グラフを表示する
    plt.xlabel('Number of Room')
    plt.ylabel('Price of House ($1,000)')
    plt.grid()
    plt.show()
    plt.savefig('image.png')

if __name__ == '__main__':
    main()
