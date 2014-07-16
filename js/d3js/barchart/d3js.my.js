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
