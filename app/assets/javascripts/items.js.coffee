jQuery ->
  $("#item_category_id").hide() unless $('body').hasClass('edit-item') is true
  categories = $('#item_category_id').html()
  brands = $('#item_brand_id').html()
  sizes  = $('#item_size_id').html()

  $('body')
    .delegate '#item_segment_id', 'change', ->
      selection = $('#item_segment_id :selected')

      if (selection.val())
        segment = selection.text()
        category_options = $(categories).filter("optgroup[label='#{segment}']").html()
        brand_options    = $(brands).filter("optgroup[label='#{segment}']").html()
        $('#item_size_id').empty().prepend('<option>Choose...</option>')

        if category_options
          $('#item_category_id').html(category_options).prepend('<option>Choose...</option>').show()
        else
          $('#item_category_id').empty().hide()

        if brand_options
          $('#item_brand_id').html(brand_options).prepend('<option>Choose...</option>').show()
        

    .delegate '#item_category_id', 'change', ->
      selection = $('#item_category_id :selected')
      $('#after_category_wrapper').show() unless $('#after_category_wrapper').is(':visible')

      if (selection.val())
        category = selection.text()
        category_id = selection.val()
        size_options = $(sizes).filter("optgroup[label='#{category_id}']").html()

        if size_options
          $('#item_size_id').html(size_options).prepend('<option>Choose...</option>').show()
        else
          $('#item_size_id').empty().hide()
