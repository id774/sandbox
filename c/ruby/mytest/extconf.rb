# extconf.rb: Generate the Makefile for the mytest extension
#
# Description:
# Use mkmf to generate a Makefile that builds MyTest.c as the mytest Ruby
# extension.
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
# - Ruby with its C extension development headers (ruby.h) and mkmf
# - A C compiler and make
#

# Loads mkmf which is used to make makefiles for Ruby extensions
require 'mkmf'

# Give it a name
extension_name = 'mytest'

# The destination
dir_config(extension_name)

# Do the work
create_makefile(extension_name)
