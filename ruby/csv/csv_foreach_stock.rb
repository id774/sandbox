#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'csv'

i = 0
CSV.foreach('ti_N225.csv') do |row|
  if i < 5
    unless row[0] == "Date"
      p row[0]
      p row[1]
      p row[2]
      p row[3]
      p row[4]
      i += 1
    end
  end
end
