#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
# mecab_neologd_example.rb: Default MeCab dictionary against mecab-ipadic-NEologd
#
# Description:
# Compare the default MeCab dictionary against mecab-ipadic-NEologd.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby mecab_neologd_example.rb
#
# Requirements:
# - Ruby
# - MeCab with its Ruby binding and mecab-ipadic-NEologd
# - The user dictionary /home/mecab/dic/custom.dic
#

require 'MeCab'
str = "『アイドルマスター シンデレラガールズ』（THE IDOLM@STER CINDERELLA GIRLS）は、バンダイナムコエンターテインメント（旧バンダイナムコゲームス）とCygamesが開発・運営する『THE IDOLM@STER』の世界観をモチーフとする携帯端末専用のソーシャルゲーム。"

puts "### normal ###"
m = MeCab::Tagger.new
print m.parse(str)

puts "### neologd ###"
dic = File.expand_path("/usr/local/lib/mecab/dic/mecab-ipadic-neologd")
m = MeCab::Tagger.new("-d #{dic}")
print m.parse(str)

puts "### neologd + userdic + chasen ###"
dic = File.expand_path("/usr/local/lib/mecab/dic/mecab-ipadic-neologd")
userdic = File.expand_path("/home/mecab/dic/custom.dic")
m = MeCab::Tagger.new("-Ochasen -u #{userdic} -d #{dic}")
print m.parse(str)
