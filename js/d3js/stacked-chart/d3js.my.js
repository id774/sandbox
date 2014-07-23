d3.json('histcatexplong.json', function(data) {
  var colors = d3.scale.category20();
  keyColor = function(d, i) {return colors(d.key)};

  var chart;
  nv.addGraph(function() {
    chart = nv.models.stackedAreaChart()
                 // .width(600).height(500)
                  .useInteractiveGuideline(true)
                  .x(function(d) { return d[0] })
                  .y(function(d) { return d[1] })
                  .color(keyColor)
                  .transitionDuration(300);

    chart.xAxis
        .tickFormat(function(d) { return d3.time.format('%x')(new Date(d)) });

    chart.yAxis
        .tickFormat(d3.format(',.2f'));

    d3.select('#chart1')
      .datum(data)
      .transition().duration(1000)
      .call(chart)
      // .transition().duration(0)
      .each('start', function() {
          setTimeout(function() {
              d3.selectAll('#chart1 *').each(function() {
                console.log('start',this.__transition__, this)
                // while(this.__transition__)
                if(this.__transition__)
                  this.__transition__.duration = 1;
              })
            }, 0)
        })
      // .each('end', function() {
      //         d3.selectAll('#chart1 *').each(function() {
      //           console.log('end', this.__transition__, this)
      //           // while(this.__transition__)
      //           if(this.__transition__)
      //             this.__transition__.duration = 1;
      //         })});

    nv.utils.windowResize(chart.update);

    // chart.dispatch.on('stateChange', function(e) { nv.log('New State:', JSON.stringify(e)); });

    return chart;
  });
});

d3.json('histcatexpshort.json', function(data) {
  nv.addGraph(function() {
    var chart = nv.models.stackedAreaChart()
                  .x(function(d) { return d[0] })
                  .y(function(d) { return d[1] })
                  .color(keyColor)
                  ;
                  //.clipEdge(true);

    chart.xAxis
        .tickFormat(function(d) { return d3.time.format('%x')(new Date(d)) });

    chart.yAxis
        .tickFormat(d3.format(',.2f'));

    d3.select('#chart2')
      .datum(histcatexpshort)
      .transition()
        .call(chart);

    nv.utils.windowResize(chart.update);

    return chart;
  });
});
