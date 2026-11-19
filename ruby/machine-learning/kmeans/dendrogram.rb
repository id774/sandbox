#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# dendrogram.rb: Dendrogram of hierarchically clustered blog data
#
# Description:
# Draw a dendrogram from hierarchically clustered file data, reading
# ../kcluster/blogdata.txt relative to this file and writing clusters.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby dendrogram.rb
#
# Requirements:
# - Ruby
# - The kmeans gem with its dendrogram support
# - ../kcluster/blogdata.txt, which generatefeedvector.rb produces
#

require 'kmeans/pearson'
require 'kmeans/hcluster'
require 'kmeans/dendrogram'

def readline_from_file(filename)
  lines = Array.new
  open(filename).each {|line|
    lines.push(line)
  }

  colnames = lines[0].strip().split("\t")
  colnames.shift

  rownames = Array.new
  data = Array.new
  lines[1...lines.length].each {|line|
    tmp = line.strip().split("\t")
    rownames.push(tmp.shift)
    wordcount = Array.new
    tmp.each {|c|
      wordcount.push(c.to_i)
    }
    data.push(wordcount)
  }

  return rownames,colnames,data
end

if __FILE__ == $0
  cluster = Kmeans::HCluster.new
  filename = File.join(File.dirname(__FILE__),
    '..', 'kcluster', 'blogdata.txt')

  blogs,words,data = readline_from_file(filename)

  hcluster = cluster.hcluster(data)
  den = Kmeans::Dendrogram.new(:imagefile => 'clusters.png')
  den.drawdendrogram(hcluster, blogs)
end
