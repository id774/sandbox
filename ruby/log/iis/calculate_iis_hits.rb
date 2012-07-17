#!/usr/bin/env ruby

require 'sysadmin'

def report(file, lines, fields, ipHitListing)
  puts "file: #{file}"
  puts "lines: #{lines}"
  puts "fields: #{fields}"
  puts "ipHitListing: #{ipHitListing}"
end

def open_file(file)
  lines = fields = 0
  ipHitListing = Hash.new
  ipHitListing.default = 0
  open(file) {|f|
    while l = f.gets
      field = l.split(" ")
      ip = field[10]
      ipHitListing[ip] = ipHitListing[ip] + 1
      lines += 1
      fields += field.size
    end
  }
  report(file, lines, fields, ipHitListing)
end

def open_files
  Dir.filelist(ARGV[0]).each {|file|
    open_file(file)
  }
end

if __FILE__ == $0
  if ARGV.size >= 1
    open_files
  else
    puts "#{__FILE__} [dir]"
  end
end
