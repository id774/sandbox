#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require 'MeCab'
str = "THE IDOLM@STER CINDERELLA GIRLS"

puts "### normal ###"
m = MeCab::Tagger.new
print m.parse(str)

puts "### neologd ###"
dic = File.expand_path("/usr/local/lib/mecab/dic/mecab-ipadic-neologd")
m = MeCab::Tagger.new("-d #{dic}")
print m.parse(str)

puts "### neologd + userdic + chasen ###"
dic = File.expand_path("/usr/local/lib/mecab/dic/mecab-ipadic-neologd")
userdic = File.expand_path("/home/mecab/dic/custom.dic")
m = MeCab::Tagger.new("-Ochasen -u #{userdic} -d #{dic}")
print m.parse(str)
