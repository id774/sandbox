#!/usr/bin/env ruby
# word_frequency.rb: Word frequencies of a fixed sentence
#
# Description:
# Count the words of a fixed text, most frequent first and alphabetically within a tie.
#
# Part of the basics cross-language exercise set: the input is fixed in the
# source, and the output is the same as that of the same exercise in every
# other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby word_frequency.rb
#
# Requirements:
# - Ruby 3.0 or later
# - No third-party package is required

TEXT = 'the quick brown fox jumps over the lazy dog the fox barks'

TEXT.split.tally.sort_by { |word, count| [-count, word] }.each do |word, count|
  puts "#{word} #{count}"
end
