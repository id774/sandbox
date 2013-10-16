#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

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
