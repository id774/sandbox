# faviconChange.coffee: Animate favicons from page buttons
#
# Description:
# Bind page elements to favicon animations through the favicon object when the
# page loads. faviconChange.js is its compiled output.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     coffee -c faviconChange.coffee
#
# Requirements:
# - CoffeeScript, to compile it
# - The compiled favicon.js in the same page
#

window.onload = ->
  resetSequence = ->
    sequence = new Array("/images/white_16.png")
    favicon.animate sequence
  $ = (id) ->
    document.getElementById id
  favicon.defaultPause = 2500
  favicon.change "/favicon.ico"
  resetSequence()
  document.onkeypress = (ev) ->
    ev = ev or window.event
    unicode = (if ev.keyCode then ev.keyCode else ev.charCode)
    char = String.fromCharCode(unicode)
    if char is "," and favicon.defaultPause >= 100
      favicon.defaultPause -= 100
    else favicon.defaultPause += 100  if char is "." and favicon.defaultPause < 10000
    resetSequence()
