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
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        id, process, result = key.strip.split(",")
        @hash[id + ',' + result + ',' + tag] = JSON.parse(json)
      end
    end
    result = Kmeans::Cluster.new(@hash, {
               :centroids => 40,
               :loop_max => 100
             })
    result.make_cluster
    i = 0
    result.cluster.values.each {|array|
      i += 1
      puts i
      ap array
    }
  end
end

if __FILE__ == $0
  filename = ARGV.shift || "json.txt"
  analyzer = Analyzer.new(filename)
  analyzer.start
end
