// Serve a fixed greeting over HTTP on port 3000.

var sys = require('sys');
var http = require('http');
 
var server = http.createServer(
    function (request, response) {
 
        response.writeHead(200, {'Content-Type': 'text/plain'});
        response.write('Hello World!!\n');
        response.end();
    }
).listen(3000);
 
sys.log('Server running at http://127.0.0.1:3000/');
