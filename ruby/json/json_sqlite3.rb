# -*- coding: utf-8 -*-

require 'active_record'
require 'json'

class Converter
  def initialize(filename, db_path)
    @filename       = filename
    @db_path        = db_path
    prepare_database
  end

  def start
    open(@filename) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        Record.create(
          :key  => key,
          :tag  => tag,
          :json => json
        )
      end
    end
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
    Record
  end

  def column_definition
    {
      :key  => :string,
      :tag  => :string,
      :json => :string
    }
  end

  def create_table
    ActiveRecord::Migration.create_table(model_class.table_name){|t|
      column_definition.each_pair{|column_name, column_type|
        t.column column_name, column_type
      }
    }
  end
end

class Record < ActiveRecord::Base
end

if __FILE__ == $0
  filename = ARGV.shift || "json.txt"
  db_path  = ARGV.shift || "sqlite3.db"
  converter = Converter.new(filename, db_path)
  converter.start
end

