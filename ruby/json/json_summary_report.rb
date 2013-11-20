# -*- coding: utf-8 -*-

require 'json'
require 'awesome_print'

class Analyzer
  def initialize(args)
    @filename = args.shift || "json.txt"
    @project_success_count = 0
    @project_failure_count = 0
    @activity_success_count = 0
    @activity_failure_count = 0
    @activity_success_wordhash = {}
    @activity_failure_wordhash = {}
  end

  def start
    open(@filename) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")

        code, type, project_name = key.strip.split(",")
        action, result = tag.strip.split(",")
        hash = JSON.parse(json)

        @project_success_count += 1 if result == "受注" and type == "_project"
        @project_failure_count += 1 if result == "失注" and type == "_project"
        @activity_success_count += 1 if result == "受注" and type == "activity"
        @activity_failure_count += 1 if result == "失注" and type == "activity"

      end
    end

    output("1", "受注案件", @project_success_count)
    output("2", "失注案件", @project_failure_count)
    output("3", "受注案件の活動実績", @activity_success_count)
    output("4", "失注案件の活動実績", @activity_failure_count)
  end

  private

  def output(key, tag, value)
    puts "#{key}\t#{tag}\t#{value}"
  end
end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.start
end

