#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# sequel.rb: In-memory SQLite table queried through Sequel
#
# Description:
# Create an in memory SQLite table and query it through Sequel models.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby sequel.rb
#
# Requirements:
# - Ruby
# - The sequel and sqlite3 gems
#

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
