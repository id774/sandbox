# -*- coding: utf-8 -*-

require 'json'
require 'date'
require 'MeCab'

PICKUP_DATE   = (Date.today - 1).strftime("%Y%m%d")
LOG_NAME      = "news.log.#{PICKUP_DATE}_0.log"
WORDCOUNT     = "wordcount_#{PICKUP_DATE}.txt"
HOT_NEWS      = "hotnews_#{PICKUP_DATE}.txt"
LOG_PATH      = "/root/.fluent/log"
WORDCOUNT_TXT = File.expand_path(File.join(LOG_PATH, WORDCOUNT))
INFILE        = File.expand_path(File.join(LOG_PATH, LOG_NAME))
OUTFILE       = File.expand_path(File.join(LOG_PATH, HOT_NEWS))

class MapReduce
  def map_reduce
    @mecab = MeCab::Tagger.new("-Ochasen")
    @text_hash = Hash.new
    @blog_hash = Hash.new{ |h,k| h[k] = Hash.new(&h.default_proc) }

    @word_vector = Array.new
    @hits = {}
    @words = 150
    open(WORDCOUNT_TXT) do |file|
      file.each_line do |line|
        num, word, count = line.force_encoding("utf-8").strip.split("\t")
        @text_hash[word] = count if count.to_i >= 1
      end
    end

    open(INFILE) do |file|
      file.each do |line|
        blog = JSON.parse(line.force_encoding("utf-8").scan(/\{.*\}/).join, {:symbolize_names => true})
        pickup_nouns(blog[:title] + blog[:description]).each {|word|
          if word.length > 1
            if word =~ /[亜-腕]/
              if @text_hash.has_key?(word)
                scoring(blog[:title], blog[:link], @text_hash[word])
              end
            end
          end
        }
      end
    end

    open(OUTFILE, "w"){|f|
      i = 0
      @blog_hash.sort_by{|k,v| -v['score']}.each {|k, v|
        f.write("#{i.to_s}\t#{v['score'].to_s}\t#{v['title']}\t#{k}\n")
        i = i + 1
      }
    }
  end

  private
  def new_wordmap
    wordmap = []
    @words.times do
      wordmap << 0
    end
    wordmap
  end

  def scoring(title, link, count)
    if @blog_hash.has_key?(link)
      @blog_hash[link]['score'] += count.to_i
    else
      @blog_hash[link]['title'] = title
      @blog_hash[link]['score'] = count.to_i
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

