// obj.js: Greeting built by a prototype method
//
// Description:
// Serve a greeting built by a prototype method over HTTP on port 3000.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     node obj.js
//
// Requirements:
// - Node.js with the deprecated sys module
//

var sys  = require('sys');
var http = require('http');

var Person = function (name) {
    this.name = name;
}

Person.prototype.sayHello = function() {
    return ('Hello ' + this.name);
}

var person = new Person('Nicole');

var server = http.createServer(
    function (request, response) {
        response.writeHead(200, {'Content-Type': 'text/plain'});
        response.write(person.sayHello());
        response.end();
    }
).listen(3000);

sys.log('Server running at http://127.0.0.1:3000/');
