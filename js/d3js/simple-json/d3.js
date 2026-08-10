// Print the label and value pairs loaded from JSON with d3.

d3.json("d3.json", function(error, data){
    var text = "";
    for(var i=0; i<data.length; i++){
        text += data[i].label + " = " + data[i].value + "<br>";
    }
    d3.select("#result").html(text);
});
