#!/usr/bin/ruby
# -*- coding: utf-8 -*-
$:.unshift File.join(File.dirname(__FILE__))

require 'rubygems'
require 'pp'
require 'generatefeedvector.rb'

require 'clusters.rb'

#gen = FeedVectorGenerator.new
#gen.generate('myblogdata.txt')

#title,wc = gen.getwordcounts('http://gizmodo.com/index.xml')
#pp gen.getwordcounts('http://gizmodo.com/atom.xml')

cs = Clusters.new
blognames,words,data = cs.readline('myblogdata.txt')

clust = cs.hcluster(data)
cs.printclust(clust, blognames)
cs.drawdendrogram(clust,blognames,'myblogclust.png')
