#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys, os
import json
import math
from collections import defaultdict

class NB(object):
    """
    nb = NB()
    training_data = [(1, {'a': 2, 'b': 2}), (2, {'a': 1, 'c': 4})]
    nb.train(training_data)
    testing_data = {'a': 1, 'b': 2}
    scores = nb.classify(testing_data)
    best = max(scores, key=scores.get)
    print(best)
    """

    def __init__(self):
        """
        """
        self.all_categories = set()
        self.category_word_count = defaultdict(lambda: defaultdict(int))
        self.category_probability = defaultdict(float)
        self.denominators = defaultdict(int)

    def train(self, data):
        """dataを用いて分類器を学習する
        """
        all_words = set()
        category_count = defaultdict(int)
        for category, document in data:
            self.all_categories.add(category)
            category_count[category] += 1
            for word, count in document.items():
                all_words.add(word)
                self.category_word_count[category][word] += count
        for category in self.all_categories:
            self.denominators[category] = sum(self.category_word_count[category].values()) + len(all_words)
            self.category_probability[category] = 1.0 * category_count[category] / len(data)

    def classify(self, document):
        """documentが分類されるcategoryを返す
        """
        scores = {category: self._calc_score(document, category)
                  for category in self.all_categories}
        return scores

    def _calc_score(self, document, category):
        """documentがcategoryに属するスコアを算出する
        """
        score = math.log(self.category_probability[category])
        for word, count in document.items():
            probability = self._calc_category_word_probability(word, category)
            score += count * math.log(probability)
        return score

    def _calc_category_word_probability(self, word, category):
        """P(word|category)を算出する
        """
        numerator = self.category_word_count[category][word] + 1.0
        return 1.0 * numerator / self.denominators[category]

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

    nb = NB()
    nb.train(training_data)

    file = open(classify_txt, 'r')

    correct = 0
    wrong   = 0

    for line in file:
        key, tag, value = line.rstrip().split("\t")
        json_obj = json.loads(value)
        words = defaultdict(int)
        for word in json_obj['words']:
            words[word] = words.get(word, 0) + 1
        json_obj['scores'] = nb.classify(words)
        json_obj['best'] = max(json_obj['scores'], key=json_obj['scores'].get)
        if json_obj['key'] == json_obj['best']:
            json_obj['evaluate'] = True
            correct += 1
        else:
            json_obj['evaluate'] = False
            wrong += 1
        json_dump = json.dumps(json_obj,ensure_ascii=False)
        print(key + "\t" + tag + "\t" + json_dump)

    print("Correct:" + str(correct))
    print("Wrong:"   + str(wrong))
    print("Accuracy:" + str(correct / (correct + wrong)))

    file.close()

if __name__=='__main__':
    if len(sys.argv) > 2:
        main(sys.argv)
    else:
        print("Invalid arguments")

