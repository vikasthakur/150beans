# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

jQuery ($) ->
  flash = $ '.flash'
  
  # hooks to handle ajax delete of transaction
  ($ '.transactions')
    .delegate '.delete', 'ajax:beforeSend', (evt, xhr, settings) ->
      flash.slideUp().empty()

    .delegate '.delete', 'ajax:success', (evt, data, status, xhr) ->
      $(this).closest('li').fadeOut('slow', -> $(this).remove())
      flash.append '<div class="alert rounded-s">transaction deleted</div>'
        
    .delegate '.delete', 'ajax:error', (evt, xhr, status, error) ->
      $.each $.parseJSON(xhr.responseText), (k, v) ->
        flash.append '<div class="errors rounded-s"><strong>' + k + '</strong> ' + v + '</div>'
            
    .delegate '.delete', 'ajax:complete', -> flash.slideDown()
