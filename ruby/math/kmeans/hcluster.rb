#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'kmeans/pearson'
require 'kmeans/hcluster'

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
  puts cluster.printclust(hcluster, blogs)
end
