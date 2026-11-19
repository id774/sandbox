#!/bin/sh
# upload.sh: Convert monthly tweet databases and upload them to HDFS
#
# Description:
# For each month from 201102 through 201308, unzip twitter-db-<month>.zip,
# convert the database to JSON with sqlite3_json.rb, put the result in HDFS
# under /user/fluent/twitter, and remove the intermediate files.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh upload.sh
#
# Requirements:
# - A POSIX shell with unzip
# - Ruby at /opt/ruby/current/bin/ruby with the requirements of
#   sqlite3_json.rb
# - Hadoop at /usr/bin/hadoop and the monthly twitter-db zip files in the
#   current directory
#

upload() {
  unzip twitter-db-$1.zip 1.db
  mv 1.db $1.db
  /opt/ruby/current/bin/ruby sqlite3_json.rb $1.db $1.txt
  /usr/bin/hadoop fs -put $1.txt /user/fluent/twitter
  rm $1.db
  rm $1.txt
}

upload 201102
upload 201103
upload 201104
upload 201105
upload 201106
upload 201107
upload 201108
upload 201109
upload 201110
upload 201111
upload 201112
upload 201201
upload 201202
upload 201203
upload 201204
upload 201205
upload 201206
upload 201207
upload 201208
upload 201209
upload 201210
upload 201211
upload 201212
upload 201301
upload 201302
upload 201303
upload 201304
upload 201305
upload 201306
upload 201307
upload 201308
