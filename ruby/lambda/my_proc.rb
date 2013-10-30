# -*- coding: utf-8 -*-

def run_it_with_param(&block)
  puts("Before the call.")
  block.call(20)
  block.call(10)
  puts("After the call.")
end

my_proc = lambda {|x| puts ("The value of x is #{x}") }
run_it_with_param(&my_proc)

