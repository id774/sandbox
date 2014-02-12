# -*- coding: utf-8 -*-

require 'json'
require 'MeCab'

class Analyzer
  def initialize(args)
    @mecab = MeCab::Tagger.new("-Ochasen")
    @filename = args.shift || "json.txt"
  end

  def start
    open(@filename) do |file|
      file.each_line do |line|
        key, tag, value = line.force_encoding("utf-8").strip.split("\t")
        hash = JSON.parse(value)
        hash['words'] = pickup_nouns(hash['value'])
        output(key, tag, JSON.generate(hash))
      end
    end
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

end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.start
end

