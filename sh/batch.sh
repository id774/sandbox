#!/bin/bash
# batch.sh: Process the words of a function's output one by one
#
# Description:
# Split the output of a data function into arguments and process them one by
# one.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     bash batch.sh
#
# Requirements:
# - Bash
#

process() {
    echo $1
}

batch() {
    while [ $# -gt 0 ]
    do
        process $1
        shift
    done
}

data() {
    echo "1 2 3"
}

batch `data`
