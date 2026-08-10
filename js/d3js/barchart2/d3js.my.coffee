window.addEventListener("load", ->
    canvas   = d3.select "#canvas1"
    svg      = canvas.append("svg")
      .attr("width", 200)
      .attr("height", 200)
    dataAttr = [
      {key1:0, key2: 0, key3: 160, key4: 18, key5: "blue"},
      {key1:0, key2: 20, key3: 170, key4: 18, key5: "blue"},
      {key1:0, key2: 40, key3: 140, key4: 18, key5: "blue"},
      {key1:0, key2: 60, key3: 150, key4: 18, key5: "blue"},
      {key1:0, key2: 80, key3: 80, key4: 18, key5: "blue"}
    ]
 
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
