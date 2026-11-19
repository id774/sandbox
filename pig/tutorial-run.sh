#!/bin/sh
# tutorial-run.sh: Run the Pig tutorial scripts locally
#
# Description:
# Run script1-local.pig and script2-local.pig in Pig local mode and print each
# result, or report the job that failed.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh tutorial-run.sh
#
# Requirements:
# - A POSIX shell
# - Apache Pig with the pig command
# - The Pig tutorial scripts in the current directory
#

pig -x local script1-local.pig
test -f script1-local-results.txt/_SUCCESS && cat script1-local-results.txt/part-r-00000
test -f script1-local-results.txt/_SUCCESS || echo "script1 Job Failed !!!"

pig -x local script2-local.pig
test -f script2-local-results.txt/_SUCCESS && cat script2-local-results.txt/part-r-00000
test -f script2-local-results.txt/_SUCCESS || echo "script2 Job Failed !!!"

