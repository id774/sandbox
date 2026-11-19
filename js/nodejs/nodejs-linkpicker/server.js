// server.js: Web entry point of the link picker
//
// Description:
// Serve the link picker on localhost:8124 with Express, rendering the links of
// the page named by the url query parameter through the EJS views.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     node server.js
//
// Requirements:
// - An early Node.js release that still provides http.createClient and
//   process.binding('evals')
// - Express 2, which provides express.createServer and app.register, and the
//   ejs package
// - The jsdom and iconv packages and jquery.min.js beside embedJQuery.js, as
//   js/nodejs/README.md describes
//

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
