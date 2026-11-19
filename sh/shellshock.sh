#!/bin/bash
# shellshock.sh: Check bash for Shellshock
#
# Description:
# Check whether bash is vulnerable to Shellshock (CVE-2014-6271).
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     bash shellshock.sh
#
# Requirements:
# - Bash
#

env x='() { :;}; echo Vulnerable' bash -c "echo This is a test."
