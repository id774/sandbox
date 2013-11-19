# -*- coding: utf-8 -*-

require 'json'
require 'naivebayes'

class Analyzer
  def initialize(args)
    @train_txt = args.shift || "train.txt"
    @classify_txt = args.shift || "classify.txt"
    @classifier = NaiveBayes::Classifier.new(:model => "multinomial")
  end

  def train
    open(@train_txt) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        code, name = key.strip.split(",")
        result, class_name = tag.strip.split(",")
        hash = JSON.parse(json)

        train_data = word_count(hash['words'], 'multinomial')
        output(code, class_name, train_data)
        @classifier.train(class_name, train_data)

        train_data = word_count(hash['deps'],  'berounoulli')
        output(code, class_name, train_data)
        @classifier.train(class_name, train_data)
      end
    end
  end

  def classify
    open(@classify_txt) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        hash = JSON.parse(json)

        classify_hash = word_count(hash['words'].concat(hash['deps']), 'berounoulli')

        result = @classifier.classify(classify_hash)
        output(key, tag, result)
      end
    end
  end

  private

  def word_count(array, model = 'multinomial')
    hash = {}
    array.each {|elm|
      if model == "multinomial"
        hash.has_key?(elm) ? hash[elm] += 1 : hash[elm] = 1
      else
        hash[elm] = 1
      end
    } unless array.nil?
    hash
  end

  def output(key, tag, value)
    puts "#{key}\t#{tag}\t#{JSON.generate(value)}"
  end

end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.train
  analyzer.classify
end

