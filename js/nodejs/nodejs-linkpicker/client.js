#!/usr/bin/env node
// client.js: Command line entry point of the link picker
//
// Description:
// Print the links of each page given on the command line, grouped by host.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     node client.js <URL>...
//
// Requirements:
// - An early Node.js release that still provides sys.puts,
//   http.createClient, and process.binding('evals')
// - The jsdom and iconv packages and jquery.min.js beside embedJQuery.js, as
//   js/nodejs/README.md describes
//

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
