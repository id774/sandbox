# -*- coding: utf-8 -*-
# grep.rb: Filter input lines by a regular expression
#
# Description:
# Filter input lines by a regular expression given with -e, reading the files
# given as arguments or standard input and prefixing each match with its file
# name when several files are given.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby grep.rb -e <regexp> [file...]
#
# Requirements:
# - Ruby with optparse and kconv
#

require 'optparse'
require 'kconv'

regexp = '';
OptionParser.new {|opt|
  opt.on('-e VAL', '--regexp VAL') {|v| regexp = v.toutf8}
  opt.parse!(ARGV)
}

rule = Regexp.new(regexp, Regexp::IGNORECASE)

dispFilename = (ARGV.size > 1)

while line = ARGF.gets
  next unless rule =~ line.toutf8
  print ARGF.filename + ':' if dispFilename
  print line
end
