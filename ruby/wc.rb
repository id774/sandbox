#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# wc.rb: Count lines, words, and bytes like wc
#
# Description:
# Count lines, words, and bytes for each file, like wc.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby wc.rb <file>...
#
# Requirements:
# - Ruby
#

lines_total = words_total = bytes_total = 0

ARGV.each{|file|
  begin
    unless File.directory?(file)
      lines = words = bytes = 0
      open(file){|input|
        while line = input.gets
          lines += 1
          bytes += line.size
          words += line.split(nil).size
        end
      }
      printf("%8d %8d %8d %s\n", lines, words, bytes, file)
      lines_total += lines
      words_total += words
      bytes_total += bytes
    end
  rescue SystemCallError
    $stderr.puts "SystemCallError: #$!"
  rescue
    $stderr.puts "Error: #$!"
  end
}
printf("%8d %8d %8d %s\n", lines_total, words_total, bytes_total, "total")
