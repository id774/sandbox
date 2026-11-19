#!/bin/sh
# simple.sh: Run the log mapper and reducer locally
#
# Description:
# Pipe data.txt through mapper.rb, sort, and reducer.rb without Hadoop.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh simple.sh
#
# Requirements:
# - A POSIX shell and Ruby
#

cat data.txt | ruby mapper.rb | sort | ruby reducer.rb
