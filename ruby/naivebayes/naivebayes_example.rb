#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

class NaiveBayesExample
  require 'rubygems'
  require 'naivebayes'

  def initialize
    @classifier = NaiveBayes::Classifier.new(:model => "berounoulli")
    @classifier.train("果物", {"りんご" => 1, "バナナ" => 1, "パイナップル" => 1})
    @classifier.train("野菜", {"キャベツ" => 1, "トマト" => 1, "きゅうり" => 1})
  end

  def classify
    @classifier.classify({"トマト" => 1})
  end
end

if __FILE__ == $0
  naivebayes = NaiveBayesExample.new
  p naivebayes.classify
end
