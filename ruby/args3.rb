#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

def hoge3(arg1, options={})
  values = {'name' => 'anonymous', 'sex' => 'not known'}
  values.merge!(options)
  puts "arg1=#{arg1}"
  values.each{|k,v|
    puts "#{k}=#{v}"
  }
end
 
hoge3('hello', { 'name' => 'Alice' })
hoge3('hello', 'name' => 'Alice', 'sex' => 'Female', 'age' => 12)
