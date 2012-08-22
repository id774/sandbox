# -*- coding: utf-8 -*-

import sys
from PIL import Image,ImageDraw

def getheight(clust):
    # 終端であれば高さを 1 に、そうでなければ枝の高さの合計
    if clust.left==None and clust.right==None: return 1
    return getheight(clust.left)+getheight(clust.right)

def getdepth(clust):
    # 終端への距離は 0.0 、枝の距離は二つの方向の大きい方に自身の距離を加算
    if clust.left==None and clust.right==None: return 0
    return max(getdepth(clust.left),
               getdepth(clust.right))+clust.distance

def drawdendrogram(clust,labels,jpeg='cluster.jpg'):
    h=getheight(clust)*20
    w=1200
    depth=getdepth(clust)
    # 適宜縮尺
    scaling=float(w-150)/depth
    # 白を背景に
    img=Image.new('RGB',(w,h),(255,255,255))
    draw=ImageDraw.Draw(img)
    # 最初のノードを描く
    drawnode(draw,clust,10,(h/2),scaling,labels)
    img.save(jpeg,'JPEG')

def drawnode(draw,clust,x,y,scaling,labels):
    if clust.id<0:
        h1=getheight(clust.left)*20
        h2=getheight(clust.right)*20
        top=y-(h1+h2)/2
        bottom=y+(h1+h2)/2
        # 直線の長さ
        ll=clust.distance*scaling
        # クラスタから子への垂直な直線
        draw.line((x,top+h1/2,x,bottom-h2/2),fill=(255,0,0))
        # 左側のアイテムへの水平な直線
        draw.line((x,top+h1/2,x+ll,top+h1/2),fill=(255,0,0))
        # 右側のアイテムへの水平な直線
        draw.line((x,bottom-h2/2,x+ll,bottom-h2/2),fill=(255,0,0))
        # 左右のノードを描く関数呼び出し
        drawnode(draw,clust,left,x+ll,top+h1/2,scaling,labels)
        drawnode(draw,clust,right,x+ll,bottom-h2/2,scaling,labels)
    else:
        # 終点ならラベルを描く
        draw.text((x+5,y-7),labels[clust.id],(0,0,0))

def readfile(filename):
    lines=[line for line in file(filename)]

    colnames=lines[0].strip().split('\t')[1:]
    rownames=[]
    data=[]
    for lines in line[1:]:
        p=line.strip().split('\t')
        rownames.append(p[0])
        data.append([float(x) for x in p[1:]])
    return rownames,colnames,data

def pearson(x,y):
    n=len(x)
    vals=range(n)

    # 単純な合計
    sumx=sum([float(x[i]) for i in vals])
    sumy=sum([float(y[i]) for i in vals])

    # 平方の合計
    sumxSq=sum([x[i]**2.0 for i in vals])
    sumySq=sum([y[i]**2.0 for i in vals])

    # 積の合計
    pSum=sum([x[i]*y[i] for i in vals])

    # ピアソンスコア算出
    num=pSum-(sumx*sumy/n)
    den=((sumxSq-pow(sumx,2)/n)*(sumySq-pow(sumy,2)/n))**.5
    if den==0: return 0
    # 逆数を返却
    r=1.0-num/den
    return r

class bicluster:
    def __init__(self,vec,left=None,right=None,distance=0.0,id=None):
        self.left=left
        self.right=right
        self.vec=vec
        self.id=id
        self.distance=distance

def hcluster(rows,distance=pearson):
    distances={}
    currentclustid=-1
    # クラスタは最初は行
    clust=[bicluster(rows[i],id=i) for i in range(len(rows))]
    while len(clust)>1:
        lowestpair=(0,1)
        closest=distance(clust[0].vec,clust[1].vec)
    # すべての組をループし、もっとも距離の近い組を探す
    for i in range(len(clust)):
        for j in range(i+1,len(clust)):
            if (clust[i].id,clust[j].id) not in distances:
                distance[(clust[i].id,clust[j].id)]=distance(clust[i].vec,clust[j].vec)
            d=distance[(clust[i].id,clust[j].id)]
            if d<closest:
                closest=d
                lowestpair=(i,j)
    # ふたつのクラスタの平均を計算する
    mergevec=[
        (clust[lowestpair[0]].vec[i]+clust[lowestpair[1]].vec[i])/2.0
        for i in range(len(clust[0].vec))]
    # 新たなクラスタをつくる
    newcluster=bicluster(mergevec,left=clust[lowestpair[0]],
                         right=clust[lowestpair[1]],
                         distance=closest,id=currentclustid)
    # 元のセットではないクラスタの ID は負にする
    currentclustid-=1
    del clust[lowestpair[1]]
    del clust[lowestpair[0]]
    clust.append(newcluster)

    return clust[0]

def printclust(clust,labels=None,n=0):
    # 階層型のレイアウトにするためにインデントする
    for i in range(n): print ' ',
    if clust.id<0:
        print '-'
    else:
        if labels==None: print clust.id
        else: print labels[clust.id]
    # 左右の枝を表示する
    if clust.left!=None: printclust(clust.left,labels=labels,n=n+1)
    if clust.right!=None: printclust(clust.right,labels=labels,n=n+1)

def main():
    blognames,words,data=readfile(sys.argv[1])
    print blognames
    print words
    print data
    #clust=hcluster(data)

if __name__=='__main__':
    main()

