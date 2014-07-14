$(document).on 'ready page:load page:change', ->
  $('.bs-component [data-toggle="popover"]').popover()
  $('.bs-component [data-toggle="tooltip"]').tooltip()
