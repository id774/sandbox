// nodejs_sample.js: Fixed greeting over HTTP that does not parse
//
// Description:
// Serve a fixed greeting over HTTP; the listen call does not parse.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Requirements:
// - Node.js, although the current source does not parse
//

var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello Node.js!\n');
}).listen(8333, *);
/* console.log('Server running at http://127.0.0.1:8333/'); */
