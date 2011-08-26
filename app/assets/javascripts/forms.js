$(function() {
  var $flash = $('.flash');
  
  $('input, textarea, select').focusin(function() {
    $(this).css('background-color','#e5fff3');
  });
  $('input, textarea, select').focusout(function() {
    $(this).css('background-color','#fff');
  });

  $('form')
    .bind('ajax:beforeSend', function(evt, data, status, xhr){
      $flash.empty().fadeOut();
    })
    .bind('ajax:success', function(evt, data, status, xhr){
      $flash.append('<div class="notice rounded-s">'+$(this).attr("data-success-msg")+'</div>');
    })
    .bind('ajax:error', function(evt, xhr, status, error){
      var responseObject = $.parseJSON(xhr.responseText);
      $.each(responseObject, function(k, v){
        $flash.append('<div class="errors rounded-s"><strong>' + k + '</strong> ' + v + '</div>');
      })
    })
    .bind('ajax:complete', function() {
      $flash.fadeIn();
    });
});