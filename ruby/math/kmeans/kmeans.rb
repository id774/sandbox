#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'kmeans/pair'
require 'kmeans/pearson'
require 'kmeans/cluster'

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
  puts result.cluster
end
