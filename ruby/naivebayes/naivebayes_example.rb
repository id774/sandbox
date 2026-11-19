#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# naivebayes_example.rb: Train and classify with the naivebayes gem
#
# Description:
# Train and classify with the naivebayes gem.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby naivebayes_example.rb
#
# Requirements:
# - Ruby
# - The naivebayes gem
#

class NaiveBayesExample
  require 'rubygems'
  require 'naivebayes'

  def initialize
    @classifier = NaiveBayes::Classifier.new(:model => "berounoulli")
  end

  def train
    @classifier.train("果物", {"りんご" => 1, "バナナ" => 1, "パイナップル" => 1})
    @classifier.train("野菜", {"キャベツ" => 1, "トマト" => 1, "きゅうり" => 1})
  end

  def classify
    @classifier.classify({"トマト" => 1})
  end
end

if __FILE__ == $0
  naivebayes = NaiveBayesExample.new
  naivebayes.train
  p naivebayes.classify
end
