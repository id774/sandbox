#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math

def jaccard(v1, v2):
    numerator = sum([c in v2 for c in v1])
    denominator = len(v1) + len(v2) - numerator
    return float(numerator) / denominator if denominator != 0 else 0

def dice(v1, v2):
    numerator = sum([c in v2 for c in v1])
    denominator = len(v1) + len(v2)
    return 2 * float(numerator) / denominator if denominator != 0 else 0

def simpson(v1, v2):
    numerator = sum([c in v2 for c in v1])
    denominator = min(len(v1), len(v2))
    return float(numerator) / denominator if denominator != 0 else 0

def cos(v1, v2):
    numerator = sum([v1[c] * v2[c] for c in v1 if c in v2])
    square = lambda x: x * x
    denominator =  math.sqrt(sum(map(square, v1.values())) * sum(map(square, v2.values())))
    return float(numerator) / denominator if denominator != 0 else 0

def jaccard_weight(v1, v2):
    numerator = 0
    denominator = 0

    keys = set(v1.keys())
    keys.update(v2.keys())

    for k in keys:
        f1 = v1.get(k, 0)
        f2 = v2.get(k, 0)
        numerator += min(f1, f2)
        denominator += max(f1, f2)
    return float(numerator) / denominator if denominator != 0 else 0

def dice_weight(v1, v2):
    numerator = 0
    denominator = 0

    keys = set(v1.keys())
    keys.update(v2.keys())

    for k in keys:
        f1 = v1.get(k, 0)
        f2 = v2.get(k, 0)
        numerator += min(f1, f2)
        denominator += f1 + f2
    return 2 * float(numerator) / denominator if denominator != 0 else 0

def demo():
    v1 = {"環境":5,"構築":4,"費用":4,"運用":4,"案件":3,"Win":3,"設定":2,"基本":2,"適用":2,"利用":2,"作業":2,"向け":2,"台":2,"方法":2,"予定":2,"東京":2,"千":1,"要旨":1,"E":1,"U":1,"要望":1,"基盤":1,"先方":1,"目的":1,"水本":1,"拡張":1,"以外":1,"制御":1,"既存":1,"方針":1,"動作":1,"検証":1,"本番":1,"内容":1,"物理":1,"仮想":1,"当方":1,"各種":1,"作成":1,"担当":1,"感":1,"人月":1,"概要":1,"円":1,"その他":1,"日本":1,"経由":1,"発注":1,"詳細":1,"時":1,"決定":1,"今後":1,"導入":1,"概算":1,"見積":1,"提示":1}
    v2 = {"環境":6,"構築":4,"費用":4,"運用":4,"予定":3,"案件":3,"利用":3,"台":3,"作業":2,"準備":2,"PC":2,"TB":2,"方法":2,"向け":2,"東京":2,"感":1,"要旨":1,"概要":1,"目的":1,"要望":1,"現行":1,"今回":1,"更新":1,"機能":1,"提供":1,"依存":1,"佐藤":1,"方針":1,"動作":1,"検証":1,"本番":1,"適用":1,"内容":1,"AD":1,"物理":1,"TK":1,"仮想":1,"GB":1,"分":1,"勝亦":1,"当方":1,"容量":1,"担当":1,"各種":1,"作成":1,"槍":1,"先方":1,"人月":1,"千":1,"円":1,"その他":1,"日本":1,"経由":1,"発注":1,"詳細":1,"基本":1,"時":1,"決定":1,"今後":1,"木":1,"導入":1,"概算":1,"見積":1,"提示":1}
    v3 = {"運用":6,"様":5,"体制":4,"説明":4,"東京":3,"時":3,"大丈夫":3,"要員":3,"不安":3,"書":2,"提案":2,"見積":2,"工数":2,"業務":2,"担当":2,"監視":2,"系":2,"期間":2,"引き継ぎ":2,"印象":2,"輪番":2,"音声":2,"所感":1,"営業":1,"要旨":1,"質疑":1,"内容":1,"以下":1,"必要":1,"山":1,"準備":1,"week":1,"カ月":1,"人":1,"疑問":1,"上田":1,"作業":1,"荒川":1,"本部":1,"者":1,"出席":1,"派遣":1,"休日":1,"出勤":1,"対応":1,"連携":1,"情報":1,"前提":1,"根拠":1,"理解":1,"兼":1,"参加":1,"人数":1,"質問":1,"数":1,"判断":1,"明らか":1,"当て馬":1,"目的":1,"側":1,"想定":1,"様子":1,"完全":1,"NG":1,"今後":1,"内":1,"協議":1,"月":1,"中旬":1,"決定":1,"予定":1,"以上":1}

    result = jaccard(v1, v2)
    print ("jaccard v1,v2 is %(result)s" % locals())
    result = jaccard(v1, v3)
    print ("jaccard v1,v3 is %(result)s" % locals())

    result = dice(v1, v2)
    print ("dice v1,v2 is %(result)s" % locals())
    result = dice(v1, v3)
    print ("dice v1,v3 is %(result)s" % locals())

    result = simpson(v1, v2)
    print ("simpson v1,v2 is %(result)s" % locals())
    result = simpson(v1, v3)
    print ("simpson v1,v3 is %(result)s" % locals())

    result = cos(v1, v2)
    print ("cos v1,v2 is %(result)s" % locals())
    result = cos(v1, v3)
    print ("cos v1,v3 is %(result)s" % locals())

    result = jaccard_weight(v1, v2)
    print ("jaccard_weight v1,v2 is %(result)s" % locals())
    result = jaccard_weight(v1, v3)
    print ("jaccard_weight v1,v3 is %(result)s" % locals())

    result = dice_weight(v1, v2)
    print ("dice_weight v1,v2 is %(result)s" % locals())
    result = dice_weight(v1, v3)
    print ("dice_weight v1,v3 is %(result)s" % locals())

if __name__=='__main__':
    demo()

