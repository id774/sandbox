// obj2.js: Instance and prototype property changes
//
// Description:
// Show how changing an instance property and a prototype property differ,
// serving the result over HTTP on port 3000.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     node obj2.js
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
        response.write(person.sayHello() + '\n');
        person.name = 'hoge';
        response.write(person.sayHello() + '\n');
        Person.prototype.name = 'fuga';
        response.write(person.sayHello() + '\n');
        delete Person.prototype.name;
        response.write(person.sayHello() + '\n');
        delete person.name;
        response.write(person.sayHello() + '\n');
        response.end();
    }
).listen(3000);

sys.log('Server running at http://127.0.0.1:3000/');
