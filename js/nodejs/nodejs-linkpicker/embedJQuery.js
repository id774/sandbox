// embedJQuery.js
// A wrapper around jsdom and jQuery

var fs = require('fs'),
    Script = process.binding('evals').Script,
    jsdom = require('jsdom'),
    httpsubr = require('./httpsubr');

// Load jQuery
var jQueryPath = __dirname + '/jquery.min.js';
var jQueryScript = new Script(fs.readFileSync(jQueryPath, 'utf-8'),
                              jQueryPath);

// Embed jQuery into the HTML content and return
// the window object and the jQuery object
exports.embedJQuery = function(body, options, callback) {
    // Build the window with the script tags in the HTML disabled
    options = options || {};
    options.features = options.features || {};
    options.features.FetchExternalResources = false;
    options.features.ProcessExternalResources = false;
    var window = jsdom.jsdom(body, null, options).createWindow();

    // Run jQuery
    jQueryScript.runInNewContext({
        window: window,
        navigator: window.navigator,
        location: window.location,
        setTimeout: setTimeout,
    });

    // Invoke the callback
    if (callback) {
        callback(null, window, window.jQuery);
    }
}

// Fetch the resource from a URL and attach jQuery to it
exports.jQueryRequest = function(targetUrl, callback) {
    httpsubr.get({ uri: targetUrl }, function(err, response, raw) {
        if (!err) {
            if (response.statusCode != 200) {
                err = new Error("HTTP Error");
            }
        }
        if (err) {
            if (callback) {
                callback(err);
            } else {
                throw err;
            }
            return;
        }

        var body = httpsubr.convertCharset(response, raw);

        // Pass the url option so the content baseURI becomes targetUrl
        exports.embedJQuery(body, { url: targetUrl }, callback);
    });
}
