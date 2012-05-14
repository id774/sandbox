#!/usr/bin/env ruby

require 'rubygems'
require 'rest-graph'

rg = RestGraph.new(:access_token => 'xxx')

feed = rg.get('search', :q => 'test')

like = rg.get('me/likes')

like.values.first each { |f|
  puts f['name']
}
