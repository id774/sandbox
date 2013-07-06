#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

$:.unshift File.join(File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
require 'naivebayes'

def train_3
  classifier = NaiveBayes.new
  classifier.train("positive", {"aaa" => 2, "bbb" => 1})
  classifier.train("negative", {"ccc" => 2, "ddd" => 2})
  classifier.train("neutral",  {"eee" => 3, "fff" => 3})
  return classifier
end

describe NaiveBayes, 'ナイーブベイズ' do
  context '多変数ベルヌーイモデルにおいて' do
    describe '3 つの教師データで positive が期待される値を与えると' do
      it 'positive が返る' do
        classifier = train_3
        expect = {
          "positive" => 0.7422680412371133,
          "negative" => 0.12886597938144329,
          "neutral"  => 0.12886597938144329
        }
        result = classifier.classify({"aaa" => 1, "bbb" => 1})
        result.should == expect
      end
    end
    describe '3 つの教師データで negative が期待される値を与えると' do
      it 'negative が返る' do
        classifier = train_3
        expect = {
          "positive" => 0.12886597938144329,
          "negative" => 0.7422680412371133,
          "neutral"  => 0.12886597938144329
        }
        result = classifier.classify({"ccc" => 3, "ddd" => 2})
        result.should == expect
      end
    end
    describe '3 つの教師データで neutral が期待される値を与えると' do
      it 'neutral が返る' do
        classifier = train_3
        expect = {
          "positive" => 0.2272727272727273,
          "negative" => 0.22727272727272724,
          "neutral"  => 0.5454545454545455
        }
        result = classifier.classify({"aaa" => 1, "ddd" => 2, "eee" => 3, "fff" => 1})
        result.should == expect
      end
    end
  end
end
