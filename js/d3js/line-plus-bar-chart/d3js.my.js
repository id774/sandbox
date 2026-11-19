// d3js.my.js: Combined line and bar chart with NVD3
//
// Description:
// Draw a combined line and bar chart from linePlusBarData.json with NVD3.
// index.html in this directory loads it.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     python3 -m http.server 8000
//     Then open line-plus-bar-chart/index.html through the server.
//
// Requirements:
// - A web browser
// - D3 3.x at /d3/d3.min.js on the serving host, as js/d3js/README.md
//   describes
// - NVD3 at /nvd3/nv.d3.min.js on the serving host
//

d3.json("linePlusBarData.json",function(error,data) {
  nv.addGraph(function() {
      var chart = nv.models.linePlusBarChart()
            .margin({top: 30, right: 60, bottom: 50, left: 70})
            //We can set x data accessor to use index. Reason? So the bars all appear evenly spaced.
            .x(function(d,i) { return i })
            .y(function(d,i) {return d[1] })
            ;

      chart.xAxis.tickFormat(function(d) {
        var dx = data[0].values[d] && data[0].values[d][0] || 0;
        return d3.time.format('%x')(new Date(dx))
      });

      chart.y1Axis
          .tickFormat(d3.format(',f'));

      chart.y2Axis
          .tickFormat(function(d) { return '$' + d3.format(',f')(d) });

      chart.bars.forceY([0]);

      d3.select('#chart svg')
        .datum(data)
        .transition()
        .duration(0)
        .call(chart);

      nv.utils.windowResize(chart.update);

      return chart;
  });

});
