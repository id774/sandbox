require 'json'
require 'csv'
require 'ibm_db'

def connect
  json_file_path = "direct-dev_vcap.json"

  json_data = open(json_file_path) do |io|
    @dashdb = JSON.load(io)
  end
  @dashdb = @dashdb["dashDB For Transactions"]
  @credentials = @dashdb.first["credentials"]
  @host = @credentials["host"]
  @username = @credentials["username"]
  @password = @credentials["password"]
  @database = @credentials["db"]
  @port = @credentials["port"]

  conn = IBM_DB.connect "DATABASE=#{@database};HOSTNAME=#{@host};PORT=#{@port};PROTOCOL=TCPIP;UID=#{@username};PWD=#{@password};", '', ''
end

def exec_sql(conn, sql)
  stmt = IBM_DB.exec conn, sql
end

def show_data(stmt)
  while row = IBM_DB.fetch_assoc(stmt)
    puts row
  end
end

def open_csv(filename, &block)
  filename = File.expand_path(filename)
  table = CSV.table(filename, encoding: "UTF-8")
  keys = table.headers
  array = []
  CSV.foreach(File.expand_path(filename), encoding: "UTF-8" ) do |row|
    row = row.map{|i|"'#{i}'"}
    array << row.join(",")
  end

  return array
end

def load_csv(file_path)
  filename = File.expand_path('public/data/information.csv')
  data = open_csv(filename)
end

def load_data(table_name, file_path)
  conn = connect
  data = load_csv(file_path)
  data.each do |row|
    sql = "insert into #{table_name} values (#{row})"
    exec_sql(conn, sql)
  end
  IBM_DB.close(conn)
end

table_name = "information"
file_path = 'public/data/information.csv'

load_data(table_name, file_path)

