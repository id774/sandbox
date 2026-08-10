#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Collect every argument into a splat parameter.

def hoge1(*args)
  args.each_index{|i|
    puts "args[#{i}]=#{args[i]}"
  }
end

hoge1('hello', 'my', 'friend')
