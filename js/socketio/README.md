# Socket.IO

Socket.IO gives a browser and a Node server a bidirectional message channel
that stays up. When it was written, that mattered because WebSocket support was
uneven: the library negotiated the best transport available and fell back to
long polling, hiding the difference behind one API. WebSocket is universal now,
so what keeps Socket.IO in use is the rest of it — automatic reconnection,
acknowledgements, rooms, and namespaces — rather than the fallbacks.

These two files are fragments rather than a working pair: they show the shape
of each side of a connection, not a program that runs. Both use the pre-1.0
API, which is not the API a current Socket.IO exposes.

## Files

| File | Side | What it shows |
| --- | --- | --- |
| `socketio_connect.js` | Browser | Opening a connection with `new io.Socket(null, {port: 8080})` and `connect()`, sending on a jQuery click handler with `socket.send(...)`, and receiving with `socket.on('message', ...)`. |
| `socketio_echoserver.js` | Server | `socketio.listen(server)` attached to an existing HTTP server, then per connection: `client.send(message)` back to the sender and `client.broadcast(message)` to everyone else. |

The pair is worth reading for the distinction in the server file's two lines,
which is the whole reason a chat program needs a library rather than a socket:
one message goes back to its sender, the same message goes out to every other
connection.

## Running

Neither file runs as it stands.

- `socketio_echoserver.js` calls `socketio.listen(server)` without defining
  `server`; it assumes an HTTP server created elsewhere in the page's original
  context.
- `socketio_connect.js` expects jQuery and the client library on the page, and
  neither is committed, as the repository policy asks.

The APIs have also moved on. In a current Socket.IO the client is
`io("http://localhost:8080")`, messages are `socket.emit(event, payload)`
rather than `send`, and the server broadcast is `socket.broadcast.emit(...)`.
The 1.0 release in 2014 split the transport layer out into Engine.IO and
changed these names.

## Notes

Socket.IO was written by Guillermo Rauch and first released in 2010. For a
realtime feature today, the choices are this library, a plain `WebSocket` (now
supported everywhere), or server-sent events for one-way updates — the
[`htmx`](../htmx/) directory's polling sample is the cheapest version of the
same idea when the update rate is low.
