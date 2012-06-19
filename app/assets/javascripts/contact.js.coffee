jQuery(document).ready ($) ->
  $('#contact').click (event) ->
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
