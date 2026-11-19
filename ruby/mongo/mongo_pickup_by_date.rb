#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# mongo_pickup_by_date.rb: MongoDB documents inside a date range
#
# Description:
# Select MongoDB documents that fall inside a date range.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby mongo_pickup_by_date.rb
#
# Requirements:
# - Ruby
# - The mongo gem before 2.0, which provides Mongo::Connection
# - A MongoDB server
#

require 'mongo'
require 'time'

mongo = Mongo::Connection.new('localhost', 27017)

db = mongo.db('fluentd')
coll = db.collection('automatic.feed')

from = Time.parse('20130708')
to   = Time.parse('20130709')
i = 0
coll.find({:time => {"$gt" => from , "$lt" => to}}).each {|row|
  i += 1
  puts row
}
p i
p from
p to
