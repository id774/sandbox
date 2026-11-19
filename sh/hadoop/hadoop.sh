#!/bin/sh
# hadoop.sh: Pass one init action to every Hadoop 0.20 daemon
#
# Description:
# Pass a single init action to every Hadoop 0.20 daemon in turn. The script
# exits with status 1 when no action is given.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh hadoop.sh <start|stop|restart|status>
#
# Requirements:
# - A POSIX shell
# - sudo privilege and the Hadoop 0.20 init scripts under /etc/init.d
#

test -n "$1" || exit 1
export HADOOP_VER=0.20
sudo /etc/init.d/hadoop-$HADOOP_VER-namenode $1
sudo /etc/init.d/hadoop-$HADOOP_VER-jobtracker $1
sudo /etc/init.d/hadoop-$HADOOP_VER-datanode $1
sudo /etc/init.d/hadoop-$HADOOP_VER-tasktracker $1

