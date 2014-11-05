#!/usr/bin/env python
# -*- encoding: utf-8 -*-

import sys
import os
import json
import codecs
from sklearn.feature_extraction.text import TfidfVectorizer

class Tfidf:
    def __init__(self, args):
        home = os.path.expanduser('~')
        self.score_dic = {}

        try:
            self.target_dir = args[1]
        except IndexError:
            self.target_dir = os.path.join(home, 'tmp', '1')

        try:
            self.output_dir = args[2]
        except IndexError:
            self.output_dir = os.path.join(home, 'tmp', '2')

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
            self.score_dic[k] = score[:50]
            i += 1

        # Return filename and scored words.
        return self.score_dic

    def write(self):
        for k, v in self.score_dic.items():
            arr = []
            for w, s in v:
                arr.append([w, str(round(s * 10000, 2))])

            hash = json.dumps({'values': arr},
                              sort_keys=True,
                              ensure_ascii=False,
                              indent=2,
                              separators=(',', ': '))

            f = codecs.open(os.path.join(self.output_dir, k),
                            "w", "utf-8")
            f.write(hash)
            f.close()

if __name__ == '__main__':
    argsmin = 0
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            tfidf = Tfidf(sys.argv)
            tfidf.analyze()
            tfidf.write()
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
