###
--- shared.js.coffee ---
###

jQuery ($) ->
  flash = $('.flash')
  
  $(window.applicationCache).bind 'error', ->
    alert 'There was an error when loading the cache manifest.'