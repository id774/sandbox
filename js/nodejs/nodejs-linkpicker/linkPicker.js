// linkPicker.js
// Pick the links, that is the a tags, out of HTML content

var url = require('url'),
    embedJQuery = require('./embedJQuery');

// Collect the a tags with jQuery and invoke the callback
exports.pickupLinks = function(targetUrl, callback) {
    embedJQuery.jQueryRequest(targetUrl, function(err, window, $) {
        if (err) {
            if (callback) {
                callback(err);
            } else {
                throw err;
            }
            return;
        }

        var links = [];
        $('a').each(function() {
            links.push(url.parse(String(this.href)));
        });

        links.sort(function(a, b) {
            if (a.href < b.href)
                return -1;
            else if (a.href > b.href)
                return 1;
            else
                return 0;
        });

        if (callback) {
            callback(null, links);
        }
    });
}

// Group the links by host and sort them
exports.sortLinksByHost = function(links) {
    var i, j;
    var host = null;
    var hosts = [];
    var hostLinks = {};
    for (i = 0; i < links.length; ++i) {
        var link = links[i];
        var fqHost = link.protocol;
        if (link.slashes)
            fqHost += '//';
        fqHost += link.host;
        if (host != fqHost) {
            host = fqHost;
            hosts.push(fqHost);
            hostLinks[fqHost] = [];
        }
        hostLinks[fqHost].push(link);
    }
    return { hosts:hosts, hostLinks:hostLinks };
}
