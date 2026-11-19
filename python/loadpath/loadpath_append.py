#!/usr/bin/env python
# loadpath_append.py: Extend sys.path with local library directories
#
# Description:
# Append a local lib directory and $SCRIPTS/lib to sys.path.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 loadpath_append.py
#
# Requirements:
# - Python 3
# - The SCRIPTS environment variable, which names the second library
#   directory
#

import sys
import os
p = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'lib')
if not p in sys.path:
    sys.path.append(p)
try:
    p = os.path.join(os.environ['SCRIPTS'], 'lib')
    if not p in sys.path:
        sys.path.append(p)
except KeyError:
    pass
print(sys.path)
