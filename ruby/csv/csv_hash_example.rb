#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# csv_hash_example.rb: Hashes from CSV rows and fixed keys
#
# Description:
# Zip each row of sample.csv against fixed keys to build a hash.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby csv_hash_example.rb
#
# Requirements:
# - Ruby
# - sample.csv in the current directory
#

require 'csv'

CSV_PATH = 'sample.csv'

keys = [:name, :age, :height]

CSV.foreach(CSV_PATH, encoding: "SJIS" ) do |row|
  p hashed_row = Hash[*keys.zip(row).flatten] # => {:age=>"30", :height=>"180", :name=>"Yamada"}
  p hashed_row[:name]   # => "Yamada"
  p hashed_row[:age]    # => "30"
  p hashed_row[:height] # => "180"
end
