#!/bin/sh

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

