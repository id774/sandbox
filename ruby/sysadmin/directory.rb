# -*- coding: utf-8 -*-
# directory.rb: Search matching log files under a directory
#
# Description:
# Search the matching log files under a directory.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby directory.rb
#
# Requirements:
# - Ruby
# - The sysadmin gem
#

require 'sysadmin'

SEARCH_PATH = "/home/fluent/.fluent/log"

filelists = Sysadmin::Directory.new(SEARCH_PATH).grep(/hotnews*./)
search_string = "hotnews"
begin
  rule = Regexp.new(search_string, Regexp::IGNORECASE)
  filelists.each do |infile|
    filename = File::basename(infile)
    # p filename if rule =~ filename
    p filename.delete(".txt").delete("hotnews_") if rule =~ filename
  end
rescue RegexpError
end
