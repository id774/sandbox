# -*- coding: utf-8 -*-

require 'active_record'
require 'json'
require 'time'

class Converter
  def initialize(args)
    @db_path  = args.shift || "sqlite3.db"
    @filename = args.shift || "out.txt"
    @tag      = args.shift || "twitter.statuses"
    @load_protected = false
    @filename       = filename
  end

  def start
    open(File.join(File.expand_path(@filename)), "w") {|f|
      statuses = Storage.new(@db_path).get
      statuses.each {|status|
        hash = nil
        if status.protected == false or @load_protected == true
          hash = {
            "uid"                     => status.uid,
            "screen_name"             => status.screen_name,
            "id_str"                  => status.id_str,
            "text"                    => status.text.force_encoding("utf-8"),
            "created_at"              => status.created_at,
            "protected"               => status.protected,
            "in_reply_to_status_id"   => status.in_reply_to_status_id,
            "in_reply_to_user_id"     => status.in_reply_to_user_id,
            "in_reply_to_screen_name" => status.in_reply_to_screen_name,
            "statuses_count"          => status.statuses_count,
            "friends_count"           => status.friends_count,
            "followers_count"         => status.followers_count,
            "source"                  => status.source.force_encoding("utf-8"),
          }
          timestamp = Time.now.instance_eval { '%s.%03d' % [strftime('%Y%m%d%H%M%S'), (usec / 1000.0).round] }
          id = timestamp + "," + status.screen_name + "," + status.uid.to_s
          f.write (id + "\t" +
                   @tag + "\t" +
                   hash.to_json + "\n") unless hash.nil?
        end
      }
    }
  end
end

class Status < ActiveRecord::Base
end

class Storage
  def initialize(db_path)
    @db_path = db_path
    prepare_database
  end

  def get
    model_class.all
  end

  def drop
    drop_table
  end

  private
  def prepare_database
    db = File.join(File.expand_path(@db_path))
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
    File.join(File.dirname(__FILE__))
  end

  def column_definition
    {
      :uid => :integer,
      :screen_name => :string,
      :id_str => :string,
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
      column_definition.each_pair{|column_name, column_type|
        t.column column_name, column_type
      }
    }
  end

  def drop_table
    ActiveRecord::Migration.drop_table(model_class.table_name)
  end

  def for_each_new_record
    existing_records = model_class.find(:all)
    @result = {}
    @records.each {|key, value|
      unless key.nil?
        new_key = false
        unless existing_records.detect{|b|b.try(unique_key) == key}
          yield(key, value)
          new_key = true
        end
        @result[key] = value if new_key
      end
    }
    @result
  end
end

if __FILE__ == $0
  converter = Converter.new(ARGV)
  converter.start
end

