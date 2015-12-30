clearNotice = ->
  uri = window.location.href
  lastUriSegment = uri.substr(uri.lastIndexOf("/") + 1)
  if lastUriSegment == "sign_in" || lastUriSegment == "sign_up"
    return
  else
    $('.alert').animate({opacity: '0'}, 3000).slideUp(250)
    $('.notice').animate({opacity: '0'}, 3000).slideUp(250)

ready = ->
  setTimeout(clearNotice, 2000)

$ ->
  $(document).ready(ready)
  $(document).on('page:load', ready)

