document.copyToClipboard = (hint, text) ->
  window.prompt(hint, text)

$(document).on 'ready page:load page:change', ->
  $('[data-toggle="popover"]').popover()
  $('[data-toggle="tooltip"]').tooltip()

  cleanSource = (html) ->
    lines = html.split(/\n/)
    lines.shift()
    lines.splice -1, 1
    indentSize = lines[0].length - lines[0].trim().length
    re = new RegExp(" {" + indentSize + "}")
    lines = lines.map((line) ->
      line = line.substring(indentSize)  if line.match(re)
      line
    )
    lines = lines.join("\n")
    lines
  $button = $("<div id='source-button' class='btn btn-primary btn-xs'>&lt; &gt;</div>").click(->
    html = $(this).parent().html()
    html = cleanSource(html)
    $("#source-modal pre").text html
    $("#source-modal").modal()
    return
  )
  $(".bs-component").hover (->
    $(this).append $button
    $button.show()
    return
  ), ->
    $button.hide()
    return
