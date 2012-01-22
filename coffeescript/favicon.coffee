favicon =
  defaultPause: 2000
  change: (iconURL, optionalDocTitle) ->
    clearTimeout @loopTimer
    document.title = optionalDocTitle  if optionalDocTitle
    @addLink iconURL, true

  animate: (iconSequence, optionalDelay) ->
    @preloadIcons iconSequence
    @iconSequence = iconSequence
    @sequencePause = (if (optionalDelay) then optionalDelay else @defaultPause)
    favicon.index = 0
    favicon.change iconSequence[0]
    @loopTimer = setInterval(->
      favicon.index = (favicon.index + 1) % favicon.iconSequence.length
      favicon.addLink favicon.iconSequence[favicon.index], false
    , favicon.sequencePause)

  loopTimer: null
  preloadIcons: (iconSequence) ->
    dummyImageForPreloading = document.createElement("img")
    i = 0

    while i < iconSequence.length
      dummyImageForPreloading.src = iconSequence[i]
      i++

  addLink: (iconURL) ->
    link = document.createElement("link")
    link.type = "image/x-icon"
    link.rel = "shortcut icon"
    link.href = iconURL
    @removeLinkIfExists()
    @docHead.appendChild link

  removeLinkIfExists: ->
    links = @docHead.getElementsByTagName("link")
    i = 0

    while i < links.length
      link = links[i]
      if link.type is "image/x-icon" and link.rel is "shortcut icon"
        @docHead.removeChild link
        return
      i++

  docHead: document.getElementsByTagName("head")[0]
