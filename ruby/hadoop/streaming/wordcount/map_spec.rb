#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# map_spec.rb: RSpec test of the word count mapper
#
# Description:
# Test the wordcount mapper against fixture data with RSpec.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     rspec map_spec.rb
#
# Requirements:
# - Ruby with RSpec
#

require 'rubygems'
require 'rspec'

class Mapper
  def self.run
    `cat data.txt | ruby map.rb`
  end
end

describe Mapper do
  it 'Map 処理の結果が返る' do
    expect = "aaa\t1\nbbb\t1\nccc\t1\nddd\t1\neee\t1\nfff\t1\nggg\t1\nhhh\t1\naaa\t1\nbbb\t1\nccc\t1\nddd\t1\n"
    Mapper.run.should == expect
  end
end
