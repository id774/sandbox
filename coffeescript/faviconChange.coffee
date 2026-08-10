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
