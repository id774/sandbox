#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# csv_table_example.rb: Average two columns read through CSV.table
#
# Description:
# Average two columns of data.csv read through CSV.table.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby csv_table_example.rb
#
# Requirements:
# - Ruby
# - data.csv in the current directory
#

require 'csv'

table = CSV.table('data.csv')

table.headers # => [:player, :gamea, :gameb]

avgA, avgB = [:gamea, :gameb].map { |e| table[e].inject(:+) / table.size } # => [68.5, 43.1]
p avgA
p avgB
