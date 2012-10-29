#!/usr/bin/env python
# -*- encoding: utf-8 -*-

import CaboCha
from nltk.parse import DependencyGraph
import re

NEXT_NODE = 1
NEXT_VERB_NODE = 2
NEXT_NOUN_NODE = 3

def cabocha2depgraph(t):
    dg = DependencyGraph()
    i = 0
    for line in t.splitlines():
        if line.startswith("*"):
            # start of bunsetsu

            cells = line.strip().split(" ", 3)
            m = re.match(r"([\-0-9]*)([ADIP])", cells[2])

            node = dg.nodelist[i]
            node.update(
                {'address': i,
                'rel': m.group(2), # dep_type
                'word': [],
                'tag': []
                })
            dep_parent = int(m.group(1))

            while len(dg.nodelist) < i+1 or len(dg.nodelist) < dep_parent+1:
                dg.nodelist.append({'word':[], 'deps':[], 'tag': []})

            if dep_parent == -1:
                dg.root = node
            else:
                dg.nodelist[dep_parent]['deps'].append(i)

            i += 1
        elif not line.startswith("EOS"):
            # normal morph
            cells = line.strip().split("\t")

            morph = (cells[0], tuple(cells[1].split(',')))
            dg.nodelist[i-1]['word'].append(morph[0])
            dg.nodelist[i-1]['tag'].append(morph[1])

        return dg

def reset_deps(dg):
    for node in dg.nodelist:
        node['deps'] = []
    dg.root = dg.nodelist[-1]

def set_head_form(dg):
    for node in dg.nodelist:
        tags = node['tag']
        num_morphs = len(tags)
        # extract bhead (主辞) and bform (語形)
        bhead = -1
        bform = -1
        for i in xrange(num_morphs-1, -1, -1):
            if tags[i][0] == u"記号":
                continue
            else:
                if bform == -1: bform = i
                if not (tags[i][0] == u"助詞"
                    or (tags[i][0] == u"動詞" and tags[i][1] == u"非自立")
                    or tags[i][0] == "助動詞"):
                    if bhead == -1: bhead = i

        node['bhead'] = bhead
        node['bform'] = bform

def get_dep_type(node):
    bform_tag = node['tag'][node['bform']]
    if bform_tag[0] == u"助詞" and bform_tag[1] == u"格助詞":
        return NEXT_VERB_NODE
    elif bform_tag[0] == u"助動詞" and bform_tag[-1] == u"タ":
        return NEXT_NOUN_NODE
    else:
        return NEXT_NODE

def analyze_dependency(dg):
    num_nodes = len(dg.nodelist)
    for i in xrange(num_nodes-1, 0, -1):
        node = dg.nodelist[i]
        if i == num_nodes - 1:                        # ... (1)
            # last node -> to_node = 0
            to_node = 0
        elif i == num_nodes - 2:                      # ... (2)
            # one from the last node -> to_node = num_nodes - 1
            to_node = num_nodes - 1
        else:
            # other nodes
            dep_type = get_dep_type(node)             # ... (3)
            if dep_type == NEXT_NODE:                 # ... (4)
                to_node = i + 1
            elif (dep_type == NEXT_VERB_NODE or
                dep_type == NEXT_NOUN_NODE):          # ... (4)
                for j in xrange(i+1, num_nodes):
                    node_j = dg.nodelist[j]
                    node_j_headtag = node_j['tag'][node_j['bhead']]
                    if (node_j['closed'] == False and
                        (dep_type == NEXT_VERB_NODE and node_j_headtag[0] == u"動詞") or
                        (dep_type == NEXT_NOUN_NODE and node_j_headtag[0] == u"名詞" and
                        node_j_headtag[1] != u"形容動詞語幹")):
                        to_node = j
                        break

            node['head'] = to_node
            dg.nodelist[to_node]['deps'].append(i)    # ... (5)
            for j in xrange(i+1, to_node):
                dg.nodelist[j]['closed'] = True       # ... (6)

def _node_map(node):
    node['word'] = '/'.join(node['word']).encode('utf-8')
    return node

if __name__ == "__main__":
    cabocha = CaboCha.Parser('--charset=UTF8')
    sent = u"太郎はこの本を二郎を見た女性に渡した。".encode('utf-8')
    tree = cabocha.parse(sent)
    cabocha_result = tree.toString(CaboCha.FORMAT_LATTICE)
    print cabocha_result

    dg = cabocha2depgraph(cabocha_result)
    reset_deps(dg)
    set_head_form(dg)

    dg.nodelist = [_node_map(n) for n in dg.nodelist]
    analyze_dependency(dg)
    print str(dg.tree()).decode('utf-8')

