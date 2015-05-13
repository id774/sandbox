#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'csv'

arr = []
CSV.foreach('ti_N225.csv') do |row|
  unless row[0] == "Date"
    arr << row
  end
end

5.times do
  a = arr.pop
  p a[0]
  p a[1]
  p a[2]
  p a[3]
  p a[4]
end
