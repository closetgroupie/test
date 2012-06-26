jQuery ($) ->
  unregistered = $('body').hasClass 'unregistered'

  window.fbAsyncInit = ->
    FB.init
      appId  : '195906460469934',
      cookie : true,
      xfbml  : true

    if !unregistered
      FB.Event.subscribe 'edge.create', (response) ->
        jQuery.post '/activity/facebook/edge/create', data: response
        return

      FB.Event.subscribe 'edge.remove', (response) ->
        jQuery.post '/activity/facebook/edge/remove', data: response
        return

      FB.Event.subscribe 'comment.create', (response) ->
        jQuery.post '/activity/facebook/comment/create', data: response
        return

      FB.Event.subscribe 'comment.remove', (response) ->
        jQuery.post '/activity/facebook/comment/remove', data: response
        return

  $(".thumb").fancybox
    overlayColor: "#fff",
    overlayOpacity: .8

  $('body')
    .delegate('#question_form', 'submit', (event) ->
      $.ajax
        url: $('#question_form').attr('action'),
        data:
          content: $('#question_form').find('textarea').val()
        type: "post",
        dataType: "text",
        success: ->
          $("#message_input").val ""
          $("#question_form").hide()
          $("#send_message_wrapper h4").fadeIn()
          return
      event.preventDefault()
      return
    )
    .delegate('#contact_link', 'click', (event) ->
      $.ajax                                                    
        url: $(this).attr('href'),
        type: "get",
        dataType: "text",
        success: (data) ->
          $.fancybox(data,
            overlayColor:"#fff",
            overlayOpacity: .8,
            onComplete: (e) ->
              $("#message_input").focus()
              return
          )
          return
      event.preventDefault()
      return
    )
