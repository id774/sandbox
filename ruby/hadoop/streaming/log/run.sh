#!/bin/sh

hadoop fs -ls
hadoop dfs -rmr test2
hadoop fs -put ~/tmp/log201206 test2/in/

export HADOOP_ROOT=/usr/lib/hadoop
export HADOOP_JAR=$HADOOP_ROOT/contrib/streaming/hadoop-streaming-0.20.2-cdh3u4.jar

hadoop jar $HADOOP_JAR \
  -file map.rb -mapper map.rb \
  -file reduce.rb -reducer reduce.rb \
  -input test2/in/* -output test2/out

hadoop fs -cat test2/out/part-00000

