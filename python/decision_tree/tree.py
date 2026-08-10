# -*- coding: utf-8 -*-

# Using "pip install pillow"
from PIL import Image, ImageDraw, ImageFont

import sys
import re
import pprint

#mydata=[line.split('\t') for line in file('decision_tree_example.txt')]
#mydata=[line.split(' ') for line in file('sample_chaos_rowdata.txt')]
fin = open(sys.argv[1])
mydata = [line.rstrip().split(' ') for line in fin]

def print_score(set1, set2, gain, col, value, column_values):
    print('項目/値: ', col, value)
    print('取りうる値: ', column_values)
    print('集団1: ', pp(set1))
    print('集団1のジニ不純度: ', giniimpurity(set1))
    print('集団1のエントロピー: ', entropy(set1))
    print('集団2: ', pp(set2))
    print('集団2のジニ不純度: ', giniimpurity(set2))
    print('集団2のエントロピー: ', entropy(set2))
    print('情報ゲイン: ', gain)

def pp(obj):
    pp = pprint.PrettyPrinter(indent=4, width=160)
    str = pp.pformat(obj)
    return re.sub(r"\\u([0-9a-f]{4})", lambda x: chr(int("0x" + x.group(1), 16)), str)

class decisionnode:

    def __init__(self, col=-1, value=None, results=None, tb=None, fb=None):
        self.col = col
        self.value = value
        self.results = results
        self.tb = tb
        self.fb = fb

def divideset(rows, column, value):
    # Decide which group a row falls into
    split_function = None
    if isinstance(value, int) or isinstance(value, float):
        split_function = lambda row: row[column] >= value
    else:
        split_function = lambda row: row[column] == value
    # Split the rows into two sets
    set1 = [row for row in rows if split_function(row)]
    set2 = [row for row in rows if not split_function(row)]
    return (set1, set2)

# Measure how mixed a set of rows is
# Count the outcomes present in each set
def uniquecounts(rows):
    # Tally the possible outcomes
    results = {}
    for row in rows:
        # The last field of each row
        r = row[len(row) - 1]
        if r not in results:
            results[r] = 0
        results[r] += 1
    return results

# Gini impurity
# Probability that a randomly placed item lands in the wrong category
# With four equally likely outcomes the error rate is 0.75
# Lower is better
def giniimpurity(rows):
    total = len(rows)
    counts = uniquecounts(rows)
    imp = 0
    for k1 in counts:
        p1 = float(counts[k1]) / total
        for k2 in counts:
            if k1 == k2:
                continue
            p2 = float(counts[k2]) / total
            imp += p1 * p2
    return imp

# Entropy
# p(i) = frequency(outcome) = count(outcome) / count(rows)
# entropy = sum of p(i) x log(p(i)) over every outcome
def entropy(rows):
    from math import log
    log2 = lambda x: log(x) / log(2)
    results = uniquecounts(rows)
    ent = 0.0
    for r in list(results.keys()):
        p = float(results[r]) / len(rows)
        ent = ent - p * log2(p)
    return ent

# The width of a branch is the total width of its child branches
# A branch with no children has width 1
def getwidth(tree):
    if tree.tb == None and tree.fb == None:
        return 1
    return getwidth(tree.tb) + getwidth(tree.fb)

# The depth of a branch is the deepest child depth plus 1
def getdepth(tree):
    if tree.tb == None and tree.fb == None:
        return 0
    return max(getdepth(tree.tb), getdepth(tree.fb)) + 1

def buildtree(rows, scoref=entropy):
    if len(rows) == 0:
        return decisionnode()
    current_score = scoref(rows)
    # Track the best split criterion found so far
    best_gain = 0.0
    best_criteria = None
    best_sets = None
    column_count = len(rows[0]) - 1
    for col in range(0, column_count):
        # List of the values this column takes
        column_values = {}
        for row in rows:
            column_values[row[col]] = 1
        # Split on each value the column takes
        for value in list(column_values.keys()):
            (set1, set2) = divideset(rows, col, value)
            # Information gain
            p = float(len(set1)) / len(rows)
            gain = current_score - p * scoref(set1) - (1 - p) * scoref(set2)
            # Print the score at this point in the tree
            print_score(set1, set2, gain, col, value, column_values)
            if gain > best_gain and len(set1) > 0 and len(set2) > 0:
                best_gain = gain
                best_criteria = (col, value)
                best_sets = (set1, set2)
    # Build the sub branches
    if best_gain > 0:
        trueBranch = buildtree(best_sets[0])
        falseBranch = buildtree(best_sets[1])
        return decisionnode(col=best_criteria[0], value=best_criteria[1],
                            tb=trueBranch, fb=falseBranch)
    else:
        return decisionnode(results=uniquecounts(rows))

def printtree(tree, indent=''):
    # Is this a leaf node
    if tree.results != None:
        print(str(tree.results))
    else:
        # Print the split criterion
        print(str(tree.col) + ':' + str(tree.value) + '? ')
        # Print the branches
        print(indent + 'T->', end=' ')
        printtree(tree.tb, indent + '  ')
        print(indent + 'F->', end=' ')
        printtree(tree.fb, indent + '  ')

# Size the canvas to fit the tree
def drawtree(tree, jpeg='tree.jpg'):
    w = getwidth(tree) * 100
    h = getdepth(tree) * 100 + 120
    img = Image.new('RGB', (w, h), (255, 255, 255))
    draw = ImageDraw.Draw(img)
    drawnode(draw, tree, w / 2, 20)
    img.save(jpeg, 'JPEG')

def drawnode(draw, tree, x, y):
    if sys.platform == "darwin":
        font_path = "/Library/Fonts/Osaka.ttf"
    else:
        font_path = "/usr/share/fonts/truetype/fonts-japanese-gothic.ttf"

    font = ImageFont.truetype(font_path,
                              16, encoding='utf-8')
    if tree.results == None:
        # Get the width of each branch
        w1 = getwidth(tree.fb) * 100
        w2 = getwidth(tree.tb) * 100
        # Determine the total space required by this node
        left = x - (w1 + w2) / 2
        right = x + (w1 + w2) / 2
        # Draw the condition string
        txt = str(tree.col) + ':' + str(tree.value)
        #txt = str(txt,'utf-8')
        draw.text((x - 20, y - 10), txt,
                  font=font, fill='#000000')
        # Draw links to the branches
        draw.line((x, y, left + w1 / 2, y + 100), fill=(255, 0, 0))
        draw.line((x, y, right - w2 / 2, y + 100), fill=(255, 0, 0))
        # Draw the branch nodes
        drawnode(draw, tree.fb, left + w1 / 2, y + 100)
        drawnode(draw, tree.tb, right - w2 / 2, y + 100)
    else:
        txt = ' \n'.join(['%s:%d' % v for v in list(tree.results.items())])
        # txt=str(txt,'utf-8')
        draw.text((x - 20, y), txt, font=font, fill='#000000')

def prune(tree, mingain):
    # Prune the branches that are not leaves
    if tree.tb.results == None:
        prune(tree.tb, mingain)
    if tree.fb.results == None:
        prune(tree.fb, mingain)
    # Decide whether the two sides should be merged
    if tree.tb.results != None and tree.fb.results != None:
        tb, fb = [], []
        for v, c in list(tree.tb.results.items()):
            tb += [[v]] * c
        for v, c in list(tree.fb.results.items()):
            fb += [[v]] * c
        # Check how far the entropy drops
        delta = entropy(tb + fb) - (entropy(tb) + entropy(fb) / 2)
        if delta < mingain:
            tree.tb, tree.fb = None, None
            tree.results = uniquecounts(tb + fb)

def variance(rows):
    if len(rows) == 0:
        return 0
    data = [float(row[len(row) - 1]) for row in rows]
    mean = sum(data) / len(data)
    variance = sum([(d - mean) ** 2 for d in data]) / len(data)
    return variance

def classify(observation, tree):
    if tree.results != None:
        return tree.results
    else:
        v = observation[tree.col]
        branch = None
        if isinstance(v, int) or isinstance(v, float):
            if v >= tree.value:
                branch = tree.tb
            else:
                branch = tree.fb
        else:
            if v == tree.value:
                branch = tree.tb
            else:
                branch = tree.fb
        return classify(observation, branch)

def mdclassify(observation, tree):
    if tree.results != None:
        return tree.results
    else:
        v = observation[tree.col]
        if v == None:
            tr, fr = mdclassify(observation, tree.tb), mdclassify(
                observation, tree.fb)
            tcount = sum(tr.values())
            fcount = sum(fr.values())
            tw = float(tcount) / (tcount + fcount)
            fw = float(fcount) / (tcount + fcount)
            result = {}
            #for k,v in tr.items(): result[k]=v*tw
            #for k,v in fr.items(): result[k]=v*fw
            for k, v in list(tr.items()):
                result[k] = tw
            for k, v in list(fr.items()):
                result[k] = fw
            return result
        else:
            if isinstance(v, int) or isinstance(v, float):
                if v >= tree.value:
                    branch = tree.tb
                else:
                    branch = tree.fb
            else:
                if v == tree.value:
                    branch = tree.tb
                else:
                    branch = tree.fb
            return mdclassify(observation, branch)

def main():
    print('決定木の生成')
    tree = buildtree(mydata)
    # prune(tree,0.8)
    printtree(tree)

    print('決定木の画像生成')
    drawtree(tree, jpeg='tree.jpg')

    print('決定木による予測')
    for row in mydata:
        print(mdclassify(row, tree))

    print('決定木による予測')
    print(mdclassify(['yes', 'no', 39], tree))
    print(mdclassify(['no', 'yes', 28], tree))
    print(mdclassify([None, 'yes', 10], tree))
    print(mdclassify(['yes', None, 33], tree))
    print(mdclassify(['no', 'yes', None], tree))

if __name__ == '__main__':
    main()
