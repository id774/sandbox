// d3.js: Label and value pairs loaded from JSON with d3
//
// Description:
// Print the label and value pairs loaded from d3.json with d3. d3.html in this
// directory loads it.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     python3 -m http.server 8000
//     Then open simple-json/d3.html through the server.
//
// Requirements:
// - A web browser
// - D3 3.x at d3/d3.min.js beside d3.html, which d3.html loads
//

d3.json("d3.json", function(error, data){
    var text = "";
    for(var i=0; i<data.length; i++){
        text += data[i].label + " = " + data[i].value + "<br>";
    }
    d3.select("#result").html(text);
});
