#!/usr/bin/env ruby
# graphvis_sample.rb: Build and render a graph with ruby-graphviz
#
# Description:
# Build a graph and render it with ruby-graphviz. An optional argument gives
# the path of the Graphviz executables.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby graphvis_sample.rb [Graphviz path]
#
# Requirements:
# - Ruby
# - The ruby-graphviz gem and Graphviz
#

require "rubygems"
gem "ruby-graphviz"
require "graphviz"


g = nil
if ARGV[0]
  g = GraphViz::new( "G", :path => ARGV[0] )
else
  g = GraphViz::new( "G" )
end

main        = g.add_nodes( "main" )
parse       = g.add_nodes( "parse" )
execute     = g.add_nodes( "execute" )
init        = g.add_nodes( "init" )
cleanup     = g.add_nodes( "cleanup" )
make_string = g.add_nodes( "make_string" )
printf      = g.add_nodes( "printf" )
compare     = g.add_nodes( "compare" )

g.add_edges( main, parse )
g.add_edges( parse, execute )
g.add_edges( main, init )
g.add_edges( main, cleanup )
g.add_edges( execute, make_string )
g.add_edges( execute, printf )
g.add_edges( init, make_string )
g.add_edges( main, printf )
g.add_edges( execute, compare )

g.output(:png => "sample.png")
