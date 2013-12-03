# -*- coding: utf-8 -*-

require 'json'
require 'MeCab'
require 'CaboCha'

class Analyzer
  def initialize(args)
    @filename = args.shift || "json.txt"
    @mecab = MeCab::Tagger.new("-Ochasen")
    @cabocha = CaboCha::Parser.new('--charset=UTF8')
  end

  def start
    open(@filename) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        hash = JSON.parse(json)

        words = []
        word_count = {}
        dep_count = {}

        conditionally_pickup = lambda {|x|
          pickup_nouns(x).map {|word|
            words.push(word) if word =~ /[一-龠]/ or word =~ /^[A-Za-z].*/
          }
        }

        conditionally_pickup.call(hash['value']) unless hash['value'].nil?
        words.each do |word|
          word_count.has_key?(word) ? word_count[word] += 1 : word_count[word] = 1
        end

        output(key, hash['key'], word_count)

        depgraph(hash['value']).each do |dep|
          dep_count.has_key?(dep) ? dep_count[dep] += 1 : dep_count[dep] = 1
        end

        output(key, hash['key'], dep_count)
      end
    end
  end

  private

  def output(key, tag, value)
    puts "#{key}\t#{tag}\t#{JSON.generate(value)}"
  end

  private

  def output(key, tag, value)
    puts "#{key}\t#{tag}\t#{value}"
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

  def depgraph(sent)
    tree = @cabocha.parse(sent)
    sentence = []
    words = [{"id" => "0", "link" => 0}]

    chank_words = lambda {|x|
      unless words[x]["word"].nil?
        sentence << words[x]["word"]
        link = words[x]["link"].to_i
        chank_words.call(link) unless link == 0
      end
    }

    tree.toString(4).force_encoding("utf-8").split("\n").each {|phrase|
      element = phrase.strip.split("\t")
      hash = {}
      hash["id"] = element[0]
      hash["word"] = element[1]
      hash["feature"] = element[3]
      hash["link"] = element[6]
      hash["rel"] = element[7]
      words << hash
    }

    i = 0
    return_sentence = []
    before_noun = false
    while (i < words.length)
      sentence = []
      if before_noun
        if words[i]["feature"] == "動詞" or
           words[i]["feature"] == "連体詞"
          chank_words.call(i)
        end
      else
        if words[i]["feature"] == "名詞" or
           words[i]["feature"] == "動詞" or
           words[i]["feature"] == "連体詞"
          chank_words.call(i)
        end
      end
      words[i]["feature"] == "名詞" ? before_noun = true : before_noun = false
      return_sentence << sentence.join if sentence.length > 0
      i += 1
    end

    return_sentence
  end
end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.start
end

