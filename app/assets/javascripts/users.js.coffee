$ ->
  (($) ->
    $.toggleShowPassword = (options) ->
      settings = $.extend(
        field: "#password"
        control: "#toggle_show_password"
      , options)
      control = $(settings.control)
      field = $(settings.field)
      control.bind "click", ->
        if control.is(":checked")
          field.attr "type", "text"
        else
          field.attr "type", "password"
        return

      return

    return
  ) jQuery
  
  #Here how to call above plugin from everywhere in your application document body
  $.toggleShowPassword
    field: "#secret_key"
    control: "#showpassword"

  return
$(document).ready(ready)
$(document).on('page:load', ready)