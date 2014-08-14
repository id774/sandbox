#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import os
import json
import math
from collections import defaultdict
from itertools import permutations, chain

class TWCNB(object):

    """
    twcnb = TWCNB()
    training_data = [(1, {'a': 2, 'b': 2}), (2, {'a': 1, 'c': 4})]
    twcnb.train(training_data)
    testing_data = {'a': 1, 'b': 2}
    scores = twcnb.classify(testing_data)
    best = min(scores, key=scores.get)
    print(best)
    """

    def __init__(self):
        """
        """
        self.all_categories = set()
        self.normalized_category_word_weight = defaultdict(
            lambda: defaultdict(int))

    def train(self, data):
        """dataを用いて分類器を学習する
        """
        category_word_count = self._calc_category_word_count(data)
        all_words = set(chain.from_iterable(iter(word_count.keys())
                                            for word_count in category_word_count.values()))
        complement_category_word_count = self._calc_complement_category_word_count(
            category_word_count, all_words)
        category_word_weight = self._calc_category_word_weight(
            complement_category_word_count, len(all_words))
        normalized_category_word_weight = self._calc_normalized_category_word_weight(
            category_word_weight)
        self.normalized_cat_word_weight = normalized_category_word_weight

    def classify(self, document):
        """documentが分類されるcategoryを返す
        """
        scores = {category: self._calc_score(document, category)
                  for category in self.all_categories}
        return scores

    def _calc_score(self, document, category):
        """documentがcategoryに属するスコアを算出する
        """
        score = 0
        for word, count in document.items():
            score += count * self.normalized_cat_word_weight[category][word]
        return score

    def _calc_idf(self, documents):
        """idf値を算出する
        """
        df = defaultdict(int)
        for document in documents:
            for word in document.keys():
                df[word] += 1
        idf = defaultdict(int)
        document_count = len(documents)
        for word, count in df.items():
            idf[word] = math.log(1.0 * document_count / count)
        return idf

    def _calc_category_word_count(self, data):
        """各カテゴリでの各単語の出現頻度を算出する
        単語の出現頻度にはTF Transform, IDF Transform, Length Normalizationを行う
        """
        documents = [d[1] for d in data]
        idf = self._calc_idf(documents)
        category_word_count = defaultdict(lambda: defaultdict(int))
        for category, document in data:
            tfidf_count = defaultdict(float)
            for word, count in document.items():
                self.all_categories.add(category)
                count = math.log(count + 1)  # 3. TF Transform
                count *= idf[word]  # 4. IDF Transform
                tfidf_count[word] = count
            document_length = math.sqrt(
                sum(math.pow(v, 2) for v in tfidf_count.values()))
            for word, count in tfidf_count.items():
                count /= document_length  # 5. Length Normalization
                category_word_count[category][word] += count
        return category_word_count

    def _calc_complement_category_word_count(self, category_word_count, all_words):
        """あるカテゴリ以外(Comlement)のカテゴリでの各単語の出現頻度を算出する
        """
        complement_category_word_count = defaultdict(
            lambda: defaultdict(int))  # 1. Complement
        for word in all_words:
            for category, other_category in permutations(self.all_categories, 2):
                complement_category_word_count[category][
                    word] += category_word_count[other_category][word]
        return complement_category_word_count

    def _calc_category_word_weight(self, complement_category_word_count, alpha):
        """各カテゴリでの各単語の重みを算出する
        """
        category_word_weight = defaultdict(lambda: defaultdict(int))
        for category, word_count in complement_category_word_count.items():
            theta_denominator = sum(word_count.values()) + alpha
            for word, count in word_count.items():
                theta = (count + 1) / theta_denominator
                category_word_weight[category][word] = math.log(theta)
        return category_word_weight

    def _calc_normalized_category_word_weight(self, category_word_weight):
        """各カテゴリでの各単語の重みを正規化する(Weight Normalization)
        """
        normalized_category_word_weight = defaultdict(lambda: defaultdict(int))
        for category, word_weight in category_word_weight.items():
            weight_sum = sum(map(abs, iter(word_weight.values())))
            for word, weight in word_weight.items():
                normalized_category_word_weight[category][
                    word] = weight / weight_sum  # 2. Weight Normalization
        return normalized_category_word_weight

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

    twcnb = TWCNB()
    twcnb.train(training_data)

    file = open(classify_txt, 'r')

    correct = 0
    wrong = 0

    for line in file:
        key, tag, value = line.rstrip().split("\t")
        json_obj = json.loads(value)
        words = defaultdict(int)
        for word in json_obj['words']:
            words[word] = words.get(word, 0) + 1
        json_obj['scores'] = twcnb.classify(words)
        json_obj['best'] = min(json_obj['scores'], key=json_obj['scores'].get)
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
