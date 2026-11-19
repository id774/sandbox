# zip.rb: Extract every entry of a zip archive
#
# Description:
# Extract every entry of hoge.zip in the current directory, overwriting
# existing files.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby zip.rb
#
# Requirements:
# - Ruby
# - The rubyzip gem before 1.0, which provides zip/zip
# - hoge.zip in the current directory
#

require 'zip/zip'

Zip::ZipFile.open("hoge.zip") do |zip|
  zip.each do |entry|
    puts "extract #{entry.to_s}"
    zip.extract(entry, entry.to_s) { true } # true overwrites
  end
end
