# -*- coding: utf-8 -*-

require 'MeCab'
require 'json'
require 'awesome_print'

class Scoring
  attr_accessor :classify, :scores, :total_score, :text

  def initialize
    @classify    = ""
    @scores      = []
    @total_score = 0.0
    @text        = ""
  end
end

class Analyzer
  def initialize(args)
    @mecab = MeCab::Tagger.new("-Ochasen")
    @filename = args.shift || "json.txt"

    dic_file = args.shift || File.join(File.dirname(__FILE__), '..', '..', '..', 'depression', 'pn_ja.dic')
    @dic = Array.new
    open(dic_file) do |file|
      file.each_line do |line|
        @dic << line.force_encoding("utf-8").chomp.split(':')
      end
    end
  end

  def start
    open(@filename) do |file|
      file.each_line do |line|
        key, tag, value = line.force_encoding("utf-8").strip.split("\t")
        json = JSON.parse(value)
        scoring = depression(json["報告内容"])
        output([key,tag].join(','), [scoring.classify,scoring.total_score].join(','), JSON.generate(scoring.scores))
        #output([key,tag].join(','), [scoring.classify,scoring.total_score].join(','), scoring.text)
      end
    end
  end

  private

  def output(key, tag, value)
    puts "#{key}\t#{tag}\t#{value}"
  end

  def depression(string)
    scoring = Scoring.new

    score = 0.0
    word_count = 0

    scoring.text = string

    if scoring.text.length > 0
      parse_to_node(scoring.text).each {|word|
        if i = @dic.assoc(word)
          word_count += 1
          scoring.scores << i
          score += i[3].to_f
        end
      }
    end

    if word_count > 1
      scoring.total_score = (score / word_count) ** 3
      scoring.classify = scoring.total_score > 0 ? 'Positive' : 'Negative'
    else
      scoring.total_score = 0.0
      scoring.classify = '判定不能'
    end

    return scoring
  end

  def parse_to_node(string)
    node = @mecab.parseToNode(string)
    nouns = []
    while node
      nouns.push(node.surface.force_encoding("utf-8"))
      node = node.next
    end
    nouns
  end
end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.start
end

