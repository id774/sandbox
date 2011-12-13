var cluster = require('cluster');
var http = require('http');
var numReqs = 0;
var numCPUs = require('os').cpus().length;
var REQUESTS_PER_CHILD = 80;
var REQUEST_TIMEOUT = 3000;

if (cluster.isMaster) {
  // Fork workers.
  (function () {
    var pids = {};

    cluster.on('death', function () {
        spawn();
    });

    function spawn() {
        var worker = cluster.fork();
        pids[worker.pid] = true;
        worker.timers = {};

        worker.on('message', function(msg) {
            if (msg.cmd) {
                switch (msg.cmd) {
                case 'notifyRequest':
                    numReqs++;
                    break;
                case 'beg_req':
                    var that = this;
                    console.log('set: ' + this.pid + " : " + msg.i);
                    worker.timers[msg.i] = setTimeout(
                        function () {
                            console.log('timeout : ' + msg.i + " PID: " + that.pid);
                            process.kill(that.pid, 'SIGTERM');
                        }, msg.timeout
                    );
                    break;
                case 'end_req':
                    console.log('clear: ' + this.pid + " : " + msg.i);
                    clearTimeout(worker.timers[msg.i]);
                    delete worker.timers[msg.i];
                    break;
                case 'close':
                    console.log('closed child');
                    break;
                }
            }
        });
    };
    for (var i = 0; i < Math.max(numCPUs-1, 1); i++) {
        spawn();
    }

    setInterval(function() {
        console.log("numReqs =", numReqs);
    }, 1000);
  })();
} else {
  // Worker processes have a http server.
  console.log('spawned worker: ' + process.pid);
  var i=0;
  var server = http.Server(function(req, res) {
    process.send({cmd: 'beg_req', i: i, timeout: REQUEST_TIMEOUT});
    req.on('end', function () {
        console.log('request close');
        process.send({cmd: 'end_req', i: i-1});
    });
    if (req.url == '/slow') {
        while (1) { }
    }

    res.writeHead(200);
    res.end("hello world: " + (i+1) + "\n");
    // Send message to master process
    process.send({ cmd: 'notifyRequest' });

    if (++i>=REQUESTS_PER_CHILD) {
        this.close();
    }
  });
  server.on('close', function () {
    process.send({ cmd: 'close' });
    console.log('close worker: ' + process.pid);
    process.exit(0);
  });
  server.listen(3000);
}
