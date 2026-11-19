#!/usr/bin/env ruby
# wc4zip.rb: Line counts and sizes of files inside zip archives
#
# Description:
# Count the lines and sizes of the files under a directory, including the
# files inside zip archives, and print a total. A second argument limits the
# search to the top directory.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby wc4zip.rb <directory> [top-only flag]
#
# Requirements:
# - Ruby
# - The zipruby and sysadmin gems
#

require 'zipruby'
require 'tempfile'
require 'sysadmin'

@total_lines = 0
@total_size = 0

def get_linesize(path)
  line = open(path).each{}.lineno
  @total_lines += line
  return line
end

def get_filesize(path)
  size = File.size(path)
  @total_size += size
  return size
end

def unzip(src)
  Zip::Archive.open(src) do |a|
    a.each do |f|
      tempfile = Tempfile::new(f.name)
      tempfile.print(f.read)
      puts "#{get_linesize(tempfile.path)}\t#{get_filesize(tempfile.path)}\t#{f.name}"
      tempfile.close
    end
  end
end

def wc(subdir=true)
  subdir = false unless ARGV[1].nil?
  Dir.filelist(ARGV[0], subdir).each {|f|
    if f =~ /\.zip\Z/
      unzip(f)
    else
      puts "#{get_linesize(f)}\t#{get_filesize(f)}\t#{f}"
    end
  }
  puts "#{@total_lines}\t#{@total_size}\t#{ARGV[0]}\t[Total]"
end

if __FILE__ == $0
  unless ARGV[0].nil?
    wc
  else
    puts "Syntax: wc4zip zipdir"
  end
end
