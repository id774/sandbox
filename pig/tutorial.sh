#!/bin/sh
# tutorial.sh: Download the Pig tutorial and run it
#
# Description:
# Download and unpack the Apache Pig tutorial, change to pigtmp, and run
# tutorial-run.sh unless an argument is given.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh tutorial.sh [skip-run flag]
#
# Requirements:
# - A POSIX shell, wget, and tar
# - Network access to cwiki.apache.org
# - The requirements of tutorial-run.sh when the tutorial is run
#

wget -O  tutorial.tar.gz "https://cwiki.apache.org/confluence/download/attachments/27822259/pigtutorial.tar.gz?version=1&modificationDate=1311188529000"
tar xzvf tutorial.tar.gz
cd pigtmp

test -n "$1" || ../tutorial-run.sh

