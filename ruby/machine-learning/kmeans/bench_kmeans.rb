#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'benchmark'

require 'k_means'
require 'ai4r'

# 1000 records with 50 dimensions
data = Array.new(1000) {Array.new(50) {rand(10)}}
ai4r_data = Ai4r::Data::DataSet.new(:data_items=> data)

# Clustering can happen in magical ways
# so lets do it over multiple times
n = 5

Benchmark.bm do |x|
  x.report('euclidean') do
    n.times { KMeans.new(data, :distance_measure => :euclidean_distance) }
  end
  x.report('cosine') do
    n.times { KMeans.new(data, :distance_measure => :cosine_similarity) }
  end
  x.report('j_index') do
    n.times { KMeans.new(data, :distance_measure => :jaccard_index) }
  end
  x.report('j_distance') do
    n.times { KMeans.new(data, :distance_measure => :jaccard_distance) }
  end
  x.report('b_j_index') do
    n.times { KMeans.new(data, :distance_measure => :binary_jaccard_index) }
  end
  x.report('b_j_distance') do
    n.times { KMeans.new(data, :distance_measure => :binary_jaccard_distance) }
  end
  x.report('tanimoto') do
    n.times { KMeans.new(data, :distance_measure => :tanimoto_coefficient) }
  end
  x.report("Ai4R") do
    n.times do
      b = Ai4r::Clusterers::KMeans.new
      b.build(ai4r_data, 4)
    end
  end
end
