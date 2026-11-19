# -*- coding: utf-8 -*-
# calc_example.rb: Basic statistics in Ruby against R
#
# Description:
# Compare Ruby against R for basic statistics on the same data.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby calc_example.rb
#
# Requirements:
# - Ruby with the rsruby, awesome_print, and sysadmin gems
# - R
#

require 'rsruby'
require 'awesome_print'
require 'sysadmin'

def r_load
  @r = RSRuby::instance
  # @exam = [13,14,7,12,10,6,8,15,4,14,9,6,10,12,5,12,8,8,12,15]
  @exam = [10,13,8,15,8]
  puts "R"
  ap r_sum
  ap r_average
  ap r_median
  ap r_variance
  ap r_standard_deviation
  puts "Ruby"
  ap @exam.variance
  ap @exam.standard_deviation
end

private

def r_sum
  @r.eval_R(<<-RCOMMAND)
  exam <- c( #{@exam.join(",")} )
  sum(exam)
RCOMMAND
end

def r_average
  @r.eval_R(<<-RCOMMAND)
  exam <- c( #{@exam.join(",")} )
  mean(exam)
RCOMMAND
end

def r_median
  @r.eval_R(<<-RCOMMAND)
  exam <- c( #{@exam.join(",")} )
  median(exam)
RCOMMAND
end

def r_variance
  @r.eval_R(<<-RCOMMAND)
  exam <- c( #{@exam.join(",")} )
  average = mean(exam)
  deviation = exam - average
  sum(deviation ^ 2) / length(exam)
RCOMMAND
end

def r_standard_deviation
  @r.eval_R(<<-RCOMMAND)
  exam <- c( #{@exam.join(",")} )
  average = mean(exam)
  deviation = exam - average
  variance = sum(deviation ^ 2) / length(exam)
  sqrt(variance)
RCOMMAND
end

if __FILE__ == $0
  r_load
end
