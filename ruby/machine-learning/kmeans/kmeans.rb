#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# kmeans.rb: Cluster fixed test data and print JSON
#
# Description:
# Cluster fixed test data and print the result as JSON.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby kmeans.rb
#
# Requirements:
# - Ruby
# - The kmeans gem
#

require 'kmeans/pair'
require 'kmeans/pearson'
require 'kmeans/cluster'
require 'json'

def testdata
  @testdata = {
    "test01"=>
      {"hoge"=>1,
       "fuga"=>1,
      },
    "test02"=>
      {"hoge"=>1,
       "fuga"=>2,
      },
    "test03"=>
      {"hoge"=>1,
       "fuga"=>1,
      },
    "test04"=>
      {"hoge"=>1000,
       "fuga"=>1000,
      },
    "test05"=>
      {"hoge"=>500,
       "fuga"=>510,
      },
    }
end

if __FILE__ == $0
  result = Kmeans::Cluster.new(testdata, {
             :centroids => 2,
             :loop_max => 100
           })
  result.make_cluster
  result.cluster.values.each {|array|
  hash = {}
  array.each {|word|
    hash[word] = 1
  }
  json = JSON.generate(hash)
  puts json
}
end
