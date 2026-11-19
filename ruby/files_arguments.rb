# -*- coding: utf-8 -*-
# files_arguments.rb: Open each file matched by a glob argument
#
# Description:
# Open each file matched by a glob given on the command line.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby files_arguments.rb '<glob>'
#
# Requirements:
# - Ruby
#

class MainClass
  def initialize(args)
    @infiles = args.shift || ""
  end

  def main
    Dir.glob(@infiles).each do |infile|
      open(infile) do |file|
        p infile
        file.each_line do |line|
        end
      end if FileTest.file?(infile)
    end
  end
end

if __FILE__ == $0
  m = MainClass.new(ARGV)
  m.main
end

