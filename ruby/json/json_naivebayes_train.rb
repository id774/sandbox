# -*- coding: utf-8 -*-

require 'json'
require 'naivebayes'

class Analyzer
  def initialize(args)
    @filename = args.shift || "json.txt"
    @classifier = NaiveBayes::Classifier.new(:model => "multinomial")
  end

  def start
    open(@filename) do |file|
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

  private

  def output(key, tag, value)
    puts "#{key}\t#{tag}\t#{value}"
  end

end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.start
end

