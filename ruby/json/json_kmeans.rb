#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'json'
require 'kmeans/pair'
require 'kmeans/pearson'
require 'kmeans/cluster'
require 'awesome_print'

class Analyzer
  def initialize(args)
    @filename  = args.shift || "json.txt"
    @centroids = args.shift.to_i || 40
    @loop_max  = args.shift.to_i || 100
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
               :centroids => @centroids,
               :loop_max  => @loop_max
             })
    kmeans.make_cluster
    i = 0
    j = 0
    kmeans.cluster.values.each {|array|
      j += 1
      array.each {|elem|
        i += 1
        output(i, j, elem)
      }
    }
  end

  private

  def output(key, tag, value)
    puts "#{key}\t#{tag}\t#{value}"
  end
end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.start
end
