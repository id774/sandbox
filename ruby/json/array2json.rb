# -*- coding: utf-8 -*-

require 'json'

multi_array = [["test01", "test04"], ["test02"], ["test03", "test05"], ["test06"], []]
i = 0
hash = {}
multi_array.each {|array|
  array.each {|word|
    hash[word] = i
  }
  i += 1
}
json = JSON.generate(hash)
puts json

