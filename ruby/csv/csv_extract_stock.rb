#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'csv'
require 'sysadmin'
require 'pp'

CSV_PATH = 'ti_N225.csv'

def create_hash(hash)
  table = CSV.table(File.expand_path(CSV_PATH), encoding: "UTF-8")
  keys = table.headers

  CSV.foreach(File.expand_path(CSV_PATH), encoding: "UTF-8" ) do |row|
    hashed_row = Hash[*keys.zip(row).flatten]
    pri_key = hashed_row[:date]
    unless pri_key == "Date"
      hash[pri_key] =
        {
          "Open"  => hashed_row[:open],
          "High"  => hashed_row[:high],
          "Low"   => hashed_row[:low],
          "Close" => hashed_row[:adj_close]
        }
    end
  end

  return hash
end

def extract
  array = []

  hash = Sysadmin::Util.create_multi_dimensional_hash
  hash = create_hash(hash)

  i = 3
  hash.each do |k, v|
    pp k, v if i < 10
    i += 1
  end
end

if __FILE__ == $0
  extract
end
