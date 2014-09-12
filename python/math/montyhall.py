import sys
from random import choice
import numpy as np

def montyhall(N, doors):
    win_picked = 0
    win_switch = 0
    for i in range(N):
        car = choice(doors)
        picked = choice(doors)

        goat = choice(list(set(doors) - set([picked, car])))

        switch_door = choice(list(set(doors) - set([picked, goat])))

        if picked == car:
            win_picked += 1
        elif switch_door == car:
            win_switch += 1

    return (win_picked, win_switch)

def main(args):
    N = int(args[1])
    doors = np.arange(0, int(args[2])) + 1
    (win_picked, win_switch) = montyhall(N, doors)
    print("%d 回ゲームを行い、車を当てた割合 :" % N)
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
