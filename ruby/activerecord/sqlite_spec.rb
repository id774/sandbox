#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

$:.unshift File.join(File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
#require File.dirname(__FILE__) + '/../spec_helper'
require 'sqlite'

describe Storage, 'SQLite3 ストレージラッパークラス' do
  before do
    #db_dir = File.join(File.dirname(__FILE__), '..', '..', 'db')
    db_dir = File.join(File.dirname(__FILE__))
    db = File.join(db_dir, 'sqlite3.db')
    File.delete(db) if File.exist?(db)
  end

  context 'の .put メソッドにおいて' do
    describe 'ハッシュを保存すると' do
      it '新規のキーがハッシュで返る' do
        expect = ""
        hash = Hash.new
        hash.default = 'UNKNOWN'
        hash['111.222.111.222'] = 'hoge.co.jp'
        hash['111.222.222.222'] = 'fuga.co.jp'
        hash['222.222.100.101'] = 'piyo.co.jp'
        hash['222.222.100.103'] = 'hogehoge.co.jp'
        hash['222.222.101.102'] = 'fugafuga.co.jp'
        result = Storage.new.put(hash)
        result.size.should == 5
        result['111.222.111.222'].should == 'hoge.co.jp'
        result['111.222.222.222'].should == 'fuga.co.jp'
        result['222.222.100.101'].should == 'piyo.co.jp'
        result['222.222.100.103'].should == 'hogehoge.co.jp'
        result['222.222.101.102'].should == 'fugafuga.co.jp'
      end
    end
  end

  context 'の .put メソッドにおいて' do
    describe 'さらにハッシュを保存すると' do
      it '新規のキーのみハッシュで返る' do
        expect = ""
        hash = Hash.new
        hash.default = 'UNKNOWN'
        hash['111.222.111.222'] = 'hoge.co.jp'
        hash['111.222.222.222'] = 'fuga.co.jp'
        hash['222.222.100.101'] = 'piyo.co.jp'
        hash['222.222.100.103'] = 'hogehoge.co.jp'
        hash['222.222.101.102'] = 'fugafuga.co.jp'
        result = Storage.new.put(hash)
        hash['111.222.111.222'] = 'hoge.co.jp'
        hash['111.222.222.222'] = 'fuga.co.jp'
        hash['222.222.100.101'] = 'piyo.co.jp'
        hash['222.222.100.103'] = 'hogehoge.co.jp'
        hash['222.222.101.102'] = 'fugafuga.co.jp'
        hash['222.222.102.104'] = 'piyopiyo.co.jp'
        result = Storage.new.put(hash)
        result.size.should == 1
        result['222.222.102.104'].should == 'piyopiyo.co.jp'
      end
    end
  end

  context 'の .put 及び .get メソッドにおいて' do
    describe '保存したレコードを参照すると' do
      it '保存されているレコードがハッシュで返る' do
        expect = ""
        hash = Hash.new
        hash.default = 'UNKNOWN'
        hash['111.222.111.222'] = 'hoge.co.jp'
        hash['111.222.222.222'] = 'fuga.co.jp'
        hash['222.222.100.101'] = 'piyo.co.jp'
        hash['222.222.100.103'] = 'hogehoge.co.jp'
        hash['222.222.101.102'] = 'fugafuga.co.jp'
        Storage.new.put(hash)
        result = Storage.new.get
        result.size.should == 5
        result['111.222.111.222'].should == 'hoge.co.jp'
        result['111.222.222.222'].should == 'fuga.co.jp'
        result['222.222.100.101'].should == 'piyo.co.jp'
        result['222.222.100.103'].should == 'hogehoge.co.jp'
        result['222.222.101.102'].should == 'fugafuga.co.jp'
      end
    end
  end

  after do
    #db_dir = File.join(File.dirname(__FILE__), '..', '..', 'db')
    db_dir = File.join(File.dirname(__FILE__))
    db = File.join(db_dir, 'sqlite3.db')
    File.delete(db) if File.exist?(db)
  end
end
