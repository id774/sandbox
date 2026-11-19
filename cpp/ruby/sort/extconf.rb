# extconf.rb: Generate the Makefile for the sort extension
#
# Description:
# Use mkmf to generate a Makefile that compiles with -std=c++11, links
# libstdc++, and builds the sort Ruby extension.
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
# - A C++11 compiler and make
#

require "mkmf"
have_library("stdc++")
$CPPFLAGS += " -std=c++11 "
$libs += " -lstdc++ "
create_makefile("sort")
