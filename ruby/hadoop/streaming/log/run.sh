#!/bin/sh

hadoop fs -ls
hadoop dfs -rmr test2
hadoop fs -put ~/tmp/log201206 logs/in/

export HADOOP_ROOT=/usr/lib/hadoop
export HADOOP_JAR=$HADOOP_ROOT/contrib/streaming/hadoop-streaming-0.20.2-cdh3u4.jar

hadoop jar $HADOOP_JAR \
  -file ip_mapper.rb -mapper ip_mapper.rb \
  -file ip_reducer.rb -reducer ip_reducer.rb \
  -input logs/in/* -output logs/ip

hadoop fs -cat logs/ip/part-00000

#hadoop jar $HADOOP_JAR \
#  -file dns_mapper.rb -mapper dns_mapper.rb \
#  -file dns_reducer.rb -reducer dns_reducer.rb \
#  -input logs/ip/part-00000 -output logs/dns

