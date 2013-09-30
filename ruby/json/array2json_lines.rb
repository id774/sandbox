# -*- coding: utf-8 -*-

require 'json'

multi_array = [["test01", "test04"], ["test02"], ["test03", "test05"], ["test06"], []]
multi_array.each {|array|
  hash = {}
  array.each {|word|
    hash[word] = 1
  }
  json = JSON.generate(hash)
  puts json
}

