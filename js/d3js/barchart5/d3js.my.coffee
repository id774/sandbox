window.addEventListener("load", ->
  d3.json("data.json", (data)->
    canvas   = d3.select "#canvas1"
    svg = canvas.append("svg")
      .attr("width", 200)
      .attr("height", 200)

    xScale = d3.scale.linear().domain([0,100]).range([0,200])
    console.log xScale 45
    yScale = d3.scale.linear().domain([0,5]).range([0,100])
    console.log yScale 3

    x = 0
    height = 18
    color = "blue"

    svg.selectAll("rect")
      .data(data)
      .enter()
      .append("rect")
      .attr("x", x)
      .attr("y", (d,i) -> yScale i)
      .attr("width", ((d) -> xScale d.value))
      .attr("height", height)
      .attr("fill", color)

    svg.selectAll("text")
      .data(data)
      .enter()
      .append("text")
      .attr("x", x + 2)
      .attr("y", (d,i) -> yScale(i) + height - 2)
      .text((d) -> d.name)
      .attr("fill", "white")

    svg.selectAll("text2")
      .data(data)
      .enter()
      .append("text")
      .attr("x", (d) -> xScale(d.value) - 20)
      .attr("y", (d,i) -> yScale(i) + height - 2)
      .text((d) -> d.value)
      .attr("fill", "white")
  )
, false)
