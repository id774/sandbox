# -*- coding: utf-8 -*-

require 'active_record'

class Record < ActiveRecord::Base
end

class Storage
  def get
    prepare_database
    records = model_class.find(:all)
    hash = Hash.new
    require 'pp'
    records.each {|record|
      hash[record.ip] = record.host
    }
    hash
  end

  def put(hosts)
    @records = hosts
    for_each_new_record {|ip, host|
      Record.create(
        :ip => ip,
        :host => host
      )
    }
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
    Record
  end

  def db_dir
    #File.join(File.dirname(__FILE__), '..', 'db')
    File.join(File.dirname(__FILE__))
  end

  def column_definition
    {
      :ip => :string,
      :host => :string,
    }
  end

  def unique_key
    :ip
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
    prepare_database
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
