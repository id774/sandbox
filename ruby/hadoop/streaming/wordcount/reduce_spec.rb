#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# reduce_spec.rb: RSpec test of the word count pipeline
#
# Description:
# Test the wordcount reducer through the whole pipe with RSpec.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     rspec reduce_spec.rb
#
# Requirements:
# - Ruby with RSpec
#

require 'rubygems'
require 'rspec'

class Reducer
  def self.run
    `cat data.txt | ruby map.rb | sort | ruby reduce.rb`
  end
end

describe Reducer do
  it 'Reduce 処理の結果が返る' do
    expect = "aaa\t2\nbbb\t2\nccc\t2\nddd\t2\neee\t1\nfff\t1\nggg\t1\nhhh\t1\n"
    Reducer.run.should == expect
  end
end
