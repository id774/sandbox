#!/bin/sh
# sample4.sh: setUp and tearDown around a counter with shunit2
#
# Description:
# Exercise setUp and tearDown around a counter with shunit2.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh sample4.sh
#
# Requirements:
# - A POSIX shell
# - shUnit2, loaded as shunit2 from the shell search path
#

setUp() {
  i=10
}

add() {
  i=`expr $i + 1`
}

testAdd() {
  add
  assertEquals $i "11"
}

tearDown() {
  echo $i
}


main() {
  i=0
  add
  echo $i
}

. shunit2
#main
