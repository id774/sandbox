#!/usr/bin/env ruby
# loadpath_append.rb: Extend the load path with local library directories
#
# Description:
# Prepend a local lib directory and $SCRIPTS/lib to the load path.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby loadpath_append.rb
#
# Requirements:
# - Ruby
# - The SCRIPTS environment variable, when its lib directory should be added
#

$:.unshift File.join(ENV['SCRIPTS'], 'lib') unless ENV['SCRIPTS'] == nil
$:.unshift File.join(File.dirname(__FILE__), 'lib')
p $:
