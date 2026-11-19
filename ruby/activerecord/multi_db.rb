# multi_db.rb: Two ActiveRecord models on one table in two databases
#
# Description:
# Map two ActiveRecord models onto the same table in twitter1.sqlite3 and
# twitter2.sqlite3.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby multi_db.rb
#
# Requirements:
# - Ruby
# - The activerecord and sqlite3 gems
# - twitter1.sqlite3 and twitter2.sqlite3 in the current directory
#

require "active_record"

class Status1 < ActiveRecord::Base
  self.table_name = :statuses
end

class Status2 < ActiveRecord::Base
  self.table_name = :statuses
end

Status1.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'twitter1.sqlite3'
)

Status2.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'twitter2.sqlite3'
)

status1 = Status1.all
status2 = Status2.first

p status1.length
p status2
