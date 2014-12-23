
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
