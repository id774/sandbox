# -*- coding: utf-8 -*-
# pickup_words_by_naivebayes.rb: Words that best separate classes with naive Bayes
#
# Description:
# Pick the words that best separate classes with naive Bayes. The company list
# defaults to company.csv and the input to json.txt.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby pickup_words_by_naivebayes.rb [company file] [JSON file]
#
# Requirements:
# - Ruby
# - The naivebayes and awesome_print gems and MeCab with its Ruby binding
#

require 'json'
require 'awesome_print'
require 'naivebayes'
require 'MeCab'

class NaiveBayesClassifier
  def initialize(args)
    @company = args.shift || "company.csv"
    @infile = args.shift || "json.txt"
    @classifier = NaiveBayes::Classifier.new(:model => "berounoulli")
    @mecab = MeCab::Tagger.new("-Ochasen")
  end

  def train
    open(@company) do |file|
      file.each_with_index do |line, i|
        hash = {}
        #arr = line.force_encoding("utf-8").strip.split(",")
        arr = pickup_words(line.force_encoding("utf-8").strip)
        arr.each {|a| hash[a] = 1}
        @classifier.train(i, hash)
      end
    end
  end

  def classify
    classified = Array.new

    open(@infile) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        hash = JSON.parse(json)
        hits = {}
        s = ""
        s << hash['title'] if hash['title'].class == String
        s << hash['description'] if hash['description'].class == String
        pickup_words(s).take(15).each {|word|
          if word.length > 1
            hits.has_key?(word) ? hits[word] += 1 : hits[word] = 1
          end
        }
        classify = @classifier.classify(hits)
        hash['classify'] = classify
        hash['key'] = key
        hash['tag'] = tag
        classified << hash
      end
    end

    classified
  end

  private

  def pickup_words(string)
    node = @mecab.parseToNode(string)
    words = []
    while node
      word = node.surface.force_encoding("utf-8")
      if word =~ /[一-龠]/
        words.push(word)
      elsif word =~ /[あ-ン]/
        words.push(word)
      elsif word =~ /^[A-Za-z].*/
        words.push(word)
      elsif word =~ /^[Ａ-Ｚａ-ｚ].*/
        words.push(word)
      end
      node = node.next
    end
    words
  end
end

if __FILE__ == $0
  clf = NaiveBayesClassifier.new(ARGV)
  clf.train
  result = clf.classify
  result.each_with_index do |r, i|
    if r['classify'].max[1] >= 0.035
      ap r
      ap r['classify'].max
    end
  end
end

