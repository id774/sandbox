#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

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
