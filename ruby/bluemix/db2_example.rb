# db2_example.rb: DB2 on Bluemix through ActiveRecord
#
# Description:
# Connect to DB2 on Bluemix through ActiveRecord.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby db2_example.rb
#
# Requirements:
# - Ruby
# - The activerecord, activesupport, bcrypt, and ibm_db gems
# - DB2 credentials for the Bluemix service
#

require 'bcrypt'
require 'ibm_db'
require 'active_support'
require 'active_record'
require 'pp'

def connect
  if(ENV['VCAP_SERVICES'])
    @dashdb = JSON.parse(ENV['VCAP_SERVICES'])["dashDB For Transactions"]
  else
    json_file_path = "sample_vcap.json"
    json_data = open(json_file_path) do |io|
      @dashdb = JSON.load(io)
    end
    @dashdb = @dashdb["dashDB For Transactions"]
  end
  @credentials = @dashdb.first["credentials"]
  config = {
    adapter: 'ibm_db',
    schema: 'TEST_ACTIVERECORD',
    port: 50000,
    database: @credentials["db"],
    username: @credentials["username"],
    host: @credentials["host"],
    password: @credentials["password"]
  }

  Time.zone = 'Asia/Tokyo'
  ActiveRecord::Base.establish_connection(config)
  conn = ActiveRecord::Base.connection

  p ActiveRecord.version
end

def prepare
  @version = RUBY_VERSION
  @os = RUBY_PLATFORM
  @env = {}
  ENV.each do |key, value|
    begin
      hash = JSON.parse(value)
      @env[key] = hash
    rescue
      @env[key] = value
    end
  end

  @conn = connect if @conn.nil?
end

class User < ActiveRecord::Base
  self.primary_key = :id
end

def main
  prepare

  @users = User.all
  pp @users
  pp User.count

  User.delete_all
  pp User.count

  @user = User.new
  @user.id = (User.count) + 1
  @user.name = "山田太郎"
  @user.age = 20
  @user.save!

  @user = User.new
  @user.id = (User.count) + 1
  @user.name = "田中二郎"
  @user.age = 22
  @user.save!

  @users = User.all
  pp @users
  pp User.count
end

main

