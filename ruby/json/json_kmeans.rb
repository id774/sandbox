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
    kmeans = Kmeans::Cluster.new(@hash, {
               :centroids => 40,
               :loop_max => 100
             })
    kmeans.make_cluster
    i = 0
    kmeans.cluster.values.each {|hash|
      i += 1
      hash.each {|k, v|
        output(i, k, v)
      }
    }
  end

  private

  def output(key, tag, value)
    puts "#{key}\t#{tag}\t#{value}"
  end
end

if __FILE__ == $0
  filename = ARGV.shift || "json.txt"
  analyzer = Analyzer.new(filename)
  analyzer.start
end
