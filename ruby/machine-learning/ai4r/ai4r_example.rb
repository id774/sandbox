#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Train a backpropagation network on shape patterns with ai4r.

require 'rubygems'
require 'ai4r'

# The images expressed as numbers
#require File.dirname(__FILE__) + '/training_patterns'
#require File.dirname(__FILE__) + '/patterns_with_noise'
#require File.dirname(__FILE__) + '/patterns_with_base_noise'
require 'ai4r/training_patterns'
require 'ai4r/patterns_with_noise'
require 'ai4r/patterns_with_base_noise'

# Build the neural network with
# an input layer of 256
# and an output layer of 3
# nodes
net = Ai4r::NeuralNetwork::Backpropagation.new([256, 3])

# Load the training data, that is the expected answers
tr_input = TRIANGLE.flatten.collect { |input| input.to_f / 10}
sq_input = SQUARE.flatten.collect { |input| input.to_f / 10}
cr_input = CROSS.flatten.collect { |input| input.to_f / 10}

# Train the network 100 times
100.times do
  net.train(tr_input, [1,0,0]) # output [1,0,0] for a triangle
  net.train(sq_input, [0,1,0]) # output [0,1,0] for a square
  net.train(cr_input, [0,0,1]) # output [0,0,1] for a cross
end

# Load the data carrying two kinds of noise
tr_with_noise = TRIANGLE_WITH_NOISE.flatten.collect { |input| input.to_f / 10}
sq_with_noise = SQUARE_WITH_NOISE.flatten.collect { |input| input.to_f / 10}
cr_with_noise = CROSS_WITH_NOISE.flatten.collect { |input| input.to_f / 10}

tr_with_base_noise = TRIANGLE_WITH_BASE_NOISE.flatten.collect { |input| input.to_f / 10}
sq_with_base_noise = SQUARE_WITH_BASE_NOISE.flatten.collect { |input| input.to_f / 10}
cr_with_base_noise = CROSS_WITH_BASE_NOISE.flatten.collect { |input| input.to_f / 10}

# Print the results

def result_label(result)
  if result[0] > result[1] && result[0] > result[2]
    "TRIANGLE"
  elsif result[1] > result[2]
    "SQUARE"
  else
    "CROSS"
  end
end

puts "学習データの場合"
puts "#{net.eval(tr_input).inspect} => #{result_label(net.eval(tr_input))}"
puts "#{net.eval(sq_input).inspect} => #{result_label(net.eval(sq_input))}"
puts "#{net.eval(cr_input).inspect} => #{result_label(net.eval(cr_input))}"
puts "ノイズ画像の場合"
puts "#{net.eval(tr_with_noise).inspect} => #{result_label(net.eval(tr_with_noise))}"
puts "#{net.eval(sq_with_noise).inspect} => #{result_label(net.eval(sq_with_noise))}"
puts "#{net.eval(cr_with_noise).inspect} => #{result_label(net.eval(cr_with_noise))}"
puts "ベースノイズの乗った画像の場合"
puts "#{net.eval(tr_with_base_noise).inspect} => #{result_label(net.eval(tr_with_base_noise))}"
puts "#{net.eval(sq_with_base_noise).inspect} => #{result_label(net.eval(sq_with_base_noise))}"
puts "#{net.eval(cr_with_base_noise).inspect} => #{result_label(net.eval(cr_with_base_noise))}"
