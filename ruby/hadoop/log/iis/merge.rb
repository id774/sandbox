#!/usr/bin/env ruby

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
