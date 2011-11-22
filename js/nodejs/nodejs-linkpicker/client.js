#!/usr/bin/env node
// client.js

var sys = require('sys'),
    linkPicker = require('./linkPicker');

process.argv.forEach(function(val, index, array) {
    if (index >= 2) {
        linkPicker.pickupLinks(val, function(err, links) {
            if (err) {
                throw err;
            }

            sys.puts(val + ' contains ' + links.length + ' links');
            var sorted = linkPicker.sortLinksByHost(links);
            for (i = 0; i < sorted.hosts.length; ++i) {
                var host = sorted.hosts[i];
                sys.puts('\t' + host + ', ' +
                         sorted.hostLinks[host].length + ' links');
                for (var j = 0; j < sorted.hostLinks[host].length; ++j) {
                    sys.puts('\t\t' + sorted.hostLinks[host][j].href);
                }
            }
        });
    }
});
