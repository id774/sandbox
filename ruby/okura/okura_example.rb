#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'okura/serializer'

dict_dir='/home/debian/tmp/okura-dic'
require 'pp'
tagger=Okura::Serializer::FormatInfo.create_tagger dict_dir

str='そうやって達成された革命の気高い志も、その後は官僚主義と大衆に飲み込まれてしまう。'

# 単語候補計算
nodes=tagger.parse(str)

# 単語候補の中で､一番最もらしい組み合わせを選択
nodes.mincost_path.each{|node|
  word=node.word
  pp word.surface # 単語の表記
  pp word.left.text # 品詞
  # 品詞はword.leftとword.rightがありますが､一般的に使われる辞書(IPA辞書やNAIST辞書)では
  # 両方同じデータが入ってます
}
