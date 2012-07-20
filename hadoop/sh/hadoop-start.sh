#!/bin/sh

sudo /etc/init.d/hadoop-0.20-namenode start
sudo /etc/init.d/hadoop-0.20-jobtracker start
sudo /etc/init.d/hadoop-0.20-datanode start
sudo /etc/init.d/hadoop-0.20-tasktracker start

