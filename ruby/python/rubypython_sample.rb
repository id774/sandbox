#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# rubypython_sample.rb: Call Python functions from Ruby
#
# Description:
# Call Python functions from Ruby with rubypython.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby rubypython_sample.rb
#
# Requirements:
# - Ruby
# - The rubypython gem and a Python installation it can load
#

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

