import sys
import os
import pandas as pd
import re
from sklearn.cluster import KMeans

def read_file(filename):
    df = pd.read_csv(filename, header=None)
    return df.ix[0].tolist()

def read_all_files(path):
    dic = {}
    for root, dirs, files in os.walk(path):
        for filename in files:
            p = re.compile(re.compile(r'.*?\.txt'))
            if p.search(filename):
                fullname = os.path.join(root, filename)
                print("Parse: " + filename)
                dic[filename] = read_file(fullname)
    return dic

def kmeans(dic):
    features = []
    for value in dic.values():
        features.append(value)

    kmeans_model = KMeans(n_clusters=5, random_state=20).fit(features)
    labels = kmeans_model.labels_
    return labels, features

def main(args):
    path = args[1]
    dic = read_all_files(path)
    labels, features = kmeans(dic)
    for label, key in zip(labels, dic.keys()):
        print(label, key)

if __name__ == '__main__':
    argsmin = 1
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            sys.exit(main(sys.argv))
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
