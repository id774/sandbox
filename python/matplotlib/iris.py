import itertools

from matplotlib import pyplot as plt
from sklearn import datasets


def main():
    iris = datasets.load_iris()

    # 特徴量の入ったデータ (4 次元)
    features = iris.data
    # 各特徴量の名前
    feature_names = iris.feature_names
    # データと品種の対応
    targets = iris.target

    # グラフの全体サイズを指定する
    plt.figure(figsize=(12, 8))

    # 二次元のグラフを作りたいので特徴量の組み合わせを作る
    for i, (x, y) in enumerate(itertools.combinations(range(4), 2)):
        # サブグラフ
        plt.subplot(2, 3, i + 1)
        # 各品種はマーカーの色や形を変える
        for t, marker, c in zip(range(3), '>ox', 'rgb'):
            plt.scatter(
                features[targets == t, x],
                features[targets == t, y],
                marker=marker,
                c=c,
            )
            plt.xlabel(feature_names[x])
            plt.ylabel(feature_names[y])
            plt.autoscale()
            plt.grid()

    plt.show()
    plt.savefig('image.png')


if __name__ == '__main__':
    main()
