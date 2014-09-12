import sys
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import font_manager
from random import choice

def montyhall(N, doors):
    arr_picked = np.zeros(N)
    arr_switch = np.zeros(N)
    for i in range(N):
        car = choice(doors)
        picked = choice(doors)
        goat = choice(list(set(doors) - set([picked, car])))
        switch = choice(list(set(doors) - set([picked, goat])))

        if picked == car:
            arr_picked[i] = 1
        elif switch == car:
            arr_switch[i] = 1

    return (arr_picked, arr_switch)

def plot(N, arr_picked, arr_switch):
    prop = font_manager.FontProperties(
        fname="/usr/share/fonts/truetype/fonts-japanese-gothic.ttf")
    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1)
    X = np.arange(N) + 1
    picked_car = arr_picked.cumsum()
    switch_car = arr_switch.cumsum()
    ax.plot(X, picked_car, label='picked up')
    ax.plot(X, switch_car, label='switched car')
    ax.set_title('モンティホール問題の通算当たり回数', fontproperties=prop)
    ax.legend(loc='best')
    plt.savefig('image.png')

def main(args):
    N = int(args[1])
    doors = np.arange(0, int(args[2])) + 1

    (arr_picked, arr_switch) = montyhall(N, doors)
    plot(N, arr_picked, arr_switch)

    win_picked = arr_picked.sum()
    win_switch = arr_switch.sum()

    print("%d 回のゲーム中" % N)
    print("ドアを変更しなかった場合: %f %% (%d)" %
          (100.0 * win_picked / N, win_picked))
    print("ドアを変更した場合:      %f %% (%d)" %
          (100.0 * win_switch / N, win_switch))
    return 0

if __name__ == '__main__':
    argsmin = 2
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            sys.exit(main(sys.argv))
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
