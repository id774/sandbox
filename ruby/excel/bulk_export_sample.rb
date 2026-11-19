# bulk_export_sample.rb: Bulk export of report records
#
# Description:
# Export report records from the database in bulk.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby bulk_export_sample.rb
#
# Requirements:
# - Ruby
# - The activerecord gem
# - A development database configured in config/database.yml beside this
#   file
#

require 'active_record'

class Report < ActiveRecord::Base
end

class Reporter < ActiveRecord::Base
end

# Prepare database for development environment.
def prepare_database
  ActiveRecord::Base.configurations = YAML.load_file(File.expand_path(File.join(File.dirname(__FILE__), 'config', 'database.yml')))
  ActiveRecord::Base.establish_connection(:development)
end

prepare_database
@reporters = Reporter.all
@reporters.each do |reporter|
  puts "<H1>#{reporter.reporter_name}</H1>"
  @reports = Report.where(reporter_name: reporter.reporter_name)
  @reports.each do |report|
    puts "<H2>#{report.project_name}</H2>"
    puts "#{report.project_report}"
  end
end
