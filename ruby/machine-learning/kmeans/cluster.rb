#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'kmeans/pair'
require 'kmeans/pearson'
require 'kmeans/cluster'

def testdata
  @testdata = {
    "test01"=>
      {"hoge"=>0,
       "fuga"=>1,
       "piyo"=>0
      },
    "test02"=>
      {"hoge"=>2,
       "fuga"=>1,
       "piyo"=>3
      },
    "test03"=>
      {"hoge"=>3,
       "fuga"=>0,
       "piyo"=>1
      },
    "test04"=>
      {"hoge"=>0,
       "fuga"=>2,
       "piyo"=>0
      },
    "test05"=>
      {"hoge"=>4,
       "fuga"=>2,
       "piyo"=>3
      },
    "test06"=>
      {"hoge"=>3,
       "fuga"=>1,
       "piyo"=>1
      }
    }
end

if __FILE__ == $0
  result = Kmeans::Cluster.new(testdata, {
             :centroids => 5,
             :loop_max => 10
           })
  result.make_cluster
  puts result.cluster
end
