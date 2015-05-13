#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'csv'

arr = []
CSV.foreach('ti_N225.csv') do |row|
  unless row[0] == "Date"
    arr << [row[0], row[1], row[2], row[3], row[4]]
  end
end

5.times do
  a = arr.pop
  p a
end
