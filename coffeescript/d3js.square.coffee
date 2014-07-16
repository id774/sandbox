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
