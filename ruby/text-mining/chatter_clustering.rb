# -*- coding: utf-8 -*-

require 'MeCab'
require 'sqlite3'
require 'kmeans/pearson'
require 'kmeans/hcluster'
require 'kmeans/dendrogram'

class MapReduce
  def map_reduce
    @mecab = MeCab::Tagger.new("-Ochasen")
    @word_list = Array.new
    @account_list = Array.new
    @text_hash = Hash.new
    @word_vector = Array.new
    @hits = {}

    db = SQLite3::Database.new(Storage.db_filename)

    db.execute(Storage.select_body).each {|row|
      pickup_nouns(row[0]).each {|word|
        if word.length > 1
          if word =~ /[一-龠]/
            word_count(word)
          end
        end
      }
    }

    i = 0
    @hits.sort_by{|k,v| -v}.each {|k, v|
      i += 1
      @word_list.push(k) if i <= 100
    }

    db.execute(Storage.select_user).each {|row|
      user_fullname = row[0]+row[1]
      @account_list.push(user_fullname)
      @text_hash[row[2]] = user_fullname
    }
    @account_list = @account_list.uniq!.sort

    @account_list.each {|account|
      i = 0
      wordmap = new_wordmap
      @word_list.each {|word|
        @text_hash.each {|k, v|
          if v == account
            wordmap[i] += 1 if k.include?(word)
          end
        }
        i += 1
      }
      @word_vector << wordmap
    }

    cluster = Kmeans::HCluster.new
    hcluster = cluster.hcluster(@word_vector)

    den = Kmeans::Dendrogram.new(:imagefile => 'clusters.png')
    den.drawdendrogram(hcluster, @account_list)

    db.close
  end

  private
  def new_wordmap
    wordmap = []
    100.times do
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

class Storage
  class << self
    def db_filename
      db_name = 'chatter.db'
      File.expand_path(File.join(File.dirname(__FILE__), db_name))
    end

    def select_body
      "select
       feedposts.Body
       from feedposts"
    end

    def select_user
      "select
       users.LastName,
       users.FirstName,
       feedposts.Body
       from feedposts left join users on (feedposts.CreatedById = users.Id)"
    end
  end
end

map_reduce = MapReduce.new
map_reduce.map_reduce

