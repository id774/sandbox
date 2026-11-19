# extract_fixtures.rake: Rake task that dumps database tables to fixtures
#
# Description:
# Define the extract_fixtures task, which writes every table except
# schema_info to test/fixtures/<table>.yml under RAILS_ROOT.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     rake extract_fixtures
#
# Requirements:
# - A Rails application whose version still defines the RAILS_ROOT constant,
#   with this file in lib/tasks
#

task :extract_fixtures => :environment do
  sql = "select * from %s"
  skip_tables = ["schema_info"]
  ActiveRecord::Base.establish_connection
  (ActiveRecord::Base.connection.tables - skip_tables).each do | table_name |
    i = "000"
    File.open("#{RAILS_ROOT}/test/fixtures/#{table_name}.yml", 'w') do |file|
      data = ActiveRecord::Base.connection.select_all(sql % table_name)
      file.write data.inject({}) { |hash, record|
        hash["#{table_name}_#{i.succ!}"] = record
        hash
      }.to_yaml
    end
  end
end
