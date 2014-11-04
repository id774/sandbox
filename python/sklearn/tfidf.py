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
        # Vectorize tokens.
        tfidf = TfidfVectorizer(tokenizer=self.tokenize,
                                max_df=10,
                                stop_words='english')
        # TF-IDF fitting.
        tfs = tfidf.fit_transform(token_dic.values())

        # Getting feature names from given words.
        feature_names = tfidf.get_feature_names()

        i = 0
        for k, v in token_dic.items():
            # Concat words and the scores of the words.
            d = dict(zip(feature_names, tfs[i].toarray()[0]))
            # Sort dic by values decending.
            score = [(x, d[x]) for x in sorted(d, key=lambda x:-d[x])]
            # Pick up top 50 words.
            dic[k] = score[:50]
            i += 1

        # Return filename and scored words.
        return dic

if __name__ == '__main__':
    argsmin = 0
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            tfidf = Tfidf(sys.argv)
            result = tfidf.analyze()
            for k, v in result.items():
                print(k)
                arr = []
                for w, s in v:
                    arr.append(w)
                print(arr)
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
