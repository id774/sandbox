# -*- coding: utf-8 -*-

require 'MeCab'
require 'json'
require 'kmeans/pearson'
require 'kmeans/hcluster'
require 'kmeans/dendrogram'
require 'pp'

class MapReduce
  def map_reduce
    @mecab = MeCab::Tagger.new("-Ochasen")
    @word_list = Array.new
    title = ""
    title_link = ""
    @entry_list = Array.new
    @text_hash = Hash.new
    @word_vector = Array.new
    @hits = {}
    @words = 150
    open("fluent_out.log") do |file|
      file.each do |line|
        JSON.parse(line.scan(/\{.*\}/).join).each {|k,v|
          if k == "title"
            title = v
          end
          if k == "link"
            title_link = title + " " + v
            @entry_list.push(title_link)
          end
          if k == "description"
            @text_hash[title_link] = v
            pickup_nouns(v).each {|word|
              if word.length > 1
                if word =~ /[一-龠]/
                  word_count(word)
                end
              end
            }
          end
        }
      end
    end

    # create wordlist
    i = 0
    @hits.sort_by{|k,v| -v}.each {|k, v|
      i += 1
      @word_list.push(k) if i <= @words
    }

    @entry_list.each {|entry|
      i = 0
      wordmap = new_wordmap
      @word_list.each {|word|
        @text_hash.each {|k, v|
          if k == entry
            wordmap[i] += 1 if v.include?(word)
          end
        }
        i += 1
      }
      @word_vector << wordmap
    }

    pp @entry_list

    cluster = Kmeans::HCluster.new
    hcluster = cluster.hcluster(@word_vector)

    den = Kmeans::Dendrogram.new(:imagefile => 'blog_clusters.png')
    den.drawdendrogram(hcluster, @entry_list)
  end

  private
  def new_wordmap
    wordmap = []
    @words.times do
      wordmap << 0
    end
    wordmap
  end

  def word_count(word)
    @hits.has_key?(word) ? @hits[word] += 1 : @hits[word] = 1
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

