// add-items.js: Add items to a Backbone collection and render them
//
// Description:
// Add items to a Backbone collection and render each one as it arrives.
// index.html in this directory loads it.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     python3 -m http.server 8000
//     Then open add-items/index.html through the server.
//
// Requirements:
// - A web browser
// - Underscore, jQuery, and Backbone under /lib/js/ on the serving host, as
//   js/backbonejs/README.md describes
//

var Item = Backbone.Model.extend({
    initialize: function() {
        this.set({date: new Date()});
    }
});

var Items = Backbone.Collection.extend({
    model: Item
});

var ItemView = Backbone.View.extend({
    el: "#items",
    events: {
        "click button": "addItem"
    },
    initialize: function() {
        this.collection = new Items();
        this.collection.bind("add", this.render, this);
    },
    render: function(item) {
        $(this.el).children("ul").append(this.template(item));
    },
    addItem: function() {
        var rand = Math.floor(Math.random()*this.nameTemplate.length);
        var name = this.nameTemplate[rand];
        var item = new Item({itemName: name});
        this.collection.add(item);
    },
    template: function(item) {
        return "<li>"+item.get("itemName")+"</li>";
    },
    nameTemplate: [
        "りんご",
        "みかん",
        "バナナ",
        "メロン",
        "いちご",
        "パパイヤ",
        "マンゴー",
        "ライチ",
        "すいか",
        "桃",
        "キウイ",
        "ぶどう",
        "梨",
        "さくらんぼ"
    ]
});
