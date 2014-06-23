#!/usr/bin/env python
# -*- encoding: utf-8 -*-

import os
import MeCab

from sklearn.feature_extraction.text import TfidfVectorizer

home = os.path.expanduser('~')
target_dir = os.path.join(home, 'tmp', 'doc')
token_dict = {}

def tokenize(text):
    wakati = MeCab.Tagger("-O wakati")
    return wakati.parse(text)

for subdir, dirs, files in os.walk(target_dir):
    for file in files:
        file_path = os.path.join(subdir, file)
        shakes = open(file_path, 'r')
        text = shakes.read()
        lowers = text.lower()
        token_dict[file] = lowers

tfidf = TfidfVectorizer(tokenizer=tokenize, stop_words='english')
tfs = tfidf.fit_transform(token_dict.values())

print(token_dict)
print(tfs)

