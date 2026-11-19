// d3js.my.js: CSV column rendered as an HTML table with d3
//
// Description:
// Render data.csv as an HTML table with d3. index.html in this directory loads
// it.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     python3 -m http.server 8000
//     Then open csv2table/index.html through the server.
//
// Requirements:
// - A web browser
// - D3 3.x at /d3/d3.min.js on the serving host, as js/d3js/README.md
//   describes
//

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
