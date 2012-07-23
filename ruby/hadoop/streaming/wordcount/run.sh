#!/bin/sh

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

