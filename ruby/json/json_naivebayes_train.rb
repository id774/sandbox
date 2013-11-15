# -*- coding: utf-8 -*-

require 'json'
require 'naivebayes'

class Analyzer
  def initialize(args)
    @train_txt = args.shift || "json.txt"
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

        train = lambda {|x, model|
          train_hash = {}
          x.each {|elm|
            if model == "multinomial"
              train_hash.has_key?(elm) ? train_hash[elm] += 1 : train_hash[elm] = 1
            else
              train_hash[elm] = 1
            end
          }
          @classifier.train(class_name, train_hash)
          output(code, class_name, JSON.generate(train_hash))
        }

        train.call(hash['words'], 'multinomial')
        train.call(hash['deps'],  'berounoulli')
      end
    end
  end

  def classify
    open(@classify_txt) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        hash = JSON.parse(json)
        result = @classifier.classify(hash)
        output(key, tag, JSON.generate(result))
      end
    end
  end

  private

  def output(key, tag, value)
    puts "#{key}\t#{tag}\t#{value}"
  end

end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.train
  analyzer.classify
end

