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
