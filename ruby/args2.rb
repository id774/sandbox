#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

def hoge2(arg1, arg2 = '', *args)
  puts "arg1=#{arg1}"
  puts "arg2=#{arg2}"
  args.each_index{|i|
    puts "args[#{i}]=#{args[i]}"
  }
end

hoge2('hello', 'my', 'friend', '!')

array = ['hello', 'my', 'friend', '!']
hoge2(*array)
