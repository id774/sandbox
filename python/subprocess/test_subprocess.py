#!/usr/bin/env python

import sys
import subprocess

r = subprocess.call('./run.sh')
print(r)

r = subprocess.check_call('./run.sh')
print(r)

r = subprocess.check_output('./run.sh')
print(r)


