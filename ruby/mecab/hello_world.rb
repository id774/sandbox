#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require 'MeCab'
m = MeCab::Tagger.new
print m.parse("昨日、急に思い立ってザリガニを飼ってみた。")
print m.parse("Hello World!!")
