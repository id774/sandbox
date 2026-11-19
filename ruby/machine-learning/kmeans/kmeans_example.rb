#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# kmeans_example.rb: Cluster students by subject scores
#
# Description:
# Cluster students by their subject scores.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby kmeans_example.rb
#
# Requirements:
# - Ruby
# - The kmeans gem
#

require 'kmeans/pair'
require 'kmeans/pearson'
require 'kmeans/cluster'

hash = {
"山田"=> {"国語"=>98, "数学"=>55, "英語"=>90, "理科"=>48, "社会"=>90 },
"田中"=> {"国語"=>54, "数学"=>99, "英語"=>67, "理科"=>93, "社会"=>47 },
"中村"=> {"国語"=>99, "数学"=>72, "英語"=>98, "理科"=>61, "社会"=>89 },
"佐藤"=> {"国語"=>56, "数学"=>93, "英語"=>62, "理科"=>99, "社会"=>49 },
"木下"=> {"国語"=>91, "数学"=>29, "英語"=>88, "理科"=>49, "社会"=>87 },
"山本"=> {"国語"=>28, "数学"=>89, "英語"=>34, "理科"=>88, "社会"=>32 }
}

result = Kmeans::Cluster.new(hash, {
  :centroids => 2, # number of centroids
  :loop_max => 10  # number of iterations
})
result.make_cluster
p result.cluster.values
