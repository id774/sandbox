
import math

A = {"みかん": 5, "りんご": 8, "ぶどう": 2}
B = {"みかん": 5, "なし": 8, "ぶどう": 2, "もも": 1}

def dotProduct(dicX, dicY):
    '''return a dot product.'''
    sum = 0
    for key in dicX:
        if key in dicY:
            sum += float(dicX[key]) * float(dicY[key])
    return sum

def root_squareSum(vector):
    """the root of the sum of squares"""
    return math.sqrt(sum([int(x) ** 2 for x in vector]))

def cosineSim(dicX, dicY):
    """this is a main"""
    if dicX == {} or dicY == {}:
        return 0
    upper = dotProduct(dicX, dicY)
    bottom = root_squareSum(dicX.values()) * root_squareSum(dicY.values())
    return float(upper) / bottom


def jaccardSim(dicX, dicY):
    if dicX == {} or dicY == {}:
        return 0
    setX = set(dicX.keys())
    setY = set(dicY.keys())
    upper = len(setX & setY)
    bottom = len(setX | setY)
    if bottom != 0:
        return float(upper) / bottom
    else:
        return 0

def simpsonSim(dicX, dicY):
    if dicX == {} or dicY == {}:
        return 0
    setX = set(dicX.keys())
    setY = set(dicY.keys())
    upper = len(setX & setY)
    bottom = min(len(setX), len(setY))
    return float(upper) / bottom

def matchCoeff(dicX, dicY):
    setX = set(dicX.keys())
    setY = set(dicY.keys())
    return len(setX & setY)

def simpson(v1, v2):
    numerator = sum([c in v2 for c in v1])
    denominator = min(len(v1), len(v2))
    return float(numerator) / denominator if denominator != 0 else 0

def cos(v1, v2):
    numerator = sum([v1[c] * v2[c] for c in v1 if c in v2])
    denominator = math.sqrt(
        sum([v * v for v in v1.values()]) * sum([v * v for v in v2.values()]))
    return float(numerator) / denominator if denominator != 0 else 0

def jaccard(v1, v2):
    numerator = sum([c in v2 for c in v1])
    denominator = len(v1) + len(v2) - numerator
    return float(numerator) / denominator if denominator != 0 else 0

def dice(v1, v2):
    numerator = sum([c in v2 for c in v1])
    denominator = len(v1) + len(v2)
    return 2 * float(numerator) / denominator if denominator != 0 else 0

print('Cosine', cosineSim(A, B))
print('Jaccard', jaccardSim(A, B))
print('Simpson', simpsonSim(A, B))
print('Match', matchCoeff(A, B))

print('Cosine', cos(A, B))
print('Jaccard', jaccard(A, B))
print('Dice', dice(A, B))
