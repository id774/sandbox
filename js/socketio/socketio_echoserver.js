// socketio_echoserver.js: Socket.IO server that echoes and broadcasts messages
//
// Description:
// Echo Socket.IO messages back to the sender and broadcast them.
// socketio.listen is given an existing HTTP server named server, which this
// file does not define.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Requirements:
// - Node.js with the pre-1.0 socket.io package, as js/socketio/README.md
//   describes
//

var socketio = require('socket.io');

// websocket
var io = socketio.listen(server);

io.on('connection', function(client) {
    client.on('message', function(message) {
        // Runs when a client sends a message
        // message holds the data that was sent
        client.send(message); // send only to the client that sent it
        client.broadcast(message); // send to everyone except the sender
    });
});
