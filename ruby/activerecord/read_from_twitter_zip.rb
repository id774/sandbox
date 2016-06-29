require 'active_record'
require 'zip/zip'

class Status < ActiveRecord::Base
end

def prepare_database(db_dir, db_file)
  db = File.join(db_dir, db_file)
  ActiveRecord::Base.establish_connection(
    :adapter  => "sqlite3",
    :database => db
  )
end

def unzip(file)
  Zip::ZipFile.open(file) do |zip|
    zip.each do |entry|
      filename = entry.to_s
      if filename == "1.db"
        # puts "extract #{filename}"
        zip.extract(entry, entry.to_s) { true }
        read_from_db(filename)
        File.unlink(filename)
      end
    end
  end
end

def read_from_db(filename)
  prepare_database(".", filename)
  statuses = Status.all.limit(100)

  statuses.each do |status|
    puts "#{status.created_at.getlocal.strftime("%Y/%m/%d %H:%M:%S")},https://twitter.com/#{status.screen_name}/statuses/#{status.id_str},#{status.screen_name},#{status.text}"
  end
end

["twitter-db-201605.zip"].each do |file|
  unzip(file)
end
