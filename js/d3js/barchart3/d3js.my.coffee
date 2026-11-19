# d3js.my.coffee: Bar chart with scales
#
# Description:
# Draw bars from inline data positioned with d3 scales into #canvas1.
# d3js.my.js is its compiled output.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     coffee -c d3js.my.coffee
#
# Requirements:
# - CoffeeScript, only to recompile it
#

window.addEventListener("load", ->
    canvas   = d3.select "#canvas1"
    svg      = canvas.append("svg")
      .attr("width", 200)
      .attr("height", 200)
    dataAttr1 = [
      { name: "Aya", value: 80},
      { name: "Bunbun", value: 85},
      { name: "Charry", value: 70},
      { name: "David", value: 75},
      { name: "Eris", value: 40}
    ]
    xScale = d3.scale.linear().domain([0,100]).range([0,200])
    console.log xScale 45
    yScale = d3.scale.linear().domain([0,5]).range([0,100])
    console.log yScale 3
    x = 0
    height = 18
    color = "blue"
 
    svg.selectAll("rect")
      .data(dataAttr1)
      .enter()
      .append("rect")
      .attr("x", x)
      .attr("y", (d,i) -> yScale i)
      .attr("width", ((d) -> xScale d.value))
      .attr("height", height)
      .attr("fill", color)
, false)
