#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

my_var = "Success"

MyClass = Class.new do
  puts "Class: #{my_var}"

  define_method :my_method do
    puts "Method: #{my_var}"
  end

end

myclass = MyClass.new
myclass.my_method

