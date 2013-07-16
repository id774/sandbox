# -*- coding: utf-8 -*-

require 'date'
require 'time'
require 'mongo'
require 'MeCab'
require 'naivebayes'

PICKUP_DATE   = (Date.today - 1).strftime("%Y%m%d")
TODAY         = Date.today.strftime("%Y%m%d")
TRAIN_ALL     = "train_all_#{PICKUP_DATE}.txt"
LOG_PATH      = "/home/fluent/.fluent/log"
OUTFILE       = File.expand_path(File.join(LOG_PATH, TRAIN_ALL))

class MapReduce
  def initialize
    @mecab = MeCab::Tagger.new("-Ochasen")
    @classifier = NaiveBayes::Classifier.new(:model => "multinomial")
  end

  def map_reduce
    train_from_datasource
    #write_result
  end

  private

  def train(db, category)
    hits = {}
    coll = db.collection(category)
    coll.find().each {|line|
      line.each {|k,v|
        if k == "title" or k == "description"
          pickup_nouns(v).each {|word|
            if word.length > 1
              if word =~ /[亜-腕]/
                hits.has_key?(word) ? hits[word] += 1 : hits[word] = 1
              end
            end
          }
        end
      }
    }
    return hits
  end

  def train_from_datasource
    mongo = Mongo::Connection.new('localhost', 27017)
    db = mongo.db('fluentd')
    @classifier.train("social", train(db, 'category.social'))
    @classifier.train("politics", train(db, 'category.politics'))
    @classifier.train("international", train(db, 'category.international'))
    @classifier.train("economics", train(db, 'economicsl'))
    @classifier.train("electro",  train(db, 'category.electro'))
    @classifier.train("sports",  train(db, 'category.sports'))
    @classifier.train("entertainment",  train(db, 'entertainment'))
    @classifier.train("science",  train(db, 'science'))

    result = @classifier.classify({"写真" => 3, "動画" => 2, "群馬" => 5
                                  })
    p result
    p result.max
    p result.max.class
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

map_reduce = MapReduce.new
map_reduce.map_reduce

