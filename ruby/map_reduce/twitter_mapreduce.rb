# -*- coding: utf-8 -*-
require 'active_record'
require 'MeCab'


class MapReduce
  def map_reduce
    mapper_hash = {}
    hits = {}
    statuses = Storage.new.get
    mecab = MeCab::Tagger.new
    statuses.each {|status|
      line = Mapper.mapper(mecab.parseToNode(status.text))
      # Reducer
      hits.has_key?(line) ? hits[line] += 1 : hits[line] = 1
    }
    i = 0
    hits.sort_by{|k,v| -v}.each {|k, v|
      i = i + 1
      puts "#{i.to_s}\t#{k}\t#{v}\n"
    }
  end
end


class Mapper
  def self.countup out
    out.length > 1 ? @text << out : nil if out
  end

  def self.mapper(node)
    @text = ""
    out = nil
    while node
      category = node.feature.force_encoding("utf-8").split(',')[0]
      word = (category == '名詞' ? node.surface.force_encoding("utf-8") : nil)
      node = node.next
      if word !~ /[^!-@\[-`{-~　「」]/
        countup out
        out = nil
      elsif !out
        out = word
      elsif out =~ /\W$/ && word =~ /^\W/
        out << word
      else
        countup out
        out = word
      end
    end
    countup out
    @text.length > 0 ? @text : nil
  end
end


class Status < ActiveRecord::Base
end


class Storage
  def get
    prepare_database
    # model_class.all
    model_class.limit(2000)
  end

  def drop
    prepare_database
    drop_table
  end

  private
  def prepare_database
    db = File.join(db_dir, 'sqlite3.db')
    ActiveRecord::Base.establish_connection(
      :adapter  => "sqlite3",
      :database => db
    )
    create_table unless model_class.table_exists?
  end

  def model_class
    Status
  end

  def db_dir
    File.dirname(__FILE__)
  end

  def column_definition
    {
      :uid => :integer,
      :screen_name => :string,
      :text => :string,
      :created_at => :datetime,
      :protected => :boolean,
      :in_reply_to_status_id => :integer,
      :in_reply_to_user_id => :integer,
      :in_reply_to_screen_name => :string,
      :statuses_count => :integer,
      :friends_count => :integer,
      :followers_count => :integer,
      :source => :string,
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

