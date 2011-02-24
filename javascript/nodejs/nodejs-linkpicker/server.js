// server.js

var hostname = 'localhost';
var port = 8124;

var express = require('express'),
    ejs = require('ejs'),
    linkPicker = require('./linkPicker');

var app = express.createServer();
app.register('.ejs', ejs);

app.get('/', function(req, res) {
    if (req.query && req.query.url) {
        linkPicker.pickupLinks(req.query.url, function(err, links) {
            if (err) {
                console.log(err);
                res.send('403 Forbidden', 403);
                return;
            }

            res.render('result.ejs', {
                locals: {
                    url: req.query.url,
                    links: links,
                    sorted: linkPicker.sortLinksByHost(links),
                }
            });
        });
    } else {
        res.render('index.ejs', {
            locals: {
                url: '',
            },
        });
    }
});

app.listen(port, hostname);
