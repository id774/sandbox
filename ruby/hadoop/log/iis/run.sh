#!/bin/sh

hadoop fs -ls
hadoop dfs -rmr test
ruby merge.rb ~/tmp/log201206
hadoop fs -put tempfile.txt test/in/file1
rm tempfile.txt
joh map_reduce.rb test/in test/out
hadoop fs -cat test/out/part-00000

