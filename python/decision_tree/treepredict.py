# -*- coding: utf-8 -*-

data=[line.split('\t') for line in file('decision_tree_example.txt')]

class decisionnode:
    def __init__(self,col=-1,value=None,results=None,tb=None,fb=None):
        self.col=col
        self.value=value
        self.results=results
        self.tb=tb
        self.fb=fb

def divideset(rows,column,value):
    split_function=None
    # 行がどちらのグループに入るか
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


def main():
    print divideset(data,2,'yes')
    print giniimpurity(data)
    print entropy(data)
    set1,set2=divideset(data,2,'yes')
    print entropy(set1)
    print giniimpurity(set1)

if __name__=='__main__':
    main()

