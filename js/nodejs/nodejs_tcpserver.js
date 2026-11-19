// nodejs_tcpserver.js: TCP server echoing accumulated lines
//
// Description:
// Echo the accumulated lines back to each TCP client on localhost:8333.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     node nodejs_tcpserver.js
//
// Requirements:
// - Node.js with the deprecated sys module
//

var net = require('net');
var sys = require('sys');
var server = net.createServer(function (stream) {
  var array = [];
  stream.setEncoding('utf8');
  stream.on('connect', function () {
    stream.write('connected\r\n');
  });
  stream.on('data', function (data) {
    array.push(data.slice(0,-2));
    stream.write('res: ' + array.join(',') + '\n');
  });
  stream.on('end', function () {
    sys.log('disconnected')
    stream.end();
  });
});
server.listen(8333, 'localhost');
