jQuery ($) ->
  flash = $ '.flash'

  ($ 'input, textarea, select').focusin -> 
    ($ this).css 'background-color','#e5fff3'
  ($ 'input, textarea, select').focusout -> 
    ($ this).css 'background-color','#fff'
  
    ($ 'form')
      .delegate 'ajax:beforeSend', (evt,xhr,settings) -> 
        flash.slideUp().empty()

      .delegate 'ajax:success', (evt,data,status,xhr) ->
        flash.append '<div class="notice rounded-s">' + ($ this).attr("data-success-msg") + '</div>'

      .delegate 'ajax:error', (evt,xhr,status,error) ->
        $.each $.parseJSON(xhr.responseText), (k,v) ->
          flash.append '<div class="errors rounded-s"><strong>' + k + '</strong> ' + v + '</div>'

      .delegate '.delete', 'ajax:complete', -> 
        flash.slideDown()