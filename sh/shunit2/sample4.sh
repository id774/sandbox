#!/bin/sh

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
