#!/usr/bin/env python
# test_subprocess.py: Compare subprocess call, check_call, and check_output
#
# Description:
# Compare call, check_call, and check_output from subprocess, running run.sh
# in this directory.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 test_subprocess.py
#
# Requirements:
# - Python 3
#

import sys
import subprocess

r = subprocess.call('./run.sh')
print(r)

r = subprocess.check_call('./run.sh')
print(r)

r = subprocess.check_output('./run.sh')
print(r)


