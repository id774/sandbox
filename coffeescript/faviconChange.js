(function() {

  window.onload = function() {
    var $, resetSequence;
    resetSequence = function() {
      var sequence;
      sequence = new Array("/images/white_16.png");
      return favicon.animate(sequence);
    };
    $ = function(id) {
      return document.getElementById(id);
    };
    favicon.defaultPause = 2500;
    favicon.change("/favicon.ico");
    resetSequence();
    return document.onkeypress = function(ev) {
      var char, unicode;
      ev = ev || window.event;
      unicode = (ev.keyCode ? ev.keyCode : ev.charCode);
      char = String.fromCharCode(unicode);
      if (char === "," && favicon.defaultPause >= 100) {
        favicon.defaultPause -= 100;
      } else {
        if (char === "." && favicon.defaultPause < 10000) {
          favicon.defaultPause += 100;
        }
      }
      return resetSequence();
    };
  };

}).call(this);
