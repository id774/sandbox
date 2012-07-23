#!/usr/bin/ruby
# -*- coding: utf-8 -*-

$KCODE = 'u'
require 'MeCab'

wakati = MeCab::Tagger.new('-O wakati')
puts wakati.parse('最近の夜は寒い')
