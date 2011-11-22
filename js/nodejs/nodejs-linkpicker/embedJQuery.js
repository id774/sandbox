// embedJQuery.js
// jsdomとjQueryのラッパー

var fs = require('fs'),
    Script = process.binding('evals').Script,
    jsdom = require('jsdom'),
    httpsubr = require('./httpsubr');

// jQuery を読み込む
var jQueryPath = __dirname + '/jquery.min.js';
var jQueryScript = new Script(fs.readFileSync(jQueryPath, 'utf-8'),
                              jQueryPath);

// HTMLコンテンツにjQueryを埋め込み、
// windowオブジェクトとjQueryオブジェクトを返す
exports.embedJQuery = function(body, options, callback) {
    // HTMLファイル中のscriptタグの処理を無効にしてwindowを作成
    options = options || {};
    options.features = options.features || {};
    options.features.FetchExternalResources = false;
    options.features.ProcessExternalResources = false;
    var window = jsdom.jsdom(body, null, options).createWindow();

    // jQueryを実行
    jQueryScript.runInNewContext({
        window: window,
        navigator: window.navigator,
        location: window.location,
        setTimeout: setTimeout,
    });

    // callbackを呼び出す
    if (callback) {
        callback(null, window, window.jQuery);
    }
}

// URLからリソースを読み込みjQueryを追加する
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

        // コンテンツのbaseURIをtargetUrlにするためurlオプションを指定
        exports.embedJQuery(body, { url: targetUrl }, callback);
    });
}
