#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Classify with averaged one dependence estimators.

import sys
import os
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
        """Train the classifier on data
        """
        for category, document in data:
            self.all_categories.add(category)
            for word1, word2 in permutations(iter(document.keys()), 2):
                self.word_count[word1] += 1
                self.category_word_count[category][word1] += 1
                self.category_word_pair_count[category][(word1, word2)] += 1

    def classify(self, document):
        """Return the category the document is classified into
        """
        scores = {category: self._calc_score(document, category)
                  for category in self.all_categories}
        return scores

    def _calc_score(self, document, category):
        """Compute the score that the document belongs to the category
        """
        score = 0.0
        for word in document.keys():
            if self.word_count[word] < self.minimum_word_count:
                # When every count is below m, this needs to fall back to plain naive Bayes instead of AODE
                continue
            score += self._calc_one_dependence_score(document, category, word)
        return score

    def _calc_one_dependence_score(self, document, category, attribute):
        """Compute that score when attribute is the parent
        P(category, attribute) * ΠP(word|category, attribute)
        """
        score = (self.category_word_count[category][
                 attribute] + 1.0) / len(self.word_count) + len(self.all_categories)
        for word, count in document.items():
            score *= count * \
                self._calc_one_dependence_probability(
                    word, category, attribute)
        return score

    def _calc_one_dependence_probability(self, word, category, attribute):
        """P(word|category, attribute)
        """
        numerator = self.category_word_pair_count[
            category][(word, attribute)] + 1.0
        denominator = self.category_word_count[
            category][word] + len(self.word_count)
        return 1.0 * numerator / denominator

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

    correct = 0
    wrong = 0

    for line in file:
        key, tag, value = line.rstrip().split("\t")
        json_obj = json.loads(value)
        words = defaultdict(int)
        for word in json_obj['words']:
            words[word] = words.get(word, 0) + 1
        json_obj['scores'] = aode.classify(words)
        json_obj['best'] = max(json_obj['scores'], key=json_obj['scores'].get)
        if json_obj['key'] == json_obj['best']:
            json_obj['evaluate'] = True
            correct += 1
        else:
            json_obj['evaluate'] = False
            wrong += 1
        json_dump = json.dumps(json_obj, ensure_ascii=False)
        print(key + "\t" + tag + "\t" + json_dump)

    print("Correct:" + str(correct))
    print("Wrong:" + str(wrong))
    print("Accuracy:" + str(correct / (correct + wrong)))

    file.close()

if __name__ == '__main__':
    if len(sys.argv) > 2:
        main(sys.argv)
    else:
        print("Invalid arguments")
