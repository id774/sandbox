#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'k_means'

if __FILE__ == $0
  @data = [[1,1], [1,2], [1,1], [1000, 1000], [500, 510]]
  kmeans = KMeans.new(@data, :centroids => 2)
  puts kmeans.inspect  # Use kmeans.view to get hold of the un-inspected array
end
