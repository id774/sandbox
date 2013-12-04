# -*- coding: utf-8 -*-

require 'json'
require 'MeCab'
require 'naivebayes'

class Analyzer
  def initialize(args)
    @train_txt = args.shift || "sfa_train3.txt"
    @mecab = MeCab::Tagger.new("-Ochasen")
    @classify_txt = args.shift || "new_train.txt"
    @classifier = NaiveBayes::Classifier.new(:model => "berounoulli")
  end

  def train
    open(@train_txt) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        hash = JSON.parse(json)

        @classifier.train(tag, hash)
        #output(key, tag, hash)
      end
    end
  end

  def classify
    open(@classify_txt) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        hash = JSON.parse(json)
        classify_hash = word_count(pickup_nouns(hash['value']), 'berounoulli')
        result = @classifier.classify(classify_hash)

        expected = result.max{|a, b| a[1] <=> b[1]}[0]
        h = {}
        result.each {|k, v|
          h[k] = (v / 1.0 * 100).round(2)
        }
        output(hash['key'], expected, JSON.generate(h))
      end
    end
  end

  private

  def output(key, tag, value)
    puts "#{key}\t#{tag}\t#{value}"
  end

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

  def pickup_nouns(string)
    node = @mecab.parseToNode(string)
    nouns = []
    while node
      if /^名詞/ =~ node.feature.force_encoding("utf-8").split(/,/)[0] then
        nouns.push(node.surface.force_encoding("utf-8"))
      end
      node = node.next
    end
    nouns
  end

end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.train
  analyzer.classify
end

