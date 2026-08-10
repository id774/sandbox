#!/bin/sh
# Pass a single init action to every Hadoop 0.20 daemon in turn.

test -n "$1" || exit 1
export HADOOP_VER=0.20
sudo /etc/init.d/hadoop-$HADOOP_VER-namenode $1
sudo /etc/init.d/hadoop-$HADOOP_VER-jobtracker $1
sudo /etc/init.d/hadoop-$HADOOP_VER-datanode $1
sudo /etc/init.d/hadoop-$HADOOP_VER-tasktracker $1

