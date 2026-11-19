#!/usr/bin/ruby
# -*- coding: utf-8 -*-
# run.rb: Hierarchical clustering of saved blog word vectors
#
# Description:
# Run hierarchical clustering over the word vectors in myblogdata.txt and draw
# the dendrogram as myblogclust.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby run.rb
#
# Requirements:
# - Ruby
# - The requirements of clusters.rb
# - myblogdata.txt in the current directory
#

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
