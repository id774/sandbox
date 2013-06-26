# -*- coding: utf-8 -*-
require 'active_support'
require 'active_record'
require 'MeCab'

DB_NAME       = "fulltext.db"
WORDCOUNT_TXT = "wordcount.txt"
PICKUP_DATE   = '2013-06-24'

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
        num, word, count = line.strip.split("\t")
        @text_hash[word] = count if count.to_i >= 1
      end
    end

    blogs = Storage.new

    blogs.get.each {|blog|
      pickup_nouns(blog.title + blog.description).each {|word|
        if word.length > 1
          if word =~ /[亜-腕]/
            if @text_hash.has_key?(word)
              scoring(blog.id, blog.title, blog.link, @text_hash[word])
            end
          end
        end
      }
    }

    @blog_hash.sort_by{|k,v| -v['score']}.each {|k, v|
      puts "#{v['score'].to_s}\t#{v['title']}\t#{v['link']}\n"
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

  def scoring(id, title, link, count)
    if @blog_hash.has_key?(id)
      @blog_hash[id]['score'] += count.to_i
    else
      @blog_hash[id]['title'] = title
      @blog_hash[id]['link'] = link
      @blog_hash[id]['score'] = count.to_i
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


class Blog < ActiveRecord::Base
end

class Storage

  def initialize
    prepare_database
  end

  def get
    # model_class.all
    model_class
      .where('created_at > ?', PICKUP_DATE)
  end

  def drop
    prepare_database
    drop_table
  end

  private
  def prepare_database
    db = File.join(db_dir, DB_NAME)
    ActiveRecord::Base.establish_connection(
      :adapter  => "sqlite3",
      :database => db
    )
    create_table unless model_class.table_exists?
  end

  def model_class
    Blog
  end

  def db_dir
    File.dirname(__FILE__)
  end

  def column_definition
    {
      :title => :string,
      :link => :string,
      :description => :string,
      :content => :string,
      :created_at => :datetime,
    }
  end

  def unique_key
    :id
  end

  def create_table
    ActiveRecord::Migration.create_table(model_class.table_name){|t|
      column_definition.each_pair {|column_name, column_type|
        t.column column_name, column_type
      }
    }
  end

  def drop_table
    ActiveRecord::Migration.drop_table(model_class.table_name)
  end
end

map_reduce = MapReduce.new
map_reduce.map_reduce

