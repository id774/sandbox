#!/bin/sh

testAssertTrue() {
  assertTrue "[ 34 -gt 23 ]"
}

testAssertFalse() {
  assertFalse 'test failed' "[ -r /some/non-existant/file' ]"
}

. shunit2
