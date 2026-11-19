#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
# mecab_example.rb: MeCab analysis of a sentence
#
# Description:
# Print the MeCab analysis of a sentence.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby mecab_example.rb
#
# Requirements:
# - Ruby
# - MeCab with its Ruby binding
#

require 'MeCab'
m = MeCab::Tagger.new
print m.parse("太郎はこの本を二郎を見た女性に渡した。")
