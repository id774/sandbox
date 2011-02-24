$(function() {

    // socket の生成
    var port = 8080;
    var socket = new io.Socket(null, {port: port});
    socket.connect();

    // 送信
    $('#button').click(function() {
        var message = $('#input').val();
        socket.send(message);
        return false;
    });

    // 受信
    socket.on('message', function(obj) {
        $('#output').text(obj);
    });

});
