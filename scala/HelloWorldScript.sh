#!/bin/sh
# Run an inline Scala program directly as a shell script.

exec scala "$0" "$@"
!#
object HelloWorld extends App {
  println("Hello, world!")
}

HelloWorld.main(args)
