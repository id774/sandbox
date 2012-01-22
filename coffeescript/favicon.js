(function() {
  var favicon;

  favicon = {
    defaultPause: 2000,
    change: function(iconURL, optionalDocTitle) {
      clearTimeout(this.loopTimer);
      if (optionalDocTitle) document.title = optionalDocTitle;
      return this.addLink(iconURL, true);
    },
    animate: function(iconSequence, optionalDelay) {
      this.preloadIcons(iconSequence);
      this.iconSequence = iconSequence;
      this.sequencePause = (optionalDelay ? optionalDelay : this.defaultPause);
      favicon.index = 0;
      favicon.change(iconSequence[0]);
      return this.loopTimer = setInterval(function() {
        favicon.index = (favicon.index + 1) % favicon.iconSequence.length;
        return favicon.addLink(favicon.iconSequence[favicon.index], false);
      }, favicon.sequencePause);
    },
    loopTimer: null,
    preloadIcons: function(iconSequence) {
      var dummyImageForPreloading, i, _results;
      dummyImageForPreloading = document.createElement("img");
      i = 0;
      _results = [];
      while (i < iconSequence.length) {
        dummyImageForPreloading.src = iconSequence[i];
        _results.push(i++);
      }
      return _results;
    },
    addLink: function(iconURL) {
      var link;
      link = document.createElement("link");
      link.type = "image/x-icon";
      link.rel = "shortcut icon";
      link.href = iconURL;
      this.removeLinkIfExists();
      return this.docHead.appendChild(link);
    },
    removeLinkIfExists: function() {
      var i, link, links;
      links = this.docHead.getElementsByTagName("link");
      i = 0;
      while (i < links.length) {
        link = links[i];
        if (link.type === "image/x-icon" && link.rel === "shortcut icon") {
          this.docHead.removeChild(link);
          return;
        }
        i++;
      }
    },
    docHead: document.getElementsByTagName("head")[0]
  };

}).call(this);
