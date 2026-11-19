# read_from_twitter_db.rb: Read stored tweets from SQLite with ActiveRecord
#
# Description:
# Read stored tweets out of 1.db in the current directory with ActiveRecord.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby read_from_twitter_db.rb
#
# Requirements:
# - Ruby
# - The activerecord and sqlite3 gems
# - 1.db in the current directory
#

require 'active_record'

class Status < ActiveRecord::Base
end

def prepare_database(db_dir, db_file)
  db = File.join(db_dir, db_file)
  ActiveRecord::Base.establish_connection(
    :adapter  => "sqlite3",
    :database => db
  )
end

prepare_database(".", "1.db")

statuses = Status.all.limit(100)

statuses.each do |status|
  puts "#{status.created_at.getlocal.strftime("%Y/%m/%d %H:%M:%S")},https://twitter.com/#{status.screen_name}/statuses/#{status.id_str},#{status.screen_name},#{status.text}"
end
