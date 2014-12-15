
# http://sinhrks.hatenablog.com/entry/2014/12/14/005604

import numpy as np
import simpy
import matplotlib.pyplot as plt
import matplotlib.animation as animation

env = simpy.Environment()

class Car(object):

    # 時速が更新される単位時間
    step = 5

    def __init__(self, env, mean, std):
        # シミュレーション環境への参照
        self.env = env

        # 時速の平均値
        self.mean = mean
        # 時速の標準偏差
        self.std = std

        # 現在の時速
        self.velocity = 0.0
        # 現在位置
        self.location = 0.0
        # 直前の位置
        self.prev_location = 0.0

    def update_velocity(self):
        # 現在時速を更新
        # 現在時速は 平均 mean, 標準偏差 std の正規分布に従う
        v = np.random.normal(self.mean, self.std)
        if v < 0:
            v = 0
        return v

    def update_location(self):
        # 現在位置を更新
        self.prev_location = self.location
        self.location += self.velocity / 3600 * 1000
        return self.location

    def run(self):
        # 自身のプロセス (generator) を返すメソッド
        while True:
            if env.now % self.step == 0:
                # step が経過するたび、現在時速を更新 (乱数をふりなおす)
                self.velocity = self.update_velocity()
            form = '現在時刻 {0:2d} 位置: {1:.1f} m 時速 {2:.1f} km'
            print(form.format(self.env.now, self.location, self.velocity))
            self.update_location()
            yield self.env.timeout(1)

class Car2(Car):

    def __init__(self, env, number, mean, std, fdist=20, ahead=None):
        super(Car2, self).__init__(env, mean, std)
        # 車の番号
        self.number = number
        # 自分の前にいる Car への参照
        self.ahead = ahead

        # fdist は初期化時の車間距離
        self.location = - number * fdist

    def run(self):
        while True:
            if env.now % self.step == 0:
                self.velocity = self.update_velocity()
            form = '現在時刻 {0:2d} 番号 {1} 位置: {2:.1f} m 時速 {3:.1f} km'
            message = form.format(
                self.env.now, self.number, self.location, self.velocity)
            self.update_location()

            # 前方に車が存在するときは、前の車の位置 -1 m まで詰める
            if self.ahead is not None:
                if self.location >= self.ahead.location - 1:
                    self.location = self.ahead.location - 1
                    # 前の車によってブロックされたときには アスタリスクを表示
                    message += ' *'
            print(message)
            yield self.env.timeout(1)

    @property
    def actual_velocity(self):
        # 現在地、直前の位置をもとに、実際に進めた距離から時速を計算
        v = (self.location - self.prev_location) * 3600 / 1000
        return v

def init_env(env, num_cars=5, mean=72, std=10, fdist=20):
    cars = []
    prev = None
    # num_cars で指定された数だけ Car2 インスタンスを作成
    for i in range(num_cars):
        c = Car2(env, number=i, mean=mean, std=std, fdist=fdist, ahead=prev)
        env.process(c.run())
        prev = c
        cars.append(c)
    return env, cars

np.random.seed(1)
env = simpy.Environment()

# 1グループ目: 車間距離の初期値 20m で 20 台
env, cars1 = init_env(env, num_cars=20, fdist=20)

# 2グループ目: 車間距離の初期値 60m で 20 台
env, cars2 = init_env(env, num_cars=20, fdist=60)

# 描画用の figure, axes を作成
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(7, 4))
ax1.set_ylim(0, 80)
ax2.set_xlim(-1000, 2000)
ax2.xaxis.set_visible(False)
ax2.yaxis.set_visible(False)
objs = []
velocities1 = []
velocities2 = []

# 200 単位時間 x 40 台分のループ
for i in range(200 * 40):
    if i % 40 == 0:
        # 各グループの時速平均値を求める
        velocities1.append(np.mean([c.actual_velocity for c in cars1]))
        velocities2.append(np.mean([c.actual_velocity for c in cars2]))

        # 折れ線グラフを描画
        l1 = ax1.plot(range(len(velocities1)), velocities1, color='#c92b2b')
        l2 = ax1.plot(range(len(velocities2)), velocities2, color='#005ec4')

        # 各グループの位置を描画
        pt1 = ax2.scatter(
            [c.location for c in cars1], [2] * len(cars1), color='#c92b2b')
        pt2 = ax2.scatter(
            [c.location for c in cars2], [1] * len(cars2), color='#005ec4')
        objs.append(tuple(l1) + tuple(l2) + (pt1, pt2))

    # シミュレーション環境を 1 ステップ進める (1単位時間でなく、次のプロセスが実行されるまで進める)
    env.step()

ax1.legend([l1[0], l2[0]], ['車間初期値20m', '車間初期値60m'], loc=4)
# アニメーション設定
ani = animation.ArtistAnimation(fig, objs, interval=1, repeat=False)

plt.show()
plt.savefig("image.png")
