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
