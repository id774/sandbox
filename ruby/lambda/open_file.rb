# open_file.rb: Yield each line of a file to a block
#
# Description:
# Pass a block to a method that yields each line of json.txt in the current
# directory.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby open_file.rb
#
# Requirements:
# - Ruby with the awesome_print gem
# - json.txt in the current directory
#

require 'awesome_print'

def open_file(file = 'json.txt', &block)
  open(file) do |file|
    file.each_line do |line|
      block.call(line)
    end
  end
end

json = []
hash = {}

split_line = lambda {|line|
  hash['key'], hash['tag'], hash['value'] = line.strip.split("\t")
  json << hash
}

open_file("json.txt", &split_line)

ap json
