# -*- coding: utf-8 -*-

from PIL import Image,ImageDraw

mydata=[line.split('\t') for line in file('decision_tree_example.txt')]
#mydata=[line.split(' ') for line in file('data_format_sample.txt')]

class decisionnode:
    def __init__(self,col=-1,value=None,results=None,tb=None,fb=None):
        self.col=col
        self.value=value
        self.results=results
        self.tb=tb
        self.fb=fb

def divideset(rows,column,value):
    # 行がどちらのグループに入るか
    split_function=None
    if isinstance(value,int) or isinstance(value,float):
        split_function=lambda row:row[column]>=value
    else:
        split_function=lambda row:row[column]==value
    # 行を二つの集合に分ける
    set1=[row for row in rows if split_function(row)]
    set2=[row for row in rows if not split_function(row)]
    return (set1,set2)

# ある集団がどの程度混合されているかを計測
# それぞれの集合にある帰結を集計
def uniquecounts(rows):
    # 可能な帰結を集計する
    results={}
    for row in rows:
        # 各項目の最終項目
        r=row[len(row)-1]
        if r not in results: results[r]=0
        results[r]+=1
    return results

# ジニ不純度
# 無作為に置いた要素が間違ったカテゴリーに入る確率
# 可能な帰結が 4 種類ありすべて等しく起きるなら誤差率は 0.75
# 低いほうが良い
def giniimpurity(rows):
    total=len(rows)
    counts=uniquecounts(rows)
    imp=0
    for k1 in counts:
        p1=float(counts[k1])/total
        for k2 in counts:
            if k1==k2: continue
            p2=float(counts[k2])/total
            imp+=p1*p2
    return imp

# エントロピー
# p(i) = 頻度(帰結) = 度数(帰結) / 度数(行)
# エントロピー = すべての帰結の p(i) x log(p(i)) の合計
def entropy(rows):
    from math import log
    log2=lambda x:log(x)/log(2)
    results=uniquecounts(rows)
    ent=0.0
    for r in results.keys():
        p=float(results[r])/len(rows)
        ent=ent-p*log2(p)
    return ent

# ある枝の幅の合計はその枝の子枝すべての合計
# 子枝を持たない場合は 1
def getwidth(tree):
    if tree.tb==None and tree.fb==None: return 1
    return getwidth(tree.tb)+getwidth(tree.fb)

# 枝の深さはもっとも長い子枝の深さ +1 となる
def getdepth(tree):
    if tree.tb==None and tree.fb==None: return 0
    return max(getdepth(tree.tb),getdepth(tree.fb))+1

def classify(observation,tree):
    if tree.results!=None:
        return tree.results
    else:
        v=observation[tree.col]
        branch=None
    if isinstance(v,int) or isinstance(v,float):
        if v>=tree.value: branch=tree.tb
        else: branch=tree.fb
    else:
        if v==tree.value: branch=tree.tb
        else: branch=tree.fb
    return classify(observation,branch)

def prune(tree,mingain):
    # If the branches aren't leaves, then prune them
    if tree.tb.results==None:
        prune(tree.tb,mingain)
    if tree.fb.results==None:
        prune(tree.fb,mingain)
    # If both the subbranches are now leaves, see if they
    # should merged
    if tree.tb.results!=None and tree.fb.results!=None:
        # Build a combined dataset
        tb,fb=[],[]
        for v,c in tree.tb.results.items():
            tb+=[[v]]*c
        for v,c in tree.fb.results.items():
            fb+=[[v]]*c
    # Test the reduction in entropy
    delta=entropy(tb+fb)-(entropy(tb)+entropy(fb)/2)
    if delta<mingain:
      # Merge the branches
      tree.tb,tree.fb=None,None
      tree.results=uniquecounts(tb+fb)

def mdclassify(observation,tree):
    if tree.results!=None:
        return tree.results
    else:
        v=observation[tree.col]
        if v==None:
            tr,fr=mdclassify(observation,tree.tb),mdclassify(observation,tree.fb)
            tcount=sum(tr.values())
            fcount=sum(fr.values())
            tw=float(tcount)/(tcount+fcount)
            fw=float(fcount)/(tcount+fcount)
            result={}
            for k,v in tr.items(): result[k]=v*tw
            for k,v in fr.items(): result[k]=v*fw
            return result
        else:
            if isinstance(v,int) or isinstance(v,float):
                if v>=tree.value: branch=tree.tb
                else: branch=tree.fb
            else:
                if v==tree.value: branch=tree.tb
                else: branch=tree.fb
        return mdclassify(observation,branch)

def variance(rows):
    if len(rows)==0: return 0
    data=[float(row[len(row)-1]) for row in rows]
    mean=sum(data)/len(data)
    variance=sum([(d-mean)**2 for d in data])/len(data)
    return variance

def buildtree(rows,scoref=entropy):
    if len(rows)==0: return decisionnode()
    current_score=scoref(rows)
    # 最良分割基準の追跡に利用
    best_gain=0.0
    best_criteria=None
    best_sets=None
    column_count=len(rows[0])-1
    for col in range(0,column_count):
        # 取りうる値のリスト
        column_values={}
        for row in rows:
            column_values[row[col]]=1
    # 項目が取るそれぞれの値に振り分け
    for value in column_values.keys():
        (set1,set2)=divideset(rows,col,value)
        # ゲイン
        p=float(len(set1))/len(rows)
        gain=current_score-p*scoref(set1)-(1-p)*scoref(set2)
        if gain>best_gain and len(set1)>0 and len(set2)>0:
            best_gain=gain
            best_criteria=(col,value)
            best_sets=(set1,set2)
    # サブブランチの生成
    if best_gain>0:
        trueBranch=buildtree(best_sets[0])
        falseBranch=buildtree(best_sets[1])
        return decisionnode(col=best_criteria[0],value=best_criteria[1],
                            tb=trueBranch,fb=falseBranch)
    else:
        return decisionnode(results=uniquecounts(rows))

def printtree(tree,indent=''):
    # リーフノードか
    if tree.results!=None:
        print str(tree.results)
    else:
        # Criteria (基準) を出力
        print str(tree.col)+':'+str(tree.value)+'? '
        # ブランチ (枝) を出力
        print indent+'T->',
        printtree(tree.tb,indent+'  ')
        print indent+'F->',
        printtree(tree.fb,indent+'  ')

# 適切なサイズを判断してキャンバスを用意する
def drawtree(tree,jpeg='tree.jpg'):
    w=getwidth(tree)*100
    h=getdepth(tree)*100+120
    img=Image.new('RGB',(w,h),(255,255,255))
    draw=ImageDraw.Draw(img)
    drawnode(draw,tree,w/2,20)
    img.save(jpeg,'JPEG')

def drawnode(draw,tree,x,y):
    if tree.results==None:
        # Get the width of each branch
        w1=getwidth(tree.fb)*100
        w2=getwidth(tree.tb)*100
        # Determine the total space required by this node
        left=x-(w1+w2)/2
        right=x+(w1+w2)/2
        # Draw the condition string
        draw.text((x-20,y-10),str(tree.col)+':'+str(tree.value),(0,0,0))
        # Draw links to the branches
        draw.line((x,y,left+w1/2,y+100),fill=(255,0,0))
        draw.line((x,y,right-w2/2,y+100),fill=(255,0,0))
        # Draw the branch nodes
        drawnode(draw,tree.fb,left+w1/2,y+100)
        drawnode(draw,tree.tb,right-w2/2,y+100)
    else:
        txt=' \n'.join(['%s:%d'%v for v in tree.results.items()])
        draw.text((x-20,y),txt,(0,0,0))

def main():
    set1,set2=divideset(mydata,2,'yes')

    print 'ジニ不純度'
    print '無作為に置いた要素が間違ったカテゴリーに入る確率'
    print '可能な帰結が 4 種類ありすべて等しく起きるなら誤差率は 0.75'
    print '低いほうが良い'
    print giniimpurity(mydata)

    print 'エントロピー'
    print 'p(i) = 頻度(帰結) = 度数(帰結) / 度数(行)'
    print 'エントロピー = すべての帰結の p(i) x log(p(i)) の合計'
    print entropy(mydata)

    print '集合 1 の個数'
    print len(set1)
    print '集合 2 の個数'
    print len(set2)
    print '集合 1 の値'
    print giniimpurity(set1)
    print entropy(set1)
    print '集合 2 の値'
    print giniimpurity(set2)
    print entropy(set2)

    print '決定木の生成'
    tree=buildtree(mydata)
    printtree(tree)

    print '決定木の画像生成'
    drawtree(tree,jpeg='tree.jpg')

if __name__=='__main__':
    main()

