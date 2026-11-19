#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# mapper_spec.rb: RSpec test of the log mapper
#
# Description:
# Test the log mapper against data.txt with RSpec.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     rspec mapper_spec.rb
#
# Requirements:
# - Ruby with RSpec
#

require 'rubygems'
require 'rspec'

class Mapper
  def self.run
    `cat data.txt | ruby mapper.rb`
  end
end

describe Mapper do
  it 'Map 処理の結果が返る' do
    expect = "88.182.8.57\t1\n88.182.29.128\t1\n218.213.26.164\t1\n211.9.48.49\t1\n88.182.29.128\t1\n"
    Mapper.run.should == expect
  end
end
