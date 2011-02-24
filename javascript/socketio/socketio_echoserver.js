var socketio = require('socket.io');

// websocket
var io = socketio.listen(server);

io.on('connection', function(client) {
    client.on('message', function(message) {
        //クライアントがメッセージを送って来たら実行される。
        //messageが送って来たデータ
        client.send(message); //送って来た本人だけに送る。
        client.broadcast(message); //送って来た人以外全員に送る。
    });
});
