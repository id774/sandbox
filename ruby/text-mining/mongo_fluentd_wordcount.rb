# -*- coding: utf-8 -*-

require 'date'
require 'time'
require 'mongo'
require 'MeCab'

RUN_DATE      = Date.today
PICKUP_DATE   = (RUN_DATE - 1).strftime("%Y%m%d")
TODAY         = RUN_DATE.strftime("%Y%m%d")
WORDCOUNT     = "wordcount_#{PICKUP_DATE}.txt"
LOG_PATH      = "/home/fluent/.fluent/log"
OUTFILE       = File.expand_path(File.join(LOG_PATH, WORDCOUNT))
EXCLUDE       = "wordcount_exclude.txt"
EXCLUDE_TXT   = File.expand_path(File.join(LOG_PATH, EXCLUDE))

class MapReduce
  def initialize
    @mecab = MeCab::Tagger.new("-Ochasen")
    @hits = {}
    @exclude = Array.new
  end

  def map_reduce
    read_from_exclude
    read_from_datasource
    write_result
  end

  private

  def read_from_exclude
    open(EXCLUDE_TXT) do |file|
      file.each_line do |word|
        @exclude << word
      end
    end
  end

  def read_from_datasource
    mongo = Mongo::Connection.new('localhost', 27017)
    db = mongo.db('fluentd')
    coll = db.collection('news.feed')
    from = Time.parse(PICKUP_DATE)
    to   = Time.parse(TODAY)
    coll.find({:time => {"$gt" => from , "$lt" => to}}).each {|line|
      line.each {|k,v|
        if k == "title" or k == "description"
          mapper(v).each {|word|
            if word.length > 1
              if word =~ /[亜-腕]/
                reducer(word)
              end
            end
          }
        end
      }
    }
  end

  def write_result
    open(OUTFILE, "w"){|f|
      i = 0
      @hits.sort_by{|k,v| -v}.each {|k, v|
        i = i + 1
        f.write("#{i.to_s}\t#{k}\t#{v}\n") if v >= 1
      }
    }
  end

  def reducer(word)
    @hits.has_key?(word) ? @hits[word] += 1 : @hits[word] = 1 unless @exclude.include?(word)
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

