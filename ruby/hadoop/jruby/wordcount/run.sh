#!/bin/sh
# run.sh: Run the JRuby word count on Hadoop
#
# Description:
# Upload data.txt to HDFS under test/in, run wordcount.rb with joh, and print
# the output. The script first removes the HDFS directory test.
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
# - Hadoop with the hadoop command, JRuby, and joh
#

hadoop fs -ls
hadoop dfs -rmr test
hadoop fs -put data.txt test/in/file1
joh wordcount.rb test/in test/out
hadoop fs -cat test/out/part-00000

