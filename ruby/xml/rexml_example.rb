#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rexml/document'
require 'open-uri'

url = "http://statdb.nstac.go.jp/api/1.0b/app/getStatsData?appId=xxxxxxxxxxxx&statsDataId=0003013276&cdArea=09003,22004&cdCat01=010920070&cdTimeFrom=2012000101&cdTimeTo=2013000303"
doc = REXML::Document.new(open(url))

puts doc
