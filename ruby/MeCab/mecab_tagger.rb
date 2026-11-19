# -*- encoding: utf-8 -*-
# mecab_tagger.rb: Taggers created from one shared MeCab model
#
# Description:
# Create taggers repeatedly from one shared MeCab model.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby mecab_tagger.rb
#
# Requirements:
# - Ruby
# - MeCab with its Ruby binding
#

require 'MeCab'

mecab_options = "-Ochasen"
mecab_model = MeCab::Model.create(mecab_options)

10.times do
  tagger = mecab_model.createTagger
  p tagger.parse("太郎はこの本を二郎を見た女性に渡した。")
end
