# -*- coding: utf-8 -*-

require 'CaboCha'
require 'awesome_print'

sent = "太郎はこの本を二郎を見た女性に渡した。"

def depgraph(sent)
  cabocha = CaboCha::Parser.new('--charset=UTF8')
  tree = cabocha.parse(sent)
  words = [{"id" => "0", "link" => 0}]
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

  chank_words = lambda {|x|
    unless words[x]["word"].nil?
      @sentence << words[x]["word"]
      link = words[x]["link"].to_i
      chank_words.call(link) unless words[x]["link"] == 0
    end
  }

  i = 0
  return_sentence = []
  before_noun = false
  while (i < words.length)
    @sentence = []
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
    return_sentence << @sentence.join if @sentence.length > 0
    i += 1
  end
  return_sentence
end

ap depgraph(sent)

