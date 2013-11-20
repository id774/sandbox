# -*- coding: utf-8 -*-

require 'json'
require 'awesome_print'

class Analyzer
  def initialize(args)
    @filename = args.shift || "json.txt"
    @project_result = {}
    @activity_action = {}
    @action_success = {}
    @action_failure = {}
    @action_refusal = {}
    @action_unknown = {}
  end

  def start
    open(@filename) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")

        code, type, project_name = key.strip.split(",")
        action, result = tag.strip.split(",")
        hash = JSON.parse(json)

        if type == "_project"
          @project_result.has_key?(result) ? @project_result[result] += 1 : @project_result[result] = 1
        end

        if type == "activity"
          @activity_action.has_key?(action) ? @activity_action[action] += 1 : @activity_action[action] = 1
        end

        if result == "受注" and type == "activity"
          @action_success.has_key?(action) ? @action_success[action] += 1 : @action_success[action] = 1
        end

        if result == "失注" and type == "activity"
          @action_failure.has_key?(action) ? @action_failure[action] += 1 : @action_failure[action] = 1
        end

        if result == "辞退" and type == "activity"
          @action_refusal.has_key?(action) ? @action_refusal[action] += 1 : @action_refusal[action] = 1
        end

        if result == "不明" and type == "activity"
          @action_unknown.has_key?(action) ? @action_unknown[action] += 1 : @action_unknown[action] = 1
        end

      end
    end

    output("1", "案件総数", JSON.generate(@project_result))
    output("2", "活動実績種別", JSON.generate(@activity_action))
    output("3", "受注案件の種別", JSON.generate(@action_success))
    output("4", "失注案件の種別", JSON.generate(@action_failure))
    output("5", "辞退案件の種別", JSON.generate(@action_refusal))
    output("6", "不明案件の種別", JSON.generate(@action_unknown))
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

