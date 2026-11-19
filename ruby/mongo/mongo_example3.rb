#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# mongo_example3.rb: Store and read a file with MongoDB GridFS
#
# Description:
# Read and write a file through MongoDB GridFS in the gridtest database. The
# comment below shows how to prepare the 1MB.file test data.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby mongo_example3.rb
#
# Requirements:
# - Ruby
# - The mongo gem before 2.0, which provides Mongo::Connection
# - A MongoDB server on localhost
#

# [setup]
# dd if=/dev/zero of=1MB.file bs=1M count=1
# mongofiles -d gridtest put 1MB.file

require  'mongo'

db_name = "gridtest"
@con = Mongo::Connection.new
@db = @con[db_name]
@grid = Mongo::Grid.new(@db)
@collection = @db["fs.files"]

file_id = @grid.put(File.binread("1MB.file"),
                    :filename => "1MB.file",
                    :tags => ["mongo","database","book"],
                    :memo => "sample file",
                    :owner => "yamada")

puts "get file_id=#{file_id}"
puts "filename = #{@grid.get(file_id).filename}"
puts ""

@collection.find({:_id => BSON::ObjectId(file_id.to_s)}).each{ |doc|
  puts doc.inspect
}

puts ""
puts "delete file_id=#{file_id}"
@grid.delete(file_id)

