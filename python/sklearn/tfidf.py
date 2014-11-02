#!/usr/bin/env python
# -*- encoding: utf-8 -*-

import sys
import os
import MeCab
from sklearn.feature_extraction.text import TfidfVectorizer

class Tfidf:
    def __init__(self, args):
        try:
            self.target_dir = args[1]
        except IndexError:
            home = os.path.expanduser('~')
            self.target_dir = os.path.join(home, 'tmp', 'doc')

    def tokenize(self, text):
        wakati = MeCab.Tagger("-O wakati")
        return wakati.parse(text)

    def main(self):
        token_dict = {}
        for subdir, dirs, files in os.walk(self.target_dir):
            for file in files:
                file_path = os.path.join(subdir, file)
                shakes = open(file_path, 'r')
                text = shakes.read()
                lowers = text.lower()
                token_dict[file] = lowers
                shakes.close()

        tfidf = TfidfVectorizer(tokenizer=self.tokenize, stop_words='english')
        tfs = tfidf.fit_transform(token_dict.values())

        return(token_dict, tfs)

if __name__ == '__main__':
    argsmin = 0
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            tfidf = Tfidf(sys.argv)
            token_dict, tfs = tfidf.main()
            print(token_dict)
            print(tfs)
            print(tfs.toarray())
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
