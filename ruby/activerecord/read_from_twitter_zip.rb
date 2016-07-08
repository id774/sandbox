require 'active_record'
require 'zip/zip'

class Status < ActiveRecord::Base
end

def query
  # Status.where(screen_name: "")
  # Status.where("text like '%ほげ%'")
  Status.all.limit(100)
end

def analysis_datafilename
  "1.db"
end

def output_format(status)
  "#{status.created_at.getlocal.strftime("%Y/%m/%d %H:%M:%S")},https://twitter.com/#{status.screen_name}/statuses/#{status.id_str},#{status.screen_name},\"#{status.text}\""
end

def prepare_database(db_dir, db_file)
  db = File.join(db_dir, db_file)
  ActiveRecord::Base.establish_connection(
    :adapter  => "sqlite3",
    :database => db
  )
end

def read_from_db(filename)
  prepare_database(".", filename)
  statuses = query
  statuses.each do |status|
    puts output_format(status)
  end
end

def unzip(file)
  Zip::ZipFile.open(file) do |zip|
    zip.each do |entry|
      filename = entry.to_s
      if filename == analysis_datafilename
        # puts "extract #{filename}"
        zip.extract(entry, entry.to_s) { true }
        read_from_db(filename)
        File.unlink(filename)
      end
    end
  end
end

def main
  Dir.glob("*").each do |filename|
    unzip filename if filename.include?(".zip")
  end
end

main
