# -*- coding: utf-8 -*-

require 'optparse'
require 'kconv'

regexp = '';
OptionParser.new {|opt|
  opt.on('-e VAL', '--regexp VAL') {|v| regexp = v.toutf8}
  opt.parse!(ARGV)
}
rule = Regexp.new(regexp)
dispFilename = (ARGV.size > 1)
while line = ARGF.gets
  next unless rule =~ line.toutf8
  print ARGF.filename + ':' if dispFilename
  print line
end
