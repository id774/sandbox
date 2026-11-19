#!/bin/sh
# mapper_test.sh: Pipe data.txt through the IP mapper and reducer
#
# Description:
# Pipe data.txt through ip_mapper.rb, sort, and ip_reducer.rb.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh mapper_test.sh
#
# Requirements:
# - A POSIX shell and Ruby
# - ip_mapper.rb and ip_reducer.rb, which are not included in this directory
#

cat data.txt | ruby ip_mapper.rb | sort | ruby ip_reducer.rb
