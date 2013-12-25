# -*- coding: utf-8 -*-

require 'json'
require 'MeCab'

class Depression
  def initialize
    @dic_file = 'pn_ja.dic'
    @pn_ja = []
    @mecab = MeCab::Tagger.new("-Ochasen")
  end

  def run(string)
    puts_with_time('Start process')
    read_from_dic
    depression(string)
    puts_with_time('End process')
  end

  private

  def depression(string)
    score = 0.0
    word_count = 0
    parse_to_node(string).each {|word|
      if i = @pn_ja.assoc(word)
        word_count += 1
        p i
        score += i[3].to_f
      end
    }
    p (score / word_count) ** 3
  end

  def puts_with_time(message)
    fmt = "%Y/%m/%d %X"
    puts "#{Time.now.strftime(fmt)}: #{message.force_encoding("utf-8")}"
  end

  def read_from_dic
    open(@dic_file) do |file|
      file.each_line do |line|
        @pn_ja << line.force_encoding("utf-8").chomp.split(':')
      end
    end
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
  string = ARGV.shift || ""
  depression = Depression.new
  depression.run(string)
end

