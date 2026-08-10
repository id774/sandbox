# -*- coding: utf-8 -*-

# http://qiita.com/okappy/items/e12ce8fb39dfd4ed1a44

import networkx as nx

# Create a directed graph instance
g = nx.DiGraph()

# Add the nodes; in a social graph a node is usually a person
g.add_node(1)
g.add_node(2)
g.add_node(3)
g.add_node(4)
g.add_node(5)
g.add_node(6)
# Listed out one by one on purpose, for readability

# Add the arrows between nodes; in a social graph these are follows or likes
g.add_edge(1, 2)
g.add_edge(1, 3)
g.add_edge(1, 4)
g.add_edge(2, 3)
g.add_edge(3, 4)
g.add_edge(3, 5)
g.add_edge(2, 6)
g.add_edge(5, 6)
g.add_edge(1, 6)
# Listed out one by one on purpose, for readability

# Compute the pagerank values
pr = nx.pagerank(g, alpha=0.85)

# Compute the pagerank values using numpy
prn = nx.pagerank_numpy(g, alpha=0.85)

# Compute the pagerank values using scipy
prc = nx.pagerank_scipy(g, alpha=0.85)

# Print the results
print("-----pagerank-----")
print(pr)

print("-----pagerank(numpy)-----")
print(prn)

print("-----pagerank(scipy)-----")
print(prc)
