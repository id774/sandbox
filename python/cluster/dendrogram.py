# -*- coding: utf-8 -*-

import sys
from PIL import Image, ImageDraw
from math import sqrt

def readfile(filename):
    lines = [line for line in file(filename)]

    colnames = lines[0].strip().split('\t')[1:]
    rownames = []
    data = []
    for lines in line[1:]:
        p = line.strip().split('\t')
        rownames.append(p[0])
        data.append([float(x) for x in p[1:]])
    return rownames, colnames, data

def getheight(clust):
    # 終端であれば高さを 1 に、そうでなければ枝の高さの合計
    if clust.left == None and clust.right == None:
        return 1
    return getheight(clust.left) + getheight(clust.right)

def getdepth(clust):
    # 終端への距離は 0.0 、枝の距離は二つの方向の大きい方に自身の距離を加算
    if clust.left == None and clust.right == None:
        return 0
    return max(getdepth(clust.left),
               getdepth(clust.right)) + clust.distance

def pearson(v1, v2):
    # 単純な合計
    sum1 = sum(v1)
    sum2 = sum(v2)
    # 平方の合計
    sum1Sq = sum([pow(v, 2) for v in v1])
    sum2Sq = sum([pow(v, 2) for v in v2])
    # 積の合計
    pSum = sum([v1[i] * v2[i] for i in range(len(v1))])
    # ピアソンスコア算出
    num = pSum - (sum1 * sum2 / len(v1))
    d = sqrt((sum1Sq - pow(sum1, 2) / len(v1))
             * (sum2Sq - pow(sum2, 2) / len(v1)))
    if d == 0:
        return 0
    # 逆数を返却
    r = 1.0 - num / d
    return r

# tanimoto 係数
# 値が 1.0 であれば最初のアイテムを欲しがっている人で 2 つ目のアイテムを
# 欲しがっている人はいない
# 値が 0.0 であれば 2 つのアイテムを全く同じ集団が欲しがっている
def tanamoto(v1, v2):
    c1, c2, shr = 0, 0, 0
    for i in range(len(v1)):
        if v1[i] != 0:
            c1 += 1
        if v2[i] != 0:
            c2 += 1
        if v1[i] != 0 and v2[i] != 0:
            shr += 1
    return 1.0 - (float(shr) / (c1 + c2 - shr))

def scaledown(data, distance=pearson, rate=0.01):
    n = len(data)
    # アイテムのすべての組の実際の距離
    realdist = [[distance(data[i], data[j]) for j in range(n)]
                for i in range(0, n)]

    # 2 次元上にランダムに配置するように初期化
    loc = [[random.random(), random.random()] for i in range(n)]
    fakedist = [[0.0 for j in range(n)] for i in range(n)]
    lasterror = None
    for m in range(0, 1000):
        # 予測距離を計測する
        for i in range(n):
            for j in range(n):
                fakedist[i][j] = sqrt(sum([pow(loc[i][x] - loc[j][x], 2)
                                           for x in range(len(loc[i]))]))
    # ポイントの移動
    grad = [[0.0, 0.0] for i in range(n)]
    totalerror = 0
    for k in range(n):
        for j in range(n):
            if j == k:
                continue
            # 誤差は距離の差の百分率
            errorterm = (fakedist[j][k] - realdist[j][k]) / realdist[j][k]
            # 他のポイントへの誤差に比例して
            # それぞれのポイントを調整
            grad[k][
                0] += ((loc[k][0] - loc[j][0]) / fakedist[j][k]) * errorterm
            grad[k][
                1] += ((loc[k][1] - loc[j][1]) / fakedist[j][k]) * errorterm
            # 誤差の合計を記録
            totalerror += abs(errorterm)
        print totalerror
        # 誤差が悪化したら終了
        if lasterror and lasterror < totalerror:
            break
        lasterror = totalerror
        # 学習率と傾斜を乗算してポイントを移動
        for k in range(n):
            loc[k][0] -= rate * grad[k][0]
            loc[k][1] -= rate * grad[k][1]

    return loc

def draw2d(data, labels, jpeg='mds2d.jpg'):
    img = Image.new('RGB', (2000, 2000), (255, 255, 255))
    draw = ImageDraw.Draw(img)
    for i in range(len(data)):
        x = (data[i][0] + 0.5) * 1000
        y = (data[i][1] + 0.5) * 1000
        draw.text((x, y), labels[i], (0, 0, 0))
    img.save(jpeg, 'JPEG')

def rotatematrix(data):
    newdata = []
    for i in range(len(data[0])):
        newrow = [data[j][i] for j in range(len(data))]
        newdata.append(newrow)
    return newdata

def drawdendrogram(clust, labels, jpeg='cluster.jpg'):
    h = getheight(clust) * 20
    w = 1200
    depth = getdepth(clust)
    # 適宜縮尺
    scaling = float(w - 150) / depth
    # 白を背景に
    img = Image.new('RGB', (w, h), (255, 255, 255))
    draw = ImageDraw.Draw(img)
    draw.line((0, h / 2, 10, h / 2), fill=(255, 0, 0))
    # 最初のノードを描く
    drawnode(draw, clust, 10, (h / 2), scaling, labels)
    img.save(jpeg, 'JPEG')

def drawnode(draw, clust, x, y, scaling, labels):
    if clust.id < 0:
        h1 = getheight(clust.left) * 20
        h2 = getheight(clust.right) * 20
        top = y - (h1 + h2) / 2
        bottom = y + (h1 + h2) / 2
        # 直線の長さ
        ll = clust.distance * scaling
        # クラスタから子への垂直な直線
        draw.line((x, top + h1 / 2, x, bottom - h2 / 2), fill=(255, 0, 0))
        # 左側のアイテムへの水平な直線
        draw.line((x, top + h1 / 2, x + ll, top + h1 / 2), fill=(255, 0, 0))
        # 右側のアイテムへの水平な直線
        draw.line(
            (x, bottom - h2 / 2, x + ll, bottom - h2 / 2), fill=(255, 0, 0))
        # 左右のノードを描く関数呼び出し
        drawnode(draw, clust, left, x + ll, top + h1 / 2, scaling, labels)
        drawnode(draw, clust, right, x + ll, bottom - h2 / 2, scaling, labels)
    else:
        # 終点ならラベルを描く
        draw.text((x + 5, y - 7), labels[clust.id], (0, 0, 0))

class bicluster:

    def __init__(self, vec, left=None, right=None, distance=0.0, id=None):
        self.left = left
        self.right = right
        self.vec = vec
        self.id = id
        self.distance = distance

def hcluster(rows, distance=pearson):
    distances = {}
    currentclustid = -1
    # クラスタは最初は行
    clust = [bicluster(rows[i], id=i) for i in range(len(rows))]
    while len(clust) > 1:
        lowestpair = (0, 1)
        closest = distance(clust[0].vec, clust[1].vec)
    # すべての組をループし、もっとも距離の近い組を探す
    for i in range(len(clust)):
        for j in range(i + 1, len(clust)):
            # キャッシュされていればそれを使う
            if (clust[i].id, clust[j].id) not in distances:
                distance[(clust[i].id, clust[j].id)] = distance(
                    clust[i].vec, clust[j].vec)
            d = distance[(clust[i].id, clust[j].id)]
            if d < closest:
                closest = d
                lowestpair = (i, j)
    # ふたつのクラスタの平均を計算する
    mergevec = [
        (clust[lowestpair[0]].vec[i] + clust[lowestpair[1]].vec[i]) / 2.0
        for i in range(len(clust[0].vec))]
    # 新たなクラスタをつくる
    newcluster = bicluster(mergevec, left=clust[lowestpair[0]],
                           right=clust[lowestpair[1]],
                           distance=closest, id=currentclustid)
    # 元のセットではないクラスタの ID は負にする
    currentclustid -= 1
    del clust[lowestpair[1]]
    del clust[lowestpair[0]]
    clust.append(newcluster)
    return clust[0]

def printclust(clust, labels=None, n=0):
    # 階層型のレイアウトにするためにインデントする
    for i in range(n):
        print ' ',
    if clust.id < 0:
        print '-'
    else:
        if labels == None:
            print clust.id
        else:
            print labels[clust.id]
    # 左右の枝を表示する
    if clust.left != None:
        printclust(clust.left, labels=labels, n=n + 1)
    if clust.right != None:
        printclust(clust.right, labels=labels, n=n + 1)

def main():
    blognames, words, data = readfile(sys.argv[1])
    print blognames
    print words
    print data
    # clust=hcluster(data)

if __name__ == '__main__':
    main()
