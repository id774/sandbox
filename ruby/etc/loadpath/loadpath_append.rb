#!/usr/bin/env ruby
# Prepend a local lib directory and $SCRIPTS/lib to the load path.
$:.unshift File.join(ENV['SCRIPTS'], 'lib') unless ENV['SCRIPTS'] == nil
$:.unshift File.join(File.dirname(__FILE__), 'lib')
p $:
