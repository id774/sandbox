#!/bin/sh
# simple.sh: Run the word count mapper and reducer locally
#
# Description:
# Pipe data.txt through map.rb, sort, and reduce.rb without Hadoop.
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

cat data.txt | ruby map.rb | sort | ruby reduce.rb
