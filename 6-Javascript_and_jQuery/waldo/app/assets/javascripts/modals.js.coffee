$ ->
  modal_holder_selector = '#modal-holder'
  modal_selector = '.modal'

  $(document).on 'click', 'a[data-modal]', ->
    location = $(this).attr('href')
    #Load modal dialog from server
    $.get location, (data)->
      $(modal_holder_selector).html(data).
      find(modal_selector).modal()
    false

  $(document).on 'ajax:success',
    'form[data-modal]', (event, data, status, xhr)->
      url = xhr.getResponseHeader('Location')
      if url
        #redirect to url
        window.location = url
      else
        #Remove old modal backdrop
        $('.modal-backdrop').remore()

        # Replace old modal with a new one
        # I don't think I'll actually need this
        # $(modal_holder_selector).html(data).
        # find(modal_selector).modal()

      false
