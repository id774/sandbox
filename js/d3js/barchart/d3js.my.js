// d3js.my.js: Bar chart from a CSV column with d3
//
// Description:
// Draw a bar chart from the value column of data.csv with d3. index.html in
// this directory loads it.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     python3 -m http.server 8000
//     Then open barchart/index.html through the server.
//
// Requirements:
// - A web browser
// - D3 3.x at /d3/d3.min.js on the serving host, as js/d3js/README.md
//   describes
//

d3.csv('data.csv', function(csvdata) {
    var dataset = [];
    for (var i = 0; i < csvdata.length; i++) {
        dataset.push(csvdata[i]['value']);
    };
    make(dataset);
});

function make(dataset) {
    d3.select('svg').selectAll('rect')
    .data(dataset)
    .enter()
    .append('rect')
    .attr({
        x : function(d, i){ return i * 30; },
        y : function(d){ return 300 - d; },
        width : 15,
        height : function(d){ return d; },
        fill : '#6fbadd'
    });
}
