#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require "rubypython"

RubyPython.start

@sys = RubyPython.import 'sys'
@sys.path.append File.join(File.dirname(__FILE__), '..', '..', 'python', 'math')

euclidean = RubyPython.import("euclidean-space")
p euclidean.euclidean([3,4,5],[4,5,8])

pearson = RubyPython.import("pearson-correlation-coefficient")
p pearson.pearson([3,4,5],[4,5,8])

weighted_mean = RubyPython.import("weighted-mean")
p weighted_mean.weighted_mean([3,4,5],[4,5,8])

RubyPython.stop

