#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'csv'

CSV_PATH = 'sample.csv'

keys = [:name, :age, :height]

CSV.foreach(CSV_PATH, encoding: "SJIS" ) do |row|
  p hashed_row = Hash[*keys.zip(row).flatten] # => {:age=>"30", :height=>"180", :name=>"Yamada"}
  p hashed_row[:name]   # => "Yamada"
  p hashed_row[:age]    # => "30"
  p hashed_row[:height] # => "180"
end
