#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# mongo_example.rb: List databases and insert a MongoDB document
#
# Description:
# List databases and insert a document into MongoDB.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby mongo_example.rb
#
# Requirements:
# - Ruby
# - The mongo gem before 2.0, which provides Mongo::Connection
# - A MongoDB server on localhost:27017
#

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
