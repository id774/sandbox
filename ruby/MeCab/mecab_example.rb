#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require 'MeCab'
m = MeCab::Tagger.new
print m.parse("太郎はこの本を二郎を見た女性に渡した。")
