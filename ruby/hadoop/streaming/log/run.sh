#!/bin/sh
# run.sh: Run the log job with Hadoop Streaming
#
# Description:
# Upload ~/tmp/log201206 to HDFS under logs/in, run mapper.rb and reducer.rb
# with Hadoop Streaming into logs/ip, and print the output. The script first
# removes logs/in and logs/out in HDFS.
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
# - Ruby on the Hadoop nodes and log files in ~/tmp/log201206
#

hadoop fs -ls
hadoop dfs -rmr logs/in
hadoop dfs -rmr logs/out
hadoop fs -put ~/tmp/log201206 logs/in/

export HADOOP_ROOT=/usr/lib/hadoop
export HADOOP_JAR=$HADOOP_ROOT/contrib/streaming/hadoop-streaming-0.20.2-cdh3u4.jar

hadoop jar $HADOOP_JAR \
  -file mapper.rb -mapper mapper.rb \
  -file reducer.rb -reducer reducer.rb \
  -input logs/in/* -output logs/ip

hadoop fs -cat logs/ip/part-00000

