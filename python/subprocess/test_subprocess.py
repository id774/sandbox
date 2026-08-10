#!/usr/bin/env python
# Compare call, check_call, and check_output from subprocess.

import sys
import subprocess

r = subprocess.call('./run.sh')
print(r)

r = subprocess.check_call('./run.sh')
print(r)

r = subprocess.check_output('./run.sh')
print(r)


