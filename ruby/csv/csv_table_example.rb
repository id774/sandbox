#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'csv'

table = CSV.table('data.csv')

table.headers # => [:player, :gamea, :gameb]

avgA, avgB = [:gamea, :gameb].map { |e| table[e].inject(:+) / table.size } # => [68.5, 43.1]
p avgA
p avgB
