#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require "benchmark"

def lineno_a(path)
  open(path).each{}.lineno
end

def lineno_b(path)
  open(path).read.count("\n")
end

def lineno_wc(path)
  `wc -l #{path}`.to_i
end


def test_lineno(str)
  path = "temp.txt"
  open(path, "w"){|f| f.print str }
  puts "%d, %d, %d" % [ lineno_a(path), lineno_b(path), lineno_wc(path) ]
end

def test_lineno_speed(col, row, t)
  path = "temp.txt"
  open(path, "w"){|f|
    row.times{
      f.puts "x" * col
    }
  }

  Benchmark.bmbm {|x|
    x.report("a :" ) { t.times { lineno_a(path) } }
    x.report("b :" ) { t.times { lineno_b(path) } }
    x.report("wc:") { t.times { lineno_wc(path) } }
  }
end

                      #   a  b  wc
test_lineno( ""     ) #=> 0, 0, 0
test_lineno( "-"    ) #=> 1, 0, 0
test_lineno( "\n"   ) #=> 1, 1, 1
test_lineno( "-\n"  ) #=> 1, 1, 1
test_lineno( "\n-"  ) #=> 2, 1, 1
test_lineno( "-\n-" ) #=> 2, 1, 1

puts "--------------------------------"
test_lineno_speed(100, 100000, 10)
test_lineno_speed(100, 10000, 100)
test_lineno_speed(100, 1000, 1000)
# test_lineno_speed(100, 100, 10000) #=> wc がすごく遅い

puts "--------------------------------"
test_lineno_speed(10,  10000000, 1)
test_lineno_speed(1000,  100000, 1)
test_lineno_speed(100000,  1000, 1)
test_lineno_speed(10000000,  10, 1)
