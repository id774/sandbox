#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

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
