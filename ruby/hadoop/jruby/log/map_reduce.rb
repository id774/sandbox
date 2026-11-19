# map_reduce.rb: JRuby map reduce word count for a log
#
# Description:
# Count words in a log through the JRuby map reduce interface. run.sh submits
# it with joh.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Requirements:
# - JRuby and the jruby-on-hadoop (joh) runner
#

def setup(conf)
end

def map(key, value, output, reporter)
  value.split.each do |elm|
    output.collect(elm, 1)
  end
end

def reduce(key, values, output, reporter)
  sum = 0
  values.each {|v| sum += v }
  output.collect(key, sum)
end
