#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# reducer_spec.rb: RSpec test of the log pipeline
#
# Description:
# Test the log reducer through the whole pipe with RSpec.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     rspec reducer_spec.rb
#
# Requirements:
# - Ruby with RSpec
#

require 'rubygems'
require 'rspec'

class Reducer
  def self.run
    `cat data.txt | ruby mapper.rb | sort | ruby reducer.rb`
  end
end

describe Reducer do
  it 'Reduce 処理の結果が返る' do
    expect = "211.9.48.49\tUNKNOWN\t1\n218.213.26.164\tUNKNOWN\t1\n88.182.29.128\tmar44-5-88-182-29-128.fbx.proxad.net\t2\n88.182.8.57\tbac69-10-88-182-8-57.fbx.proxad.net\t1\n"
    Reducer.run.should == expect
  end
end
