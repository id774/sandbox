#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
# mecab_userdic.rb: Analysis with and without a user dictionary
#
# Description:
# Compare analysis with and without a user dictionary.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby mecab_userdic.rb
#
# Requirements:
# - Ruby
# - MeCab with its Ruby binding
# - The user dictionary custom.dic in the current directory
#

require 'MeCab'

m = MeCab::Tagger.new
print m.parse("クラウド")

userdic_path = "custom.dic"
c = MeCab::Tagger.new("-u #{userdic_path}")
print c.parse("クラウド")
