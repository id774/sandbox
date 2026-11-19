#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# mapper_spec.rb: RSpec test of the job1 mapper
#
# Description:
# Test the job1 mapper against test_data.txt with RSpec.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     rspec spec/mapper_spec.rb
#
# Requirements:
# - Ruby with RSpec
# - Run from the job1_export directory
#

require 'rubygems'
require 'rspec'

class Mapper
  def self.run
    `cat test_data.txt | ruby lib/mapper.rb`
  end
end

describe Mapper do
  context '#run' do
    subject {
      Mapper.run
    }

    let(:expected) {
      "20140312.tar.gz,BBCCDDEE1122,1394559961\tShop15\t14\n" +
      "20140312.tar.gz,CCDDEEAA2233,1394559946\tShop14\t26\n" +
      "20140312.tar.gz,CCDDEEAA2233,1394560046\tShop13\t28\n"
    }

    it '予期したデータが抽出される' do
      expect(subject).to eq expected
    end
  end
end
