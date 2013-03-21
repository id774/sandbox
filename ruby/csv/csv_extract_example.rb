#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

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
