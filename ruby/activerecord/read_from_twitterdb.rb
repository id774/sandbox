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
  puts "#{status.id_str},#{status.created_at.getlocal.strftime("%Y/%m/%d %H:%M:%S")},#{status.screen_name},#{status.text}"
end
