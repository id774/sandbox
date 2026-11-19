# extconf.rb: Generate the Makefile for the human extension
#
# Description:
# Use mkmf to generate a Makefile that links libstdc++ and builds the human
# Ruby extension.
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

require "mkmf"
$libs += " -lstdc++ "
create_makefile("human")
