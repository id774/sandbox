#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Build an ID3 decision tree from labelled wine data with ai4r.

require 'rubygems'
require 'ai4r'

# Train
train_data = Ai4r::Data::DataSet.new.load_csv_with_labels("./train_wine.csv")
tree_id3 = Ai4r::Classifiers::ID3.new.build(train_data)

# get_rules returns the contents of the tree as a string
# puts tree_id3.get_rules

# Predict
p tree_id3.eval(["14.3","1.92","2.72","20","120","2.8","3.14","0.33","1.97","6.2","1.07","2.65","1280"])
