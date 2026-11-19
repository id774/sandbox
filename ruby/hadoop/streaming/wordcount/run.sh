#!/bin/sh
# run.sh: Run the word count with Hadoop Streaming
#
# Description:
# Upload data.txt to HDFS under test/in, run map.rb and reduce.rb with Hadoop
# Streaming into test/out, and print the output. The script first removes the
# HDFS directory test.
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
# - Hadoop with the streaming jar at
#   /usr/lib/hadoop/contrib/streaming/hadoop-streaming-0.20.2-cdh3u4.jar
# - Ruby on the Hadoop nodes
#

hadoop fs -ls
hadoop dfs -rmr test
hadoop fs -put data.txt test/in/file1

export HADOOP_ROOT=/usr/lib/hadoop
export HADOOP_JAR=$HADOOP_ROOT/contrib/streaming/hadoop-streaming-0.20.2-cdh3u4.jar

hadoop jar $HADOOP_JAR \
  -file map.rb -mapper map.rb \
  -file reduce.rb -reducer reduce.rb \
  -input test/in/* -output test/out

hadoop fs -cat test/out/part-00000

