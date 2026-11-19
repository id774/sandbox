# extconf.rb: Generate the Makefile for the hello extension
#
# Description:
# Use mkmf to generate a Makefile that links libstdc++ and builds the hello
# Ruby extension from hello.cpp and hello_wrp.cpp. Readme.md in this directory
# describes the files.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby extconf.rb
#     make
#     ruby test.rb
#
# Requirements:
# - Ruby with its C extension development headers and mkmf
# - A C++ compiler and make
#

require 'mkmf'

have_library("stdc++")

create_makefile("hello")
