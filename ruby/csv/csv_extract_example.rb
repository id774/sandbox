#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# csv_extract_example.rb: Shift_JIS CSV rows as header-keyed hashes
#
# Description:
# Load the Shift_JIS data.csv into hashes keyed by its header row.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby csv_extract_example.rb
#
# Requirements:
# - Ruby with the sysadmin gem
# - data.csv in the current directory
#

require 'csv'
require 'sysadmin'
require 'pp'

CSV_PATH = 'data.csv'

def create_hash(hash)
  table = CSV.table(File.expand_path(CSV_PATH), encoding: "SJIS")
  keys = table.headers

  CSV.foreach(File.expand_path(CSV_PATH), encoding: "SJIS" ) do |row|
    hashed_row = Hash[*keys.zip(row).flatten]
    pri_key = hashed_row[:player]
    unless pri_key == "player"
      hash[pri_key] =
        {
          "gameA" => hashed_row[:gamea],
          "gameB" => hashed_row[:gameb]
        }
    end
  end

  return hash
end

def extract
  hash = Sysadmin::Util.create_multi_dimensional_hash
  hash = create_hash(hash)

  pp hash
end

if __FILE__ == $0
  extract
end
