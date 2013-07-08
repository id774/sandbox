#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

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
