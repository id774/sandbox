#!/usr/bin/env ruby
# merge.rb: Merge the eleventh log field into one file
#
# Description:
# Merge the eleventh field of every log file under the directory given as an
# argument into tempfile.txt.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby merge.rb <log directory>
#
# Requirements:
# - Ruby
# - The sysadmin gem
#

require 'sysadmin'

def open_file(file, out)
  open(file) {|f|
    while l = f.gets
      field = l.split(" ")
      out.puts field[10]
    end
  }
end

def open_files
  open("tempfile.txt", "w") { |out|
    Dir.filelist(ARGV[0]).each {|file|
      open_file(file, out)
    }
  }
end

if __FILE__ == $0
  if ARGV.size >= 1
    open_files
  else
    puts "#{__FILE__} [dir]"
  end
end
