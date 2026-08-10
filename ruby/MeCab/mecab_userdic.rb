#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
# Compare analysis with and without a user dictionary.

require 'MeCab'

m = MeCab::Tagger.new
print m.parse("クラウド")

userdic_path = "custom.dic"
c = MeCab::Tagger.new("-u #{userdic_path}")
print c.parse("クラウド")
