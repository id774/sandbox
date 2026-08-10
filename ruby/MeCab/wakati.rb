#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Segment a sentence into words with MeCab.

$KCODE = 'u'
require 'MeCab'

wakati = MeCab::Tagger.new('-O wakati')
puts wakati.parse('最近の夜は寒い')
