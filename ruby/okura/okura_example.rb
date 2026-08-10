#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Segment Japanese text with the okura tagger.

require 'okura/serializer'

dict_dir='/home/debian/tmp/okura-dic'
require 'pp'
tagger=Okura::Serializer::FormatInfo.create_tagger dict_dir

str='そうやって達成された革命の気高い志も、その後は官僚主義と大衆に飲み込まれてしまう。'

# Compute the candidate words
nodes=tagger.parse(str)

# Pick the most likely combination among the candidates
nodes.mincost_path.each{|node|
  word=node.word
  pp word.surface # the surface form of the word
  pp word.left.text # the part of speech
  # A word has both left and right parts of speech, but the dictionaries in
  # general use, IPA and NAIST, hold the same data in both
}
