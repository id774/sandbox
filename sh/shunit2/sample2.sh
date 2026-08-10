#!/bin/sh
# Assert equality and compare the current year with shunit2.

testEquality()
{
  assertEquals 1 1
}

testPartyLikeItIs2012()
{
  year=`date '+%Y'`
  assertEquals "It's not 2012 :-(" \
      '2012' "${year}"
}

. shunit2
