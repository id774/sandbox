#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'csv'
require 'json'

class Converter
  def initialize(csv_path, filename)
    @csv_path       = csv_path
    @filename       = filename
  end

  def start
    open(File.join(File.expand_path(@filename)), "w") {|f|
      table = CSV.table(File.expand_path(@csv_path), encoding: "UTF-8")
      keys = table.headers
      id = 1

      CSV.foreach(File.expand_path(@csv_path), encoding: "UTF-8" ) {|row|
        hash = Hash[*keys.zip(row).flatten]
        f.write (id.to_s + "\t" +
                 @csv_path + "\t" +
                 hash.to_json + "\n") unless hash.nil?
        id += 1
      }
    }
  end
end

if __FILE__ == $0
  csv_path = ARGV.shift || "data.csv"
  filename = ARGV.shift || "out.txt"
  converter = Converter.new(csv_path, filename)
  converter.start
end
