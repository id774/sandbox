#!/bin/sh
# sample3.sh: assertTrue and assertFalse with shunit2
#
# Description:
# Exercise assertTrue and assertFalse with shunit2.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh sample3.sh
#
# Requirements:
# - A POSIX shell
# - shUnit2, loaded as shunit2 from the shell search path
#

testAssertTrue() {
  assertTrue "[ 34 -gt 23 ]"
}

testAssertFalse() {
  assertFalse 'test failed' "[ -r /some/non-existant/file' ]"
}

. shunit2
