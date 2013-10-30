# -*- coding: utf-8 -*-

require 'CaboCha'
require 'awesome_print'

cabocha = CaboCha::Parser.new('--charset=UTF8')

sent = "太郎はこの本を二郎を見た女性に渡した。"
tree = cabocha.parse(sent)

tree.toString(4).force_encoding("utf-8").split("\n").each {|line|
  i = 0
  line.strip.split("\t").each {|element|
    puts "#{i},#{element}"
    i += 1
  }
}

