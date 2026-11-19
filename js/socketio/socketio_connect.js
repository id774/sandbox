// socketio_connect.js: Browser side of a Socket.IO connection
//
// Description:
// Send and receive messages over a Socket.IO connection to port 8080, sending
// the input text on a jQuery button click and showing each received message.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Requirements:
// - A web browser with jQuery and the pre-1.0 Socket.IO client, as
//   js/socketio/README.md describes
//

$(function() {

    // Create the socket
    var port = 8080;
    var socket = new io.Socket(null, {port: port});
    socket.connect();

    // Send
    $('#button').click(function() {
        var message = $('#input').val();
        socket.send(message);
        return false;
    });

    // Receive
    socket.on('message', function(obj) {
        $('#output').text(obj);
    });

});
