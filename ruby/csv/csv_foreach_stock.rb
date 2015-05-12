#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'csv'

CSV.foreach('ti_N225.csv') do |bo|
  print bo, "\n"
end
