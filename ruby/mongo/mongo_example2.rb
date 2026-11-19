#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# mongo_example2.rb: Insert, query, and update MongoDB documents
#
# Description:
# Insert, query, and update documents in a MongoDB collection.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby mongo_example2.rb
#
# Requirements:
# - Ruby
# - The mongo gem before 2.0, which provides Mongo::Connection
# - A MongoDB server on localhost:27017
#

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

