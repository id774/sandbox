# -*- coding: utf-8 -*-

require 'date'
require 'time'
require 'mongo'
require 'MeCab'
require 'kmeans/pearson'
require 'kmeans/hcluster'
require 'kmeans/dendrogram'

PICKUP_DATE   = (Date.today - 1).strftime("%Y%m%d")
TODAY         = Date.today.strftime("%Y%m%d")
WORDCOUNT     = "wordcount_#{PICKUP_DATE}.txt"
HOT_NEWS      = "hotnews_#{PICKUP_DATE}.txt"
IMAGE_FILE    = "tree_#{PICKUP_DATE}.png"
LOG_PATH      = "/home/fluent/.fluent/log"
IMAGE_PATH    = "/var/www/rails/news_cloud/public/images"
WORDCOUNT_TXT = File.expand_path(File.join(LOG_PATH, WORDCOUNT))
OUTFILE       = File.expand_path(File.join(LOG_PATH, HOT_NEWS))
OUTIMAGE      = File.expand_path(File.join(IMAGE_PATH, IMAGE_FILE))
WORDS         = 150

class MapReduce
  def map_reduce
    @mecab = MeCab::Tagger.new("-Ochasen")
    @text_hash = Hash.new
    @blog_hash = Hash.new{ |h,k| h[k] = Hash.new(&h.default_proc) }
    @word_vector = Array.new
    @hits = {}

    open(WORDCOUNT_TXT) do |file|
      file.each_line do |line|
        num, word, count = line.force_encoding("utf-8").strip.split("\t")
        @text_hash[word] = count if count.to_i >= 1
      end
    end

    mongo = Mongo::Connection.new('localhost', 27017)
    db = mongo.db('fluentd')
    coll = db.collection('automatic.feed')
    from = Time.parse(PICKUP_DATE)
    to   = Time.parse(TODAY)
    blog = Hash.new
    coll.find({:time => {"$gt" => from , "$lt" => to}}).each {|line|
      blog.merge!(line)
      pickup_nouns(blog['title'] + blog['description']).each {|word|
        if word.length > 1
          if word =~ /[亜-腕]/
            if @text_hash.has_key?(word)
              scoring(blog['title'],
                      blog['link'],
                      blog['description'],
                      @text_hash[word])
            end
          end
        end
      }
    }

    open(OUTFILE, "w"){|f|
      i = 0
      @blog_hash.sort_by{|k,v| -v['score']}.each {|k, v|
        i = i + 1
        f.write("#{i.to_s}\t#{v['score'].to_s}\t#{v['title']}\t#{k}\n")
      }
    }

    entry_list = new_entrylist
    entry_list.each {|entry|
      i = 0
      wordmap = new_wordmap
      @text_hash.keys.each {|word|
        if i < WORDS
          @blog_hash.each {|k,v|
            if v['title'] == entry
              if (v['title'] + v['description']).include?(word)
                wordmap[i] += 1
              end
            end
          }
          i += 1
        end
      }
      @word_vector << wordmap
    }

    cluster = Kmeans::HCluster.new
    hcluster = cluster.hcluster(@word_vector)
    # p cluster.printclust(hcluster, entry_list)
    den = Kmeans::Dendrogram.new(:imagefile => OUTIMAGE)
    den.drawdendrogram(hcluster, entry_list)
  end

  private
  def new_entrylist
    entry_list = Array.new
    @blog_hash.each {|k,v|
      entry_list << v['title']
    }
    entry_list
  end

  def new_wordmap
    wordmap = []
    WORDS.times do
      wordmap << 0
    end
    wordmap
  end

  def scoring(title, link, description, count)
    if @blog_hash.has_key?(link)
      @blog_hash[link]['score'] += count.to_i
    else
      @blog_hash[link]['title'] = title
      @blog_hash[link]['score'] = count.to_i
      @blog_hash[link]['description'] = description
    end
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

