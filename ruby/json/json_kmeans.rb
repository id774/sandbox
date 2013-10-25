#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'json'
require 'kmeans/pair'
require 'kmeans/pearson'
require 'kmeans/cluster'
require 'awesome_print'

class Analyzer
  def initialize(filename)
    @filename = filename
    @hash = Hash.new
  end

  def start
    open(@filename) do |file|
      file.each_line do |line|
        key, json = line.force_encoding("utf-8").strip.split("\t")
        id, process, result = key.strip.split(",")
        @hash[id] = JSON.parse(json)
      end
    end
    result = Kmeans::Cluster.new(@hash, {
               :centroids => 30,
               :loop_max => 100
             })
    result.make_cluster
    result.cluster.values.each {|array|
      hash = {}
      array.each {|word|
        hash[word] = 1
      }
      json = JSON.generate(hash)
      ap json
    }
  end
end

if __FILE__ == $0
  filename = ARGV.shift || "json.txt"
  analyzer = Analyzer.new(filename)
  analyzer.start
end
