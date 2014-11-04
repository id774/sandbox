#!/usr/bin/env python
# -*- encoding: utf-8 -*-

import sys
import os
# import MeCab
from sklearn.feature_extraction.text import TfidfVectorizer

class Tfidf:
    def __init__(self, args):
        try:
            self.target_dir = args[1]
        except IndexError:
            home = os.path.expanduser('~')
            self.target_dir = os.path.join(home, 'tmp', 'doc')

    def token_dict(self):
        dic = {}
        for subdir, dirs, files in os.walk(self.target_dir):
            for file in files:
                file_path = os.path.join(subdir, file)
                shakes = open(file_path, 'r')
                text = shakes.read()
                lowers = text.lower()
                dic[file] = lowers
                shakes.close()
        return dic

    def tokenize(self, text):
        words = text.rstrip().split("\n")
        return list(set(words))

    def analyze(self):
        dic = {}
        token_dic = self.token_dict()
        tfidf = TfidfVectorizer(tokenizer=self.tokenize,
                                max_df=10,
                                stop_words='english')
        tfs = tfidf.fit_transform(token_dic.values())
        feature_names = tfidf.get_feature_names()
        i = 0
        for k, v in token_dic.items():
            score = dict(zip(feature_names, tfs[i].toarray()[0]))
            dic[k] = score
            i += 1
        return dic

if __name__ == '__main__':
    argsmin = 0
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            tfidf = Tfidf(sys.argv)
            result = tfidf.analyze()
            print(result)
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
