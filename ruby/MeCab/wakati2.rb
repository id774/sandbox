#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# wakati2.rb: Segment every line of a file with MeCab
#
# Description:
# Segment every line of a file into words with MeCab. The input defaults to
# input.txt.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby wakati2.rb [input file]
#
# Requirements:
# - Ruby
# - MeCab with its Ruby binding
#

$KCODE = 'u'
require 'MeCab'

def wakati(args)
  infile = args.shift || "input.txt"
  wakati = MeCab::Tagger.new('-O wakati')

  open(infile) do |file|
    file.each_with_index do |line, i|
      puts wakati.parse(line)
    end
  end
end


if __FILE__ == $0
  wakati(ARGV)
end
