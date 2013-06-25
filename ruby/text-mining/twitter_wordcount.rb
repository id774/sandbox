# -*- coding: utf-8 -*-

require 'MeCab'
require 'active_record'

class MapReduce
  def map_reduce
    @mecab = MeCab::Tagger.new("-Ochasen")
    @hits = {}
    statuses = Storage.new.get
    statuses.each {|status|
      mapper(status.text).each {|word|
        if word.length > 1
          if word =~ /[亜-腕]/
            reducer(word)
          end
        end
      }
    }
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

