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
