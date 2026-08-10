# -*- coding: utf-8 -*-
# Draw a hierarchical clustering dendrogram as an image; written for Python 2.

import sys
from PIL import Image, ImageDraw
from math import sqrt

def readfile(filename):
    lines = [line for line in file(filename)]

    colnames = lines[0].strip().split('\t')[1:]
    rownames = []
    data = []
    for lines in line[1:]:
        p = line.strip().split('\t')
        rownames.append(p[0])
        data.append([float(x) for x in p[1:]])
    return rownames, colnames, data

def getheight(clust):
    # Use height 1 for a leaf, otherwise the sum of the branch heights
    if clust.left == None and clust.right == None:
        return 1
    return getheight(clust.left) + getheight(clust.right)

def getdepth(clust):
    # A leaf sits at distance 0.0; a branch adds its own distance to the deeper side
    if clust.left == None and clust.right == None:
        return 0
    return max(getdepth(clust.left),
               getdepth(clust.right)) + clust.distance

def pearson(v1, v2):
    # Plain sums
    sum1 = sum(v1)
    sum2 = sum(v2)
    # Sums of squares
    sum1Sq = sum([pow(v, 2) for v in v1])
    sum2Sq = sum([pow(v, 2) for v in v2])
    # Sum of products
    pSum = sum([v1[i] * v2[i] for i in range(len(v1))])
    # Compute the Pearson score
    num = pSum - (sum1 * sum2 / len(v1))
    d = sqrt((sum1Sq - pow(sum1, 2) / len(v1))
             * (sum2Sq - pow(sum2, 2) / len(v1)))
    if d == 0:
        return 0
    # Return the inverse
    r = 1.0 - num / d
    return r

# Tanimoto coefficient
# A value of 1.0 means nobody who wants the first item also wants
# the second one
# A value of 0.0 means exactly the same group wants both items
def tanamoto(v1, v2):
    c1, c2, shr = 0, 0, 0
    for i in range(len(v1)):
        if v1[i] != 0:
            c1 += 1
        if v2[i] != 0:
            c2 += 1
        if v1[i] != 0 and v2[i] != 0:
            shr += 1
    return 1.0 - (float(shr) / (c1 + c2 - shr))

def scaledown(data, distance=pearson, rate=0.01):
    n = len(data)
    # Real distance between every pair of items
    realdist = [[distance(data[i], data[j]) for j in range(n)]
                for i in range(0, n)]

    # Start the points at random positions in two dimensions
    loc = [[random.random(), random.random()] for i in range(n)]
    fakedist = [[0.0 for j in range(n)] for i in range(n)]
    lasterror = None
    for m in range(0, 1000):
        # Measure the projected distance
        for i in range(n):
            for j in range(n):
                fakedist[i][j] = sqrt(sum([pow(loc[i][x] - loc[j][x], 2)
                                           for x in range(len(loc[i]))]))
    # Move the points
    grad = [[0.0, 0.0] for i in range(n)]
    totalerror = 0
    for k in range(n):
        for j in range(n):
            if j == k:
                continue
            # The error is the percentage difference between the distances
            errorterm = (fakedist[j][k] - realdist[j][k]) / realdist[j][k]
            # Adjust each point in proportion to
            # its error against the other points
            grad[k][
                0] += ((loc[k][0] - loc[j][0]) / fakedist[j][k]) * errorterm
            grad[k][
                1] += ((loc[k][1] - loc[j][1]) / fakedist[j][k]) * errorterm
            # Record the total error
            totalerror += abs(errorterm)
        print totalerror
        # Stop once the error gets worse
        if lasterror and lasterror < totalerror:
            break
        lasterror = totalerror
        # Move the points by the gradient scaled by the learning rate
        for k in range(n):
            loc[k][0] -= rate * grad[k][0]
            loc[k][1] -= rate * grad[k][1]

    return loc

def draw2d(data, labels, jpeg='mds2d.jpg'):
    img = Image.new('RGB', (2000, 2000), (255, 255, 255))
    draw = ImageDraw.Draw(img)
    for i in range(len(data)):
        x = (data[i][0] + 0.5) * 1000
        y = (data[i][1] + 0.5) * 1000
        draw.text((x, y), labels[i], (0, 0, 0))
    img.save(jpeg, 'JPEG')

def rotatematrix(data):
    newdata = []
    for i in range(len(data[0])):
        newrow = [data[j][i] for j in range(len(data))]
        newdata.append(newrow)
    return newdata

def drawdendrogram(clust, labels, jpeg='cluster.jpg'):
    h = getheight(clust) * 20
    w = 1200
    depth = getdepth(clust)
    # Scale to fit
    scaling = float(w - 150) / depth
    # Draw on a white background
    img = Image.new('RGB', (w, h), (255, 255, 255))
    draw = ImageDraw.Draw(img)
    draw.line((0, h / 2, 10, h / 2), fill=(255, 0, 0))
    # Draw the first node
    drawnode(draw, clust, 10, (h / 2), scaling, labels)
    img.save(jpeg, 'JPEG')

def drawnode(draw, clust, x, y, scaling, labels):
    if clust.id < 0:
        h1 = getheight(clust.left) * 20
        h2 = getheight(clust.right) * 20
        top = y - (h1 + h2) / 2
        bottom = y + (h1 + h2) / 2
        # Length of the line
        ll = clust.distance * scaling
        # Vertical line from the cluster down to its children
        draw.line((x, top + h1 / 2, x, bottom - h2 / 2), fill=(255, 0, 0))
        # Horizontal line to the left item
        draw.line((x, top + h1 / 2, x + ll, top + h1 / 2), fill=(255, 0, 0))
        # Horizontal line to the right item
        draw.line(
            (x, bottom - h2 / 2, x + ll, bottom - h2 / 2), fill=(255, 0, 0))
        # Recurse to draw the left and right nodes
        drawnode(draw, clust, left, x + ll, top + h1 / 2, scaling, labels)
        drawnode(draw, clust, right, x + ll, bottom - h2 / 2, scaling, labels)
    else:
        # Draw the label when this is an endpoint
        draw.text((x + 5, y - 7), labels[clust.id], (0, 0, 0))

class bicluster:

    def __init__(self, vec, left=None, right=None, distance=0.0, id=None):
        self.left = left
        self.right = right
        self.vec = vec
        self.id = id
        self.distance = distance

def hcluster(rows, distance=pearson):
    distances = {}
    currentclustid = -1
    # Each row starts out as its own cluster
    clust = [bicluster(rows[i], id=i) for i in range(len(rows))]
    while len(clust) > 1:
        lowestpair = (0, 1)
        closest = distance(clust[0].vec, clust[1].vec)
    # Loop over every pair and find the closest one
    for i in range(len(clust)):
        for j in range(i + 1, len(clust)):
            # Reuse the cached distance when there is one
            if (clust[i].id, clust[j].id) not in distances:
                distance[(clust[i].id, clust[j].id)] = distance(
                    clust[i].vec, clust[j].vec)
            d = distance[(clust[i].id, clust[j].id)]
            if d < closest:
                closest = d
                lowestpair = (i, j)
    # Average the two clusters
    mergevec = [
        (clust[lowestpair[0]].vec[i] + clust[lowestpair[1]].vec[i]) / 2.0
        for i in range(len(clust[0].vec))]
    # Create the new cluster
    newcluster = bicluster(mergevec, left=clust[lowestpair[0]],
                           right=clust[lowestpair[1]],
                           distance=closest, id=currentclustid)
    # Give clusters outside the original set a negative id
    currentclustid -= 1
    del clust[lowestpair[1]]
    del clust[lowestpair[0]]
    clust.append(newcluster)
    return clust[0]

def printclust(clust, labels=None, n=0):
    # Indent to produce a hierarchical layout
    for i in range(n):
        print ' ',
    if clust.id < 0:
        print '-'
    else:
        if labels == None:
            print clust.id
        else:
            print labels[clust.id]
    # Print the left and right branches
    if clust.left != None:
        printclust(clust.left, labels=labels, n=n + 1)
    if clust.right != None:
        printclust(clust.right, labels=labels, n=n + 1)

def main():
    blognames, words, data = readfile(sys.argv[1])
    print blognames
    print words
    print data
    # clust=hcluster(data)

if __name__ == '__main__':
    main()
