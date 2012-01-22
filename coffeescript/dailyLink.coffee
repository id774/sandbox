window.onload = ->
  computeDate = (year, month, day, addDays) ->
    dt = new Date(year, month - 1, day)
    baseSec = dt.getTime()
    addSec = addDays * 86400000
    targetSec = baseSec + addSec
    dt.setTime targetSec
    dt
  computeDateFromDate = (date, addDays) ->
    yy = date.getFullYear()
    mm = date.getMonth() + 1
    dd = date.getDate()
    dt = computeDate(yy, mm, dd, addDays)
    dt
  getDateString = (date) ->
    yy = date.getFullYear()
    mm = date.getMonth() + 1
    dd = date.getDate()
    yy += 1900  if yy < 2000
    mm = "0" + mm  if mm < 10
    dd = "0" + dd  if dd < 10
    dt = (yy + mm + dd)
    dt
  rewriteDailyLink = (linkID, rewriteLink) ->
    linkURL = "http://b.hatena.ne.jp/Naruhodius/" + rewriteLink
    baseTag = document.getElementById(linkID)
    link1 = baseTag.firstChild.nodeValue
    aTag = document.createElement("a")
    aTag.href = linkURL
    aTag.appendChild document.createTextNode(link1)
    baseTag.replaceChild aTag, baseTag.firstChild
  rewriteDailyLinks = ->
    today = new Date()
    rewriteDailyLink "three_days_before_yesterday", getDateString(computeDateFromDate(today, -4))
    rewriteDailyLink "two_days_before_yesterday", getDateString(computeDateFromDate(today, -3))
    rewriteDailyLink "day_before_yesterday", getDateString(computeDateFromDate(today, -2))
    rewriteDailyLink "yesterday", getDateString(computeDateFromDate(today, -1))
    rewriteDailyLink "today", getDateString(today)
  rewriteDailyLinks()
