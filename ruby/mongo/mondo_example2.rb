#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'mongo'

connection = Mongo::Connection.new('localhost',27017)
db = connection.db("test")
coll = db.collection("cars")

p coll.insert({:_id => 1, :maker => 'toyota', :name => '86'})
p coll.insert({:_id => 2, :maker => 'subaru', :name => 'BRZ'})
p coll.insert({:_id => 3, :maker => 'honda', :name => 'NSX', :concept => true})
p coll.insert({:_id => 4, :maker => 'unknown'})

puts "Data inserted"
coll.find().each{|cars|
  puts cars
}

p coll.update({:_id => 3}, {:maker => 'honda', :name => 'Nbox', :concept => false})
p coll.update({:_id => 4}, {"$set" => {:maker => 'mazda', :name => 'takeri', :concept => true}})

p coll.remove({:maker => 'toyota'})

puts "Data updated and deleted"
coll.find().each{|cars|
  puts cars
}

p coll.remove({})

puts "Data nothing"
coll.find().each{|cars|
  puts cars
}

