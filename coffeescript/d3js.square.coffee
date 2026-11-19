# d3js.square.coffee: Draw squares from data with d3
#
# Description:
# Draw squares from an inline data set into an SVG element in #canvas1 with d3
# when the page loads. d3js.square.js is its compiled output.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     coffee -c d3js.square.coffee
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
    dataAttr = [
      {key1:10, key2: 10, key3: 80, key4: 80, key5: "green"},
      {key1:110, key2: 110, key3: 80, key4: 80, key5: "blue"}
    ]
 
    svg.append("rect")
    svg.append("rect")
    svg.selectAll("rect")
      .data(dataAttr)
      .attr("x", (d, i) -> d.key1)
      .attr("y", (d, i) -> d.key2)
      .attr("width", (d, i) -> d.key3)
      .attr("height", (d, i) -> d.key4)
      .attr("fill", (d, i) -> d.key5)
    svg.selectAll("rect")
      .data(dataAttr)
      .enter()
      .append("rect")
      .attr("x", (d, i) -> d.key1)
      .attr("y", (d, i) -> d.key2)
      .attr("width", (d, i) -> d.key3)
      .attr("height", (d, i) -> d.key4)
      .attr("fill", (d, i) -> d.key5)
, false)
