#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# wakati.rb: Segment a sentence into words with MeCab
#
# Description:
# Segment a sentence into words with MeCab.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby wakati.rb
#
# Requirements:
# - Ruby
# - MeCab with its Ruby binding
#

$KCODE = 'u'
require 'MeCab'

wakati = MeCab::Tagger.new('-O wakati')
puts wakati.parse('最近の夜は寒い')
