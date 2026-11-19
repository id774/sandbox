# basename.rb: Strip a file extension with File.basename
#
# Description:
# Strip the extension from a file name with File.basename.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby basename.rb
#
# Requirements:
# - Ruby
#

def extract_basename(filename)
  basename = File.basename(filename, File.extname(filename))
  return "#{filename} => #{basename}"
end

p extract_basename("hoge.txt")
p extract_basename("fuga.tar.gz")
p extract_basename("test.csv")
p extract_basename("a.b.c.d.e")
