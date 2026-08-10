#!/usr/bin/env ruby
# Rewrite a file in upper case through a temporary file.

require 'tempfile'

temp = Tempfile::new("foobar")

open("foo.txt") {|f|
  f.each {|line|
    line.upcase!
    temp.puts(line)
  }
}

temp.close
temp.open

open("foo.txt", "w") {|f| temp.each {|line| f.puts(line) }}

temp.close(true)
