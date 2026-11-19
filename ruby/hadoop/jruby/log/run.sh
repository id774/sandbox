#!/bin/sh
# run.sh: Run the JRuby log word count on Hadoop
#
# Description:
# Merge the logs in ~/tmp/log201206 with merge.rb, upload the result to HDFS
# under test/in, run map_reduce.rb with joh, and print the output. The script
# first removes the HDFS directory test.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh run.sh
#
# Requirements:
# - A POSIX shell
# - Hadoop with the hadoop command, Ruby, JRuby, and joh
# - Log files in ~/tmp/log201206
#

hadoop fs -ls
hadoop dfs -rmr test
ruby merge.rb ~/tmp/log201206
hadoop fs -put tempfile.txt test/in/file1
rm tempfile.txt
joh map_reduce.rb test/in test/out
hadoop fs -cat test/out/part-00000

