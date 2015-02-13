# -*- coding: utf-8 -*-

# http://qiita.com/okappy/items/e12ce8fb39dfd4ed1a44

import matplotlib.pyplot as plt
from matplotlib import animation
import networkx as nx
import random

# ネットワーク
g = nx.Graph()
def get_fig(node_number):
    g.add_node(node_number, Position=(
        random.randrange(0, 100), random.randrange(0, 100)))
    g.add_edge(node_number, random.choice(g.nodes()))
    nx.draw(g, pos=nx.get_node_attributes(g, 'Position'))

fig = plt.figure(figsize=(10, 8))

anim = animation.FuncAnimation(fig, get_fig, frames=100)
anim.save('graph_gifani.gif', writer='imagemagick', fps=10)
