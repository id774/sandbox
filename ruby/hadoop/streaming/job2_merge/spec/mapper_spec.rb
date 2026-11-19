#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# mapper_spec.rb: RSpec test of the job2 mapper
#
# Description:
# Test the job2 mapper against fixture data with RSpec.
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
# - Run from the job2_merge directory
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
      "20140312.tar.gz,1394559961\tBBCCDDEE1122\tShop15\t14\t2014-03-12 02:46:01 +0900\t-1\n" +
      "20140312.tar.gz,1394559946\tCCDDEEAA2233\tShop14\t26\t2014-03-12 02:45:46 +0900\t-1\n" +
      "20140312.tar.gz,1394560046\tCCDDEEAA2233\tShop13\t28\t2014-03-12 02:47:26 +0900\t100\n" +
      "20140312.tar.gz,1394560109\tCCDDEEAA2233\tShop10\t33\t2014-03-12 02:48:29 +0900\t60\n" +
      "20140312.tar.gz,1394559961\tDBCCDDEE1122\tShop15\t14\t2014-03-12 02:46:01 +0900\t-1\n" +
      "20140312.tar.gz,1394559946\tECDDEEAA2233\tShop14\t26\t2014-03-12 02:45:46 +0900\t-1\n" +
      "20140312.tar.gz,1394560046\tECDDEEAA2233\tShop13\t28\t2014-03-12 02:47:26 +0900\t100\n" +
      "20140312.tar.gz,1394560109\tECDDEEAA2234\tShop10\t33\t2014-03-12 02:48:29 +0900\t60\n"
    }

    it '一定時間間隔以内の同一キーの場合を除去してデータを出力する' do
      expect(subject).to eq expected
    end
  end
end
