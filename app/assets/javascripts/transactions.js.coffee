###
--- transactions.js.coffee ---
###

jQuery ($) ->
  flash = $('.flash')

  # hooks to load transactions list via JSON
  # TODO wrap in closure
  # TODO cleanup var extraction
  # TODO check if .list present
  journal = $('section.transactions').attr("id")
  url = $("##{journal}").attr("data-url")
  page = $("##{journal}").attr("data-page")
  filter = $("##{journal}").attr("data-filter")
  tags = $("##{journal}").attr("data-tags")
  $.getJSON url, {journal:journal, filter:filter, page:page, tags:tags}, (data,status,xhr) ->
    $("##{journal} .list").html(($ "#transaction_template_#{journal}").tmpl(data))
  
  # hook to handle new transaction form
  $('#new_transaction')
    .bind 'ajax:success', (evt, data, status, xhr) ->
      journal = data.transaction.journal_id
      $("#transaction_template_#{journal}").tmpl(data).hide().prependTo($("##{journal} .list")).fadeIn("slow")
      $('#new_transaction').each -> this.reset()
      
  # TODO hook to handle edit transaction form submission
      
  # hooks to handle ajax links in transactions list
  $('.transactions')
    .delegate 'a', 'ajax:beforeSend', (evt, xhr, settings) ->
      flash.slideUp().empty()

    .delegate 'a', 'ajax:error', (evt, xhr, status, error) ->
      # TODO edit link returns non-JSON errors!
      $.each $.parseJSON(xhr.responseText), (k, v) ->
        # TODO append to flash.errors directly
        flash.append '<div class="errors rounded-s"><strong>' + k + '</strong> ' + v + '</div>'

    .delegate 'a', 'ajax:complete', -> 
      flash.slideDown()

    # hook to handle edit link (ajax) click
    .delegate '.edit', 'ajax:success', (evt, data, status, xhr) ->
      $(this).closest('.transaction').append(data).slideDown
      # TODO append to flash.alert directly
      flash.append '<div class="alert rounded-s">edit returned something useful</div>'
  
    # hook to handle transaction (ajax) delete
    .delegate '.delete', 'ajax:success', (evt, data, status, xhr) ->
      $(this).closest('.transaction').fadeOut('slow', -> $(this).remove())
      # TODO append to flash.alert directly
      flash.append '<div class="alert rounded-s">transaction deleted</div>'
