// Send and receive messages over a Socket.IO connection.

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
