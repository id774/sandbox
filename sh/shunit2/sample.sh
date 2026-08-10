#!/bin/sh
# Assert a trivial equality with shunit2.

testEquality()
{
  assertEquals 1 1
}

# load shunit2
. shunit2
