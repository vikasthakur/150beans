# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

jQuery ($) ->
  flash = $ '.flash'
  
  # hooks to handle new transaction form
  ($ '#new_transaction')
    .bind 'ajax:success', (evt, data, status, xhr) ->
      journal = data.transaction.journal_id
      $('#transaction_template_'+journal).tmpl(data).hide().prependTo($('#'+journal+" .list")).fadeIn("slow")
      $('#new_transaction').each -> this.reset()
  
  # hooks to handle transaction (ajax) delete
  ($ '.transactions')
    .delegate '.delete', 'ajax:beforeSend', (evt, xhr, settings) ->
      flash.slideUp().empty()

    .delegate '.delete', 'ajax:success', (evt, data, status, xhr) ->
      $(this).closest('.transaction').fadeOut('slow', -> $(this).remove())
      flash.append '<div class="alert rounded-s">transaction deleted</div>'
        
    .delegate '.delete', 'ajax:error', (evt, xhr, status, error) ->
      $.each $.parseJSON(xhr.responseText), (k, v) ->
        flash.append '<div class="errors rounded-s"><strong>' + k + '</strong> ' + v + '</div>'
            
    .delegate '.delete', 'ajax:complete', -> 
      flash.slideDown()
