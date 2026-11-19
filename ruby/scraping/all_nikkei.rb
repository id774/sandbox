#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# all_nikkei.rb: Word counts across collected articles
#
# Description:
# Count the words across the collected articles.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby all_nikkei.rb
#
# Requirements:
# - Ruby
# - all.nikkei in the current directory
#

$KCODE = 'u'
system("cat *.txt > all.nikkei")
text = open("all.nikkei").read
regex = /[一-龠]+|[ぁ-ん]+|[ァ-ヴー]+|[a-zA-Z0-9]+|[ａ-ｚＡ-Ｚ０-９]+/
words = text.scan regex
counts = Hash.new(0)
words.each{|e| counts[e] = counts[e] + 1 }
sorted = counts.to_a.sort {|a,b| b[1] <=> a[1]}
sorted.each{|e| puts "#{e[0]}=>#{e[1]}"}
puts "-" * 10
puts words.size
