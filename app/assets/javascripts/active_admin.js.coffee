#= require ckeditor/init
#= require ckeditor/config
#= require ckeditor/lang/ru
#= require ckeditor/styles
#= require active_admin/base
#= require jquery-ui/tabs
#= require just_datetime_picker/nested_form_workaround
#= require jquery.damnUploader
#= require interface
#= require chosen-jquery

#= require_tree ./active_admin
jQuery ->
  $('.itemGal').each(
    ->
      x = $(this)
      $(this).hover(
        ->
          x.find('.infoHover').stop(true,false).fadeTo(500, 1.0);
          x.find('.infoHover').contents().show();
      ,
      ->
        x.find('.infoHover').stop(true,false)
        .fadeTo(500, 0.0).delay(500)
        .contents().hide();
      )
      $(this).find('input[name="cover"]').click(
        ->

          $.post(
            window.location.href+'/cover',
            {image_id:$(this).val()},
          (data)->
            return true

          ,
            'json')
      )
  )

  $( ".sortable" ).sortable(
    {
      stop: ( event, ui ) ->


        $.ajax({
          url: $(this).data("sortable-url"),
          type: "post",
          data: $(this).sortable("serialize")
        })
    }
  );
  $( ".sortable" ).disableSelection();
  $('.drop-down legend, .drop-up legend').click( (event) ->
    event.preventDefault()
    fieldset = $(this).parent()
    fieldset.find('ol').slideToggle()
  );
  $('.delete_img').click( (event)->

    event.preventDefault()
    field = $(this).data('field')
    elem = $(this)


    post = { 'field':field}
    $.post(
      $(this).attr('href'),
      post,
    (data)->
      if data.type = 'ok'
        elem.parent().remove()

    ,
      'json')

  )