#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'sequel'

DB = Sequel.sqlite
DB << "CREATE TABLE users (id INTEGER PRIMARY KEY, name VARCHAR(255) not NULL)"

class  User < Sequel::Model
end

User.create(:name => 'hoge')

User.find(:name => 'hoge')
User.find(:id => 1).update(:name => 'hoge')
# User.find(:id => 1).delete
User.first

p User.all
p DB[:users].filter(:name => 'hoge').sql
User.filter("id > ?", 0).limit(10).each {|u|p u[:name]}
