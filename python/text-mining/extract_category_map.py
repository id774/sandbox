#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, os
import json
import re
from collections import OrderedDict

class Analyzer:
    def __init__(self, args):
        self.filename = args[1]
        self.exclude  = args[2]
        self.exclude_list = []
        self.category_num = 0
        self.__read_from_exclude()

    def start(self):
        self.__extract_map('category.social')
        self.__extract_map('category.politics')
        self.__extract_map('category.international')
        self.__extract_map('category.economics')
        self.__extract_map('category.electro')
        self.__extract_map('category.sports')
        self.__extract_map('category.entertainment')
        self.__extract_map('category.science')

    def __output__(self, key, tag, value):
        print(key, tag, json.dumps(value, ensure_ascii=False), sep="\t")

    def __extract_map(self, category):
        self.dic = OrderedDict()
        file = open(self.filename, 'r')
        for line in file:
            word, counts, social, politics, international, economics, electro, sports, entertainment, science, standard_deviation = line.rstrip().split("\t")
            array = [int(social), int(politics), int(international), int(economics), int(electro), int(sports), int(entertainment), int(science)]
            if not array[self.category_num] == 0:
                if float(standard_deviation) < 10.0:
                    if not word in self.exclude_list:
                        r = re.compile("[一-龠]")
                        if r.match(word):
                            self.__add_dic(word, array[self.category_num] * 3)
                        else:
                            self.__add_dic(word, array[self.category_num])

        file.close
        self.category_num += 1
        self.__output__(self.category_num, category, self.dic)
        return self.dic

    def __add_dic(self, word, count):
        if word in self.dic:
            self.dic[word] += count
        else:
            self.dic[word] = count

    def __read_from_exclude(self):
        file = open(self.exclude, 'r')
        for line in file:
            exclude_word = line.rstrip().split("\t")
            self.exclude_list.append(exclude_word)
        file.close
        return self.exclude_list

if __name__=='__main__':
    if sys.version_info > (3,0):
        if len(sys.argv) > 2:
            analyzer = Analyzer(sys.argv)
            analyzer.start()
        else:
            print("Invalid arguments")
    else:
        print("This program require python > 3.0")

