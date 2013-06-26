# -*- coding: utf-8 -*-
from math import log

#
# 多変数ベルヌーイモデル multivariate Bernoulli model
#
def mBm_MLestimate(D, classes):
  V = set()
  N_c = [0 for c in classes]
  N_cw = [dict() for c in classes]

  for (words,c) in D:
    N_c[c] += 1
    wordset = set()
    for w in words:
      wordset.add(w)
      V.add(w)
    for w in wordset:
      N_cw[c][w] = N_cw[c].get(w,0) + 1

  N = sum(N_c)
  p_c = [0 for c in classes]
  p_cw = [dict() for c in classes]
  for c in classes:
    p_c[c] = 1.0 * N_c[c] / N
    for w in V:
      p_cw[c][w] = 1.0 * N_cw[c].get(w,0) / N_c[c]

  return (V, p_c, p_cw)


def mBm_MAPestimate(D, classes):
  V = set()
  N_c = [0 for c in classes]
  N_cw = [dict() for c in classes]

  for (words,c) in D:
    N_c[c] += 1
    wordset = set()
    for w in words:
      wordset.add(w)
      V.add(w)
    for w in wordset:
      N_cw[c][w] = N_cw[c].get(w,0) + 1

  N = sum(N_c)
  Nclasses = len(classes)
  p_c = [0 for c in classes]
  p_cw = [dict() for c in classes]
  for c in classes:
    p_c[c] = 1.0 * (N_c[c] + 1) / (N + Nclasses)
    for w in V:
      p_cw[c][w] = 1.0 * (N_cw[c].get(w,0) + 1) / (N_c[c] + Nclasses);

  return (V, p_c, p_cw)


def mBm_make_classifier(V, classes, p_c, p_cw):
  def prod(ar):
    return reduce(lambda x,y:x*y, ar)
  def argmax(ar):
    maxval = ar[0]
    arg = 0
    for i in xrange(len(ar)):
      if ar[i] > maxval:
        arg = i
        maxval = ar[i]
    return arg
  def classify(words):
    wordset = set(words)
    p_given_c = [log(p_c[c]) + sum([log(p_cw[c][w]) if (w in wordset) else log(1.0-p_cw[c][w]) for w in V])
                 for c in classes]
    return argmax(p_given_c)
  return classify

#
# 多項モデル multinomial model
#
def mm_MLestimate(D, classes):
  V = set()
  N_c = [0 for c in classes]
  N_c_sum = [0 for c in classes]
  N_cw = [dict() for c in classes]

  for (words,c) in D:
    N_c[c] += 1
    for w in words:
      V.add(w)
      N_c_sum[c] += 1
      N_cw[c][w] = N_cw[c].get(w,0) + 1

  N = sum(N_c)
  p_c = [0 for c in classes]
  q_cw = [dict() for c in classes]
  for c in classes:
    p_c[c] = 1.0 * N_c[c] / N
    for w in V:
      q_cw[c][w] = 1.0 * N_cw[c].get(w,0) / N_c_sum[c]

  return (V, p_c, q_cw)


def mm_MAPestimate(D, classes):
  V = set()
  N_c = [0 for c in classes]
  N_c_sum = [0 for c in classes]
  N_cw = [dict() for c in classes]

  for (words,c) in D:
    N_c[c] += 1
    for w in words:
      V.add(w)
      N_c_sum[c] += 1
      N_cw[c][w] = N_cw[c].get(w,0) + 1

  N = sum(N_c)
  Nclasses = len(classes)
  Nwords = len(V)
  p_c = [0 for c in classes]
  q_cw = [dict() for c in classes]

  for c in classes:
    p_c[c] = 1.0 * (N_c[c] + 1) / (N + Nclasses)
    for w in V:
      q_cw[c][w] = 1.0 * (N_cw[c].get(w,0) + 1) / (N_c_sum[c] + Nwords)

  return (V, p_c, q_cw)


def mm_make_classifier(V, classes, p_c, q_cw):
  def prod(ar):
    return reduce(lambda x,y:x*y, ar)
  def argmax(ar):
    maxval = ar[0]
    arg = 0
    for i in xrange(len(ar)):
      if ar[i] > maxval:
        arg = i
        maxval = ar[i]
    return arg
  def classify(words):
    p_given_c = [log(p_c[c]) + sum([log(q_cw[c][w]) for w in words if w in q_cw[c] and q_cw[c] > 0]) for c in classes]
    return argmax(p_given_c)
  return classify


def split(string):
  return string.split(" ")

classes = [0, 1]
D = [(split("社会 厳しい 社会"), 0),
     (split("人生 どうでも 飯田橋"), 0),
     (split("家にある つけま 全部 つけた"), 1)]

# パラメータ推定（ここでは多変数ベルヌーイでMAP推定）
# (V, p_c, p_cw) = naive_bayes_ja.mBm_MAPestimate(D, classes)
(V, p_c, p_cw) = mBm_MAPestimate(D, classes)
# classify = naive_bayes_ja.mBm_make_classifier(V, classes, p_c, p_cw)
classify = mBm_make_classifier(V, classes, p_c, p_cw)
# 実際に分類
# d = split("good good bad boring")
d = split("社会 厳しい 全部")
c = classify(d)

print(c)

