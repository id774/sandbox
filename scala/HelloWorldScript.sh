#!/bin/sh
# HelloWorldScript.sh: Run an inline Scala program as a shell script
#
# Description:
# Run an inline Scala program directly as a shell script. The shell part
# executes scala on this file, and scala skips the script header up to the !#
# line.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh HelloWorldScript.sh
#
# Requirements:
# - A POSIX shell
# - Scala 2 with the scala script runner
#

exec scala "$0" "$@"
!#
object HelloWorld extends App {
  println("Hello, world!")
}

HelloWorld.main(args)
