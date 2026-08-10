#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# List databases and insert a document into MongoDB.

require 'rubygems'
require 'mongo'

m = Mongo::Connection.new('localhost', 27017)

m.database_names.each{|db_name|
  puts db_name
}

db = m.db('testdb')

db['users'].insert({
  :name => 'yamada',
  :age => 20
})

puts db['users'].count
p db['users'].find({:name => 'yamada'})
