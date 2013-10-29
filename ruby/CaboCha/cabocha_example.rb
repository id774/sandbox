# -*- coding: utf-8 -*-

require 'CaboCha'

cabocha = CaboCha::Parser.new('--charset=UTF8')

#sent = "サッカーワールドカップで、日本はデンマークに快勝した。"
sent = "太郎はこの本を二郎を見た女性に渡した。"

puts "puts sent"
puts sent

puts "puts cabocha.parseToString(sent)"
puts cabocha.parseToString(sent)

tree = cabocha.parse(sent)
puts "puts tree.toString(0)"
puts tree.toString(0)
puts "puts tree.toString(1)"
puts tree.toString(1)
puts "puts tree.toString(2)"
puts tree.toString(2)
puts "puts tree.toString(3)"
puts tree.toString(3)
puts "puts tree.toString(4)"
puts tree.toString(4)
puts "puts tree.toString(5)"
puts tree.toString(5)

