# -*- encoding: utf-8 -*-
# Create taggers repeatedly from one shared MeCab model.

require 'MeCab'

mecab_options = "-Ochasen"
mecab_model = MeCab::Model.create(mecab_options)

10.times do
  tagger = mecab_model.createTagger
  p tagger.parse("太郎はこの本を二郎を見た女性に渡した。")
end
