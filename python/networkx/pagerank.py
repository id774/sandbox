# -*- coding: utf-8 -*-

# http://qiita.com/okappy/items/e12ce8fb39dfd4ed1a44

import networkx as nx

# 有向グラフのインスタンスを生成
g = nx.DiGraph()

# ノードを追加する ※ソーシャルグラフなら人がノードになることが多い
g.add_node(1)
g.add_node(2)
g.add_node(3)
g.add_node(4)
g.add_node(5)
g.add_node(6)
# 分かりやすいように敢えての羅列形式

# ノード間の矢印を加えていく ※ソーシャルグラフなら友達関係やフォロー、いいね！など
g.add_edge(1, 2)
g.add_edge(1, 3)
g.add_edge(1, 4)
g.add_edge(2, 3)
g.add_edge(3, 4)
g.add_edge(3, 5)
g.add_edge(2, 6)
g.add_edge(5, 6)
g.add_edge(1, 6)
# 分かりやすいように敢えての羅列形式

# pagerank 値の計算
pr = nx.pagerank(g, alpha=0.85)

# pagerank 値の計算 (numpy を利用)
prn = nx.pagerank_numpy(g, alpha=0.85)

# pagerank 値の計算 (scipy を利用)
prc = nx.pagerank_scipy(g, alpha=0.85)

# 計算結果表示
print("-----pagerank-----")
print(pr)

print("-----pagerank(numpy)-----")
print(prn)

print("-----pagerank(scipy)-----")
print(prc)
