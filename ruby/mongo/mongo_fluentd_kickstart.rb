#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# mongo_fluentd_kickstart.rb: Inspect collections written by fluentd
#
# Description:
# Inspect the collections fluentd writes into MongoDB.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby mongo_fluentd_kickstart.rb
#
# Requirements:
# - Ruby
# - The mongo gem before 2.0, which provides Mongo::Connection
# - A MongoDB server on localhost:27017
#

require 'mongo'

mongo = Mongo::Connection.new('localhost', 27017)

db = mongo.db('fluentd')
coll = db.collection('fluentd')

puts "-- mongodb database list --"
mongo.database_names.each {|db_name|
  puts db_name
}

puts "-- write test --"
coll.insert({:name => 'yamada', :age => 20})
coll.find({:name => 'yamada'})
coll.find.each {|row|
  puts row
}

puts "-- remove test data --"
p coll.remove({})

puts "-- data removed --"
coll.find().each {|row|
  puts row
}
