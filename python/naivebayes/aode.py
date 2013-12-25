#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys, os
import json
from collections import defaultdict
from itertools import permutations

class AODE(object):
    """
    aode = AODE()
    training_data = [(1, {'a': 2, 'b': 2}), (2, {'a': 1, 'c': 4})]
    aode.train(training_data)
    testing_data = {'a': 1, 'b': 2}
    scores = aode.classify(testing_data)
    best = max(scores, key=scores.get)
    print(best)
    """

    def __init__(self, minimum_word_count=30):
        """
        """
        self.minimum_word_count = minimum_word_count
        self.all_categories = set()
        self.word_count = defaultdict(int)
        self.category_word_count = defaultdict(lambda: defaultdict(int))
        self.category_word_pair_count = defaultdict(lambda: defaultdict(int))

    def train(self, data):
        """dataを用いて分類器を学習する
        """
        for category, document in data:
            self.all_categories.add(category)
            for word1, word2 in permutations(iter(document.keys()), 2):
                self.word_count[word1] += 1
                self.category_word_count[category][word1] += 1
                self.category_word_pair_count[category][(word1, word2)] += 1

    def classify(self, document):
        """documentが分類されるcategoryを返す
        """
        scores = {category: self._calc_score(document, category)
                  for category in self.all_categories}
        return scores

    def _calc_score(self, document, category):
        """documentがcategoryに属するスコアを算出する
        """
        score = 0.0
        for word in document.keys():
            if self.word_count[word] < self.minimum_word_count:
                # すべてm未満の時は、AODEではなく通常のNaive Bayesを用いるようにする等の処理が必要
                continue
            score += self._calc_one_dependence_score(document, category, word)
        return score

    def _calc_one_dependence_score(self, document, category, attribute):
        """attributeがペアレントの時に、documentがcategoryに属するスコアを算出する
        P(category, attribute) * ΠP(word|category, attribute)
        """
        score = (self.category_word_count[category][attribute] + 1.0) / len(self.word_count) + len(self.all_categories)
        for word, count in document.items():
            score *= count * self._calc_one_dependence_probability(word, category, attribute)
        return score

    def _calc_one_dependence_probability(self, word, category, attribute):
        """P(word|category, attribute)
        """
        numerator = self.category_word_pair_count[category][(word, attribute)] + 1.0
        denominator = self.category_word_count[category][word] + len(self.word_count)
        return 1.0 * numerator / denominator

def main():
    aode = AODE()
    training_data = [(1, {'a': 2, 'b': 2}), (2, {'a': 1, 'c': 4})]
    aode.train(training_data)
    testing_data = {'a': 1, 'b': 2}
    result = aode.classify(testing_data)
    print(result)

if __name__=='__main__':
    main()

def main(args):
    train_txt = args[1]
    classify_txt = args[2]

    file = open(train_txt, 'r')
    training_data = []
    for line in file:
        key, tag, value = line.rstrip().split("\t")
        json_obj = json.loads(value)
        training_data.append((tag, json_obj))
    file.close()

    aode = AODE()
    aode.train(training_data)

    file = open(classify_txt, 'r')
    for line in file:
        key, tag, value = line.rstrip().split("\t")
        json_obj = json.loads(value)
        words = defaultdict(int)
        for word in json_obj['words']:
            words[word] = words.get(word, 0) + 1
        scores = aode.classify(words)
        json_dump = json.dumps(scores,ensure_ascii=False)
        best = max(scores, key=scores.get)
        print(key + ',' + tag + "\t" + best + "\t" + json_dump)
    file.close()

if __name__=='__main__':
    if len(sys.argv) > 2:
        main(sys.argv)
    else:
        print("Invalid arguments")

