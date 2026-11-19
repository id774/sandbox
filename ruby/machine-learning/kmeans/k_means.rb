#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# k_means.rb: Two centroids with the k_means gem
#
# Description:
# Split a small point set into two centroids with the k_means gem.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby k_means.rb
#
# Requirements:
# - Ruby
# - The k_means gem
#

require 'rubygems'
require 'k_means'

if __FILE__ == $0
  @data = [[1,1], [1,2], [1,1], [1000, 1000], [500, 510]]
  kmeans = KMeans.new(@data, :centroids => 2)
  puts kmeans.inspect  # Use kmeans.view to get hold of the un-inspected array
end
