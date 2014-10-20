#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

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
