#!/bin/bash -eux
# shebang.sh: Trace shebang options on positional parameters
#
# Description:
# Trace how the shebang options -eux expand the first three positional
# parameters.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     bash shebang.sh <arg1> <arg2> <arg3>
#
# Requirements:
# - Bash
#

: $1 $2 $3
