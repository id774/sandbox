#!/usr/bin/env python
# -*- encoding: utf-8 -*-

import sys
import os
#import MeCab
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
        #wakati = MeCab.Tagger("-O wakati")
        #return wakati.parse(text)
        return text.rstrip().split(",")

    def main(self):
        dic = self.token_dict()
        tfidf = TfidfVectorizer(tokenizer=self.tokenize, stop_words='english')
        tfs = tfidf.fit_transform(dic.values())

        return(dic, tfs)

if __name__ == '__main__':
    argsmin = 0
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            tfidf = Tfidf(sys.argv)
            dic, tfs = tfidf.main()
            print(dic)
            for i, name in enumerate(dic):
                print(name, tfs[i])
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
