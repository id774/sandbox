# d3js.circle.coffee: Draw a circle with d3
#
# Description:
# Draw a circle into an SVG element in #canvas1 with d3 when the page loads.
# d3js.circle.js is its compiled output.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     coffee -c d3js.circle.coffee
#
# Requirements:
# - CoffeeScript, to compile it
# - D3 in the page that loads the compiled script
#

window.addEventListener("load", ->
    canvas = d3.select "#canvas1"
    svg = canvas.append("svg")
        .attr("width", 200)
        .attr("height", 200)
    circle = svg.append("circle")
      .attr("cx", 100)
      .attr("cy", 100)
      .attr("r", 80)
      .attr("fill","red")
      .attr("stroke", "orange")
      .attr("stroke-width", 10)
, false)
