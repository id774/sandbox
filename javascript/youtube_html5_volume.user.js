// ==UserScript==
// @name Youtube HTML5 Player default volume setter
// @namespace http://soralabo.net
// @description Set Initialize volume in youtube html5 player.
// @version 1.1
// @include http://*youtube.com/watch*
// ==/UserScript==

(function(){
  var video = document.getElementsByTagName("video")[0];
  if (!window.localStorage.youtube_html5_player_default_volume) {
    window.localStorage.youtube_html5_player_default_volume = 0.7;
  }

  if (video) {
    video.volume = window.localStorage.youtube_html5_player_default_volume;
    video.addEventListener("volumechange", function() {
      window.localStorage.youtube_html5_player_default_volume = video.volume;
    });
  }
})();
