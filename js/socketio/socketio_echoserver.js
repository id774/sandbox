// Echo Socket.IO messages back to the sender and broadcast them.

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
