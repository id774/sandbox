# -*- coding: utf-8 -*-

require 'json'
require 'naivebayes'

class Analyzer
  def initialize(args)
    @train_txt = args.shift || "train.txt"
    @classify_txt = args.shift || "classify.txt"
    @classifier = NaiveBayes::Classifier.new(:model => "berounoulli")
  end

  def train
    open(@train_txt) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        hash = JSON.parse(json)

        @classifier.train(tag, hash)
        output(key, tag, hash)
      end
    end
  end

  def classify
    open(@classify_txt) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")

        code, type, project_name = key.strip.split(",")
        action, result = tag.strip.split(",")

        if type == "activity"
          hash = JSON.parse(json)
          classify_hash = word_count(hash['words'].concat(hash['deps']), 'berounoulli')
          h = {}
          @classifier.classify(classify_hash).each {|k, v|
            h[k] = (v / 1.0 * 100).round(2)
          }
          output(key, tag, JSON.generate(h))
        end
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
    puts "#{key}\t#{tag}\t#{value}"
  end

end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.train
  analyzer.classify
end

