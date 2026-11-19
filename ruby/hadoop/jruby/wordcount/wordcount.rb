# wordcount.rb: JRuby map reduce word count
#
# Description:
# Count words through the JRuby map reduce interface. run.sh submits it with
# joh.
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
  # setup jobconf
end

def map(key, value, output, reporter)
  # mapper process
  # (wordcount example)
  value.split.each do |word|
    output.collect(word, 1)
  end
end

def reduce(key, values, output, reporter)
  # reducer process
  # (wordcount example)
  sum = 0
  values.each {|v| sum += v }
  output.collect(key, sum)
end

