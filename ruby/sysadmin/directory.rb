# -*- coding: utf-8 -*-

require 'sysadmin'

SEARCH_PATH = "/home/fluent/.fluent/log"

filelists = Sysadmin::Directory.new(SEARCH_PATH).grep(/hotnews*./)
search_string = "hotnews"
begin
  rule = Regexp.new(search_string, Regexp::IGNORECASE)
  filelists.each do |infile|
    filename = File::basename(infile)
    p filename if rule =~ filename
  end
rescue RegexpError
end
