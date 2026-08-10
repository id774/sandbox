// Render a CSV column as an HTML table with d3.

d3.csv("./data.csv", function(error, list){
    d3.select("#result")
        .append("table")
        .selectAll("tr")
        .data(list)
        .enter()
        .append("tr")
        .append("td")
        .text(function(d){
            return d["value"];
        })
});
