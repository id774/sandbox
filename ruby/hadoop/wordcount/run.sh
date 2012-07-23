#!/bin/sh

hadoop fs -ls
hadoop dfs -rmr test
hadoop fs -put data.txt test/in/file1
joh wordcount.rb test/in test/out
hadoop fs -cat test/out/part-00000

