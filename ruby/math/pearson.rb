#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# ピアソン相関関数
# http://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient

# 二つの変数にどの程度壮観があるのか計測するための指標
# 1 と -1 の間の値を取り、完全に相関するなら 1 、相関がないなら 0 、逆相関なら -1

# ピアソン相関距離を計算
def pearson(v1,v2)
  v1 = [v1] if v1.class != Array
  v2 = [v2] if v2.class != Array
  # 単純な合計
  sum1 = 0
  v1.each{ |n|
    sum1 += n
  }
  sum2 = 0
  v2.each{ |n|
    sum2 += n
  }

  # 平方の合計
  sum1Sq = 0
  v1.each{ |n|
    sum1Sq += n*n
  }
  sum2Sq = 0
  v2.each{ |n|
    sum2Sq += n*n
  }

  # 積の合計
  pSum = 0
  for i in 0...v1.length
    pSum += v1[i]*v2[i]
  end

  # ピアソンによるスコアを算出
  num = pSum - (sum1*sum2/v1.length)
  den = Math::sqrt( (sum1Sq-sum1*sum1/v1.length)*(sum2Sq-sum2*sum2/v1.length) )
  return 0 if den == 0
  return num/den
end
