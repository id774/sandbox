// Generated by CoffeeScript 1.4.0
(function() {

  window.addEventListener("load", function() {
    var canvas, circle, svg;
    canvas = d3.select("#canvas1");
    svg = canvas.append("svg").attr("width", 200).attr("height", 200);
    return circle = svg.append("circle").attr("cx", 100).attr("cy", 100).attr("r", 80).attr("fill", "red").attr("stroke", "orange").attr("stroke-width", 10);
  }, false);

}).call(this);
