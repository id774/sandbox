#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# csv_foreach_stock.rb: Stock price rows read with CSV.foreach
#
# Description:
# Read the stock price rows of ti_N225.csv with CSV.foreach, skipping the
# header.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby csv_foreach_stock.rb
#
# Requirements:
# - Ruby
# - ti_N225.csv in the current directory
#

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
