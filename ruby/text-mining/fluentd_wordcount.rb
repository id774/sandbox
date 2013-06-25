# -*- coding: utf-8 -*-

require 'MeCab'
require 'json'

class MapReduce
  def map_reduce
    @mecab = MeCab::Tagger.new("-Ochasen")
    mapper_hash = {}
    @hits = {}
    open("fluent_out.log") do |file|
      file.each do |line|
        JSON.parse(line.scan(/\{.*\}/).join).each {|k,v|
          if k == "description"
            mapper(v).each {|word|
              if word.length > 1
                if word =~ /[亜-腕]/
                  reducer(word)
                end
              end
            }
          end
        }
      end
    end

    i = 0
    @hits.sort_by{|k,v| -v}.each {|k, v|
      i = i + 1
      puts "#{i.to_s}\t#{k}\t#{v}\n" if i <= 100
    }
  end

  private
  def reducer(word)
    @hits.has_key?(word) ? @hits[word] += 1 : @hits[word] = 1
  end

  def mapper(string)
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

map_reduce = MapReduce.new
map_reduce.map_reduce

