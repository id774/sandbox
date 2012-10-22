#!/usr/bin/env ruby

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
